import sys
from modules.utils import load_sql_query, clear_console, pause_and_clear
from modules.db_operations import execute_procedure, execute_query
from psycopg2 import Error # Importar Error para lidar com exceções de psycopg2

def listar_loja(conn, id_jogador, game_callback):
    """
    Lista os itens disponíveis na loja para compra.
    Permite o jogador escolher um item por ID para comprar.
    """
    clear_console()
    print("[ LOJA ]")
    
    try:
        # Carrega consulta SQL da pasta sql_queries (padrão)
        sql_query_listar_loja = load_sql_query("listar_loja")
        
        if not sql_query_listar_loja:
            print("Erro: Query 'listar_loja' não carregada.")
            pause_and_clear()
            game_callback(conn, id_jogador) # Volta ao menu principal
            return

        loja_items_db = execute_query(conn, sql_query_listar_loja) # Usa execute_query para obter os resultados
        
        if not loja_items_db:
            print("Nenhum item disponível na loja no momento.")
            pause_and_clear()
            game_callback(conn, id_jogador) # Volta ao menu principal
            return

        # Dicionário para mapear o ID exibido ao usuário para os detalhes completos do item
        loja_items_mapeados = {}
        
        print("\nItens disponíveis para compra:")
        for item in loja_items_db:
            # item[0] é o id_loja (row_number), item[1] é nome_item, item[2] é preco, etc.
            item_id = item[0]
            nome_item = item[1]
            preco = item[2]
            quantidade = item[3]
            nome_gangue = item[4]

            print(f"ID: {item_id} | Item: {nome_item} | Preço: {preco} | Quantidade: {quantidade} | Loja: {nome_gangue}")
            
            # Armazenar os detalhes completos do item mapeados pelo ID
            loja_items_mapeados[item_id] = {
                'nome_item': nome_item,
                'preco': preco,
                'quantidade': quantidade,
                'nome_gangue': nome_gangue
            }

        while True:
            try:
                item_id_selecionado = int(input("\nDigite o ID do item que deseja comprar (ou 0 para sair): "))
                print(f"Você selecionou o ID: {item_id_selecionado}")
                if item_id_selecionado == 0:
                    break # Sai do loop de compra

                # Usar o dicionário para obter os detalhes corretos do item
                item_para_comprar = loja_items_mapeados.get(item_id_selecionado)

                if item_para_comprar:
                    nome_item_comprar = item_para_comprar['nome_item']
                    nome_gangue_comprar = item_para_comprar['nome_gangue']
                    quantidade_item_comprar = item_para_comprar['quantidade'] # Verificar quantidade antes de confirmar
                    
                    if quantidade_item_comprar <= 0:
                        print(f"❌ '{nome_item_comprar}' está fora de estoque!")
                        pause_and_clear()
                        clear_console()
                        # Recarregar e exibir a loja novamente para o próximo loop
                        sql_query_listar_loja = load_sql_query("listar_loja")
                        loja_items_db = execute_query(conn, sql_query_listar_loja)
                        loja_items_mapeados = {} # Resetar o mapeamento
                        if not loja_items_db:
                            print("Nenhum item disponível na loja no momento.")
                            pause_and_clear()
                            game_callback(conn, id_jogador)
                            return
                        print("\nItens disponíveis para compra:")
                        for item in loja_items_db:
                            item_id, nome_item, preco, quantidade, gangue = item
                            print(f"ID: {item_id} | Item: {nome_item} | Preço: {preco} | Quantidade: {quantidade} | Loja: {gangue}")
                            loja_items_mapeados[item_id] = {'nome_item': nome_item, 'preco': preco, 'quantidade': quantidade, 'nome_gangue': gangue}
                        continue # Volta para o início do loop while True para nova entrada
                        
                    confirmar = input(f"Confirmar compra de '{nome_item_comprar}' da gangue '{nome_gangue_comprar}'? (s/n): ").lower()
                    if confirmar == 's':
                        # CORREÇÃO AQUI: Chamar "procedure_comprar_item" que está em sql_queries/
                        sql_proc_comprar = load_sql_query("procedure_comprar_item") 
                        if not sql_proc_comprar:
                            print("Erro: Procedure 'procedure_comprar_item' não carregada.")
                            pause_and_clear()
                            break # Sai do loop de compra
                            
                        execute_procedure(conn, sql_proc_comprar, (id_jogador, nome_item_comprar, nome_gangue_comprar))
                        print(f"✅ Você comprou '{nome_item_comprar}' com sucesso!")
                        
                        pause_and_clear()
                        clear_console()
                        # Recarregar e exibir a loja novamente para o próximo loop
                        sql_query_listar_loja = load_sql_query("listar_loja")
                        loja_items_db = execute_query(conn, sql_query_listar_loja)
                        loja_items_mapeados = {} # Resetar o mapeamento
                        if not loja_items_db:
                            print("Nenhum item disponível na loja no momento.")
                            pause_and_clear()
                            game_callback(conn, id_jogador)
                            return
                        print("\nItens disponíveis para compra:")
                        for item in loja_items_db:
                            item_id, nome_item, preco, quantidade, gangue = item
                            print(f"ID: {item_id} | Item: {nome_item} | Preço: {preco} | Quantidade: {quantidade} | Loja: {gangue}")
                            loja_items_mapeados[item_id] = {'nome_item': nome_item, 'preco': preco, 'quantidade': quantidade, 'nome_gangue': gangue}

                    else:
                        print("Compra cancelada.")
                        pause_and_clear()
                        clear_console()
                        # Recarregar e exibir a loja novamente para o próximo loop
                        sql_query_listar_loja = load_sql_query("listar_loja")
                        loja_items_db = execute_query(conn, sql_query_listar_loja)
                        loja_items_mapeados = {} # Resetar o mapeamento
                        if not loja_items_db:
                            print("Nenhum item disponível na loja no momento.")
                            pause_and_clear()
                            game_callback(conn, id_jogador)
                            return
                        print("\nItens disponíveis para compra:")
                        for item in loja_items_db:
                            item_id, nome_item, preco, quantidade, gangue = item
                            print(f"ID: {item_id} | Item: {nome_item} | Preço: {preco} | Quantidade: {quantidade} | Loja: {gangue}")
                            loja_items_mapeados[item_id] = {'nome_item': nome_item, 'preco': preco, 'quantidade': quantidade, 'nome_gangue': gangue}
                else:
                    print("ID de item inválido. Por favor, tente novamente.")
                    pause_and_clear()
                    clear_console()
                    # Recarregar e exibir a loja novamente para o próximo loop
                    sql_query_listar_loja = load_sql_query("listar_loja")
                    loja_items_db = execute_query(conn, sql_query_listar_loja)
                    loja_items_mapeados = {} # Resetar o mapeamento
                    if not loja_items_db:
                        print("Nenhum item disponível na loja no momento.")
                        pause_and_clear()
                        game_callback(conn, id_jogador)
                        return
                    print("\nItens disponíveis para compra:")
                    for item in loja_items_db:
                        item_id, nome_item, preco, quantidade, gangue = item
                        print(f"ID: {item_id} | Item: {nome_item} | Preço: {preco} | Quantidade: {quantidade} | Loja: {gangue}")
                        loja_items_mapeados[item_id] = {'nome_item': nome_item, 'preco': preco, 'quantidade': quantidade, 'nome_gangue': gangue}

            except ValueError:
                print("Entrada inválida. Por favor, digite um número.")
                pause_and_clear()
                clear_console()
                # Recarregar e exibir a loja novamente para o próximo loop
                sql_query_listar_loja = load_sql_query("listar_loja")
                loja_items_db = execute_query(conn, sql_query_listar_loja)
                loja_items_mapeados = {} # Resetar o mapeamento
                if not loja_items_db:
                    print("Nenhum item disponível na loja no momento.")
                    pause_and_clear()
                    game_callback(conn, id_jogador)
                    return
                print("\nItens disponíveis para compra:")
                for item in loja_items_db:
                    item_id, nome_item, preco, quantidade, gangue = item
                    print(f"ID: {item_id} | Item: {nome_item} | Preço: {preco} | Quantidade: {quantidade} | Loja: {gangue}")
                    loja_items_mapeados[item_id] = {'nome_item': nome_item, 'preco': preco, 'quantidade': quantidade, 'nome_gangue': gangue}

            except Exception as e:
                print(f"Erro inesperado durante a compra: {e}")
                pause_and_clear()
                break
        
    except Error as e:
        print(f"Erro de banco de dados ao listar loja: {e}")
        pause_and_clear()
    except Exception as e:
        print(f"Erro inesperado na loja: {e}")
        pause_and_clear()
    finally:
        game_callback(conn, id_jogador)

def comprar_item(conn, id_jogador, nome_item, nome_gangue):
    """
    Função auxiliar para chamar a procedure de compra.
    Agora não é mais usada diretamente pela listar_loja,
    mas pode ser útil se outras partes do código precisarem dela.
    """
    try:
        # CORREÇÃO AQUI: Chamar "procedure_comprar_item" que está em sql_queries/
        sql_proc = load_sql_query("procedure_comprar_item")
        if not sql_proc:
            raise Exception("Query 'procedure_comprar_item' não carregada.")

        execute_procedure(conn, sql_proc, (id_jogador, nome_item, nome_gangue))
        print(f"✅ Você comprou '{nome_item}' com sucesso!")
    except Exception as e:
        print(f"❌ Erro ao comprar item: {e}")

def vender_item(conn, id_jogador, id_instancia_item, nome_gangue_loja):
    """
    Realiza a venda de um item do inventário do jogador para uma loja.
    """
    try:
        # CORREÇÃO AQUI: Chamar "procedure_vender_item" que está em sql_queries/
        sql_proc = load_sql_query("procedure_vender_item")
        if not sql_proc:
            raise Exception("Query 'procedure_vender_item' não carregada.")
            
        execute_procedure(conn, sql_proc, (id_jogador, id_instancia_item, nome_gangue_loja))
        print(f"✅ Item vendido com sucesso para {nome_gangue_loja}!")
    except Exception as e:
        print(f"❌ Erro ao vender item: {e}")