from dataclasses import dataclass
from pyodbc import Row


@dataclass
class BancoDTO:
    nome_banco: str
    dados: dict[str, str]
    especificacoes: dict[str, str]

    @staticmethod
    def prepara_usuarios(rows: list[Row]) -> dict[str, dict[str, str]]:
        # chave -> usuário
        usuarios: dict[str, dict[str, str]] = {}
        for row in rows:
            usuarios[row.usuario] = {
                "nome": row.usuario,
                "tipo": row.tipo,
                "esquema": row.esquema,
                "login": row.login,
            }
        return usuarios

    @staticmethod
    def prepara_dados_banco(rows: list[Row]) -> dict[str, dict[str, str]]:
        dados: dict[str, dict[str, str]] = {}
        for row in rows:
            if row.filegroup == "PRIMARY":
                dados["dados_banco"] = {
                    "name": row.name,
                    "filename": row.filename,
                    "size": row.size,
                    "maxsize": row.maxsize,
                    "growth": row.growth,
                }
            else:
                dados["dados_log"] = {

                }
        return dados

    @classmethod
    def row_to_db_dto(cls, row: Row) -> "BancoDTO":
        specs: dict[str, str] = {}
        # os dados abaixo são retornados apenas quando é
        # realizada a busca com a query DATABASES
        if row.type_desc == "ROWS":
            # as especificações comentadas são de uma
            # versão mais nova do SQL Server
            specs = {
                # as especificações abaixo fazem parte do ALTER DATABASE
                "ANSI_NULL_DEFAULT": "ON" if row.is_ansi_null_default_on else "OFF",
                "ANSI_NULLS": "ON" if row.is_ansi_nulls_on else "OFF",
                "ANSI_PADDING": "ON" if row.is_ansi_padding_on else "OFF",
                "ANSI_WARNINGS": "ON" if row.is_ansi_warnings_on else "OFF",
                "ARITHABORT": "ON" if row.is_arithabort_on else "OFF",
                "AUTO_CLOSE": "ON" if row.is_auto_close_on else "OFF",
                "AUTO_SHRINK": "ON" if row.is_auto_shrink_on else "OFF",
                "AUTO_UPDATE_STATISTICS": "ON" if row.is_auto_update_stats_on else "OFF",
                "CURSOR_CLOSE_ON_COMMIT": "ON" if row.is_cursor_close_on_commit_on else "OFF",
                "CURSOR_DEFAULT": "LOCAL" if row.is_local_cursor_default else "GLOBAL",
                "CONCAT_NULL_YIELDS_NULL": "ON" if row.is_concat_null_yields_null_on else "OFF",
                "NUMERIC_ROUNDABORT": "ON" if row.is_numeric_roundabort_on else "OFF",
                "QUOTED_IDENTIFIER": "ON" if row.is_quoted_identifier_on else "OFF",
                "RECURSIVE_TRIGGERS": "ON" if row.is_recursive_triggers_on else "OFF",
                "broker": "ENABLE_BROKER" if row.is_broker_enabled else "DISABLE_BROKER",
                "AUTO_UPDATE_STATISTICS_ASYNC": "ON" if row.is_auto_update_stats_async_on else "OFF",
                "DATE_CORRELATION_OPTIMIZATION": "ON" if row.is_date_correlation_on else "OFF",
                "TRUSTWORTHY": "ON" if row.is_trustworthy_on else "OFF",
                "ALLOW_SNAPSHOT_ISOLATION": str(row.snapshot_isolation_state_desc),
                "PARAMETERIZATION": "FORCED" if row.is_parameterization_forced else "SIMPLE",
                "READ_COMMITTED_SNAPSHOT": "ON" if row.is_read_committed_snapshot_on else "OFF",
                "HONOR_BROKER_PRIORITY": "ON" if row.is_honor_broker_priority_on else "OFF",
                "RECOVERY": str(row.recovery_model_desc),
                "user": str(row.user_access_desc),
                "PAGE_VERIFY": str(row.page_verify_option_desc),
                "DB_CHAINING": "ON" if row.is_db_chaining_on else "OFF",
                # https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-database-filestream-options-transact-sql?view=sql-server-ver16
                # aparentemente, o FILETREAM é o mesmo para todos os bancos, para
                # conseguir essas informações, seria necessário realizar um SELECT em
                # sys.database_filestream_options com o código do banco
                #todo : ver uma forma de fazer isso (não urgente)
                "FILESTRAM": "(NON_TRANSACTED_ACCESS = OFF)",
                "TARGET_RECOVERY_TIME": f"= {row.target_recovery_time_in_seconds} SECONDS",
                "DELAYED_DURABILITY": f"= {row.delayed_durability_desc}",
                # "ACCELERATED_DATABASE_RECOVERY": f"= {"ON" if row.is_accelerated_database_recovery_on else "OFF"}",
                "QUERY_STORE": f"= {"ON" if row.is_query_store_on else "OFF"}",
                "read": "READ_ONLY" if row.is_read_only else "READ_WRITE",

                # as especificações abaixo fazem parte do CREATE DATABASE
                "CONTAINMENT": str(row.containment_desc),
                # "CATALOG_COLLATION": str(row.catalog_collation_type_desc),
                # "LEDGER": "ON" if row.is_ledger_on else "OFF",
                # "LOG": "ON",
            }

        tamanho_max: str = ""
        # o tamanho máximo pode ser Unlimited ou em KB
        if row.max_size == -1:
            tamanho_max = "Unlimited"
        else:
            tamanho_max = f"{str(row.max_size * 8)} KB"

        crescimento: str = ""
        # o crescimento pode ser em percentual ou em KB
        if row.is_percent_growth:
            crescimento = f"{row.growth}%"
        else:
            crescimento = f"{row.growth * 8} KB"

        return cls(
            nome_banco = row.nome_banco,
            especificacoes = specs,
            dados = {
                "filename": row.nome_arquivo,
                "physical_name": row.physical_name,
                "size": str(row.size * 8) + " KB",
                "maxsize": tamanho_max,
                "growth": crescimento,
                "type_desc": row.type_desc,
            }
        )
