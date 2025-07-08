CREATE OR REPLACE PROCEDURE concluir_missao(p_nome_jogador VARCHAR(50))
LANGUAGE plpgsql
AS $$
DECLARE
    p_missao_atual         VARCHAR(255);
    p_nova_missao          VARCHAR(255);
    p_novo_objetivo        VARCHAR(255);
    p_ordem_atual          INT;
    p_recompensa           INT := 10;
    p_nome_sala            VARCHAR(50);
    p_descricao_sala       VARCHAR(1000);
    p_nivel_perigo_sala    INT;
    p_sala_desbloqueada_id INT;
BEGIN
    -- Busca missão atual do jogador
    SELECT nome_missao INTO p_missao_atual
    FROM Jogador
    WHERE nome = p_nome_jogador;

    IF p_missao_atual IS NULL THEN
        RAISE NOTICE 'Jogador % não possui missão ativa.', p_nome_jogador;
        RETURN;
    END IF;

    -- Mensagem de conclusão logo no início
    RAISE NOTICE 'Missão % concluída. % recebeu % recursos.', p_missao_atual, p_nome_jogador, p_recompensa;

    -- Marca missão como concluída
    UPDATE Missao
    SET status = false
    WHERE nome_missao = p_missao_atual;

    -- Dá recompensa e limpa missão atual
    UPDATE Jogador
    SET qtded_recurso = qtded_recurso + p_recompensa,
        nome_missao = NULL,
        titulo_objetivo = NULL
    WHERE nome = p_nome_jogador;

    -- Busca a ordem da missão atual
    SELECT opm.ordem INTO p_ordem_atual
    FROM Objetivo_principal_missao opm
    WHERE opm.nome_missao = p_missao_atual;

    -- Busca a próxima missão com base na ordem
    SELECT opm.nome_missao, opm.titulo_objetivo
    INTO p_nova_missao, p_novo_objetivo
    FROM Objetivo_principal_missao opm
    JOIN Missao m ON m.nome_missao = opm.nome_missao
    WHERE opm.ordem = p_ordem_atual + 1
      AND m.status = true
    LIMIT 1;

    IF p_nova_missao IS NOT NULL THEN
        UPDATE Jogador
        SET nome_missao = p_nova_missao,
            titulo_objetivo = p_novo_objetivo
        WHERE nome = p_nome_jogador;

        RAISE NOTICE 'Nova missão atribuída: % com objetivo %.', p_nova_missao, p_novo_objetivo;
    ELSE
        RAISE NOTICE 'Parabéns você concluiu todas as missões.';
    END IF;

    -- Desbloqueia nova sala e exibe informações
    SELECT id_sala, nome, descricao, nivel_perigo
    INTO p_sala_desbloqueada_id, p_nome_sala, p_descricao_sala, p_nivel_perigo_sala
    FROM Sala
    WHERE bloqueado = true
    LIMIT 1;

    IF p_sala_desbloqueada_id IS NOT NULL THEN
        UPDATE Sala
        SET bloqueado = false
        WHERE id_sala = p_sala_desbloqueada_id;

        RAISE NOTICE 'Sala desbloqueada:';
        RAISE NOTICE '%', p_nome_sala;
        RAISE NOTICE '%', p_descricao_sala;
        RAISE NOTICE 'Nível de perigo: %', p_nivel_perigo_sala;
    END IF;
END;
$$;
