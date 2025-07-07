'''
    Se o jogador tentar entrar em uma sala:

    a) Verificar se o cálculo do modificador não é superior ao limite;
        a.1) Valor = Sala.nivel_perigo + SUM(Agente_penitenciario.nivel_perigo) - (Pessoa.dificuldade_jogo)
        se (Valor <= 0): passou no teste;
        se não: é capturado.
    
    Se o cálculo (a) passar (resolver depois)
'''

from modules.utils import load_sql_query
from modules.db_operations import executar_query_select, executar_query_update

# Definir um limite para o nível de perigo considerado "alto"
NIVEL_PERIGO_ALTO_LIMITE = 5 # Ajuste este valor conforme a dificuldade desejada do jogo

def tentar_mudar_sala(player_id: int, nova_sala_id: int, conn, cursor) -> bool:
    """
    Permite ao jogador tentar mudar para uma nova sala, verificando o nível de perigo.

    Esta função realiza as seguintes etapas:
    1. Busca os detalhes da sala de destino, incluindo seu nível de perigo.
    2. Se o nível de perigo da sala for considerado "alto", alerta o jogador
       e oferece a opção de prosseguir ou desistir.
    3. Se o jogador decidir entrar (ou se o nível de perigo for baixo),
       atualiza a sala do jogador no banco de dados.
    4. Retorna True se o jogador mudou de sala com sucesso, False caso contrário.

    Args:
        player_id (int): O ID do personagem jogador.
        nova_sala_id (int): O ID da sala para a qual o jogador deseja se mover.
        conn: Objeto de conexão com o banco de dados (psycopg2 connection).
        cursor: Objeto cursor do banco de dados (psycopg2 cursor).

    Returns:
        bool: True se o jogador foi movido para a nova sala, False caso contrário.
    """
    print(f"\n--- Tentando mover o jogador {player_id} para a sala {nova_sala_id} ---")

    query_sala_details = load_sql_query('select_room_details_by_id')
        
    if not query_sala_details:
        print("Erro: Query 'select_room_details_by_id' não encontrada.")
        return False

    # 1. Buscar detalhes da sala de destino
    try:
        # Carrega a query SQL para obter detalhes da sala
        query_sala_details = load_sql_query('select_room_details_by_id')
        
        if not query_sala_details:
            print("Erro: Query 'select_room_details_by_id' não encontrada.")
            return False

        # Executa a query para obter os detalhes da sala
        # A função executar_query_select retorna uma lista de tuplas
        detalhes_sala = executar_query_select(cursor, query_sala_details, (nova_sala_id,))

        if not detalhes_sala:
            print(f"Erro: Sala com ID {nova_sala_id} não encontrada.")
            return False

        # Extrai os detalhes da sala (a primeira tupla da lista)
        # Assumindo que a query retorna: id_sala, nome, descricao, nivel_perigo, bloqueado
        id_sala, nome_sala, descricao_sala, nivel_perigo_sala, bloqueado_sala = detalhes_sala[0]

        print(f"Detalhes da Sala de Destino (ID: {id_sala}, Nome: {nome_sala}):")
        print(f"Descrição: {descricao_sala}")
        print(f"Nível de Perigo: {nivel_perigo_sala}")

        # 2. Verificar o nível de perigo e alertar se for alto
        if nivel_perigo_sala > NIVEL_PERIGO_ALTO_LIMITE:
            print("\n!!! ALERTA DE PERIGO !!!")
            print(f"O nível de perigo desta sala ({nivel_perigo_sala}) é alto!")
            print("Você tem certeza que deseja prosseguir?")
            print("1. Sim, entrar na sala mesmo assim.")
            print("2. Não, desistir e permanecer na sala atual.")

            escolha = input("Digite sua escolha (1 ou 2): ").strip()

            if escolha == '1':
                print("Você decidiu entrar na sala perigosa. Boa sorte!")
                # Procede para a atualização da sala
                return True
            elif escolha == '2':
                print("Você decidiu não entrar na sala. Permanecendo na sala atual.")
                return False # O jogador desistiu
            else:
                print("Escolha inválida. Permanecendo na sala atual.")
                return False # Escolha inválida, não move o jogador
        else:
            print("Nível de perigo da sala é aceitável. Prosseguindo...")

        # 3. Atualizar a sala do jogador no banco de dados
        query_update_player_room = load_sql_query('update_player_room')
        if not query_update_player_room:
            print("Erro: Query 'update_player_room' não encontrada.")
            return False

        # Executa a query de atualização
        # A função executar_query_update retorna o número de linhas afetadas
        linhas_afetadas = executar_query_update(conn, cursor, query_update_player_room, (nova_sala_id, player_id))

        if linhas_afetadas > 0:
            print(f"Jogador {player_id} movido com sucesso para a sala {nova_sala_id}!")
            return True
        else:
            print(f"Falha ao mover o jogador {player_id} para a sala {nova_sala_id}.")
            return False

    except Exception as e:
        print(f"Ocorreu um erro inesperado ao tentar mudar de sala: {e}")
        return False