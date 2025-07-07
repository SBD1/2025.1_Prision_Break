-- Procedure para mover NPCs aleatoriamente
CREATE OR REPLACE FUNCTION mover_npc(
    p_id_personagem INT,
    p_tipo_personagem VARCHAR(2)
)
RETURNS VOID AS $$
DECLARE
    r_id_sala_atual INT;
    r_salas_adjacentes INT[];
    id_sala_proxima INT;
    array_limite_inferior INT;
    array_limite_superior INT;
    indice_aleatorio INT;
BEGIN
    IF p_tipo_personagem = 'P' THEN
        SELECT id_sala INTO r_id_sala_atual
        FROM Prisioneiro
        WHERE id_personagem = p_id_personagem;

        SELECT array_agg(adjacente.id_sala) INTO r_salas_adjacentes
        FROM Sala AS Atual
        JOIN Sala AS adjacente ON adjacente.id_sala IN (Atual.norte, Atual.sul, Atual.leste, Atual.oeste)
        WHERE Atual.id_sala = r_id_sala_atual and adjacente.bloqueado = false;

    ELSIF p_tipo_personagem = 'AP' THEN 
        SELECT id_sala INTO r_id_sala_atual
        FROM Agente_Penitenciario
        WHERE id_personagem = p_id_personagem;

        SELECT array_agg(adjacente.id_sala) INTO r_salas_adjacentes
        FROM Sala AS Atual
        JOIN Sala AS adjacente ON adjacente.id_sala IN (Atual.norte, Atual.sul, Atual.leste, Atual.oeste)
        WHERE Atual.id_sala = r_id_sala_atual;

    ELSE
        RAISE EXCEPTION 'Tipo de personagem inválido: %', p_tipo_personagem;
    END IF;

    IF r_salas_adjacentes IS NULL OR array_length(r_salas_adjacentes, 1) = 0 THEN
        RETURN;
    END IF;

    array_limite_inferior := array_lower(r_salas_adjacentes, 1);
    array_limite_superior := array_upper(r_salas_adjacentes, 1);
    indice_aleatorio := floor(random() * (array_limite_superior - array_limite_inferior + 1) + array_limite_inferior);

    id_sala_proxima := r_salas_adjacentes[indice_aleatorio];
 
    IF p_tipo_personagem = 'P' THEN
        UPDATE Prisioneiro
        SET id_sala = id_sala_proxima
        WHERE id_personagem = p_id_personagem;
    ELSIF p_tipo_personagem = 'AP' THEN
        UPDATE Agente_Penitenciario
        SET id_sala = id_sala_proxima
        WHERE id_personagem = p_id_personagem;
    END IF;

END;
$$ LANGUAGE plpgsql;
