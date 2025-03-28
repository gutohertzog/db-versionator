from ..dto import database as dto_db


class Banco:
    def __init__(self) -> None:
        self.nome_banco: str = ""
        self.query: str = ""

        # caminho de salvamento do arquivo
        self.caminho_abs: str = ""

        # dados do arquivo de banco de dados
        self.dados_banco: dict[str, str] = {}
        # dados do arquivo de logo do banco de dados
        self.dados_log: dict[str, str] = {}

        # variável para as especificações do banco de dados, como
        # ANSI_NULLS, CURSOR_DEFAULT, RECURSIVE_TRIGGERS, etc
        self.specs: dict[str, str] = {}

        # variável para os usuários do banco de dados
        # chave -> usuario
        self.usuarios: dict[str, dict[str, str]] = {}

    def gera_query(self) -> None:
        self.query += f"USE [master]\nGO\n\n"
        self.query += f"CREATE DATABASE [{self.nome_banco}]\n"
        self.query += f"    CONTAINMENT = {self.specs["CONTAINMENT"]}\n"
        self.query += f"    ON PRIMARY\n    (\n        "
        self.query += f"NAME = N'{self.dados_banco['filename']}',\n        "
        self.query += f"FILENAME = N'{self.dados_banco['physical_name']}',\n        "
        self.query += f"SIZE = {self.dados_banco['size']},\n        "
        self.query += f"MAXSIZE = {self.dados_banco['maxsize']},\n        "
        self.query += f"FILEGROWTH = {self.dados_banco['growth']}\n    )\n"
        self.query += f"    LOG ON\n    (\n        "
        self.query += f"NAME = N'{self.dados_log['filename']}',\n        "
        self.query += f"FILENAME = N'{self.dados_log['physical_name']}',\n        "
        self.query += f"SIZE = {self.dados_log['size']},\n        "
        self.query += f"MAXSIZE = {self.dados_log['maxsize']},\n        "
        self.query += f"FILEGROWTH = {self.dados_log['growth']}\n    )\nGO\n\n"
        # self.query += f"    WITH CATALOG_COLLATION = {self.specs['CATALOG_COLLATION']},\n"
        # self.query += f"    LEDGER = {self.specs['LEDGER']}\nGO\n\n"
        self.query += "IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))\n"
        self.query += "begin\n   "
        self.query += f"EXEC [{self.nome_banco}].[dbo].[sp_fulltext_database] @action = 'enable'"
        self.query += "\nend\nGO\n\n"

        base: str = "ALTER DATABASE [{}] SET {} {}\n"
        for chave, valor in self.specs.items():
            if chave.islower():
                self.query += f"ALTER DATABASE [{self.nome_banco}] SET {valor}\n"
                #! QUE COISA HORRÍVEL, MAS FUNCIONA
                if chave == "read":
                    break
                continue
            self.query += base.format(self.nome_banco, chave, valor)
        self.query += "GO\n"

        # criação dos usuários
        if self.usuarios:
            for usuario in self.usuarios.values():
                self.query += f"\nCREATE USER [{usuario['nome']}]"

                if usuario["esquema"]:
                    if not usuario["login"]:
                        self.query += " WITHOUT LOGIN"
                    elif usuario["login"]:
                        self.query += f" FOR LOGIN [{usuario['login']}]"
                    self.query += f" WITH DEFAULT_SCHEMA=[{usuario['esquema']}]"

                self.query += f" -- {usuario['tipo']}"

            self.query += "\nGO\n"

    @classmethod
    def fabrica_db(cls, dto: dto_db.BancoDTO) -> "Banco":
        """ essa fábrica espera como objeto um dto
        resultante da query DATABASE """
        novo_banco = cls()
        novo_banco.nome_banco = dto.nome_banco
        novo_banco.specs = dto.especificacoes
        novo_banco.dados_banco = dto.dados
        return novo_banco

    @classmethod
    def fabrica_db_log(cls, dto: dto_db.BancoDTO) -> "Banco":
        """ essa fábrica espera como objeto um dto
        resultante da query DATABASE """
        novo_banco = cls()
        novo_banco.nome_banco = dto.nome_banco
        novo_banco.dados_log = dto.dados
        return novo_banco
