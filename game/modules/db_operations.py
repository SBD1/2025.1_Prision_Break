import psycopg2
from psycopg2 import Error
from tabulate import tabulate
from .utils import load_sql_query # Importa a função do módulo 'utils'

# Funções que já existiam, agora neste arquivo
def conectar_bd(db_host, db_name, db_user, db_password): # Agora aceita as credenciais como parâmetros
    """Tenta estabelecer uma conexão com o banco de dados PostgreSQL."""
    conn = None
    try:
        conn = psycopg2.connect(
            host=db_host,
            database=db_name,
            user=db_user,
            password=db_password
        )
        print("Conexão com o banco de dados PostgreSQL estabelecida com sucesso!")
    except Error as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
    return conn

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