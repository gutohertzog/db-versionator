from ..dto.tabela import TableDTO, ColumnDTO
from ..models.constraints import PrimaryKey, ForeignKey, Check, Default, Unique
from ..models.permission import Permission


class Table:
    tipo: str = "tables"

    def __init__(self) -> None:
        # atributos de identificação
        self.banco: str = ""
        self.esquema: str = ""
        self.nome_tabela: str = ""

        # atributos de características
        self.colunas: list[Column] = []
        self.chave_pk: PrimaryKey = None
        self.chaves_fk: list[ForeignKey] = []
        self.checks: list[Check] = []
        self.defaults: list[Default] = []
        self.uniques: list[Unique] = []
        self.permissoes: list[Permission] = []

        # caminhos de salvamento do arquivo
        self.caminho_abs: str = ""
        self.caminho_rel: str = ""

    def gera_query_tabela(self) -> None:
        """ função para criar a query de criação da tabela """
        # gera a query dos atributos com as marcações das colunas PKs e FKs
        [atr.cria_query_coluna() for atr in self.colunas]

        self.query: str = f"USE [{self.banco}]\nGO\n\n"
        self.query += f"CREATE TABLE "
        self.query += f"[{self.esquema}].[{self.nome_tabela}] (\n    "
        self.query += f"{"\n    ,".join([atr.query for atr in self.colunas])}"

        # adicionar aqui ainda a criação das PK e FKs
        if self.chave_pk:
            self.query += f"\n\n    {self.chave_pk.query.strip()}"

        if self.uniques:
            for unique in self.uniques:
                self.query += f"\n\n    {unique.query.strip()}"

        if self.chaves_fk:
            for chave in self.chaves_fk:
                self.query += f"\n\n    {chave.query.strip()}"

        if self.checks:
            for check in self.checks:
                self.query += f"\n\n    {check.query.strip()}"

        self.query += "\n)\nGO\n"

        if self.defaults:
            for default in self.defaults:
                self.query += f"\n{default.query.strip()}\nGO\n"

        if self.permissoes:
            for permissao in self.permissoes:
                permissao.cria_query_permissao()
                self.query += f"\n{permissao.query}"
            self.query += "\nGO\n"

    def marca_pk(self) -> None:
        """ marca os atributos que fazem parte da chave primária """
        for col in self.colunas:
            if col.nome_coluna in self.chave_pk.colunas:
                col.eh_pk = True

    def marca_fk(self) -> None:
        """ marca os atributos que fazem parte de uma chave estrangeira """
        for col in self.colunas:
            for fk in self.chaves_fk:
                if col.nome_coluna in fk.colunas:
                    col.eh_fk = True
                    col.tabelas_fk.append(fk.tabela_pk)

    def marca_ck(self) -> None:
        """ marca as colunas que são CHECK ou DEFAULT e limpa os campos """
        for col in self.colunas:
            for check in self.checks:
                if col.nome_coluna == check.coluna:
                    col.eh_check = True

                    limpo: str = check.definicao[1:-1]
                    limpo = limpo.replace(col.nome_coluna, "")
                    limpo = limpo.replace("[]", "")
                    limpo = limpo.replace("='", "'")
                    limpo = limpo.replace("(", " ")
                    limpo = limpo.replace(")", " ")
                    limpo = limpo.replace("  ", " ")

                    col.check = limpo

    def marca_df(self) -> None:
        """ marca as colunas que são CHECK ou DEFAULT e limpa os campos """
        for atr in self.colunas:
            for default in self.defaults:
                if atr.nome_coluna == default.coluna:
                    atr.eh_default = True
                    limpo: str = default.definicao[1:-1]

                    # remove parênteses das fórmulas
                    if not "()" in limpo:
                        limpo = limpo.replace("(", "")
                        limpo = limpo.replace(")", "")

                    atr.default = limpo

    def marca_uk(self) -> None:
        """ marca as colunas que fazem parte de uma constraint UNIQUE """
        for atr in self.colunas:
            for unique in self.uniques:
                if atr.nome_coluna in unique.colunas:
                    atr.eh_unique = True

    @classmethod
    def fabrica_tabela(cls, dto: TableDTO) -> "Table":
        tabela = cls()
        tabela.banco = dto.banco
        tabela.esquema = dto.esquema
        tabela.nome_tabela = dto.nome_tabela
        return tabela

    def __str__(self) -> str:
        texto: str = f"[{self.banco}].[{self.esquema}].[{self.nome_tabela}]\n"
        for col in self.colunas:
            texto += f"    {col}\n"
        return texto


class Column:
    def __init__(self) -> None:
        # atributos de identificação
        self.banco: str = ""
        self.esquema: str = ""
        self.tabela: str = ""
        self.nome_coluna: str = ""

        # atributos de definição
        self.tipo: str = ""
        self.posicao: int = 0
        self.tamanho: int = 0
        self.precisao: int = 0
        self.decimais: int = 0
        self.eh_nulo: bool = False
        self.eh_identidade: bool = False

        # atributos das constraints
        self.eh_pk: bool = False
        self.eh_fk: bool = False
        self.eh_check: bool = False
        self.eh_default: bool = False
        self.eh_unique: bool = False
        self.tabelas_fk: list[str] = []
        self.check: str = ""
        self.default: str = ""

        self.query: str = ""

    def cria_query_coluna(self) -> None:
        self.query = f"[{self.nome_coluna}] {self.tipo}"

        if self.tipo in ("numeric", "decimal"):
            self.query += f"({self.precisao}, {self.decimais})"
        elif "char" in self.tipo or "varbinary" in self.tipo:
            if self.tamanho == -1:
                self.query += "(MAX)"
            else:
                # para tipos de dados como nvarchar, o valor é dividido
                # por 2 para obter o número de caracteres.
                if self.tipo == "nvarchar":
                    self.query += f"({int(self.tamanho / 2)})"
                else:
                    self.query += f"({self.tamanho})"

        if self.eh_nulo:
            self.query += " NULL"
        else:
            self.query += " NOT NULL"

        if self.eh_identidade:
            self.query += " IDENTITY(1,1)"

        comentarios: list[str] = []
        if self.eh_pk:
            comentarios.append("PK")
        if self.eh_unique:
            comentarios.append("UK")
        if self.eh_fk:
            comentarios.append(f"FK [{", ".join(self.tabelas_fk)}]")
        if self.eh_default:
            comentarios.append(f"DF [{self.default}]")
        if self.eh_check:
            comentarios.append(f"CK [{self.check}]")
        if comentarios:
            self.query += " -- " + " ".join(comentarios)

    @classmethod
    def fabrica_coluna(cls, dto: ColumnDTO) -> "Column":
        nova_coluna = cls()
        nova_coluna.banco = dto.banco
        nova_coluna.esquema = dto.esquema
        nova_coluna.tabela = dto.tabela
        nova_coluna.nome_coluna = dto.nome_coluna
        nova_coluna.tipo = dto.tipo
        nova_coluna.tamanho = dto.tamanho
        nova_coluna.precisao = dto.precisao
        nova_coluna.decimais = dto.decimais
        nova_coluna.eh_nulo = dto.eh_nulo
        nova_coluna.eh_identidade = dto.eh_identidade
        nova_coluna.posicao = dto.posicao
        return nova_coluna

    def __str__(self) -> str:
        return f"{self.posicao} - {self.nome_coluna} {self.tipo}"
