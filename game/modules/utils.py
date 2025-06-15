import os
import sys
import psycopg2

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

def quit_application(conn=None, cursor=None):
    """
    Encerra a aplicação de forma controlada, fechando a conexão com o banco de dados.
    """
    print("\nEncerrando a aplicação...")
    
    clear_console()

    if cursor:
        try:
            cursor.close()
        except psycopg2.Error as e:
            print(f"Erro ao fechar cursor: {e}")
        except Exception as e:
            print(f"Erro inesperado ao fechar cursor: {e}")


    if conn:
        try:
            conn.close()
            # print("Conexão com o banco de dados fechada.") # Manter apenas se for para depuração
        except psycopg2.Error as e:
            print(f"Erro ao fechar conexão: {e}")
        except Exception as e:
            print(f"Erro inesperado ao fechar conexão: {e}")
    
    print("Aplicação encerrada. Até logo!")
    sys.exit(0)