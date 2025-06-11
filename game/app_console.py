import os
import psycopg2
from psycopg2 import Error
from tabulate import tabulate

DB_HOST = os.getenv("PG_HOST")
DB_NAME = os.getenv("PG_DB_NAME")
DB_USER = os.getenv("PG_USER")
DB_PASSWORD = os.getenv("PG_PASSWORD")

if not all([DB_HOST, DB_NAME, DB_USER, DB_PASSWORD]):
    print("Erro: Variáveis de ambiente do banco de dados não configuradas corretamente.")
    print("Verifique seu docker-compose.yml ou Dockerfile.")
    exit(1)

def conectar_bd():
    conn = None
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            database=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD
        )
        print("Conexão com o banco de dados PostgreSQL estabelecida com sucesso!")
    except Error as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
    return conn

def listar_tabelas(cursor):
    """Lista todas as tabelas no banco de dados."""
    try:
        cursor.execute("""
            SELECT tablename FROM pg_catalog.pg_tables
            WHERE schemaname != 'pg_catalog' AND schemaname != 'information_schema';
        """)
        tabelas = cursor.fetchall()
        if tabelas:
            print("\n--- Tabelas Disponíveis ---")
            for i, tabela in enumerate(tabelas):
                print(f"{i+1}. {tabela[0]}")
            print("--------------------------")
        else:
            print("Nenhuma tabela encontrada neste banco de dados (exceto tabelas de sistema).")
        return [tabela[0] for tabela in tabelas]
    except Error as e:
        print(f"Erro ao listar tabelas: {e}")
        return []

def visualizar_tabela(cursor, nome_tabela):
    """Exibe os dados de uma tabela específica no console."""
    try:
        cursor.execute(f"SELECT * FROM {nome_tabela}")
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

def menu_principal():
    """Função principal que gerencia o menu de interação do console."""
    conn = conectar_bd()
    if not conn:
        print("Não foi possível iniciar a aplicação sem uma conexão com o banco de dados.")
        return

    cursor = conn.cursor()

    while True:
        print("\n=== Menu da Aplicação Prision Break ===")
        print("1. Listar todas as tabelas")
        print("2. Visualizar dados de uma tabela")
        print("3. Sair")
        escolha = input("Digite sua opção: ")

        if escolha == '1':
            listar_tabelas(cursor)
        elif escolha == '2':
            tabelas_disponiveis = listar_tabelas(cursor)
            if tabelas_disponiveis:
                tabela_escolhida = input("Digite o nome da tabela que deseja visualizar: ")
                if tabela_escolhida in tabelas_disponiveis:
                    visualizar_tabela(cursor, tabela_escolhida)
                else:
                    print("Nome de tabela inválido ou não encontrado.")
            else:
                print("Não há tabelas para visualizar.")
        elif escolha == '3':
            print("Fechando a aplicação. Até logo!")
            break
        else:
            print("Opção inválida. Por favor, tente novamente.")

    if conn:
        cursor.close()
        conn.close()
        print("Conexão com o banco de dados fechada.")

if __name__ == "__main__":
    menu_principal()
