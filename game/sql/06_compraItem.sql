CREATE OR REPLACE PROCEDURE comprar_item(
    IN p_id_jogador INT,
    IN p_nome_item VARCHAR(50),
    IN p_nome_gangue_loja VARCHAR(50)
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_preco_item INT;
    v_id_inventario_jogador INT;
    v_qtd_itens_inventario INT;
    v_is_full_inventario BOOLEAN;
    v_proximo_id_instancia INT;
BEGIN
    -- Obter o preço do item na loja da gangue específica
    SELECT preco INTO v_preco_item
    FROM Loja
    WHERE nome_item = p_nome_item AND nome_gangue = p_nome_gangue_loja;

    IF v_preco_item IS NULL THEN
        RAISE EXCEPTION 'Item ''%'' não encontrado na loja da gangue ''%'' ou não está à venda.', p_nome_item, p_nome_gangue_loja;
    END IF;

    -- Obter informações do jogador e seu inventário
    SELECT j.id_inventario, i.qtd_itens, i.is_full
    INTO v_id_inventario_jogador, v_qtd_itens_inventario, v_is_full_inventario
    FROM Jogador j
    JOIN Inventario i ON j.id_inventario = i.id_inventario
    WHERE j.id_personagem = p_id_jogador;

    IF v_id_inventario_jogador IS NULL THEN
        RAISE EXCEPTION 'Jogador com ID % não encontrado.', p_id_jogador;
    END IF;

    -- Verificar se o jogador tem recursos suficientes
    IF (SELECT qtded_recurso FROM Jogador WHERE id_personagem = p_id_jogador) < v_preco_item THEN
        RAISE EXCEPTION 'Recursos insuficientes para comprar o item ''%''.', p_nome_item;
    END IF;

    IF v_qtd_itens_inventario >= 10 THEN
        RAISE EXCEPTION 'Inventário do jogador está cheio.';
    END IF;

    -- Lógica da transação
    BEGIN
        UPDATE Jogador
        SET qtded_recurso = qtded_recurso - v_preco_item
        WHERE id_personagem = p_id_jogador;

        SELECT COALESCE(MAX(id_instancia), 0) + 1 INTO v_proximo_id_instancia FROM Instancia_Item;

        INSERT INTO Instancia_Item (id_instancia, id_inventario, nome_item)
        VALUES (v_proximo_id_instancia, v_id_inventario_jogador, p_nome_item);

        UPDATE Inventario
        SET qtd_itens = qtd_itens + 1,
            is_full = CASE WHEN (v_qtd_itens_inventario + 1) >= 10 THEN TRUE ELSE FALSE END
        WHERE id_inventario = v_id_inventario_jogador;

        RAISE NOTICE 'Item ''%'' comprado com sucesso por % recursos.', p_nome_item, v_preco_item;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Erro ao comprar item: %', SQLERRM;
    END;
END;
$$;
