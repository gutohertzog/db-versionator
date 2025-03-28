""" módulo para gerenciar apenas a classe do Aplicativo """

import os

from . import dto
from .config import config, queries
from .db_conn import DatabaseManager
from .models.arquivo import Arquivo, Logger, Sincronizador
from .models.constraints import Check, Default, ForeignKey, PrimaryKey, Unique
from .models.database import Banco
from .models.objetos import Function, Index, Procedure, Trigger, View
from .models.permission import Permission, Role, User
from .models.tabela import Column, Table


class Aplicativo():
    """ classe para gerenciar todo o programa """
    def __init__(self, servidor: str) -> None:
        # servidor a ser conectado e carregada suas configurações
        self.servidor = config.BANCOS[servidor]

        # diretório base do servidor onde tudo será salvo
        self.dir_base = os.path.join(
            os.getcwd(),
            config.DIR_BASE,
            str(self.servidor["dir"]))

        if not os.path.exists(self.dir_base):
            os.makedirs(self.dir_base)

        # configura logger
        self.logger = Logger(
            int(self.servidor["log-level"]),
            os.path.join(self.dir_base, config.ARQ_LOG))

        # variável de conexão
        self.db_man = DatabaseManager(
            logger=self.logger,
            server=str(self.servidor["server"]),
            trusted_connection=bool(self.servidor["trusted"]))
        self.db_man.conectar()

        # os dicionários estão sendo usados para otimizar as buscas
        # listas usam O(n) enquanto dicionários usam O(1)
        # chave -> nome_banco
        self.bancos: dict[str, Banco] = {}
        # chave -> esquema, nome_objeto
        self.tabelas: dict[tuple[str, str], Table] = {}
        self.visoes: dict[tuple[str, str], View] = {}
        self.funcoes: dict[tuple[str, str], Function] = {}
        self.procedimentos: dict[tuple[str, str], Procedure] = {}
        self.triggers: dict[tuple[str, str], Trigger] = {}
        self.indices: dict[tuple[str, str], Index] = {}
        # chave -> banco, nome_role
        self.grupos: dict[tuple[str, str], Role] = {}
        # chave -> nome_objeto, usuario
        self.permissoes: dict[tuple[str, str], Permission] = {}

        # variável para salvar os objetos
        self.indice_caminho: str = ""
        self.arquivo = Arquivo(self.logger, self.dir_base)
        self.sicronizador = Sincronizador(self.arquivo)

    def gera_caminho(self) -> str:
        return os.path.join(self.dir_base, config.ARQ_OBJS)

    def gera_caminho_absoluto(
            self, banco: str, tipo: str, nome: str = "") -> str:
        """ função para gerar o caminho absoluto dos arquivos """
        return os.path.join(self.dir_base, banco, tipo, f"{nome}.sql")

    def gera_caminho_relativo(
            self, banco: str, tipo: str, nome: str = "") -> str:
        """ função para gerar o caminho relativo dos arquivos """
        return os.path.join(banco, tipo, f"{nome}.sql")

    def gera_caminho_indice(self, banco: str) -> None:
        self.indice_caminho = os.path.join(
            self.dir_base, banco, f"{banco}_indice.txt")

    def cria_diretorios(self, diretorios: list[str]) -> None:
        """ função para criar um diretório """
        diretorio: str = os.path.join(self.dir_base, *diretorios)

        if not os.path.exists(diretorio):
            try:
                os.makedirs(diretorio)
            except OSError as erro:
                erro_str: str = f"Erro ao criar o diretório : {diretorio} - "
                erro_str += f"Erro : {erro}"
                self.logger.error(erro_str)

    def busca_bancos(self) -> None:
        # primeiro busca pelo banco, seus dados e suas especificações
        for db_raw in self.db_man.executar(queries.DATABASES):
            db_dto = dto.BancoDTO.row_to_db_dto(db_raw)

            if db_dto.nome_banco in config.EXCLUDED_DATABASES:
                continue

            novo_db = Banco.fabrica_db(db_dto)
            novo_db.caminho_abs = self.gera_caminho_absoluto(
                novo_db.nome_banco, "", novo_db.nome_banco)

            self.bancos[novo_db.nome_banco] = novo_db

        # depois busca seus os dados de LOG de cada banco
        for db_log_raw in self.db_man.executar(queries.DATABASES_LOGS):
            db_log_dto = dto.BancoDTO.row_to_db_dto(db_log_raw)

            if db_log_dto.nome_banco in config.EXCLUDED_DATABASES:
                continue

            novo_db_log = Banco.fabrica_db_log(db_log_dto)
            self.bancos[
                novo_db_log.nome_banco].dados_log = novo_db_log.dados_log

    def busca_users_banco(self, banco: Banco) -> None:
        banco.usuarios = dto.BancoDTO.prepara_usuarios(
            self.db_man.executar(queries.DB_USERS))

    def troca_banco(self, banco: str) -> None:
        query: str = f"USE {banco}"
        self.db_man.executar(query, fetch=False)
        print(f'Conectando em : {banco}')

    """ # * IMPORTANTE * #
    para as funções de busca abaixo, é importante que suas respectivas listas
    (atributos listas da classe Aplicativo) sejam esvaziadas no começo de cada
    uma, pois elas são executadas para cada banco de dados
    """
    def busca_tabelas(self) -> None:
        self.tabelas: dict[tuple[str, str], Table] = {}

        for tabela in self.db_man.executar(queries.TABLES):
            tabela_dto = dto.TableDTO.row_to_table_dto(tabela)

            if tabela_dto.esquema in config.EXCLUDED_SCHEMAS:
                continue

            nova_tabela = Table.fabrica_tabela(tabela_dto)

            nova_tabela.caminho_abs = self.gera_caminho_absoluto(
                nova_tabela.banco, nova_tabela.tipo, nova_tabela.nome_tabela)
            nova_tabela.caminho_rel = self.gera_caminho_relativo(
                nova_tabela.banco, nova_tabela.tipo, nova_tabela.nome_tabela)

            chave = (nova_tabela.esquema, nova_tabela.nome_tabela)
            self.tabelas[chave] = nova_tabela

    def busca_tabela_dados(self) -> None:
        """ busca colunas, pk, fks, cks, dfs, uks e permissões """
        # chave -> tabela, coluna
        colunas = self._busca_colunas()
        for coluna in colunas.values():
            chave = (coluna.esquema, coluna.tabela)
            tabela = self.tabelas[chave]
            if tabela:
                tabela.colunas.append(coluna)

        pks = self._busca_pks()
        for pk in pks.values():
            chave = (pk.esquema, pk.tabela)
            pk.cria_query_pk()
            self.tabelas[chave].chave_pk = pk

        fks = self._busca_fks()
        for fk in fks.values():
            chave = (fk.esquema, fk.tabela)
            fk.cria_query_fk()
            self.tabelas[chave].chaves_fk.append(fk)

        cks = self._busca_cks()
        for ck in cks.values():
            chave = (ck.esquema, ck.tabela)
            ck.cria_query_check()
            self.tabelas[chave].checks.append(ck)

        dfs = self._busca_dfs()
        for df in dfs.values():
            chave = (df.esquema, df.tabela)
            df.cria_query_default()
            self.tabelas[chave].defaults.append(df)

        uks = self._busca_uks()
        for uk in uks.values():
            chave = (uk.esquema, uk.tabela)
            uk.cria_query_unique()
            self.tabelas[chave].uniques.append(uk)

        # marca as colunas com as constraints
        for tabela in self.tabelas.values():
            if tabela.chave_pk:
                tabela.marca_pk()
            if tabela.chaves_fk:
                tabela.marca_fk()
            if tabela.checks:
                tabela.marca_ck()
            if tabela.defaults:
                tabela.marca_df()
            if tabela.uniques:
                tabela.marca_uk()

    def _busca_colunas(self) -> dict[tuple[str, str], Column]:
        colunas: dict[tuple[str, str], Column] = {}

        for coluna in self.db_man.executar(queries.COLUMNS):
            coluna_dto = dto.ColumnDTO.row_to_column_dto(coluna)
            chave = (coluna_dto.tabela, coluna_dto.nome_coluna)
            colunas[chave] = Column.fabrica_coluna(coluna_dto)

        return colunas

    def _busca_pks(self) -> dict[tuple[str, str], PrimaryKey]:
        pks: dict[tuple[str, str], PrimaryKey] = {}

        for pk_raw in self.db_man.executar(queries.PRIMARY_KEYS):
            pk_dto = dto.PrimaryKeyDTO.row_to_pk_dto(pk_raw)
            chave = (pk_dto.tabela, pk_dto.nome_constraint)

            if chave not in pks:
                pks[chave] = PrimaryKey.fabrica_pk(pk_dto)
            pks[chave].colunas.append(pk_dto.coluna)

        return pks

    def _busca_fks(self) -> dict[tuple[str, str], ForeignKey]:
        fks: dict[tuple[str, str], ForeignKey] = {}

        for fk_raw in self.db_man.executar(queries.FOREIGN_KEYS):
            fk_dto = dto.ForeignKeyDTO.row_to_fk_dto(fk_raw)
            chave = (fk_dto.tabela, fk_dto.nome_constraint)

            if chave not in fks:
                fks[chave] = ForeignKey.fabrica_fk(fk_dto)
            fks[chave].colunas.append(fk_dto.coluna)
            fks[chave].colunas_pk.append(fk_dto.coluna_ref)

        return fks

    def _busca_cks(self) -> dict[tuple[str, str], Check]:
        checks: dict[tuple[str, str], Check] = {}

        for check_raw in self.db_man.executar(queries.CHECKS):
            check_dto = dto.CheckDTO.row_to_check_dto(check_raw)
            chave = (check_dto.tabela, check_dto.check_constraint)
            checks[chave] = Check.fabrica_ck(check_dto)

        return checks

    def _busca_dfs(self) -> dict[tuple[str, str], Default]:
        defaults: dict[tuple[str, str], Default] = {}

        for default_raw in self.db_man.executar(queries.DEFAULTS):
            default_dto = dto.DefaultDTO.row_to_default_dto(default_raw)
            chave = (default_dto.tabela, default_dto.default_constraint)
            defaults[chave] = Default.fabrica_df(default_dto)

        return defaults

    def _busca_uks(self) -> dict[tuple[str, str], Unique]:
        uniques: dict[tuple[str, str], Unique] = {}

        for unique_raw in self.db_man.executar(queries.UNIQUES):
            unique_dto = dto.UniqueDTO.row_to_unique_dto(unique_raw)
            chave = (unique_dto.tabela, unique_dto.unique_constraint)

            if chave not in uniques:
                uniques[chave] = Unique.fabrica_uk(unique_dto)
            uniques[chave].colunas.append(unique_dto.col_nome)

        return uniques

    def busca_entidades(self) -> None:
        """ o método, usando a query ENTITIES, vai buscar por todos os objetos
        do tipo função, procedimento, visão e gatilho """
        self.visoes: dict[tuple[str, str], View] = {}
        self.funcoes: dict[tuple[str, str], Function] = {}
        self.procedimentos: dict[tuple[str, str], Procedure] = {}
        self.triggers: dict[tuple[str, str], Trigger] = {}

        for entity_raw in self.db_man.executar(queries.ENTITIES):
            entity_dto = dto.EntityDTO.row_to_entity_dto(entity_raw)

            if entity_dto.esquema in config.EXCLUDED_SCHEMAS:
                continue

            chave = (entity_dto.esquema, entity_dto.nome_entidade)

            if entity_dto.tipo.strip() == "V":
                nova_v = View.fabrica_visao(entity_dto)
                nova_v.caminho_abs = self.gera_caminho_absoluto(
                        nova_v.banco, nova_v.tipo, nova_v.nome_ent)
                nova_v.caminho_rel = self.gera_caminho_relativo(
                        nova_v.banco, nova_v.tipo, nova_v.nome_ent)
                self.visoes[chave] = nova_v

            elif entity_dto.tipo.strip() == "P":
                nova_pr = Procedure.fabrica_procedure(entity_dto)
                nova_pr.caminho_abs = self.gera_caminho_absoluto(
                        nova_pr.banco, nova_pr.tipo, nova_pr.nome_ent)
                nova_pr.caminho_rel = self.gera_caminho_relativo(
                        nova_pr.banco, nova_pr.tipo, nova_pr.nome_ent)
                self.procedimentos[chave] = nova_pr

            elif entity_dto.tipo.strip() == "TR":
                nova_tr = Trigger.fabrica_trigger(entity_dto)
                nova_tr.caminho_abs = self.gera_caminho_absoluto(
                        nova_tr.banco, nova_tr.tipo, nova_tr.nome_ent)
                nova_tr.caminho_rel = self.gera_caminho_relativo(
                        nova_tr.banco, nova_tr.tipo, nova_tr.nome_ent)
                self.triggers[chave] = nova_tr

            else:
                nova_fn = Function.fabrica_funcao(entity_dto)
                nova_fn.caminho_abs = self.gera_caminho_absoluto(
                        nova_fn.banco, nova_fn.tipo, nova_fn.nome_ent)
                nova_fn.caminho_rel = self.gera_caminho_relativo(
                        nova_fn.banco, nova_fn.tipo, nova_fn.nome_ent)
                self.funcoes[chave] = nova_fn

    def busca_permissoes(self) -> None:
        self.permissoes: dict[tuple[str, str], Permission] = {}

        for perm_raw in self.db_man.executar(queries.PERMISSIONS):
            perm_dto = dto.PermissionDTO.row_to_permission_dto(perm_raw)
            if perm_dto.esquema in config.EXCLUDED_SCHEMAS:
                continue
            chave = (perm_dto.objeto_nome, perm_dto.usuario)

            if chave not in self.permissoes:
                self.permissoes[chave] = Permission.fabrica_perm(perm_dto)
            self.permissoes[chave].permissoes.append(perm_dto.permissao)

        self._atribui_permissoes()

    def _atribui_permissoes(self) -> None:
        """ método para distribuir permissões aos seus respectivos objetos """
        for perm in self.permissoes.values():
            chave = (perm.esquema, perm.objeto)

            try:
                # V -> VIEW
                if perm.objeto_tipo == "V":
                    # adicionar permissões nos objetos gerados
                    self.visoes[chave].permissoes.append(perm)
                # U -> USER_TABLE
                elif perm.objeto_tipo == "U":
                    self.tabelas[chave].permissoes.append(perm)
                # P -> SQL_STORED_PROCEDURE
                elif perm.objeto_tipo == "P":
                    self.procedimentos[chave].permissoes.append(perm)
                # FN -> SQL_SCALAR_FUNCTION
                # TF -> SQL_TABLE_VALUED_FUNCTION
                # IF -> SQL_INLINE_TABLE_VALUED_FUNCTION
                else:
                    self.funcoes[chave].permissoes.append(perm)
            except KeyError as erro:
                self.logger.error(f"{erro} -> {perm}")

    def busca_indices(self) -> None:
        self.indices: dict[tuple[str, str], Index] = {}

        for indice_raw in self.db_man.executar(queries.INDEXES):
            idx_dto = dto.IndexDTO.row_to_index_dto(indice_raw)
            if idx_dto.esquema in config.EXCLUDED_SCHEMAS:
                continue

            chave = (idx_dto.esquema, idx_dto.nome_indice)
            if chave not in self.indices:
                novo_idx = Index.fabrica_indice(idx_dto)
                novo_idx.caminho_abs = self.gera_caminho_absoluto(
                    novo_idx.banco, novo_idx.tipo, novo_idx.nome_indice)
                novo_idx.caminho_rel = self.gera_caminho_relativo(
                    novo_idx.banco, novo_idx.tipo, novo_idx.nome_indice)
                self.indices[chave] = novo_idx

            if idx_dto.eh_inclusivo:
                self.indices[chave].colunas_includas.append(idx_dto.nome_coluna)
            else:
                self.indices[chave].colunas_chave.append(idx_dto.nome_coluna)

    def busca_roles(self) -> None:
        """ busca pelos grupos (roles) e também seus respectivos usuários """
        self.grupos: dict[tuple[str, str], Role] = {}

        # busca por todos os grupos do banco conectado
        for role_raw in self.db_man.executar(queries.ROLES):
            role_dto = dto.RoleDTO.row_to_role_dto(role_raw)
            chave = (role_dto.banco, role_dto.nome_grupo)

            nova_role: Role = Role.fabrica_role(role_dto)
            nova_role.caminho_abs = self.gera_caminho_absoluto(
                nova_role.banco, nova_role.tipo, nova_role.nome_role)
            nova_role.caminho_rel = self.gera_caminho_relativo(
                nova_role.banco, nova_role.tipo, nova_role.nome_role)
            self.grupos[chave] = nova_role

        # busca pelos usuários de cada grupo
        for usuario_raw in self.db_man.executar(queries.ROLE_USERS):
            usuario_dto = dto.UserDTO.row_to_user_dto(usuario_raw)
            chave = (usuario_dto.banco, usuario_dto.role)

            novo_usuario = User.fabrica_user(usuario_dto)
            self.grupos[chave].usuarios.append(novo_usuario)

    def gera_queries(self, banco: Banco) -> None:
        banco.gera_query()
        for tabela in self.tabelas.values():
            tabela.gera_query_tabela()
        for visao in self.visoes.values():
            visao.gera_query_visao()
        for procedimento in self.procedimentos.values():
            procedimento.gera_query_procedure()
        for funcao in self.funcoes.values():
            funcao.gera_query_funcao()
        for trigger in self.triggers.values():
            trigger.gera_query_trigger()
        for indice in self.indices.values():
            indice.gera_query_indice()
        for grupo in self.grupos.values():
            grupo.gera_query_role()
