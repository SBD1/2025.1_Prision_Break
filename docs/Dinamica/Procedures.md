## Introdução 

As Stored Procedures (Procedimentos Armazenados) são blocos de código SQL que encapsulam operações lógicas e rotinas do sistema, permitindo sua reutilização de forma estruturada e segura dentro do banco de dados. No contexto do jogo Prision Break, essas procedures são responsáveis por automatizar regras de negócio importantes, como a conclusão de missões, concessão de recompensas ao jogador, desbloqueio de novas salas e negociação com agentes penitenciários corruptos.

Utilizar procedures melhora a organização da lógica do sistema, reduz acoplamentos com a aplicação Python e garante que ações críticas ocorram de forma padronizada, segura e eficiente. Além disso, facilita a manutenção do código e o controle sobre os dados do jogo, já que todas as ações sensíveis passam a ser centralizadas no próprio banco.

## Metodologia 

A metodologia aplicada para o desenvolvimento das Stored Procedures consistiu em mapear os principais comportamentos esperados durante o jogo e convertê-los em operações reutilizáveis diretamente no banco de dados. Foram identificadas ações frequentes como concluir uma missão, conceder recompensas e desbloquear conteúdos e transformadas em rotinas SQL encapsuladas, visando reduzir a duplicidade de lógica e aumentar a segurança e consistência dos dados.

A definição dos parâmetros das procedures seguiu o princípio de clareza e padronização, utilizando prefixos identificáveis (como p_) e limitando o tamanho dos VARCHARs conforme o modelo relacional. Isso favoreceu tanto a organização quanto a fácil integração com a aplicação Python. A estrutura modular permite acionar essas procedures de forma isolada ou combinada, conforme os eventos ocorram no jogo.

## Stored procedures

### Criar personagens 

Tem como objetivo cadastrar entidades essenciais no sistema do jogo, como jogadores, agentes penitenciários, prisioneiros e salas. Cada uma realiza verificações prévias de integridade referencial, garantindo que os dados associados, como salas, missões, objetivos e gangues, existam antes de prosseguir com a inserção. 

A procedure criar_jogador valida a existência de entidades relacionadas e cria um novo personagem com inventário vinculado. De forma semelhante, criar_agente_penitenciario e criar_prisioneiro inserem novos personagens do tipo agente ou prisioneiro após confirmar a existência da sala e, no caso dos prisioneiros, da gangue associada. Já a procedure criar_sala é responsável por gerar uma nova sala no jogo, vinculada a um inventário recém-criado. Essas procedures garantem a consistência do banco de dados e automatizam a criação controlada dos elementos do sistema.

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

Realiza a compra de um item por parte de um jogador em uma loja vinculada a uma gangue específica. Primeiramente, ela busca o preço do item na loja correspondente e verifica se o item está disponível. Em seguida, obtém os dados do inventário do jogador, certificando-se de que o mesmo exista e possua recursos suficientes para realizar a compra. Também é verificado se o inventário do jogador não está cheio (limite de 10 itens). 

Caso todas as condições sejam atendidas, o procedimento prossegue com a transação: atualiza os recursos do jogador, cria uma nova instância do item adquirido no inventário, incrementa a quantidade de itens e ajusta o status de inventário cheio, se necessário. Em caso de erro durante qualquer etapa da compra, uma exceção personalizada é lançada com a mensagem de erro correspondente.

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

### Vender item

 Permite que um jogador venda um item específico de seu inventário para a loja de uma gangue. O processo começa verificando se a instância do item existe, se pertence ao inventário do jogador informado e se o item pode ser vendido. Também valida se a loja da gangue indicada comercializa o item. Caso todas as condições sejam atendidas, a procedure calcula o preço de venda (50% do valor original), adiciona essa quantia aos recursos do jogador, remove o item do inventário e atualiza a loja com o item devolvido.
 
A quantidade total de itens no inventário é ajustada, e o status de inventário cheio é desativado, se necessário. Em caso de erro, uma mensagem formatada é lançada, detalhando o problema ocorrido.

``` 
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
```
### Concluir missão 

Gerencia a finalização de uma missão por um jogador e executa diversas ações encadeadas. Primeiro, identifica a missão atual do jogador pelo nome; se ele não tiver nenhuma missão ativa, a execução termina com um aviso. Caso contrário, a missão é marcada como concluída, o jogador recebe uma recompensa de recursos e suas referências à missão e ao objetivo são limpas. Em seguida, é atribuída automaticamente uma nova missão disponível (caso exista), vinculada a um novo objetivo, e uma mensagem é exibida informando a nova tarefa. 

Além disso, a procedure tenta desbloquear uma sala que esteja marcada como bloqueada no sistema, atualizando seu status e exibindo suas informações ao jogador. Com isso, a procedure automatiza a progressão de missões e o avanço no mapa de forma integrada e orientada à narrativa.

```
CREATE OR REPLACE PROCEDURE concluir_missao(p_nome_jogador VARCHAR(50))
LANGUAGE plpgsql
AS $$
DECLARE
    p_missao_atual         VARCHAR(255);
    p_nova_missao          VARCHAR(255);
    p_novo_objetivo        VARCHAR(255);
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

    -- Atribui nova missão (se houver)
    SELECT m.nome_missao, opm.titulo_objetivo
    INTO p_nova_missao, p_novo_objetivo
    FROM Missao m
    JOIN Objetivo_principal_missao opm ON m.nome_missao = opm.nome_missao
    WHERE m.status = true
    LIMIT 1;

    IF p_nova_missao IS NOT NULL THEN
        UPDATE Jogador
        SET nome_missao = p_nova_missao,
            titulo_objetivo = p_novo_objetivo
        WHERE nome = p_nome_jogador;

        RAISE NOTICE 'Nova missão atribuída: % com objetivo %.', p_nova_missao, p_novo_objetivo;
    ELSE
        RAISE NOTICE 'Parabéns você concluiu todas as missões';
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
    ELSE
        RAISE NOTICE '';
    END IF;
END;
$$;
```

### Subornar agente penitenciario 

Permite que um jogador suborne um agente penitenciário corrupto, reduzindo o nível de perigo tanto da sala onde o agente atua quanto do próprio agente. Primeiramente, ela verifica se o agente existe, se é corrupto e qual o custo do suborno. Em seguida, confere se o jogador possui recursos suficientes para realizar a ação. 

Se todas as condições forem atendidas, o valor é descontado dos recursos do jogador, e os níveis de perigo do agente e da sala são reduzidos (respeitando o limite mínimo de zero). Ao final, são exibidas mensagens de sucesso informando a realização do suborno e a redução dos perigos envolvidos.

```
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
        RAISE NOTICE 'Agente penitenciario não encontrado.';
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
```
### Mover NPC

A função mover_npc permite movimentar dinamicamente um personagem do tipo prisioneiro ou agente penitenciário entre salas adjacentes. Primeiramente, a função identifica a sala atual do personagem com base no seu tipo ('P' para prisioneiro e 'AP' para agente). Em seguida, ela busca todas as salas adjacentes à atual, considerando as direções norte, sul, leste e oeste. Para prisioneiros, somente salas desbloqueadas são consideradas, enquanto agentes podem se mover livremente. Caso existam salas adjacentes disponíveis, é sorteado aleatoriamente um índice dentro do array dessas salas e selecionada uma nova sala de destino. 

Por fim, o personagem é atualizado em sua respectiva tabela (Prisioneiro ou Agente_Penitenciario), sendo movido para a nova sala de forma automática. Essa função simula o deslocamento dos NPCs no ambiente do jogo, promovendo interações e dinamicidade entre as entidades.

```
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
```

## 📑 Histórico de Versões

| **Versão**   |   **Data**   | **Descrição** | **Autor** |
|--------|---------|-----------|--------|
|`1.0`| 07/07/2025 | Criação da página de Stored de procedures| [Mayara Alves](https://github.com/Mayara-tech)| 
