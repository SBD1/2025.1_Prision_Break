CREATE OR REPLACE FUNCTION handle_player_capture()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se qtded_captura mudou para um valor maior que o anterior
    IF NEW.qtded_captura > OLD.qtded_captura THEN
        -- O atributo id_sala muda para 1
        UPDATE Jogador
        SET id_sala = 1
        WHERE id_personagem = NEW.id_personagem;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

