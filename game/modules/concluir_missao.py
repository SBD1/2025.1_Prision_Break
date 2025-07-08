from modules.utils import load_sql_query

def concluir_missao(conn, nome_jogador):
    """
    Executa a procedure de conclusão de missão para um jogador específico.
    """
    try:
        query = load_sql_query('procedure_concluir_missao')

        if not query:
            print("Erro: Procedure 'procedure_concluir_missao' não encontrada.")
            return

        cursor = conn.cursor()
        cursor.execute(query, (nome_jogador,))
        conn.commit()
        cursor.close()

        print(f"Missão concluída para o jogador {nome_jogador}!")

    except Exception as e:
        print(f"Erro ao concluir missão: {e}")
