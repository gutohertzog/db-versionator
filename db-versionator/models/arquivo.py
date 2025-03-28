""" módulo para gerenciar as classes que acessam o disco """

import logging
import os


class Logger:
    """ classe para gerenciar logs da aplicação """
    def __init__(self, level: int, arq_log: str):
        self.logger = logging.getLogger(arq_log)
        self.logger.setLevel(level)

        # manipulador de arquivo
        file_handler = logging.FileHandler(
            filename=arq_log,
            encoding="utf-8",
            mode="w")
        file_handler.setLevel(level)

        # configura o formato do log
        formatter = logging.Formatter(
            "%(asctime)s - %(levelname)s - %(message)s")
        file_handler.setFormatter(formatter)

        # evita adicionar múltiplos manipuladores ao logger
        if not self.logger.hasHandlers():
            self.logger.addHandler(file_handler)

    def debug(self, message: str):
        """ registra uma mensagem de nível DEBUG """
        self.logger.debug(message)

    def info(self, message: str):
        """ registra uma mensagem de nível INFO """
        self.logger.info(message)

    def warning(self, message: str):
        """ registra uma mensagem de nível WARNING """
        self.logger.warning(message)

    def error(self, message: str):
        """ registra uma mensagem de nível ERROR """
        self.logger.error(message)

    def critical(self, message: str):
        """ registra uma mensagem de nível CRITICAL """
        self.logger.critical(message)


class Arquivo:
    """ classe usada para salvar os objetos em disco """
    def __init__(self, logger: Logger, dir_base: str):
        self.logger: Logger = logger
        self.dir_base: str = dir_base

    def salva_script(self, caminho: str, script: str) -> bool:
        """ salva o script em arquivo """
        try:
            if not script:
                raise OSError("Script vazio, não é possível salvar.")

            with open(caminho, "w", encoding="utf-8") as arq:
                arq.write(script)
            return True
        except OSError as erro:
            self.logger.error(
                f"--> Erro ao salvar o objeto {caminho} - Erro: {erro}")
            return False

    def atualiza_indice(self, banco: str, tipo: str, nome: str) -> None:
        """ atualiza o índice com o novo arquivo """
        arq_indice: str = f"{banco}_indice.txt"
        caminho_indice = os.path.join(self.dir_base, banco, arq_indice)
        registro = os.path.join(tipo, f"{nome}.sql")

        try:
            with open(caminho_indice, "a", encoding="utf-8") as arq:
                arq.write(f"{registro}\n")
            self.logger.info(f"Índice atualizado com '{registro}'.")
        except OSError as erro:
            self.logger.error(
                f"Erro ao atualizar o índice '{caminho_indice}': {erro}")

    def carrega_indice(self, indice_caminho: str) -> set[str]:
        """ carrega os registros do índice do banco """
        if not os.path.exists(indice_caminho):
            return set()

        with open(indice_caminho, "r", encoding="utf-8") as arq:
            return set(linha.strip() for linha in arq if linha.strip())


class Sincronizador:
    """ sincroniza os objetos do banco com os arquivos em disco """

    def __init__(self, arquivo: Arquivo):
        self.arquivo = arquivo

    def sincronizar(self, indice_caminho: str, novo_indice: set[str]) -> None:
        """ carrega o índice do banco em disco e compara com o que foi gerado,
        o que tiver sido removido do banco de dados é excluído do disco e depois
        atualiza o índice com os novos registros """
        indice_atual: set[str] = self.arquivo.carrega_indice(indice_caminho)

        # remove arquivos obsoletos
        obsoletos = indice_atual - novo_indice
        for registro in obsoletos:
            arq_caminho = os.path.join(self.arquivo.dir_base, registro)
            try:
                os.remove(arq_caminho)
                self.arquivo.logger.info(
                    f"Arquivo obsoleto removido: {arq_caminho}")
            except OSError as erro:
                self.arquivo.logger.error(
                    f"Erro ao remover o arquivo '{arq_caminho}': {erro}")

        # atualiza o índice com os novos registros
        try:
            with open(indice_caminho, "w", encoding="utf-8") as arq:
                for registro in sorted(novo_indice):
                    arq.write(f"{registro}\n")
            self.arquivo.logger.info(
                f"Índice atualizado com sucesso: {indice_caminho}")
        except OSError as erro:
            self.arquivo.logger.error(
                f"Erro ao atualizar o índice '{indice_caminho}': {erro}")
