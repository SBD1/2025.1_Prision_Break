import psycopg2
from psycopg2 import Error
from tabulate import tabulate
from .utils import load_sql_query # Importa a função do módulo 'utils'
import time # Importar o módulo time para retentativas

def conectar_bd(db_host, db_name, db_user, db_password, retries=5, delay=3):
    """
    Tenta estabelecer uma conexão com o banco de dados PostgreSQL com retentativas.

    Args:
        db_host (str): O host do banco de dados.
        db_name (str): O nome do banco de dados.
        db_user (str): O nome de usuário para a conexão.
        db_password (str): A senha para a conexão.
        retries (int): O número de tentativas de conexão.
        delay (int): O atraso em segundos entre as tentativas.

    Returns:
        psycopg2.connection: O objeto de conexão se bem-sucedido, None caso contrário.
    """
    conn = None
    for i in range(retries):
        try:
            conn = psycopg2.connect(
                host=db_host,
                database=db_name,
                user=db_user,
                password=db_password
            )
            # Opcional: Execute uma query simples para garantir que o banco de dados esteja realmente pronto
            with conn.cursor() as cursor:
                cursor.execute("SELECT 1;")
            print(f"Conexão com o banco de dados PostgreSQL estabelecida com sucesso (tentativa {i+1})!")
            return conn
        except Error as e:
            print(f"Erro ao conectar ao banco de dados: {e}. Tentando novamente em {delay} segundos...")
            conn = None # Garante que conn seja None se houver erro
            time.sleep(delay)
    print(f"Falha ao conectar ao banco de dados após {retries} retentativas.")
    return None

def executar_query_select(cursor, query_sql: str, params: tuple = None) -> list:
    """
    Executa uma query SELECT e retorna os resultados.

    Args:
        cursor: Objeto cursor do banco de dados.
        query_sql (str): A string da query SQL.
        params (tuple, optional): Parâmetros para a query. Default é None.

    Returns:
        list: Uma lista de tuplas contendo as linhas retornadas pela query.
    """
    try:
        cursor.execute(query_sql, params)
        return cursor.fetchall()
    except Error as e:
        print(f"Erro ao executar SELECT: {e}")
        return []

def executar_query_update(conn, cursor, query_sql: str, params: tuple = None) -> int:
    """
    Executa uma query UPDATE, INSERT ou DELETE e retorna o número de linhas afetadas.

    Args:
        conn: Objeto de conexão com o banco de dados.
        cursor: Objeto cursor do banco de dados.
        query_sql (str): A string da query SQL.
        params (tuple, optional): Parâmetros para a query. Default é None.

    Returns:
        int: O número de linhas afetadas pela operação.
    """
    try:
        cursor.execute(query_sql, params)
        conn.commit()
        return cursor.rowcount
    except Error as e:
        conn.rollback()
        print(f"Erro ao executar UPDATE/INSERT/DELETE: {e}")
        return 0

# Funções que já existiam, agora neste arquivo
def visualizar_tabela(cursor, nome_tabela, tabelas_disponiveis):
    """
    Exibe os dados de uma tabela específica no console.
    A validação do nome da tabela é feita externamente.
    """
    if nome_tabela not in tabelas_disponiveis: # Faz a validação aqui ou onde for chamado
        print(f"Nome de tabela inválido ou não permitido: '{nome_tabela}'.")
        print("Por favor, escolha uma das tabelas listadas.")
        return

    query_template = load_sql_query('select_all_from_table')
    if not query_template: return

    sql_query = query_template % (nome_tabela,)

    try:
        cursor.execute(sql_query)
        linhas = cursor.fetchall()
        colunas = [desc[0] for desc in cursor.description]

        if not linhas:
            print(f"\nA tabela '{nome_tabela}' está vazia ou não existe.")
            return

        print(f"\n--- Dados da tabela: {nome_tabela} ---")
        print(tabulate(linhas, headers=colunas, tablefmt="grid"))
        print("---------------------------------------")

    except Error as e:
        print(f"Erro ao visualizar a tabela '{nome_tabela}': {e}")
    except Exception as e:
        print(f"Um erro inesperado ocorreu: {e}")

def alterar_dado_tupla(conn, cursor):
    """Permite ao usuário alterar um dado em uma tupla específica."""
    print("\n--- Alterar Dado em uma Tupla ---")
    tabelas_disponiveis = listar_tabelas(cursor) # Chama a versão neste módulo
    if not tabelas_disponiveis:
        print("Nenhuma tabela disponível para alteração.")
        return

    nome_tabela = input("Digite o NOME da tabela para alterar: ")
    if nome_tabela not in tabelas_disponiveis:
        print("Nome de tabela inválido ou não permitido.")
        return

    colunas_disponiveis = get_table_columns(cursor, nome_tabela) # Chama a versão neste módulo
    if not colunas_disponiveis:
        print(f"Não foi possível obter as colunas da tabela '{nome_tabela}'.")
        return

    print(f"\nColunas disponíveis em '{nome_tabela}': {', '.join(colunas_disponiveis)}")

    coluna_condicao = input("Digite o NOME da coluna para identificar a linha (ex: id, cpf): ")
    if coluna_condicao not in colunas_disponiveis:
        print(f"Coluna de condição '{coluna_condicao}' inválida para a tabela '{nome_tabela}'.")
        return

    valor_condicao = input(f"Digite o VALOR da {coluna_condicao} da linha a ser alterada: ")

    coluna_para_atualizar = input("Digite o NOME da coluna que deseja ATUALIZAR: ")
    if coluna_para_atualizar not in colunas_disponiveis:
        print(f"Coluna a ser atualizada '{coluna_para_atualizar}' inválida para a tabela '{nome_tabela}'.")
        return

    novo_valor = input(f"Digite o NOVO VALOR para a coluna '{coluna_para_atualizar}': ")

    query_template = load_sql_query('update_generic_row')
    if not query_template: return

    sql_query = query_template % (nome_tabela, coluna_para_atualizar, '%s', coluna_condicao, '%s')

    try:
        cursor.execute(sql_query, (novo_valor, valor_condicao))
        conn.commit()

        if cursor.rowcount > 0:
            print(f"\nSucesso! {cursor.rowcount} tupla(s) alterada(s) na tabela '{nome_tabela}'.")
        else:
            print(f"\nNenhuma tupla encontrada com {coluna_condicao} = '{valor_condicao}' ou nenhum dado alterado.")

    except Error as e:
        conn.rollback()
        print(f"Erro ao alterar dado: {e}")
    except Exception as e:
        conn.rollback()
        print(f"Um erro inesperado ocorreu: {e}")

# Adicione as funções listar_tabelas e get_table_columns se ainda não as tiver,
# pois elas são chamadas por alterar_dado_tupla
def listar_tabelas(cursor) -> list:
    """Lista todas as tabelas disponíveis no banco de dados."""
    query = load_sql_query('list_tables')
    if not query:
        return []
    try:
        cursor.execute(query)
        tabelas = [row[0] for row in cursor.fetchall()]
        print("\nTabelas disponíveis:")
        for tabela in tabelas:
            print(f"- {tabela}")
        return tabelas
    except Error as e:
        print(f"Erro ao listar tabelas: {e}")
        return []

def get_table_columns(cursor, table_name: str) -> list:
    """Obtém os nomes das colunas de uma tabela específica."""
    try:
        cursor.execute(f"SELECT * FROM {table_name} LIMIT 0;")
        return [desc[0] for desc in cursor.description]
    except Error as e:
        print(f"Erro ao obter colunas da tabela '{table_name}': {e}")
        return []
