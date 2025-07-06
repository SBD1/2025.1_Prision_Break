CREATE OR REPLACE PROCEDURE subornar_agente(p_nome_jogador VARCHAR(50), p_id_agente INT)
LANGUAGE plpgsql
AS $$
DECLARE
    p_preco_agente       INT;
    p_corrupto           BOOLEAN;
    p_sala               INT;
    p_recursos_jogador   INT;
    p_novo_nivel_agente  INT;
BEGIN
    -- Verifica se agente existe e se é corrupto
    SELECT preco, corrupto, id_sala
    INTO p_preco_agente, p_corrupto, p_sala
    FROM Agente_Penitenciario
    WHERE id_personagem = p_id_agente;

    IF NOT FOUND THEN
        RAISE NOTICE 'Agente não encontrado.';
        RETURN;
    END IF;

    IF p_corrupto IS FALSE THEN
        RAISE NOTICE 'Esse agente não pode ser subornado.';
        RETURN;
    END IF;

    -- Verifica recursos do jogador
    SELECT qtded_recurso INTO p_recursos_jogador
    FROM Jogador
    WHERE nome = p_nome_jogador;

    IF p_recursos_jogador < p_preco_agente THEN
        RAISE NOTICE 'Recursos insuficientes. Custo: %, você tem: %', p_preco_agente, p_recursos_jogador;
        RETURN;
    END IF;

    -- Desconta o recurso
    UPDATE Jogador
    SET qtded_recurso = qtded_recurso - p_preco_agente
    WHERE nome = p_nome_jogador;

    -- Reduz nível de perigo da sala (mínimo 0)
    UPDATE Sala
    SET nivel_perigo = GREATEST(nivel_perigo - 3, 0)
    WHERE id_sala = p_sala;

    -- Reduz nível de perigo do agente (mínimo 0)
    UPDATE Agente_Penitenciario
    SET nivel_de_perigo = GREATEST(nivel_de_perigo - 2, 0)
    WHERE id_personagem = p_id_agente;

    RAISE NOTICE 'Suborno realizado com sucesso.';
    RAISE NOTICE 'Perigo da sala % e do agente % foram reduzidos.', p_sala, p_id_agente;
END;
$$;
