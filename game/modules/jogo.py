from modules.utils import load_sql_query, clear_console, pause_and_clear
from modules.start_game import start_game
from psycopg2 import Error

def iniciar_jogo(conn, cursor):
    print("\n--- Criar personagem ---")

    try:
        id_jogador = 1

        # 1. Consultar e exibir informações do jogador
        query_select_player = load_sql_query('select_player_info')
        if not query_select_player: return

        cursor.execute(query_select_player, (id_jogador,))
        jogador_info = cursor.fetchone()

        if not jogador_info:
            print(f"Jogador com ID {id_jogador} não encontrado.")
            return

        nome_atual, gangue_atual = jogador_info
        print(f"\nDados do personagem:")
        print(f"  Nome: {nome_atual}")
        print(f"  Gangue: {gangue_atual}")

        # 2. Perguntar se o usuário aceita ou quer editar
        while True:
            choice = input("\nDeseja editar essas informações? [S/N]: ").upper()
            if choice == 'N':
                print(f"Personagem criado com sucesso com sucesso! Pressione ENTER para iniciar o jogo.")
                clear_console()
                start_game(conn, cursor)

            elif choice == 'S':
                break
            else:
                print("Opção inválida. Digite 'S' ou 'E'.")

        # 3. Se desejar editar, perguntar o que editar
        while True:
            novo_nome = input(f"Digite o NOVO nome para o personagem '{nome_atual}': ")

            if not novo_nome:
                print("Nome não pode ser vazio. Operação cancelada.")
                conn.rollback()
                return
            
            query_update_player_name = load_sql_query('update_player_field') % ('nome', '%s', '%s')
            
            try:
                cursor.execute(query_update_player_name, (novo_nome, id_jogador))
                conn.commit()
                if cursor.rowcount <= 0:
                    print("Erro: Nenhum jogador encontrado para atualizar ou nome não alterado.")
            except Error as e:
                conn.rollback()
                print(f"Erro ao alterar nome do jogador: {e}")

            # Listar gangues disponíveis
            query_select_gangs = load_sql_query('select_all_gangs')

            if not query_select_gangs: return
            
            cursor.execute(query_select_gangs)
            gangues_disponiveis = [g[0] for g in cursor.fetchall()]
            
            if not gangues_disponiveis:
                print("Nenhuma gangue disponível no banco de dados para escolha.")
                return
            
            print("\n--- Gangues Disponíveis ---")
            for i, gangue in enumerate(gangues_disponiveis):
                print(f"{i+1}. {gangue}")
            print("---------------------------")
            nova_gangue = input(f"Digite o nome da gangue que deseja escolher: ")
            
            # Validação da gangue
            if nova_gangue not in gangues_disponiveis:
                print(f"Gangue '{nova_gangue}' inválida ou não existente. Operação cancelada.")
                conn.rollback() # Desfaz qualquer alteração pendente
                return

            query_update_player_gang = load_sql_query('update_player_field') % ('nome_gangue', '%s', '%s')
                
            try:
                cursor.execute(query_update_player_gang, (nova_gangue, id_jogador))
                conn.commit()
                if cursor.rowcount <= 0:
                    print("Erro: Nenhum jogador encontrado para atualizar ou gangue não alterada.")
                
                print(f"Personagem criado com sucesso com sucesso! Pressione ENTER para iniciar o jogo.")
                clear_console()
                start_game(conn, cursor)

            except Error as e:
                conn.rollback()
                print(f"Erro ao alterar gangue do jogador: {e}")
            
            break
            
    except Error as e:
        conn.rollback()
        print(f"Erro no gerenciamento do jogador: {e}")
    except Exception as e:
        conn.rollback()
        print(f"Um erro inesperado ocorreu: {e}")
