import time
from datetime import datetime

from .aplicativo import Aplicativo
from .menu import Menu
from .models.objetos import Function, Index, Procedure, Trigger, View
from .models.permission import Role
from .models.tabela import Table


if __name__ == '__main__':
    menu = Menu()
    menu.menu_ambiente()

    # contagem do tempo de execução apenas a partir do início do backup
    inicio: float = time.time()

    app: Aplicativo = Aplicativo(menu.ambiente)

    arq = open(app.gera_caminho(), "w")
    data_atual = datetime.now()
    arq.write(f'Dados coletados em {data_atual.strftime("%d/%m/%Y")}\n')

    app.busca_bancos()

    tabelas: int = 0
    visoes: int = 0
    funcoes: int = 0
    procedimentos: int = 0
    triggers: int = 0
    indices: int = 0
    grupos: int = 0

    for banco in app.bancos:
        novo_indice: set[str] = set()
        app.gera_caminho_indice(banco)

        app.troca_banco(banco)
        print(f'\n---- {banco} ----', file=arq)

        app.busca_users_banco(app.bancos[banco])
        app.busca_tabelas()
        app.busca_tabela_dados()
        app.busca_entidades()
        app.busca_permissoes()
        app.busca_indices()
        app.busca_roles()
        app.gera_queries(app.bancos[banco])

        if app.tabelas:
            app.cria_diretorios([banco, Table.tipo])
            for tabela in app.tabelas.values():
                if app.arquivo.salva_script(tabela.caminho_abs, tabela.query):
                    novo_indice.add(tabela.caminho_rel)

        if app.visoes:
            app.cria_diretorios([banco, View.tipo])
            for visao in app.visoes.values():
                if app.arquivo.salva_script(visao.caminho_abs, visao.query):
                    novo_indice.add(visao.caminho_rel)

        if app.funcoes:
            app.cria_diretorios([banco, Function.tipo])
            for funcao in app.funcoes.values():
                if app.arquivo.salva_script(funcao.caminho_abs, funcao.query):
                    novo_indice.add(funcao.caminho_rel)

        if app.procedimentos:
            app.cria_diretorios([banco, Procedure.tipo])
            for proced in app.procedimentos.values():
                if app.arquivo.salva_script(proced.caminho_abs, proced.query):
                    novo_indice.add(proced.caminho_rel)

        if app.triggers:
            app.cria_diretorios([banco, Trigger.tipo])
            for trigger in app.triggers.values():
                if app.arquivo.salva_script(trigger.caminho_abs, trigger.query):
                    novo_indice.add(trigger.caminho_rel)

        if app.indices:
            app.cria_diretorios([banco, Index.tipo])
            for indice in app.indices.values():
                if app.arquivo.salva_script(indice.caminho_abs, indice.query):
                    novo_indice.add(indice.caminho_rel)

        if app.grupos:
            app.cria_diretorios([banco, Role.tipo])
            for grupo in app.grupos.values():
                if app.arquivo.salva_script(grupo.caminho_abs, grupo.query):
                    novo_indice.add(grupo.caminho_rel)

        app.arquivo.salva_script(
            app.bancos[banco].caminho_abs, app.bancos[banco].query)
        app.sicronizador.sincronizar(app.indice_caminho, novo_indice)

        tabelas += len(app.tabelas)
        visoes += len(app.visoes)
        funcoes += len(app.funcoes)
        procedimentos += len(app.procedimentos)
        triggers += len(app.triggers)
        indices += len(app.indices)
        grupos += len(app.grupos)

        texto: str = f"{len(app.tabelas)} tables, {len(app.visoes)} views, "
        texto += f"{len(app.funcoes)} functions, "
        texto += f"{len(app.procedimentos)} procedures, "
        texto += f"{len(app.triggers)} triggers, {len(app.indices)} indices, "
        texto += f"{len(app.grupos)} grupos"
        print(texto, file=arq)

    app.db_man.desconectar()

    texto: str = f"\n\n---- TOTAL ----\n"
    texto += f'{tabelas} tables, {visoes} views, '
    texto += f'{funcoes} functions, {procedimentos} procedures, '
    texto += f'{triggers} triggers, {indices} indices, {grupos} grupos\n'
    print(texto, file=arq)

    fim: float = time.time()
    tempo: str = f'\nTempo total : {fim - inicio:.2f} segundos'

    print(tempo, file=arq)
    print(tempo)

    arq.close()
