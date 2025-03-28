from dataclasses import dataclass
from pyodbc import Row


@dataclass(frozen=True)
class PrimaryKeyDTO:
    banco: str
    esquema: str
    tabela: str
    nome_constraint: str
    coluna: str

    @classmethod
    def row_to_pk_dto(cls, row: Row) -> "PrimaryKeyDTO":
        return cls(
            banco = row.banco,
            esquema = row.esquema,
            tabela = row.tabela,
            nome_constraint = row.nome_pk,
            coluna = row.nome_col
        )


@dataclass(frozen=True)
class ForeignKeyDTO:
    banco: str
    esquema: str
    tabela: str
    nome_constraint: str
    coluna: str
    esquema_ref: str
    tabela_ref: str
    coluna_ref: str

    @classmethod
    def row_to_fk_dto(cls, row: Row) -> "ForeignKeyDTO":
        return cls(
            banco = row.banco,
            esquema = row.esquema,
            tabela = row.tabela,
            nome_constraint = row.nome_fk,
            coluna = row.col_fk_nome,
            esquema_ref = row.esquema_ref,
            tabela_ref = row.tabela_ref,
            coluna_ref = row.col_fk_nome_ref,
        )


@dataclass
class CheckDTO:
    banco: str
    esquema: str
    tabela: str
    check_constraint: str
    coluna: str
    definicao: str

    @classmethod
    def row_to_check_dto(cls, row: Row) -> "CheckDTO":
        return cls(
            banco = row.banco,
            esquema = row.esquema,
            tabela = row.tabela,
            check_constraint = row.check_constraint,
            coluna = row.coluna,
            definicao = row.definicao,
        )


@dataclass
class DefaultDTO:
    banco: str
    esquema: str
    tabela: str
    default_constraint: str
    coluna: str
    definicao: str

    @classmethod
    def row_to_default_dto(cls, row: Row) -> "DefaultDTO":
        # o campo constraint_type é usado para especificar a coluna que o
        # DEFAULT referencia
        return cls(
            banco = row.banco,
            esquema = row.esquema,
            tabela = row.tabela,
            default_constraint = row.default_constraint,
            coluna = row.coluna,
            definicao = row.definicao,
        )


@dataclass
class UniqueDTO:
    banco: str
    esquema: str
    tabela: str
    unique_constraint: str
    col_ordem: int
    col_nome: str
    tipo: str

    @classmethod
    def row_to_unique_dto(cls, row: Row) -> "UniqueDTO":
        return cls(
            banco = row.banco,
            esquema = row.esquema,
            tabela = row.tabela,
            unique_constraint = row.unique_constraint,
            col_ordem = row.col_ordem,
            col_nome = row.col_nome,
            # 1 = CLUSTERED, 2 = NONCLUSTERED
            tipo = "CLUSTERED" if row.tipo else "NONCLUSTERED"
        )
