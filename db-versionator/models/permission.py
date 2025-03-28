from ..dto import permission as dto_perm

class Permission:
    """ classe para representar as permissões de um usuário em um objeto """
    def __init__(self) -> None:
        self.banco: str = ""
        self.esquema: str = ""
        self.objeto: str = ""
        self.objeto_tipo: str = ""
        self.usuario: str = ""
        self.usuario_tipo: str = ""
        self.permissoes: list[str] = []
        self.query: str = ""

    def cria_query_permissao(self) -> None:
        """ função para gerar a query de criação da permissão """
        self.query += f"GRANT {", ".join(self.permissoes)} ON"
        self.query += f" [{self.objeto}] TO [{self.usuario}]"

    @classmethod
    def fabrica_perm(cls, dto: dto_perm.PermissionDTO) -> "Permission":
        nova_perm = cls()
        nova_perm.banco = dto.banco
        nova_perm.esquema = dto.esquema
        nova_perm.objeto = dto.objeto_nome
        nova_perm.objeto_tipo = dto.objeto_tipo.strip()
        nova_perm.usuario = dto.usuario
        nova_perm.usuario_tipo = dto.usuario_tipo
        return nova_perm


class Role:
    tipo: str = "roles"

    def __init__(self) -> None:
        self.banco: str = ""
        self.nome_role: str = ""
        self.id: int = 0
        self.usuarios: list[User] = []
        self.query: str = ""

        # caminhos de salvamento do arquivo
        self.caminho_abs: str = ""
        self.caminho_rel: str = ""

    def gera_query_role(self) -> None:
        self.query += f"USE [{self.banco}]\nGO\n\n"
        self.query += f"CREATE ROLE [{self.nome_role}]\nGO\n\n"

        if self.usuarios:
            for usuario in self.usuarios:
                self.query += f"ALTER ROLE [{self.nome_role}] "
                self.query += f"ADD MEMBER [{usuario.nome}] "
                self.query += f"-- {usuario.tipo}\n"
            self.query += "GO\n"

    @classmethod
    def fabrica_role(cls, dto: dto_perm.RoleDTO) -> "Role":
        nova_role = cls()
        nova_role.banco = dto.banco
        nova_role.nome_role = dto.nome_grupo
        nova_role.id = dto.id
        return nova_role


class User:
    def __init__(self):
        self.banco = ""
        self.nome = ""
        self.tipo = ""  # DATABASE_ROLE | SQL_USER | WINDOWS_USER
        self.grupo = ""

    @classmethod
    def fabrica_user(cls, dto: dto_perm.UserDTO) -> "User":
        novo_user = cls()
        novo_user.banco = dto.banco
        novo_user.nome = dto.nome
        novo_user.tipo = dto.tipo
        novo_user.grupo = dto.role
        return novo_user
