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
        clear_console()
        print(f"==========================================================================================")
        print(f"[ PRISON BREAK ] Menu da Aplicação\n")
        print("1. Iniciar jogo")
        print("2. Opções")
        print("3. Sair")
        print(f"==========================================================================================\n")

        escolha = input("Digite sua opção: ")

        if escolha == '1':
            clear_console()
            iniciar_jogo(conn, cursor) 
            # exibir_loja(conn, cursor, 1)
        elif escolha == '2':
            clear_console()
            opcoes_menu()
        elif escolha == '3':
            print("Saindo do jogo. Até logo!")
            break
        else:
            print("Opção inválida. Tente novamente.")
            pause_and_clear()

    if conn:
        cursor.close()
        conn.close()
        print("Conexão com o banco de dados fechada.")

def opcoes_menu():
    clear_console()
    print(f"==========================================================================================")
    print(f"[ PRISON BREAK ] Opções do Jogo\n")
    print("0. Voltar ao menu principal")
    print(f"==========================================================================================\n")

    escolha = input("Digite sua opção: ")

    if escolha == '0':
        return
    else:
        print("Opção inválida. Tente novamente.")
        pause_and_clear()

if __name__ == "__main__":
    menu_principal()