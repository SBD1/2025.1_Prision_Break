from modules.db_operations import execute_procedure
from modules.utils import load_sql_query

def comprar_item(conn, id_jogador, id_loja):
    cursor = conn.cursor()
    sql = load_sql_query("sql/select_nome_item_e_gangue.sql")
    cursor.execute(sql, (id_loja,))
    result = cursor.fetchone()

    if not result:
        print("Loja ou item não encontrado.")
        return

    nome_item, nome_gangue = result

    confirmacao = input(f"Confirmar compra do item '{nome_item}' da loja '{nome_gangue}'? (s/n): ").lower()
    if confirmacao != 's':
        print("Compra cancelada.")
        return

    try:
        sql = load_sql_query("sql/compra_item.sql")
        execute_procedure(conn, sql, (id_jogador, nome_item, nome_gangue))
        print(f"Você comprou o item '{nome_item}' da loja '{nome_gangue}' com sucesso!")
    except Exception as e:
        print(f"Erro na compra: {e}")

    while True:
        opcao = input("\nDeseja fazer outra compra (1) ou sair da loja (2)? ")
        if opcao == "1":
            listar_loja(conn, id_jogador)
            break
        elif opcao == "2":
            print("Saindo da loja e continuando o jogo...")
            continuar_jogo(conn, id_jogador)
            break
        else:
            print("Opção inválida. Tente novamente.")


def vender_item(conn, id_jogador, id_instancia_item, nome_gangue_loja):
    try:
        sql = load_sql_query("sql/venda_item.sql")
        execute_procedure(conn, sql, (id_jogador, id_instancia_item, nome_gangue_loja))
        print("Item vendido com sucesso!")
    except Exception as e:
        print(f"Erro na venda: {e}")


def listar_loja(conn, id_jogador):
    cursor = conn.cursor()
    cursor.execute("""
        SELECT nome_gangue, nome_item, preco, quantidade_disponivel 
        FROM Loja
        ORDER BY nome_gangue, nome_item
    """)
    lojas = cursor.fetchall()

    if not lojas:
        print("Nenhum item disponível na loja.")
        return

    print("\nItens disponíveis para compra:")
    for i, (nome_gangue, nome_item, preco, quantidade) in enumerate(lojas, 1):
        print(f"{i}. Item: {nome_item} | Preço: {preco} | Quantidade: {quantidade} | Loja: {nome_gangue}")

    try:
        opcao = int(input("\nDigite o número do item que deseja comprar (ou 0 para sair): "))
        if opcao == 0:
            print("Saindo da loja.")
            continuar_jogo(conn, id_jogador)
            return
        
        if 1 <= opcao <= len(lojas):
            nome_gangue, nome_item, preco, quantidade = lojas[opcao - 1]
            comprar_item_por_nome(conn, id_jogador, nome_item, nome_gangue)
        else:
            print("Opção inválida.")
    except ValueError:
        print("Entrada inválida.")
    
    cursor.close()


def continuar_jogo(conn, id_jogador):
    from modules.jogo import iniciar_jogo
    cursor = conn.cursor()
    iniciar_jogo(conn, cursor)

def comprar_item_por_nome(conn, id_jogador, nome_item, nome_gangue):
    """
    Compra um item diretamente pelo nome do item e da gangue.
    """
    confirmacao = input(f"Confirmar compra do item '{nome_item}' da loja '{nome_gangue}'? (s/n): ").lower()
    if confirmacao != 's':
        print("Compra cancelada.")
        return

    try:
        sql = load_sql_query("sql/compra_item.sql")
        execute_procedure(conn, sql, (id_jogador, nome_item, nome_gangue))
        print(f"Você comprou o item '{nome_item}' da loja '{nome_gangue}' com sucesso!")
    except Exception as e:
        print(f"Erro na compra: {e}")

    while True:
        opcao = input("\nDeseja fazer outra compra (1) ou sair da loja (2)? ")
        if opcao == "1":
            listar_loja(conn, id_jogador)
            break
        elif opcao == "2":
            print("Saindo da loja e continuando o jogo...")
            continuar_jogo(conn, id_jogador)
            break
        else:
            print("Opção inválida. Tente novamente.")
