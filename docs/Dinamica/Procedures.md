## Introdução 

As Stored Procedures (Procedimentos Armazenados) são blocos de código SQL que encapsulam operações lógicas e rotinas do sistema, permitindo sua reutilização de forma estruturada e segura dentro do banco de dados. No contexto do jogo Prision Break, essas procedures são responsáveis por automatizar regras de negócio importantes, como a conclusão de missões, concessão de recompensas ao jogador, desbloqueio de novas salas e negociação com agentes penitenciários corruptos.

Utilizar procedures melhora a organização da lógica do sistema, reduz acoplamentos com a aplicação Python e garante que ações críticas ocorram de forma padronizada, segura e eficiente. Além disso, facilita a manutenção do código e o controle sobre os dados do jogo, já que todas as ações sensíveis passam a ser centralizadas no próprio banco.

## Metodologia 

A metodologia aplicada para o desenvolvimento das Stored Procedures consistiu em mapear os principais comportamentos esperados durante o jogo e convertê-los em operações reutilizáveis diretamente no banco de dados. Foram identificadas ações frequentes como concluir uma missão, conceder recompensas e desbloquear conteúdos e transformadas em rotinas SQL encapsuladas, visando reduzir a duplicidade de lógica e aumentar a segurança e consistência dos dados.

A definição dos parâmetros das procedures seguiu o princípio de clareza e padronização, utilizando prefixos identificáveis (como p_) e limitando o tamanho dos VARCHARs conforme o modelo relacional. Isso favoreceu tanto a organização quanto a fácil integração com a aplicação Python. A estrutura modular permite acionar essas procedures de forma isolada ou combinada, conforme os eventos ocorram no jogo.

## Stored procedures

### Criar personagens 

```
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

```

### Comprar item

```
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
```
### 

## 📑 Histórico de Versões

| **Versão**   |   **Data**   | **Descrição** | **Autor** |
|--------|---------|-----------|--------|
|`1.0`| 07/07/2025 | Criação da página de Stored de procedures| [Mayara Alves](https://github.com/Mayara-tech)| 
