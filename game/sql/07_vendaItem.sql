CREATE OR REPLACE PROCEDURE vender_item(
    IN p_id_jogador INT,
    IN p_id_instancia_item INT,
    IN p_nome_gangue_loja VARCHAR(50)
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_nome_item VARCHAR(50);
    v_preco_item INT;
    v_id_inventario_jogador INT;
    v_pode_ser_vendido BOOLEAN;
    v_qtd_itens_inventario INT;
    v_loja_existe BOOLEAN;
    v_msg_erro TEXT;
BEGIN
    -- Obter informações da instância do item e do item
    SELECT ii.nome_item, it.pode_ser_vendido, ii.id_inventario
    INTO v_nome_item, v_pode_ser_vendido, v_id_inventario_jogador
    FROM Instancia_Item ii
    JOIN Item it ON ii.nome_item = it.nome_item
    WHERE ii.id_instancia = p_id_instancia_item;

    -- Verificar se a instância do item existe
    IF v_nome_item IS NULL THEN
        RAISE EXCEPTION 'Instância do item com ID % não encontrada.', p_id_instancia_item;
    END IF;

    -- Verificar se o item pertence ao inventário do jogador
    IF (SELECT id_inventario FROM Jogador WHERE id_personagem = p_id_jogador) IS DISTINCT FROM v_id_inventario_jogador THEN
        RAISE EXCEPTION 'O item com ID de instância % não pertence ao inventário do jogador %.', p_id_instancia_item, p_id_jogador;
    END IF;

    -- Verificar se o item pode ser vendido
    IF NOT v_pode_ser_vendido THEN
        RAISE EXCEPTION 'O item ''%'' não pode ser vendido.', v_nome_item;
    END IF;

    -- Verificar se a loja de destino existe e se o item é vendido por ela
    SELECT EXISTS(SELECT 1 FROM Loja WHERE nome_gangue = p_nome_gangue_loja AND nome_item = v_nome_item)
    INTO v_loja_existe;
    IF NOT v_loja_existe THEN
        RAISE EXCEPTION 'A loja ''%'' não comercializa o item ''%'' ou não existe.', p_nome_gangue_loja, v_nome_item;
    END IF;

    -- Obter o preço de venda do item (50% do valor original)
    SELECT FLOOR(L.preco * 0.5)
    INTO v_preco_item
    FROM Loja L
    WHERE L.nome_item = v_nome_item AND L.nome_gangue = p_nome_gangue_loja;

    IF v_preco_item IS NULL THEN
        v_preco_item := 0;
        RAISE NOTICE 'Preço de venda para o item ''%'' não encontrado na Loja especificada, assumindo 0.', v_nome_item;
    END IF;

    -- Iniciar transações (o bloco BEGIN/EXCEPTION já cria um ponto de salvamento implícito)
    BEGIN
        -- Atualizar recursos do jogador
        UPDATE Jogador
        SET qtded_recurso = qtded_recurso + v_preco_item
        WHERE id_personagem = p_id_jogador;

        -- Remover item do inventário
        DELETE FROM Instancia_Item
        WHERE id_instancia = p_id_instancia_item;

        -- Atualizar quantidade de itens no inventário
        SELECT qtd_itens
        INTO v_qtd_itens_inventario
        FROM Inventario
        WHERE id_inventario = v_id_inventario_jogador;

        UPDATE Inventario
        SET qtd_itens = v_qtd_itens_inventario - 1,
            is_full = FALSE
        WHERE id_inventario = v_id_inventario_jogador;

        -- Adicionar item de volta ao estoque da loja
        UPDATE Loja
        SET quantidade_disponivel = quantidade_disponivel + 1
        WHERE nome_gangue = p_nome_gangue_loja AND nome_item = v_nome_item;

        RAISE NOTICE 'Item ''%'' vendido com sucesso por % recursos para a loja ''%''.', v_nome_item, v_preco_item, p_nome_gangue_loja;
    
    EXCEPTION
        WHEN OTHERS THEN
            v_msg_erro := format('Erro ao vender item: %s - %s', SQLSTATE, SQLERRM);
            RAISE EXCEPTION USING MESSAGE = v_msg_erro;
    END;
END;
$$;