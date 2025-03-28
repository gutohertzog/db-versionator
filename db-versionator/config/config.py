""" módulo das constantes de configuração do sistema """

ARQ_LOG: str = "app.log"
DIR_BASE: str = "sql"
ARQ_OBJS: str = "objetos.txt"

# bancos e suas configurações
BANCOS: dict[str, dict[str, str | int | bool]] = {
    "DEV": {
        "server": "localhost\\TYPHOON",
        "nome": "localhost",
        "dir": "DEV",
        "log-level": 10,  # DEBUG level
        "trusted": True
    },
    # modelo de uma segunda conexão
    # "TST": {
    #     "server": "localhost_teste",
    #     "nome": "teste",
    #     "dir": "TST",
    #     "log-level": 10,  # DEBUG level
    #     "trusted": True
    # },
}

# abaixo há uma lista de esquemas que serão ignorados
EXCLUDED_SCHEMAS: list[str] = [
    "sys",
    "INFORMATION_SCHEMA",
    "db_accessadmin",
    "db_backupoperator",
    "db_datareader",
    "db_datawriter",
    "db_ddladmin",
    "db_denydatareader",
    "db_denydatawriter",
    "db_owner",
    "db_securityadmin",
    "guest",
    "public",
]

EXCLUDED_DATABASES: list[str] = [
    # "master",
    # "msdb",
    "tempdb",
    "model",
    "ReportServer",
    "ReportServerTempDB",
]
