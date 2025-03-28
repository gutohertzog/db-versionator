from dataclasses import dataclass
from pyodbc import Row


@dataclass(frozen=True)
class EntityDTO:
    """ a mesma query é usada para resgatar as funções, procedimentos, visões e
    gatilhos, então não é necessário dataclasses para cada um dos objetos, mas
    classes específicas são usadas """
    banco: str
    esquema: str
    nome_entidade: str
    tipo: str
    definicao: str

    @classmethod
    def row_to_entity_dto(cls, row: Row) -> "EntityDTO":
        return cls(
            banco = row.banco,
            esquema = row.esquema,
            nome_entidade = row.nome_entidade,
            tipo = row.tipo,
            definicao = EntityDTO.gera_definicao(row.definicao)
        )

    @staticmethod
    def gera_definicao(str_rows: str) -> str:
        """ remove os \r\n desnecessários que estão no começo e no fim das
        entidades e remove o espaço excedente à direita de cada string """
        str_rows = str_rows.strip()
        linhas = [linha.rstrip() for linha in str_rows.split("\r\n")]
        return "\n".join(linhas)


@dataclass(frozen=True)
class IndexDTO:
    banco: str
    esquema: str
    tabela: str
    nome_indice: str
    clusterizado: str
    eh_inclusivo: bool
    nome_coluna: str

    @classmethod
    def row_to_index_dto(cls, row: Row) -> "IndexDTO":
        return cls(
            banco = row.banco,
            esquema = row.esquema,
            tabela = row.tabela,
            nome_indice = row.nome_indice,
            clusterizado = row.tipo_indice,
            eh_inclusivo = bool(row.eh_inclusivo),
            nome_coluna = row.nome_coluna,
        )
