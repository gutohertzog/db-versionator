from dataclasses import dataclass
from pyodbc import Row


@dataclass(frozen=True)
class TableDTO:
    banco: str
    esquema: str
    nome_tabela: str

    @classmethod
    def row_to_table_dto(cls, row: Row) -> "TableDTO":
        return cls(
            banco = row.banco,
            esquema = row.esquema,
            nome_tabela = row.tabela,
        )


@dataclass(frozen=True)
class ColumnDTO:
    banco: str
    esquema: str
    tabela: str
    nome_coluna: str
    tipo: str
    tamanho: int
    precisao: int
    decimais: int
    eh_nulo: bool
    eh_identidade: bool
    posicao: int

    @classmethod
    def row_to_column_dto(cls, row: Row) -> "ColumnDTO":
        return cls(
            banco = row.banco,
            esquema = row.esquema,
            tabela = row.tabela,
            nome_coluna = row.coluna,
            tipo = row.col_tipo,
            tamanho = row.col_tamanho_raw,
            precisao = row.col_precisao_raw,
            decimais = row.escala,
            eh_nulo = bool(row.eh_nulo),
            eh_identidade = bool(row.eh_identity),
            posicao = row.posicao,
        )
