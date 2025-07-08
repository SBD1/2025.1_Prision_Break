CREATE OR REPLACE FUNCTION atualiza_objetivo(
    p_id_jogador INTEGER,
    p_titulo_objetivo VARCHAR(255)
) RETURNS VOID AS $$
DECLARE
    r_nome_missao VARCHAR(255);
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Jogador WHERE id_personagem = p_id_jogador) THEN
        RAISE EXCEPTION 'Jogador com ID % não encontrado', p_id_jogador;
    END IF;

    SELECT nome_missao INTO r_nome_missao
    FROM Objetivo_principal_missao
    WHERE titulo_objetivo = p_titulo_objetivo and ordem = 1;

    UPDATE Jogador
    SET titulo_objetivo = p_titulo_objetivo, nome_missao = r_nome_missao
    WHERE id_personagem = p_id_jogador;

END;
$$ LANGUAGE plpgsql;