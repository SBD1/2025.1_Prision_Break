import os

def clear_console():
    """Limpa a tela do console, compatível com Windows, Linux e macOS."""
    os.system('cls' if os.name == 'nt' else 'clear')

def load_sql_query(query_name):
    """Carrega uma query SQL de um arquivo na pasta sql_queries/"""
    # Para carregar de dentro de um módulo, precisamos ajustar o caminho base.
    # O caminho deve ser relativo à raiz do projeto.
    # __file__ é o caminho do arquivo atual (utils.py)
    # os.path.dirname(os.path.dirname(__file__)) volta para a raiz do projeto (seu_projeto/)
    project_root = os.path.dirname(os.path.dirname(__file__))
    query_path = os.path.join(project_root, 'sql_queries', f'{query_name}.sql')
    try:
        with open(query_path, 'r') as f:
            return f.read()
    except FileNotFoundError:
        print(f"Erro: Arquivo de query '{query_name}.sql' não encontrado em '{query_path}'")
        return None

def pause_and_clear():
    """Aguarda o usuário pressionar Enter e limpa o console."""
    input("\nPressione Enter para continuar...")
    clear_console()