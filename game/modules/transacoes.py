from modules.utils import load_sql_query
from modules.db_operations import execute_procedure

# REMOVA ESTA LINHA: from modules.jogo import jogar  # Isso causa a importação circular

def listar_loja(conn, id_jogador, game_callback):
    """
    Exibe todos os itens disponíveis na loja.
    Permite o jogador escolher um item por ID para comprar.
    """
    cursor = conn.cursor()
    
    # Carrega consulta SQL da pasta sql_queries
    # CORREÇÃO: Remover ".sql" do nome do arquivo
    sql = load_sql_query("listar_loja") #
    
    # Adicionar verificação se a query foi carregada com sucesso
    if not sql:
        print("Erro: Query 'listar_loja' não carregada.")
        if game_callback:
            game_callback(conn, cursor)
        return

    try:
        cursor.execute(sql)
    except Error as e:
        print(f"Erro ao executar query de loja: {e}")
        if game_callback:
            game_callback(conn, cursor)
        return

    lojas = cursor.fetchall()

    if not lojas:
        print("Nenhum item disponível na loja.")
        if game_callback:
            game_callback(conn, cursor)
        return

    # Exibe os itens disponíveis na loja
    print("\nItens disponíveis para compra:")
    for loja in lojas:
        id_loja, nome_item, preco, quantidade, gangue = loja
        print(f"ID: {id_loja} | Item: {nome_item} | Preço: {preco} | Quantidade: {quantidade} | Loja: {gangue}")

    # Permite que o jogador selecione um item para comprar
    try:
        id_escolhido = int(input("\nDigite o ID do item que deseja comprar (ou 0 para sair): "))
        if id_escolhido == 0:
            print("Saindo da loja e continuando o jogo...\n")
            if game_callback:
                game_callback(conn, cursor)
            return
        comprar_item(conn, id_jogador, id_escolhido, game_callback)
    except ValueError:
        print("Entrada inválida. Retornando ao jogo.")
        if game_callback:
            game_callback(conn, cursor)


def comprar_item(conn, id_jogador, id_loja, game_callback):
    """
    Processa a compra de um item:
    - Pede confirmação
    - Executa procedure comprar_item
    - Permite nova compra ou sair da loja
    """
    cursor = conn.cursor()

    # Consulta nome do item e da gangue a partir do id_loja
    # CORREÇÃO: Remover ".sql" do nome do arquivo
    sql = load_sql_query("select_nome_item_e_gangue") #
    if not sql:
        print("Erro: Query 'select_nome_item_e_gangue' não carregada.")
        if game_callback:
            game_callback(conn, cursor)
        return

    try:
        cursor.execute(sql, (id_loja,))
    except Error as e:
        print(f"Erro ao executar query de item/gangue: {e}")
        if game_callback:
            game_callback(conn, cursor)
        return

    result = cursor.fetchone()

    if not result:
        print("Item/loja inválidos.")
        if game_callback:
            game_callback(conn, cursor)
        return

    nome_item, nome_gangue = result

    # Confirmação da compra pelo jogador
    confirmacao = input(f"\nConfirmar compra de '{nome_item}' da gangue '{nome_gangue}'? (s/n): ").strip().lower()
    if confirmacao != 's':
        print("Compra cancelada.")
        listar_loja(conn, id_jogador, game_callback)
        return

    try:
        # Executa a procedure do banco para efetuar a compra
        # CORREÇÃO: Remover ".sql" do nome do arquivo
        sql_proc = load_sql_query("procedure_comprar_item") #
        if not sql_proc:
            raise Exception("Query 'procedure_comprar_item' não carregada.")

        execute_procedure(conn, sql_proc, (id_jogador, nome_item, nome_gangue))
        print(f"✅ Você comprou '{nome_item}' com sucesso!")
    except Exception as e:
        print(f"❌ Erro ao comprar item: {e}")

    # Menu pós-compra: nova compra ou sair da loja
    while True:
        opcao = input("\nDeseja (1) comprar outro item ou (2) sair da loja? ")
        if opcao == "1":
            listar_loja(conn, id_jogador, game_callback)
            break
        elif opcao == "2":
            print("Saindo da loja...")
            if game_callback:
                game_callback(conn, cursor)
            break
        else:
            print("Opção inválida. Tente novamente.")


def vender_item(conn, id_jogador, id_instancia_item, nome_gangue_loja):
    """
    Realiza a venda de um item do inventário do jogador para uma loja.
    """
    try:
        # Executa a procedure vender_item
        # CORREÇÃO: Remover ".sql" do nome do arquivo
        sql_proc = load_sql_query("procedure_vender_item") #
        if not sql_proc:
            raise Exception("Query 'procedure_vender_item' não carregada.")
            
        execute_procedure(conn, sql_proc, (id_jogador, id_instancia_item, nome_gangue_loja))
        print("✅ Item vendido com sucesso!")
    except Exception as e:
        print(f"❌ Erro ao vender item: {e}")