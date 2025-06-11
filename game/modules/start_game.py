import psycopg2
from psycopg2 import Error
from tabulate import tabulate
import sys
from .utils import load_sql_query, pause_and_clear, clear_console, quit_application

def start_game(conn, cursor):
    """
    Permite ao jogador navegar entre as salas disponíveis no banco de dados.
    """

    # mudar para texto mais imersivo
    print("\n--- Início da Navegação de Salas ---")

    id_jogador = 1

    while True:
        clear_console() # Limpa o console a cada iteração de navegação

        try:
            # 1. Resgatar a sala atual do jogador
            query_current_room_id = load_sql_query('select_player_current_room_id')
            if not query_current_room_id: break
            cursor.execute(query_current_room_id, (id_jogador,))
            result = cursor.fetchone()
            if not result:
                print(f"Erro: Sala atual do jogador {id_jogador} não encontrada. Verifique os dados.")
                break # Sai do loop de navegação
            
            id_sala_atual = result[0]

            # 2. Resgatar detalhes da sala atual
            query_room_details = load_sql_query('select_room_details_by_id')
            if not query_room_details: break

            cursor.execute(query_room_details, (id_sala_atual,))
            current_room_details = cursor.fetchone()

            if current_room_details:
                nome_sala_atual, descricao_sala_atual = current_room_details
                print(f"\nVocê está atualmente na sala: '{nome_sala_atual}'")
                print(f"Descrição: {descricao_sala_atual}")
            else:
                print(f"Erro: Detalhes da sala atual (ID: {id_sala_atual}) não encontrados.")
                break # Sai do loop de navegação

            print("\n--- Salas Acessíveis ---")
            print("Digite '0' para sair da navegação.")

            # 3. Mostrar todas as salas disponíveis (acesso liberado), exceto a atual
            query_available_rooms = load_sql_query('select_available_rooms_excluding_current')
            if not query_available_rooms: break
            cursor.execute(query_available_rooms, (id_sala_atual,))
            available_rooms_data = cursor.fetchall()

            if not available_rooms_data:
                print("Não há outras salas acessíveis no momento.")
                input("\nPressione Enter para continuar...") # Pausa antes de tentar novamente ou sair
                break # Não há para onde ir
            
            # Mapeia IDs para detalhes da sala para fácil validação
            rooms_map = {room_id: {'nome': nome, 'descricao': desc}
                         for room_id, nome, desc in available_rooms_data}

            # Exibe as salas disponíveis em formato de tabela
            headers = ["ID da Sala", "Nome da Sala", "Descrição"]
            display_data = [[id_s, nome_s, desc_s] for id_s, nome_s, desc_s in available_rooms_data]
            print(tabulate(display_data, headers=headers, tablefmt="grid"))
            print("--------------------------")

            # 4. Usuário escolhe qual sala deseja ir
            escolha_sala_str = input("Digite o ID da sala para onde deseja ir (0 para sair): ")
            
            try:
                escolha_sala_id = int(escolha_sala_str)
            except ValueError:
                print("Entrada inválida. Digite um número inteiro.")
                pause_and_clear()
                continue # Volta ao início do loop

            #  --------- SAIR DO JOGO ------------- #
            if escolha_sala_id == 0:
                quit_application(conn, cursor)
                # break # Sai do loop de navegação

            # Validação: A sala escolhida existe e está na lista de salas acessíveis?
            if escolha_sala_id not in rooms_map:
                print(f"ID de sala inválido ou sala não acessível: {escolha_sala_id}.")
                pause_and_clear()
                continue # Volta ao início do loop

            # 5. Mudar o id da sala do jogador (UPDATE)
            query_update_player_room = load_sql_query('update_player_room')
            if not query_update_player_room: break

            cursor.execute(query_update_player_room, (escolha_sala_id, id_jogador))
            conn.commit() # Confirma a mudança de sala

            if cursor.rowcount > 0:
                print(f"Você se moveu para a sala: '{rooms_map[escolha_sala_id]['nome']}' (ID: {escolha_sala_id}) com sucesso!")
            else:
                print("Erro ao mover para a nova sala. Tente novamente.")
            
            input("\nPressione Enter para continuar na nova sala...") # Pausa para ver a mensagem antes de recarregar
            # O loop vai repetir, e a sala atual será a nova sala escolhida.

        except Error as e:
            conn.rollback() # Desfaz qualquer transação em caso de erro no DB
            print(f"Erro de banco de dados durante a navegação: {e}")
            pause_and_clear()
            break # Sai do loop de navegação
        except Exception as e:
            conn.rollback()
            print(f"Um erro inesperado ocorreu durante a navegação: {e}")
            pause_and_clear()
            break # Sai do loop de navegação


    