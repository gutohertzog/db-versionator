"""
db-versionator: A tool for managing database versioning.

This package provides utilities for versioning database schemas and applying migrations.
"""

__author__ = "Guto Hertzog"
__doc__ = "Uma ferramenta para gerenciar o versionamento de banco de dados"
__file__ = "db-versionator/__init__.py"
__name__ = "db-versionator"
__version__ = "v1.0.0"

def get_author() -> str:
    return __author__

def get_doc() -> str | None:
    return __doc__

def get_file() -> str:
    return __file__

def get_name() -> str:
    return __name__

def get_version() -> str:
    return __version__

def get_data() -> None:
    print(f"\n\t    Autor : {get_author()}")
    print(f"\t  Projeto : {get_name()}")
    print(f"\t   Versão : {get_version()}")
