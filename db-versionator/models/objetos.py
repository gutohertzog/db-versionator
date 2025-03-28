""" módulo com as classes de objetos do banco de dados """
from ..dto import objetos as dto_obj
from ..models.permission import Permission


class Entity:
    """ classe base para os objetos das classes View, Function, Procedure,
    Trigger e Index """
    def __init__(self) -> None:
        self.banco: str = ""
        self.esquema: str = ""
        self.nome_ent: str = ""
        self.definicao: str = ""

        self.query: str = ""
        # caminho de salvamento do arquivo
        self.caminho_abs: str = ""
        # caminho da entidade para o arquivo de índice
        self.caminho_rel: str = ""

    def _gera_query_entidade(self) -> None:
        """ função genérica para gerar a query de criação do objeto """
        self.query += f"USE [{self.banco}]\nGO\n\n"
        self.query += f"{self.definicao}\nGO\n"

    def _gera_query_permissoes(self, permissoes: list[Permission]) -> None:
        if permissoes:
            for permissao in permissoes:
                permissao.cria_query_permissao()
                self.query += f"\n{permissao.query}"
            self.query += "\nGO\n"

    def __str__(self) -> str:
        return f"{self.banco}.{self.esquema}.{self.nome_ent}"


class View(Entity):
    """ diferente das tabelas, as visões já terão seus scripts gerados na
    criação do objeto """
    tipo: str = "views"

    def __init__(self) -> None:
        super().__init__()
        self.permissoes: list[Permission] = []

    def gera_query_visao(self):
        self._gera_query_entidade()
        self._gera_query_permissoes(self.permissoes)

    @classmethod
    def fabrica_visao(cls, dto: dto_obj.EntityDTO) -> "View":
        nova_visao = cls()
        nova_visao.banco = dto.banco
        nova_visao.esquema = dto.esquema
        nova_visao.nome_ent = dto.nome_entidade
        nova_visao.definicao = dto.definicao
        return nova_visao


class Function(Entity):
    tipo: str = "functions"

    def __init__(self) -> None:
        super().__init__()
        self.permissoes: list[Permission] = []

    def gera_query_funcao(self) -> None:
        self._gera_query_entidade()
        self._gera_query_permissoes(self.permissoes)

    @classmethod
    def fabrica_funcao(cls, dto: dto_obj.EntityDTO) -> "Function":
        nova_funcao = cls()
        nova_funcao.banco = dto.banco
        nova_funcao.esquema = dto.esquema
        nova_funcao.nome_ent = dto.nome_entidade
        nova_funcao.definicao = dto.definicao
        return nova_funcao


class Procedure(Entity):
    tipo: str = "procedures"

    def __init__(self) -> None:
        super().__init__()
        self.permissoes: list[Permission] = []

    def gera_query_procedure(self) -> None:
        self._gera_query_entidade()
        self._gera_query_permissoes(self.permissoes)

    @classmethod
    def fabrica_procedure(cls, dto: dto_obj.EntityDTO) -> "Procedure":
        novo_procedimento = cls()
        novo_procedimento.banco = dto.banco
        novo_procedimento.esquema = dto.esquema
        novo_procedimento.nome_ent = dto.nome_entidade
        novo_procedimento.definicao = dto.definicao
        return novo_procedimento


class Trigger(Entity):
    tipo: str = "triggers"

    def __init__(self) -> None:
        super().__init__()

    def gera_query_trigger(self) -> None:
        self._gera_query_entidade()

    @classmethod
    def fabrica_trigger(cls, dto: dto_obj.EntityDTO) -> "Trigger":
        nova_trigger = cls()
        nova_trigger.banco = dto.banco
        nova_trigger.esquema = dto.esquema
        nova_trigger.nome_ent = dto.nome_entidade
        nova_trigger.definicao = dto.definicao
        return nova_trigger


class Index:
    tipo: str = "indexes"

    def __init__(self) -> None:
        self.banco: str = ""
        self.esquema: str = ""
        self.tabela: str = ""
        self.nome_indice: str = ""
        self.colunas_chave: list[str] = []
        self.colunas_includas: list[str] = []
        self.clusterizado: str = ""  # CLUSTERED | NONCLUSTERED
        self.query: str = ""
        # caminho de salvamento do arquivo
        self.caminho_abs: str = ""
        # caminho da entidade para o arquivo de índice
        self.caminho_rel: str = ""

    def gera_query_indice(self) -> None:
        self.query += (
            f"USE [{self.banco}]\nGO\n\nCREATE"
            f" {self.clusterizado} INDEX [{self.nome_indice}] ON"
            f" [{self.esquema}].[{self.tabela}]\n(\n    "
        )
        self.query += ",\n    ".join([f"[{c}]" for c in self.colunas_chave])
        self.query += "\n)"
        if self.colunas_includas:
            self.query += "\nINCLUDE\n(\n    "
            self.query += ",\n    ".join([
                f"[{c}]"
                for c in self.colunas_includas])
            self.query += "\n)"
        self.query += "\nGO\n"

    @classmethod
    def fabrica_indice(cls, dto: dto_obj.IndexDTO) -> "Index":
        novo_indice = cls()
        novo_indice.banco = dto.banco
        novo_indice.esquema = dto.esquema
        novo_indice.tabela = dto.tabela
        novo_indice.nome_indice = dto.nome_indice
        novo_indice.clusterizado = dto.clusterizado
        return novo_indice

    def __str__(self) -> str:
        texto: str = super().__str__()
        texto += f"{self.tabela}"
        texto += f"\n\tcolunas chave : {[c for c in self.colunas_chave]}"
        texto += f"\n\tcolunas incluídas : {[c for c in self.colunas_includas]}"
        texto += f"\n\tclusterizado : {self.clusterizado}"
        return texto
