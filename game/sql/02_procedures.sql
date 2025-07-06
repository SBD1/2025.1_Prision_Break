-- Arquivo para criação de procedures (funções armazenadas)
-- Este arquivo contém todas as procedures/funções do sistema

CREATE OR REPLACE PROCEDURE criar_jogador(
        p_nome VARCHAR(50),
        p_id_sala INT,
        p_titulo_objetivo VARCHAR(255) DEFAULT NULL,
        p_nome_missao VARCHAR(255) DEFAULT NULL,
        p_nome_gangue VARCHAR(50) DEFAULT NULL,
        p_velocidade INT DEFAULT 0,
        p_vida INT DEFAULT 0,
        p_recursos INT DEFAULT 0,
        p_captura INT DEFAULT 0
    )
    LANGUAGE plpgsql
    AS $$
    DECLARE
        r_id_personagem INT;
        r_id_inventario INT;
        flag_sala_exists BOOLEAN;
        flag_missao_exists BOOLEAN;
        flag_objetivo_exists BOOLEAN;
        flag_gangue_exists BOOLEAN;
    BEGIN
        SELECT EXISTS ( SELECT 1 FROM Sala WHERE id_sala = p_id_sala ) INTO flag_sala_exists;
        IF NOT flag_sala_exists THEN
            RAISE EXCEPTION 'Sala com ID % não existe', p_id_sala;
        END IF;

        IF p_nome_missao IS NOT NULL THEN
            SELECT EXISTS ( SELECT 1 FROM Missao WHERE nome_missao = p_nome_missao ) INTO flag_missao_exists;
            IF NOT flag_missao_exists THEN
                RAISE EXCEPTION 'Missão % não existe', p_nome_missao;
            END IF;
        END IF;

        IF p_titulo_objetivo IS NOT NULL THEN
            SELECT EXISTS ( SELECT 1 FROM Objetivo_Principal WHERE titulo_objetivo = p_titulo_objetivo ) INTO flag_objetivo_exists;
            IF NOT flag_objetivo_exists THEN
                RAISE EXCEPTION 'Objetivo % não existe', p_titulo_objetivo;
            END IF;
        END IF;

        IF p_nome_gangue IS NOT NULL THEN
            SELECT EXISTS ( SELECT 1 FROM Gangue WHERE nome_gangue = p_nome_gangue ) INTO flag_gangue_exists;
            IF NOT flag_gangue_exists THEN
                RAISE EXCEPTION 'Gangue % não existe', p_nome_gangue;
            END IF;
        END IF;

        INSERT INTO Consulta_Personagem(tipo_personagem) VALUES ('J')
            RETURNING id_personagem INTO r_id_personagem;

        INSERT INTO Inventario DEFAULT VALUES
            RETURNING id_inventario INTO r_id_inventario;

        INSERT INTO Jogador (id_personagem, nome, velocidade, vida, qtded_recurso, qtded_captura, id_sala, id_inventario, nome_missao, titulo_objetivo, nome_gangue)
            VALUES (
                r_id_personagem,
                p_nome,
                p_velocidade,
                p_vida,
                p_recursos,
                p_captura,
                p_id_sala,
                r_id_inventario,
                p_nome_missao,
                p_titulo_objetivo,
                p_nome_gangue
            );
    END;
    $$; 

CREATE OR REPLACE PROCEDURE criar_agente_penitenciario(
        p_id_sala INT,
        p_nome VARCHAR(50) DEFAULT 'Tira',
        p_velocidade INT DEFAULT 5,
        p_nivel_perigo INT DEFAULT 5,
        p_nivel_alerta INT DEFAULT 5,
        p_corrupto BOOLEAN DEFAULT FALSE,
        p_preco INT DEFAULT 0,
        p_cargo VARCHAR(255) DEFAULT 'Carcereiro'
    )
    LANGUAGE plpgsql
    AS $$
    DECLARE
        r_id_personagem INT;
        flag_sala_exists BOOLEAN;
    BEGIN
        SELECT EXISTS (
            SELECT 1 FROM Sala WHERE id_sala = p_id_sala
        ) INTO flag_sala_exists;
        IF NOT flag_sala_exists THEN
            RAISE EXCEPTION 'Sala com ID % não existe', p_id_sala;
        END IF;

        INSERT INTO Consulta_Personagem (tipo_personagem) 
        VALUES ('AP') 
        RETURNING id_personagem INTO r_id_personagem;

        INSERT INTO Agente_Penitenciario (id_personagem, nome, id_sala, velocidade, nivel_de_perigo, nivel_de_alerta, corrupto, preco, cargo)
        VALUES (
            r_id_personagem,
            p_nome,
            p_id_sala,
            p_velocidade,
            p_nivel_perigo,
            p_nivel_alerta,
            p_corrupto,
            p_preco,
            p_cargo
        );
    END;
    $$; 

CREATE OR REPLACE PROCEDURE criar_prisioneiro(
        p_nome VARCHAR(50),
        p_id_sala INT,
        p_velocidade INT DEFAULT 0,
        p_vida INT DEFAULT 0,
        p_crime VARCHAR(255) DEFAULT NULL,
        p_nome_gangue VARCHAR(50) DEFAULT NULL
    )
    LANGUAGE plpgsql
    AS $$
    DECLARE
        r_id_personagem INT;
        flag_sala_exists BOOLEAN;
        flag_gangue_exists BOOLEAN;
    BEGIN
        SELECT EXISTS (
            SELECT 1 FROM Sala WHERE id_sala = p_id_sala
        ) INTO flag_sala_exists;
        IF NOT flag_sala_exists THEN
            RAISE EXCEPTION 'Sala com ID % não existe', p_id_sala;
        END IF;

        SELECT EXISTS (
            SELECT 1 FROM Gangue WHERE nome_gangue = p_nome_gangue
        ) INTO flag_gangue_exists;
        IF NOT flag_gangue_exists THEN
            RAISE EXCEPTION 'Gangue % não existe', p_nome_gangue;
        END IF;

        INSERT INTO Consulta_Personagem (tipo_personagem) 
        VALUES ('P') 
        RETURNING id_personagem INTO r_id_personagem;

        INSERT INTO Prisioneiro (id_personagem, nome, velocidade, vida, crime, id_sala, nome_gangue)
        VALUES (
            r_id_personagem,
            p_nome,
            p_velocidade,
            p_vida,
            p_crime,
            p_id_sala,
            p_nome_gangue
        );
    END;
    $$; 

CREATE OR REPLACE PROCEDURE criar_sala(
        p_nome VARCHAR(50),
        p_descricao VARCHAR(1000),
        p_nivel_perigo INT,
        p_bloqueado BOOLEAN DEFAULT FALSE
    )
    LANGUAGE plpgsql
    AS $$
    DECLARE
        r_id_inventario INT;
    BEGIN

    INSERT INTO Inventario DEFAULT VALUES
        RETURNING id_inventario INTO r_id_inventario;

    INSERT INTO sala (id_inventario, nome, descricao, nivel_perigo, bloqueado) VALUES(
        r_id_inventario,
        p_nome,
        p_descricao,
        p_nivel_perigo,
        p_bloqueado
    );

    END;
    $$; 
