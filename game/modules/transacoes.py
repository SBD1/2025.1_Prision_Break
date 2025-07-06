from db_operations import execute_procedure
from utils import load_sql_query

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
        SELECT id_loja, nome_item, preco, quantidade_disponivel, nome_gangue 
        FROM Loja
    """)
    lojas = cursor.fetchall()

    if not lojas:
        print("Nenhum item disponível na loja.")
        return

    print("\nItens disponíveis para compra:")
    for id_loja, nome_item, preco, quantidade, gangue in lojas:
        print(f"ID: {id_loja} | Item: {nome_item} | Preço: {preco} | Quantidade: {quantidade} | Loja: {gangue}")

    try:
        id_escolhido = int(input("\nDigite o ID do item que deseja comprar (ou 0 para sair): "))
        if id_escolhido == 0:
            print("Saindo da loja.")
            continuar_jogo(conn, id_jogador)
            return
        comprar_item(conn, id_jogador, id_escolhido)
    except ValueError:
        print("ID inválido.")


def continuar_jogo(conn, id_jogador):
    from jogo import jogar
    jogar(conn, id_jogador)
