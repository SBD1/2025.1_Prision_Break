import psycopg2
from psycopg2 import Error
from tabulate import tabulate
import sys
from .utils import load_sql_query, pause_and_clear, clear_console, quit_application
from modules.move_npc import iniciar_movimentacao_automatica

def start_game(conn, cursor):
    """
    Permite ao jogador navegar entre as salas disponíveis no banco de dados.
    """

    # mudar para texto mais imersivo
    print("\n--- Início da Navegação de Salas ---")

    id_jogador = 1
    thread_npc = iniciar_movimentacao_automatica(conn)


    while True:
        clear_console() # Limpa o console a cada iteração de navegação

        try:
            query_dados_jogador = load_sql_query('select_player_data')
            if not query_dados_jogador: break
            
            cursor.execute(query_dados_jogador, (id_jogador,))
            dados_jogador = cursor.fetchone()
            if not dados_jogador: break

            # dados_jogador é uma tupla: (id_personagem, nome, qtded_recurso, gangue)
            id_personagem, nome, qtded_recurso, gangue, titulo_objetivo = dados_jogador

            print(f"==========================================================================================")
            print(f"[ PRISON BREAK ] {nome} | Recursos: {qtded_recurso} | Gangue: {gangue or 'Nenhuma'}")
            print(f"-------------------------------------------------------------------------------------------")
            print(f"OBJETIVO: {titulo_objetivo}")

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

            query_agents_in_room = load_sql_query('select_agentes_na_sala')
            if not query_agents_in_room: break

            cursor.execute(query_agents_in_room, (id_sala_atual,))
            agents_in_room = cursor.fetchall()

            query_prisoners_in_room = load_sql_query('select_prisioneiros_na_sala')
            if not query_prisoners_in_room: break

            cursor.execute(query_prisoners_in_room, (id_sala_atual,))
            prisoners_in_room = cursor.fetchall()

            if current_room_details:
                id_sala, nome_sala_atual, descricao_sala_atual, nivel_perigo, bloqueado = current_room_details
                print(f"==========================================================================================")
                print(f"\nVocê está em: * {nome_sala_atual} *")
                print(f"\n{descricao_sala_atual}")

                print(f'\n--------------------------------- [ NA SALA ] ------------------------------------------')
                if agents_in_room:
                    print("Policiais:")
                    for agent in agents_in_room:
                        print(f"  - {agent[0]}")
                else:
                    print("Não há policiais na sala.")

                print()
                if prisoners_in_room:
                    print("\nPrisioneiros:")
                    for prisoner in prisoners_in_room:
                        print(f"  - {prisoner[0]}")
                else:
                    print("Não há prisioneiros na sala.")

                # Adicionar informação sobre itens no chão, caso haja

            else:
                print(f"Erro: Detalhes da sala atual (ID: {id_sala_atual}) não encontrados.")
                break # Sai do loop de navegação

            print(f"--------------------------------------- [ Ações ] ---------------------------------------\n")
            print(f"1. Mover para outra sala")
            # print(f"2. Verificar inventário")
            # print(f"3. Ver detalhes dos prisioneiros na sala")
            # print(f"4. Ver detalhes dos policiais na sala")
            # print(f"5. Pegar item do chão (se houver)")
            # print(f"6. Realizar combate (se houver prisioneiros)")
            print(f"0. Sair do jogo")

            acao = input("\nQual ação deseja realizar?: ")
            
            if acao == '1':
                clear_console()
                print(f"---------------------------------- [ Salas Acessíveis ] ----------------------------------\n")
                print(f"Digite 0 para retornar ao menu anterior.\n")

                # 3. Mostrar todas as salas disponíveis (acesso liberado), exceto a atual
                query_available_rooms = load_sql_query('select_available_rooms')
                if not query_available_rooms: break
                cursor.execute(query_available_rooms, (id_sala_atual,))
                available_rooms_data = cursor.fetchall()

                if not available_rooms_data:
                    print("Não há para onde ir no momento.")
                    input("\nPressione Enter para continuar...") # Pausa antes de tentar novamente ou sair
                    break
                
                # Mapeia IDs para detalhes da sala para fácil validação
                rooms_map = {room_id: {'nome': nome, 'direcao': direcao, 'status': bloqueado,}
                    for room_id, nome, bloqueado, direcao in available_rooms_data}

                # Exibe as salas disponíveis em formato de tabela
                headers = ["Número da Sala", "Nome da Sala", "Direção", "Status"]
                display_data = [[id_s, nome_s, direcao_s, ('Bloqueada' if bloqueado_s else 'Liberada')] for id_s, nome_s, bloqueado_s, direcao_s in available_rooms_data]
                print(tabulate(display_data, headers=headers, tablefmt="grid"))

                # 4. Usuário escolhe qual sala deseja ir
                escolha_sala_str = input("\nDigite o número da sala para onde deseja ir: ")
                
                try:
                    escolha_sala_id = int(escolha_sala_str)
                except ValueError:
                    print("Entrada inválida. Digite um número inteiro.")
                    pause_and_clear()
                    continue # Volta ao início do loop

                if escolha_sala_id == 0:
                    pause_and_clear()
                    continue

                # Validação: A sala escolhida existe e está na lista de salas acessíveis?
                if escolha_sala_id not in rooms_map:
                    print(f"A sala {escolha_sala_id} não está disponível, escolha outra.")
                    pause_and_clear()
                    continue # Volta ao início do loop

                if rooms_map[escolha_sala_id]['status']:
                    print(f"A sala '{rooms_map[escolha_sala_id]['nome']}' (ID: {escolha_sala_id}) está bloqueada. Escolha outra sala.")
                    pause_and_clear()
                    continue

                # 5. Mudar o id da sala do jogador (UPDATE)
                query_update_player_room = load_sql_query('update_player_room')
                if not query_update_player_room: break

                cursor.execute(query_update_player_room, (escolha_sala_id, id_jogador))
                conn.commit() # Confirma a mudança de sala

                # if cursor.rowcount > 0:
                #     print(f"Você se moveu para a sala: '{rooms_map[escolha_sala_id]['nome']}' (ID: {escolha_sala_id}) com sucesso!")
                # else:
                #     print("Erro ao mover para a nova sala. Tente novamente.")
                
                # input("\nPressione Enter para continuar na nova sala...") # Pausa para ver a mensagem antes de recarregar
                # O loop vai repetir, e a sala atual será a nova sala escolhida.

                # if acao == '2':
                    # print(f"------------------------------- [ SEU INVENTÁRIO ] -------------------------------------")


                #  --------- SAIR DO JOGO ------------- #
                if acao == 0:
                    quit_application(conn, cursor)
                    break

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


    