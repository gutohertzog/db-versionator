# DB Versionator

**db-versionator** é uma ferramenta desenvolvida em Python para versionamento e gerenciamento de mudanças em bancos de dados, garantindo controle, rastreabilidade e consistência em sistemas com múltiplas atualizações de esquema e dados.

## Funcionalidades
- Versionamento de scripts do SQL Server.
- Aplicação incremental de mudanças no banco de dados.
- Registro de histórico de versões aplicadas.
- Suporte a múltiplos ambientes (desenvolvimento, homologação, produção).

## Requisitos
- Python 3.8+
- Biblioteca `pyodbc` ([instalação no item 2](#2-instalar-dependências)).

Certifique-se de ter um banco de dados compatível com o objetivo do projeto, o SQL Server e o driver correspondente instalado.

## Estrutura do Projeto
```
db-versionator/
|-- db-versionator/
|   |-- config/
|   |   |-- __init__.py
|   |   |-- config.py
|   |   └-- queries.py
|   |-- dto/
|   |   |-- __init__.py
|   |   |-- constraints.py
|   |   |-- database.py
|   |   |-- objetos.py
|   |   |-- permission.py
|   |   └-- tabela.py
|   |-- models/
|   |   |-- __init__.py
|   |   |-- arquivo.py
|   |   |-- constraints.py
|   |   |-- database.py
|   |   |-- objetos.py
|   |   |-- permission.py
|   |   └-- tabela.py
|   |-- __init__.py
|   |-- aplicativo.py
|   |-- db_conn.py
|   |-- main.py
|   └-- menu.py
|-- sql/  # scripts SQL versionados (veja detalhes abaixo).
|   └-- ambientes.txt
|-- .gitignore
|-- LICENSE
|-- README.md
└-- requistos.txt
```

## Como Usar

### 1. Configurar Local dos Scripts SQL
Ao executar `db-versionator.main`, os scripts SQL serão salvos na pasta `sql` por padrão.

É possível alterar o local no arquivo `config.py`, mudando o valor da variável `DIR_BASE`. Use o caminho completo da pasta quando for alterar.
- exemplo : `DIR_BASE: str = 'C:\\backup-sql\\'` ou `DIR_BASE: str = '/home/backup-sql/'`

### 2. Instalar Dependências
É recomendado que as dependências sejam instaladas em um ambiente virtual.

Criando o ambiente virtual:
```bash
$ python -m venv .venv
```

Ativando o ambiente virtual:
```bash
# windows
$ .\.venv\Scripts\activate

# unix
$ source ./.venv/bin/activate
```

Instalando as dependências do projeto:
```bash
pip install -r requisitos.txt
```

O módulo principal do projeto é o `pyodbc`. Veja aqui a [documentação oficial](https://github.com/mkleehammer/pyodbc).

Certifique-se de que o driver ODBC para o seu banco de dados esteja corretamente configurado no sistema. Por exemplo, para SQL Server, você pode instalar o driver ODBC disponível [aqui](https://learn.microsoft.com/pt-br/sql/connect/odbc/download-odbc-driver-for-sql-server).

### 3. Rodar o Aplicativo
Execute o script principal para aplicar as mudanças no banco de dados:
```bash
python -m db-versionator.main
```

### 4. Pasta sql
A pasta `sql` é onde serão salvos os scrips de cada objeto do banco de dados conectado.
No presente repositório, há um versionamento do banco de dados [`AdventureWorks2022`](https://github.com/Microsoft/sql-server-samples/releases/tag/adventureworks) como modelo de resultado após execução do `db-versionator`.
Esse banco de dados é fornecido pela Microsoft como modelo para testar o SQL Server.

## Contribuições
Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou pull requests neste repositório.

---

**Autor:**
- Guto Hertzog

**Repositório:**
- https://github.com/gutohertzog/db-versionator.git/
