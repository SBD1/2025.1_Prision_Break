from modules.utils import load_sql_query, clear_console, pause_and_clear
from modules.start_game import start_game
from psycopg2 import Error
from tabulate import tabulate
import textwrap

ID_JOGADOR = 1

def atualizar_dificuldade_jogador(conn, cursor, novo_dificuldade, jogador_id):
    query_template = load_sql_query('change_difficulty')
    if not query_template:
        return

    try:
        cursor.execute(query_template, (novo_dificuldade, jogador_id))
        conn.commit()
        if cursor.rowcount > 0:
            print(f"Dificuldade do jogador {jogador_id} alterada para '{novo_dificuldade}' com sucesso.")
        else:
            print(f"Nenhum jogador encontrado com ID {jogador_id} ou dificuldade já é '{novo_dificuldade}'.")
    except Error as e:
        conn.rollback()
        print(f"Erro ao atualizar dificuldade do jogador: {e}")
    except Exception as e:
        conn.rollback()
        print(f"Um erro inesperado ocorreu ao atualizar dificuldade: {e}")


def change_difficulty_console(conn, cursor, jogador_id):
    clear_console()

    print(f"Escolha em qual dificuldade deseja jogar:")
    difc = input(f"Escolha F para Fácil, M para Médio ou D para difícil:").upper()

    while not difc:
        print("Você deve selecionar uma dificuldade.")
        difc = input(f"Escolha F para Fácil, M para Médio ou D para difícil:").upper()

    atualizar_dificuldade_jogador(conn, cursor, difc, jogador_id)

    clear_console()

def escolher_objetivo_principal(conn):
    print(f"\n--------------------------------- [ Objetivo Principal ] ------------------------------------------")
    print("Você deve escolher um objetivo principal para o jogo.\n")

    query_objetivos = load_sql_query('select_objetivo_principal')
    if not query_objetivos: return

    cursor = conn.cursor()
    cursor.execute(query_objetivos)
    objetivos = cursor.fetchall()
    cursor.close()

    if not objetivos:
        print("Nenhum objetivo disponível no momento.")
        return None

    objetivos_lista = [(titulo, descricao, quantidade_missoes) for titulo, descricao, quantidade_missoes in objetivos]
#
    largura_titulo = 25
    largura_descricao = 50

    display_data = []
    for i, (titulo, descricao, quantidade_missoes) in enumerate(objetivos_lista):
        titulo_formatado = textwrap.fill(titulo, width=largura_titulo)
        descricao_formatada = textwrap.fill(descricao, width=largura_descricao)
        
        linhas_titulo = titulo_formatado.split('\n')
        linhas_descricao = descricao_formatada.split('\n')
        
        max_linhas = max(len(linhas_titulo), len(linhas_descricao))
        
        while len(linhas_titulo) < max_linhas:
            linhas_titulo.append('')
        while len(linhas_descricao) < max_linhas:
            linhas_descricao.append('')
        
        titulo_completo = '\n'.join(linhas_titulo)
        descricao_completa = '\n'.join(linhas_descricao)
        
        display_data.append([i + 1, titulo_completo, descricao_completa, quantidade_missoes])

    headers = ["Número do Objetivo", "Título", "Descrição", "Quantidade de Missões"]
    print(tabulate(display_data, headers=headers, tablefmt="grid"))

    while True:
        try:
            escolha = input("Digite o número do objetivo escolhido: ").strip()
            numero_objetivo = int(escolha)
            
            if 1 <= numero_objetivo <= len(objetivos_lista):
                objetivo_escolhido = objetivos_lista[numero_objetivo - 1]
                titulo_objetivo = objetivo_escolhido[0]

                query_update_objetivo = load_sql_query('procedure_atualiza_objetivo')
                if not query_update_objetivo: return

                cursor = conn.cursor()
                cursor.execute(query_update_objetivo, (ID_JOGADOR, titulo_objetivo))
                conn.commit()
                cursor.close()
                clear_console()
                break

            else:
                print(f"Opção inválida. Por favor, escolha um número entre 1 e {len(objetivos_lista)}.")
        except ValueError:
            print("Por favor, digite um número válido.")
        except KeyboardInterrupt:
            conn.rollback()
            print("\nOperação cancelada.")
            return None

def iniciar_jogo(conn, cursor):
    print(f'\n--------------------------------- [ Criar Personagem ] ------------------------------------------')

    try:
        # 1. Consultar e exibir informações do jogador
        query_select_player = load_sql_query('select_player_info')
        if not query_select_player: return

        cursor.execute(query_select_player, (ID_JOGADOR,))
        jogador_info = cursor.fetchone()

        if not jogador_info:
            print(f"Jogador com ID {ID_JOGADOR} não encontrado.")
            return

        nome_atual, gangue_atual = jogador_info
        print(f"\nDados do personagem:")
        print(f"  Nome: {nome_atual}")
        print(f"  Gangue: {gangue_atual}")

        # 2. Perguntar se o usuário aceita ou quer editar
        while True:
            choice = input("\nDeseja editar essas informações? [S/N]: ").strip().upper()
            
            if choice == 'N':
                print(f"Personagem criado com sucesso com sucesso! Pressione ENTER para iniciar o jogo.")
                change_difficulty_console(conn, cursor, ID_JOGADOR)
                escolher_objetivo_principal(conn)
                clear_console()
                start_game(conn, cursor)
                break

            elif choice == 'S':
                change_difficulty_console(conn, cursor, ID_JOGADOR)
                escolher_objetivo_principal(conn)
                pause_and_clear()
                break
            else:
                print("Opção inválida. Digite 'S' para editar ou 'N' para continuar.")

        # 3. Se desejar editar, perguntar o que editar
        while True:
            print(f"\n---------------------------------- [ Edição de Jogador ] ----------------------------------")
            novo_nome = input(f"Digite o novo nome do jogador '{nome_atual}' (até 50 caracteres): ").strip()

            if not novo_nome:
                print("Nome não pode ser vazio. Operação cancelada.")
                conn.rollback()
                return
            
            if len(novo_nome) > 50:
                print("Nome muito longo. O nome deve ter no máximo 50 caracteres. Tente novamente.")
                continue
            
            query_update_player_name = load_sql_query('update_player_field') % ('nome', '%s', '%s')
            
            try:
                cursor.execute(query_update_player_name, (novo_nome, ID_JOGADOR))
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
            

            print(f"\n---------------------------------- [ Gangues Disponíveis ] ----------------------------------\n")
            for i, gangue in enumerate(gangues_disponiveis):
                print(f"{i+1}. {gangue}")
            print("\n")
            
            try:
                escolha_numero = int(input("Digite o número da gangue que deseja escolher: "))
                
                if escolha_numero < 1 or escolha_numero > len(gangues_disponiveis):
                    print(f"Número inválido. Escolha entre 1 e {len(gangues_disponiveis)}. Operação cancelada.")
                    conn.rollback()
                    return
                
                nova_gangue = gangues_disponiveis[escolha_numero - 1]
                
            except ValueError:
                print("Por favor, digite um número válido. Operação cancelada.")
                conn.rollback()
                return

            query_update_player_gang = load_sql_query('update_player_field') % ('nome_gangue', '%s', '%s')
                
            try:
                cursor.execute(query_update_player_gang, (nova_gangue, ID_JOGADOR))
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
