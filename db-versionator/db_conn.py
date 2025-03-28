from contextlib import contextmanager
from getpass import getpass
from typing import Optional, Any

from pyodbc import Connection, Cursor, Row, connect
from pyodbc import Error, ProgrammingError

from .models.arquivo import Logger

class DatabaseManager:
    def __init__(
            self,
            logger: Logger,
            driver: str = "ODBC Driver 17 for SQL Server",
            server: str = "localhost",
            database: str = "master",
            trusted_connection: bool = True):
        # variáveis do banco de dados
        self._driver: str = driver
        self._server: str = server
        self._database: str = database
        self._trusted_connection: bool = trusted_connection

        self._conexao: Connection = None
        self._cursor: Cursor = None

        # variável de logging
        self.logger: Logger = logger

    def _construir_string_conexao(self) -> str:
        conn_str: str = (
            f"DRIVER={{{self._driver}}};"
            f"SERVER={self._server};"
            f"DATABASE={self._database};"
        )

        if self._trusted_connection:
            conn_str += "Trusted_Connection=yes;"
        else:
            usario: str = input("Usuário : ")
            senha: str = getpass("  Senha : ")
            print("\n")
            conn_str += f"UID={usario};PWD={senha}"

        return conn_str

    def conectar(self) -> None:
        if self._conexao:
            return

        conn_str = self._construir_string_conexao()

        try:
            self._conexao: Connection = connect(conn_str)
            self._cursor:Cursor = self._conexao.cursor()
            self.logger.info("Conexão estabelecida com sucesso")
        except Error:
            self.logger.error(f"Erro na conexão.")
            raise

    def desconectar(self) -> None:
        if self._conexao:
            self._conexao.close()
            del self._conexao
            del self._cursor
            self.logger.info("Conexão fechada")

    @contextmanager
    def conexao(self):
        """ gerenciador de contexto (with) para uso seguro da conexão """
        self.conectar()
        try:
            yield self
        finally:
            self.desconectar()

    def executar(
            self,
            query: str,
            parametros: list[str] = [],
            commit: bool = False,
            fetch: bool = True) -> list[Row]:
        """
        executa uma query e retorna resultados se solicitado

        Args:
            query : query SQL a ser executada;
            parametros : lista de parâmetros para query parametrizada;
            commit : se deve fazer commit após a execução;
            fetch : se deve retornar resultados;

        Returns:
            Lista de dicionários com resultados ou None
        """
        if not self._conexao:
            self.logger.error("Conexão não estabelecida")
            return []

        try:
            # execução segura com parâmetros
            if parametros:
                self._cursor.execute(query, parametros)
            else:
                self._cursor.execute(query)

            if commit:
                self._conexao.commit()
                self.logger.info("Commit realizado")

            if fetch:
                return self._cursor.fetchall()

            return []

        except ProgrammingError:
            self.logger.error(f"Erro na query: {query}.")
            return []

        except Error:
            self.logger.error(
                f"Erro de banco na query: {query}.")
            return []

    def cursor_objetos(self, tipo: str, nome: str = "") -> list[Row]:
        """ retorna dados específicos a partir do cursor """
        objetos: list[Row] = []

        if tipo == "tables":
            objetos: list[Row] = [
                t for t in self._cursor.tables(tableType="TABLE")]
        elif tipo == "views":
            objetos: list[Row] = [
                v for v in self._cursor.tables(tableType="VIEW")]
        elif tipo == "columns":
            objetos: list[Row] = [c for c in self._cursor.columns(table=nome)]
        elif tipo == "pk":
            objetos: list[Row] = [
                pk for pk in self._cursor.primaryKeys(table=nome)]
        elif tipo == "fk":
            objetos: list[Row] = [
                fk for fk in self._cursor.foreignKeys(foreignTable=nome)]

        return objetos if objetos else []

    # os dois métodos abaixo são usados para permitir o uso do
    # gerenciador de contexto
    def __enter__(self):
        self.conectar()
        return self

    def __exit__(
            self,
            # parâmetros abaixo necessários para o gerenciador de contexto
            exc_type: Optional[type],
            exc_val: Optional[BaseException],
            exc_traceback: Optional[Any]):
        self.desconectar()
