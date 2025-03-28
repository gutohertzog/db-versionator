from dataclasses import dataclass
from pyodbc import Row


@dataclass(frozen=True)
class PermissionDTO:
    banco: str
    esquema: str
    objeto_nome: str
    objeto_tipo: str
    usuario: str
    usuario_tipo: str
    permissao: str

    @classmethod
    def row_to_permission_dto(cls, row: Row) -> "PermissionDTO":
        return cls(
            banco = row.banco,
            esquema = row.esquema,
            objeto_nome = row.objeto_nome,
            objeto_tipo = row.objeto_tipo,
            usuario = row.usuario,
            usuario_tipo = row.usuario_tipo,
            permissao = row.permissao,
        )


@dataclass(frozen=True)
class RoleDTO:
    banco: str
    nome_grupo: str
    id: int

    @classmethod
    def row_to_role_dto(cls, row: Row) -> "RoleDTO":
        return cls(
            banco = row.banco,
            nome_grupo = row.grupo_nome,
            id = row.id,
        )


@dataclass
class UserDTO:
    banco: str
    nome: str
    tipo: str
    role: str

    @classmethod
    def row_to_user_dto(cls, row: Row) -> "UserDTO":
        return UserDTO(
            banco = row.banco,
            nome = row.usuario,
            tipo = row.tipo_usuario,
            role = row.grupo,
        )
