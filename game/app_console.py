import os
# Importa as funções dos novos módulos
from modules.utils import clear_console, pause_and_clear
from modules.db_operations import conectar_bd
from modules.jogo import iniciar_jogo

# --- Configurações do Banco de Dados ---
# Elas serão lidas das variáveis de ambiente (mantidas aqui no arquivo principal)
DB_HOST = os.getenv("PG_HOST")
DB_NAME = os.getenv("PG_DB_NAME")
DB_USER = os.getenv("PG_USER")
DB_PASSWORD = os.getenv("PG_PASSWORD")

if not all([DB_HOST, DB_NAME, DB_USER, DB_PASSWORD]):
    print("Erro: Variáveis de ambiente do banco de dados não configuradas corretamente.")
    print("Verifique seu docker-compose.yml ou Dockerfile.")
    exit(1)

def menu_principal():
    # Passa as credenciais para a função de conexão, agora no módulo db_operations
    conn = conectar_bd(DB_HOST, DB_NAME, DB_USER, DB_PASSWORD)
    if not conn:
        print("Não foi possível iniciar a aplicação sem uma conexão com o banco de dados.")
        return

    cursor = conn.cursor()

    while True:
        clear_console() # Usa a função do módulo utils
        print("\n=== Menu da Aplicação Prision Break ===")
        print("1. Iniciar jogo")
        print("2. Opções")
        print("3. Sair")
        escolha = input("Digite sua opção: ")

        if escolha == '1':
            iniciar_jogo(conn, cursor)
            pause_and_clear()
        elif escolha == '2':
            pause_and_clear() # Usa a função do módulo utils
        elif escolha == '3':
            print("Fechando a aplicação. Até logo!")
            break
        else:
            print("Opção inválida. Tente novamente.")
            pause_and_clear() # Usa a função do módulo utils

    if conn:
        cursor.close()
        conn.close()
        print("Conexão com o banco de dados fechada.")

if __name__ == "__main__":
    menu_principal()