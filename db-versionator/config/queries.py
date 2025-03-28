""" queries para SQL Server """

DATABASES: str = """SELECT
    db.name AS nome_banco,
    mf.name AS nome_arquivo,
    mf.physical_name,
    mf.size,
    mf.max_size,
    mf.is_percent_growth,
    mf.growth,
    mf.type_desc,
    db.*
FROM
    sys.databases db
INNER JOIN
    sys.master_files mf
    ON db.database_id = mf.database_id
WHERE
    mf.type_desc = 'ROWS'
ORDER BY
    db.name, mf.name, mf.type_desc;
"""

DATABASES_LOGS: str = """SELECT
    db.name AS nome_banco,
    mf.name AS nome_arquivo,
    mf.physical_name,
    mf.size,
    mf.max_size,
    mf.is_percent_growth,
    mf.growth,
    mf.type_desc
FROM
    sys.databases db
INNER JOIN
    sys.master_files mf
    ON db.database_id = mf.database_id
WHERE
    mf.type_desc = 'LOG'
ORDER BY
    db.name, mf.name, mf.type_desc;
"""

TABLES: str = """SELECT
    DB_NAME() AS banco,
    s.name AS esquema,
    t.name AS tabela
FROM
    sys.tables t
INNER JOIN
    sys.schemas s
    ON t.schema_id = s.schema_id;
"""

COLUMNS: str = """SELECT
    DB_NAME() AS banco,
    SCHEMA_NAME(t.schema_id) AS esquema,
    t.name AS tabela,
    c.name AS coluna,
    ty.name AS col_tipo,
    c.max_length AS col_tamanho_raw,
    c.precision AS col_precisao_raw,
    c.scale AS escala,
    c.is_nullable AS eh_nulo,
    c.is_identity AS eh_identity,
    c.column_id AS posicao
FROM
    sys.tables t
INNER JOIN
    sys.columns c
    ON t.object_id = c.object_id
INNER JOIN
    sys.types ty
    ON c.user_type_id = ty.user_type_id
ORDER BY
    banco, esquema, tabela, posicao;
"""

PRIMARY_KEYS: str = """SELECT
    DB_NAME() AS banco,
    SCHEMA_NAME(t.schema_id) AS esquema,
    t.name AS tabela,
    pk.name AS nome_pk,
    ic.key_ordinal AS ordem_col,
    c.name AS nome_col
FROM
    sys.tables t
INNER JOIN
    sys.indexes pk
    ON t.object_id = pk.object_id
    AND pk.is_primary_key = 1
INNER JOIN
    sys.index_columns ic
    ON pk.object_id = ic.object_id
    AND pk.index_id = ic.index_id
INNER JOIN
    sys.columns c
    ON ic.object_id = c.object_id
    AND ic.column_id = c.column_id
ORDER BY
    banco, esquema, tabela, nome_pk, ordem_col;
"""

FOREIGN_KEYS: str = """SELECT
    DB_NAME() AS banco,
    SCHEMA_NAME(t.schema_id) AS esquema,
    t.name AS tabela,
    fk.name AS nome_fk,
    --fkc.constraint_column_id AS col_fk_ord,
    c.name AS col_fk_nome,
    SCHEMA_NAME(rt.schema_id) AS esquema_ref,
    rt.name AS tabela_ref,
    rc.name AS col_fk_nome_ref
FROM
    sys.foreign_keys fk
INNER JOIN
    sys.tables t
    ON fk.parent_object_id = t.object_id
INNER JOIN
    sys.foreign_key_columns fkc
    ON fk.object_id = fkc.constraint_object_id
INNER JOIN
    sys.columns c
    ON fkc.parent_object_id = c.object_id
    AND fkc.parent_column_id = c.column_id
INNER JOIN
    sys.tables rt
    ON fk.referenced_object_id = rt.object_id
INNER JOIN
    sys.columns rc
    ON fkc.referenced_object_id = rc.object_id
    AND fkc.referenced_column_id = rc.column_id
ORDER BY
    banco, esquema, tabela, nome_fk, fkc.constraint_column_id;
"""

CHECKS: str = """SELECT
    DB_NAME() AS banco,
    SCHEMA_NAME(t.schema_id) AS esquema,
    t.name AS tabela,
    cc.name AS check_constraint,
    col.name AS coluna,
    cc.definition AS definicao
FROM
    sys.check_constraints cc
INNER JOIN
    sys.tables t
    ON cc.parent_object_id = t.object_id
INNER JOIN
    sys.columns col
    ON cc.parent_column_id = col.column_id
    AND cc.parent_object_id = col.object_id
ORDER BY
    banco, esquema, tabela, check_constraint;
"""

DEFAULTS: str = """SELECT
    DB_NAME() AS banco,
    SCHEMA_NAME(t.schema_id) AS esquema,
    t.name AS tabela,
    dc.name AS default_constraint,
    col.name AS coluna,
    dc.definition AS definicao
FROM
    sys.default_constraints dc
INNER JOIN
    sys.tables t
    ON dc.parent_object_id = t.object_id
INNER JOIN
    sys.columns col
    ON dc.parent_column_id = col.column_id
    AND dc.parent_object_id = col.object_id
ORDER BY
    banco, esquema, tabela, default_constraint;
"""

UNIQUES: str = """SELECT
    DB_NAME() AS banco,
    SCHEMA_NAME(t.schema_id) AS esquema,
    t.name AS tabela,
    kc.name AS unique_constraint,
    ic.key_ordinal AS col_ordem,
    col.name AS col_nome,
    i.type AS tipo
FROM
    sys.key_constraints kc
INNER JOIN
    sys.tables t
    ON kc.parent_object_id = t.object_id
INNER JOIN
    sys.indexes i
    ON kc.parent_object_id = i.object_id
    AND kc.unique_index_id = i.index_id
INNER JOIN
    sys.index_columns ic
    ON i.object_id = ic.object_id
    AND i.index_id = ic.index_id
INNER JOIN
    sys.columns col
    ON ic.object_id = col.object_id
    AND ic.column_id = col.column_id
WHERE
    kc.type = 'UQ'
ORDER BY
    banco, esquema, tabela, unique_constraint, col_ordem;
"""

# a query das entidades tem a capacidade de resgatar os objetos abaixo sem where
# - procedimentos   -> WHERE o.type = 'P'
# - funções         -> WHERE o.type IN ('FN', 'IF', 'TF')
# - visões          -> WHERE o.type = 'V'
# - gatilhos        -> WHERE o.type = 'TR'
ENTITIES: str = """SELECT
    DB_NAME() AS banco,
    SCHEMA_NAME(o.schema_id) AS esquema,
    o.name AS nome_entidade,
    o.type as tipo,
    m.definition AS definicao
FROM
    sys.objects o
INNER JOIN
    sys.sql_modules m
    ON o.object_id = m.object_id
ORDER BY
    banco, esquema, nome_entidade;
"""

INDEXES: str = """SELECT
    db_name() AS banco
    ,sch.name AS esquema
    ,obj.name AS tabela
    ,ind.name AS nome_indice
    ,col.name AS nome_coluna
    ,ic.is_included_column AS eh_inclusivo
    ,ic.key_ordinal
    ,ind.type_desc AS tipo_indice
    -- ind.is_unique
FROM
    sys.indexes AS ind
JOIN
    sys.index_columns AS ic
    ON ind.index_id = ic.index_id
    AND ind.object_id = ic.object_id
JOIN
    sys.columns AS col
    ON ic.object_id = col.object_id
    AND ic.column_id = col.column_id
JOIN
    sys.objects AS obj
    ON ind.object_id = obj.object_id
JOIN
    sys.schemas AS sch
    ON obj.schema_id = sch.schema_id
WHERE
    ind.is_primary_key = 0
    AND sch.name <> 'sys'
    AND ind.is_unique = 0
ORDER BY
    obj.name, ind.name, ic.key_ordinal, ic.index_column_id;
"""

PERMISSIONS: str = """SELECT
    DB_NAME() AS banco,
    s.name AS esquema,
    o.name AS objeto_nome,
    o.type as objeto_tipo,
    pr.name AS usuario,
    pr.type_desc AS usuario_tipo,
    dp.permission_name AS permissao
FROM
    sys.database_permissions dp
INNER JOIN
    sys.objects o
    ON dp.major_id = o.object_id
INNER JOIN
    sys.schemas s
    ON o.schema_id = s.schema_id
INNER JOIN
    sys.database_principals pr
    ON dp.grantee_principal_id = pr.principal_id
ORDER BY
    banco, esquema, objeto_nome, usuario, permissao;
"""

# queries referente aos grupos
ROLES: str = """SELECT
    db_name() AS banco,
    name AS grupo_nome,
    principal_id AS id
FROM
    sys.database_principals
WHERE
    type = 'R';
"""

# quando é usado o SQL Studio para ver as permissões de um determinado grupo,
# ele vai retornar todos os usuário e grupos que estão incluídos diretamente
# nele e também vai incluir usuários dos grupos que estão dentro desse grupo,
# de forma recursiva
ROLE_USERS: str = """SELECT
    db_name() AS banco,
    dp_member.name AS usuario,
    dp_member.type_desc AS tipo_usuario,
    dp_role.name AS grupo
FROM
    sys.database_role_members drm
INNER JOIN
    sys.database_principals dp_role
    ON drm.role_principal_id = dp_role.principal_id
INNER JOIN
    sys.database_principals dp_member
    ON drm.member_principal_id = dp_member.principal_id
ORDER BY
    grupo, usuario;
"""

# queries para os dados do banco de dados
DB_EXEC: str = "EXEC sp_helpdb '{banco}'"
DB_USERS: str = """SELECT
    dp.principal_id as id,
    dp.name AS usuario,
    dp.type_desc AS tipo,
    dp.default_schema_name AS esquema,
    sp.name AS login
FROM
    sys.database_principals dp
LEFT JOIN
    sys.server_principals sp
    ON dp.sid = sp.sid
WHERE
    dp.type IN ('S', 'U')
ORDER BY
    dp.name;
"""
