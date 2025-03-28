import os
import sys
from . import get_data
from .config.config import BANCOS


class Menu:
    def __init__(self):
        self.ambiente: str = ""

    def menu_ambiente(self) -> None:
        """ função para escolher entre os ambientes cadastrados """
        opcao: int = -1

        while opcao < 0 or opcao > len(BANCOS):
            self.limpa_tela()
            get_data()
            print("\nEscolha um dos ambientes abaixo :\n")
            for i, nome in enumerate(BANCOS.values(), start=1):
                print(f"\t{i}. {nome['nome']}")
            print(f"\t0. sair")

            try:
                opcao = int(input("\n >> "))
                if opcao < 0 or opcao > len(BANCOS):
                    raise Exception
                break
            except ValueError:
                print("\n\t---->>   Digite um número!   <<----\n")
                continue
            except Exception:
                print("\n\t---->>   Opção incorreta!   <<----\n")
                continue

        self.pega_ambiente(opcao)

    def pega_ambiente(self, valor: int) -> None:
        if valor == 0:
            self.limpa_tela()
            print("\n\n\tEncerrando o programa.\n")
            sys.exit()

        self.ambiente = list(BANCOS.keys())[valor - 1]
        nome: str = str(BANCOS[self.ambiente]['nome']).upper()
        print(f"\nConectando no servidor de {nome}\n")

    def limpa_tela(self) -> None:
        if os.name == "nt":
            os.system("cls")
        else:
            os.system("clear")
