import psycopg2
from psycopg2 import Error
from tabulate import tabulate
import sys
from .utils import load_sql_query, pause_and_clear, clear_console, quit_application
from modules.move_npc import iniciar_movimentacao_automatica
from modules.transacoes import listar_loja, vender_item

def start_game(conn, cursor):
    """
    Função principal de navegação do jogador entre salas e interações no jogo
    """
    print("\n--- Início da Navegação de Salas ---")
    id_jogador = 1
    thread_npc = iniciar_movimentacao_automatica(conn)

    while True:
        clear_console()

        try:
            query_dados_jogador = load_sql_query('select_player_data')
            cursor.execute(query_dados_jogador, (id_jogador,))
            dados_jogador = cursor.fetchone()
            if not dados_jogador:
                print("Erro ao carregar dados do jogador.")
                break

            id_personagem, nome, qtded_recurso, gangue, titulo_objetivo, nome_missao, missao_desc = dados_jogador

            print(f"==========================================================================================")
            print(f"[ PRISON BREAK ] {nome} | Recursos: {qtded_recurso} | Gangue: {gangue or 'Nenhuma'}")
            print(f"-------------------------------------------------------------------------------------------")
            print(f"OBJETIVO: {titulo_objetivo}")
            print(f"MISSÃO ATUAL: {nome_missao}")
            print(f"-------------------------------------------------------------------------------------------")
            print(f"DESCRICAO: {missao_desc}")
            print(f"-------------------------------------------------------------------------------------------")

            # Sala atual do jogador
            query_current_room_id = load_sql_query('select_player_current_room_id')
            cursor.execute(query_current_room_id, (id_jogador,))
            id_sala_atual = cursor.fetchone()[0]

            query_room_details = load_sql_query('select_room_details_by_id')
            cursor.execute(query_room_details, (id_sala_atual,))
            current_room_details = cursor.fetchone()

            query_agents_in_room = load_sql_query('select_agentes_na_sala')
            cursor.execute(query_agents_in_room, (id_sala_atual,))
            agents_in_room = cursor.fetchall()

            query_prisoners_in_room = load_sql_query('select_prisioneiros_na_sala')
            cursor.execute(query_prisoners_in_room, (id_sala_atual,))
            prisoners_in_room = cursor.fetchall()

            if current_room_details:
                id_sala, nome_sala_atual, descricao_sala_atual, nivel_perigo, bloqueado = current_room_details
                print(f"\nVocê está em: * {nome_sala_atual} *\n{descricao_sala_atual}")

                print(f'\n--------------------------------- [ NA SALA ] ------------------------------------------')
                if agents_in_room:
                    print("Policiais:")
                    for agent in agents_in_room:
                        print(f"  - {agent[0]}")
                else:
                    print("Não há policiais na sala.")

                if prisoners_in_room:
                    print("\nPrisioneiros:")
                    for prisoner in prisoners_in_room:
                        print(f"  - {prisoner[0]}")
                else:
                    print("Não há prisioneiros na sala.")
            else:
                print(f"Erro ao buscar detalhes da sala atual.")
                break

            # Menu de Ações
            print(f"\n--------------------------------------- [ Ações ] ---------------------------------------")
            print("1. Mover para outra sala")
            print("2. Comprar itens na loja")
            print("3. Vender item do inventário")
            print("0. Sair do jogo")

            acao = input("\nQual ação deseja realizar?: ")

            if acao == '1':
                clear_console()
                print("\n---------------------------------- [ Salas Acessíveis ] ----------------------------------")
                query_available_rooms = load_sql_query('select_available_rooms')
                cursor.execute(query_available_rooms, (id_sala_atual,))
                available_rooms_data = cursor.fetchall()

                if not available_rooms_data:
                    print("Não há salas acessíveis.")
                    pause_and_clear()
                    continue

                rooms_map = {room_id: {'nome': nome, 'direcao': direcao, 'status': bloqueado} for room_id, nome, bloqueado, direcao in available_rooms_data}
                headers = ["ID", "Nome", "Direção", "Status"]
                rows = [[rid, r["nome"], r["direcao"], "Bloqueada" if r["status"] else "Liberada"] for rid, r in rooms_map.items()]
                print(tabulate(rows, headers=headers, tablefmt="grid"))

                escolha_sala = input("\nDigite o ID da sala para onde deseja ir (ou 0 para cancelar): ")
                try:
                    escolha_sala_id = int(escolha_sala)
                    if escolha_sala_id == 0:
                        continue
                    if escolha_sala_id not in rooms_map or rooms_map[escolha_sala_id]['status']:
                        print("Sala inválida ou bloqueada.")
                        pause_and_clear()
                        continue

                    query_update_player_room = load_sql_query('update_player_room')
                    cursor.execute(query_update_player_room, (escolha_sala_id, id_jogador))
                    conn.commit()
                except ValueError:
                    print("Entrada inválida.")
                    pause_and_clear()
                    continue

            elif acao == '2':
                clear_console()
                listar_loja(conn, id_jogador, start_game)

            elif acao == '3':
                clear_console()
                try:
                    print("\n[ SEU INVENTÁRIO ]")
                    query_inv = load_sql_query('listar_inventario_jogador')
                    cursor.execute(query_inv, (id_jogador,))
                    itens = cursor.fetchall()

                    if not itens:
                        print("Inventário vazio.")
                        pause_and_clear()
                        continue

                    print(tabulate(itens, headers=["ID Instância", "Item", "Pode Vender"], tablefmt="grid"))
                    id_item = int(input("\nDigite o ID do item para vender (ou 0 para cancelar): "))
                    if id_item == 0:
                        continue

                    nome_gangue = input("Digite o nome da gangue (loja): ").strip()
                    vender_item(conn, id_jogador, id_item, nome_gangue)
                    input("\nPressione Enter para continuar...")
                except Exception as e:
                    print(f"Erro ao acessar inventário: {e}")
                    pause_and_clear()

            elif acao == '0':
                quit_application(conn, cursor)
                break

            else:
                print("Ação inválida.")
                pause_and_clear()

        except Error as e:
            conn.rollback()
            print(f"Erro de banco de dados: {e}")
            pause_and_clear()
            break
        except Exception as e:
            conn.rollback()
            print(f"Erro inesperado: {e}")
            pause_and_clear()
            break
