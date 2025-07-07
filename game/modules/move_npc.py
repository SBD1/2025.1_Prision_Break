"""
Controle da movimentação automática de prisioneiros e agentes penitenciários.
"""

from modules.utils import load_sql_query
import time
import threading
import random

INTERVALO_DE_TEMPO = 10

def get_npc_ids(conn):
    """
    Busca no banco de dados os IDs de todos os personagens que são NPCs 
    (Prisioneiros e Agentes Penitenciários).
    """
    try:
        query_npc_ids = load_sql_query('select_npc_ids')

        if not query_npc_ids:
            print("Erro: Query 'select_npc_ids' não encontrada.")
            return []

        cursor = conn.cursor()
        cursor.execute(query_npc_ids)
        npcs_map = cursor.fetchall()
        conn.commit()
        cursor.close()

        if not npcs_map:
            print("Nenhum NPC encontrado no banco de dados.")
            return []

        npc_ids = [(npc_id, tipo) for npc_id, tipo in npcs_map]
        return npc_ids

    except Exception as e:
        print(f"Erro ao buscar IDs dos NPCs: {e}")
        return []

def mover_npc_individual(conn, id_personagem, tipo_personagem):
    """
    Move um NPC individual usando a procedure do banco de dados.
    """
    try:
        procedure_move_npc = load_sql_query('procedure_move_npc')
        if not procedure_move_npc:
            print(f"Erro: Query 'procedure_move_npc' não encontrada.")
            return False
        
        cursor = conn.cursor()
        cursor.execute(procedure_move_npc, (id_personagem, tipo_personagem))
        conn.commit()
        cursor.close()
        
        return True
        
    except Exception as e:
        print(f"Erro ao mover NPC {id_personagem}: {e}")
        return False

def mover_todos_npcs(conn):
    """
    Move todos os NPCs uma vez.
    """
    try:
        npc_ids = get_npc_ids(conn)
        
        if not npc_ids:
            print("Nenhum NPC para movimentar.")
            return
        
        quantidade_para_mover = random.randint(8, 16)

        quantidade_para_mover = min(quantidade_para_mover, len(npc_ids))
        npcs_para_mover = random.sample(npc_ids, quantidade_para_mover)
        
        movimentos_realizados = 0
        for npc_id, tipo in npcs_para_mover:
            if mover_npc_individual(conn, npc_id, tipo):
                movimentos_realizados += 1
        
        # print(f"[NPCs] {movimentos_realizados}/{len(npcs_para_mover)} NPCs se movimentaram")
        
    except Exception as e:
        print(f"Erro ao mover NPCs: {e}")

def iniciar_movimentacao_automatica(conn):
    """
    Inicia a movimentação automática dos NPCs em background.
    """
    def loop_movimentacao():
        while True:
            try:
                mover_todos_npcs(conn)
                time.sleep(INTERVALO_DE_TEMPO)
            except Exception as e:
                print(f"Erro no loop de movimentação: {e}")
                time.sleep(INTERVALO_DE_TEMPO)
    
    thread_movimentacao = threading.Thread(target=loop_movimentacao, daemon=True)
    thread_movimentacao.start()
    
    return thread_movimentacao