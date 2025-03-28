from ..dto.constraints import (
    CheckDTO, DefaultDTO, ForeignKeyDTO, PrimaryKeyDTO, UniqueDTO)

class Constraint:
    def __init__(self) -> None:
        self.banco: str = ""
        self.esquema: str = ""
        self.tabela: str = ""
        self.nome_constraint: str = ""
        self.query: str = ""

    def __str__(self) -> str:
        texto: str = f"{self.banco}.{self.esquema}.{self.tabela}."
        texto += f"{self.nome_constraint}"
        return texto


class PrimaryKey(Constraint):
    def __init__(self) -> None:
        super().__init__()
        self.colunas: list[str] = []

    def cria_query_pk(self) -> None:
        """ função para criar a query de criação da chave primária """
        self.query += (
            f"    ,CONSTRAINT [{self.nome_constraint}]\n"
            f"        PRIMARY KEY ("
        )
        self.query += ", ".join([f"[{col}]" for col in self.colunas])
        self.query += ")"

    @classmethod
    def fabrica_pk(cls, dto: PrimaryKeyDTO) -> "PrimaryKey":
        nova_pk = cls()
        nova_pk.banco = dto.banco
        nova_pk.esquema = dto.esquema
        nova_pk.tabela = dto.tabela
        nova_pk.nome_constraint = dto.nome_constraint
        return nova_pk


class ForeignKey(Constraint):
    """ classe para representar uma chave estrangeira de uma tabela """
    def __init__(self) -> None:
        super().__init__()
        self.colunas: list[str] = []
        self.tabela_pk: str = ""
        self.colunas_pk: list[str] = []

    def cria_query_fk(self) -> None:
        """ função para criar a query de criação da chave estrangeira """
        self.query += (
            f"    ,CONSTRAINT [{self.nome_constraint}]\n"
            "        FOREIGN KEY ("
        )
        self.query += ", ".join([f"[{col}]" for col in self.colunas]) + ")\n"
        self.query += "        REFERENCES "
        self.query += f"[{self.esquema}].[{self.tabela_pk}] ("
        self.query += ", ".join([f"[{col}]" for col in self.colunas_pk])
        self.query += ")"

    @classmethod
    def fabrica_fk(cls, dto: ForeignKeyDTO) -> "ForeignKey":
        nova_fk = cls()
        nova_fk.banco = dto.banco
        nova_fk.esquema = dto.esquema
        nova_fk.tabela = dto.tabela
        nova_fk.nome_constraint = dto.nome_constraint
        nova_fk.tabela_pk = dto.tabela_ref
        return nova_fk


class Check(Constraint):
    """ essas constraint precisa ser recuperanda usando a pr
    sp_helpconstraint 'banco.esquema.tabela' """
    def __init__(self) -> None:
        super().__init__()
        self.coluna: str
        self.definicao: str

    def cria_query_check(self) -> None:
        self.query += (
            f"    ,CONSTRAINT [{self.nome_constraint}]\n"
            f"        CHECK ({self.definicao})"
        )

    @classmethod
    def fabrica_ck(cls, dto: CheckDTO) -> "Check":
        novo_check: Check = cls()
        novo_check.banco = dto.banco
        novo_check.esquema = dto.esquema
        novo_check.tabela = dto.tabela
        novo_check.nome_constraint = dto.check_constraint
        novo_check.coluna = dto.coluna
        novo_check.definicao = dto.definicao
        return novo_check


class Default(Constraint):
    """ essas constraint precisa ser recuperanda usando a pr
    sp_helpconstraint 'banco.esquema.tabela' """
    def __init__(self) -> None:
        super().__init__()
        self.coluna: str
        self.definicao: str

    def cria_query_default(self) -> None:
        """ diferente das demais constraints, a DEFAULT precisa ser gerada
        usando ALTER TABLE, por alguma limitação do SQL Server, ela não pode
        ser gerada dentro do CREATE TABLE """
        self.query += (
            f"ALTER TABLE [{self.esquema}].[{self.tabela}]"
            f" ADD CONSTRAINT [{self.nome_constraint}]\n"
            f"    DEFAULT ({self.definicao}) FOR [{self.coluna}]"
        )

    @classmethod
    def fabrica_df(cls, dto: DefaultDTO) -> "Default":
        novo_default: Default = cls()
        novo_default.banco = dto.banco
        novo_default.esquema = dto.esquema
        novo_default.tabela = dto.tabela
        novo_default.nome_constraint = dto.default_constraint
        novo_default.coluna = dto.coluna
        novo_default.definicao = dto.definicao
        return novo_default


class Unique(Constraint):
    """ classe para representar as constraints UNIQUE de uma tabela """
    def __init__(self) -> None:
        super().__init__()
        self.colunas: list[str] = []
        self.col_ordem: int
        self.tipo: str  # CLUSTERED ou NONCLUSTERED

    def cria_query_unique(self) -> None:
        """ função para gerar a query de criação da constraint UNIQUE """
        self.query += f"    ,CONSTRAINT [{self.nome_constraint}]\n"
        self.query += f"        UNIQUE {self.tipo} ("
        self.query += ", ".join([f"[{coluna}]" for coluna in self.colunas])
        self.query += ")"

    @classmethod
    def fabrica_uk(cls, dto: UniqueDTO) -> "Unique":
        novo_unique: Unique = cls()
        novo_unique.banco = dto.banco
        novo_unique.esquema = dto.esquema
        novo_unique.tabela = dto.tabela
        novo_unique.nome_constraint = dto.unique_constraint
        novo_unique.colunas = [dto.col_nome]
        novo_unique.col_ordem = dto.col_ordem
        novo_unique.tipo = dto.tipo
        return novo_unique
