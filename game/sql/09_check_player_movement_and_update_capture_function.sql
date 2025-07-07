CREATE OR REPLACE FUNCTION verificar_e_atualizar_captura()
RETURNS TRIGGER AS $$
DECLARE
    v_nivel_perigo_sala INT;
    v_soma_nivel_perigo_agentes INT;
    v_modificador_dificuldade INT;
    v_modificador_equipamento INT;
    v_valor_aleatorio INT;
    v_resultado_calculo INT;
BEGIN
    -- 1) Verifica se o atributo 'id_sala' do Jogador mudou
    IF NEW.id_sala IS DISTINCT FROM OLD.id_sala THEN
        -- Obter nivel_perigo da nova Sala
        SELECT nivel_perigo INTO v_nivel_perigo_sala
        FROM Sala
        WHERE id_sala = NEW.id_sala;

        -- Calcular a soma de todos os niveis de perigo dos agentes penitenciários na nova sala
        SELECT COALESCE(SUM(AP.nivel_de_perigo), 0) INTO v_soma_nivel_perigo_agentes
        FROM Agente_Penitenciario AP
        WHERE AP.id_sala = NEW.id_sala;

        -- Obter o modificador da dificuldade do jogo do Jogador
        SELECT modificador INTO v_modificador_dificuldade
        FROM Modificador_dificuldade
        WHERE tag_dificuldade = NEW.dificuldade_jogo;

        -- Obter o modificador de equipamento do Jogador
        v_modificador_equipamento := NEW.modificador_equipamento;

        -- Gerar um valor aleatório entre 0 e 10
        v_valor_aleatorio := FLOOR(RANDOM() * 11); -- Multiplica por 11 para incluir o 10

        -- Realizar o cálculo: Sala.nivel_perigo + (soma agentes) - modificador dificuldade + modificador equipamento + aleatório
        v_resultado_calculo := v_nivel_perigo_sala + v_soma_nivel_perigo_agentes - v_modificador_dificuldade + v_modificador_equipamento + v_valor_aleatorio;

        -- 2) Se o valor for maior que 0, incrementa 1 no atributo 'qtded_captura' de Jogador
        IF v_resultado_calculo > 0 THEN
            NEW.qtded_captura := NEW.qtded_captura + 1;
        END IF;
    END IF;

    RETURN NEW; -- Retorna a nova linha (potencialmente modificada)
END;
$$ LANGUAGE plpgsql;