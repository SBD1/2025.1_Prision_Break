-- Exemplo de UPDATE para cada tabela


-- Aumentar quantidade de membros da Gangue
UPDATE Gangue
SET qtdd_membros = qtdd_membros + 1
WHERE nome_gangue = 'Os Fox River Eight'

-- Aumentar quantidade de recursos da Gangue
UPDATE Gangue
SET qtdd_recurso_gangue = qtdd_recurso_gangue + 1
WHERE nome_gangue = 'Os Fox River Eight'



-- Aumentar capacidade do inventário de id = 101
UPDATE Inventario 
SET qtd_itens = 25, is_full = TRUE
WHERE id_inventario = 101;



-- Liberar o acesso à enfermaria
UPDATE Sala SET bloqueado = FALSE, WHERE id_sala = 3;



-- Atualiza o status de missões concluídas
UPDATE Missao
SET status = true
WHERE nome_missao IN ('Arquivos da Sona', 'Rota Segura');

-- Corrige a descrição de uma missão
UPDATE Missao
SET descricao = 'Construir um túnel secreto que leve para fora dos muros da prisão, usando ferramentas improvisadas'
WHERE noma_missao IN 'Túnel da Liberdade';



-- Altera a durabilidade de um item
UPDATE Item 
SET durabilidade = 120 
WHERE nome_item = 'Chave Inglesa';



-- Altera o nível de gasto de um item (Conserto ou uso do item)
UPDATE Instancia_Item S
SET nivel_de_gasto = 20 
WHERE id_instancia = 1;



-- Altera a gangue que está vendendo o item
UPDATE Item_Loja 
SET nome_gangue = 'Os Renovados' 
WHERE id_compra = 1;



-- Altera o preço de um item
UPDATE Loja 
SET preco = 180.00 
WHERE nome_gangue = 'Os Fugitivos' AND nome_item = 'Chave Inglesa';



-- Consulta_Personagem não possui update pois não há regra de negócio para isso



-- Aumentar a velocidade do personagem 
UPDATE Jogador
SET velocidade = 8,
WHERE id_personagem = 1;

-- Aumentar vida do personagem 
UPDATE Jogador
SET vida = Vida + 25
WHERE id_personagem = 1

-- Aumentar quantidade de recurso do personagem
UPDATE Jogador
SET qtded_recurso = qtded_recurso + 1
WHERE id_personagem = 1

-- Aumentar quantidade de capturas do persoangem
UPDATE Jogador
SET qtded_captura = qtded_captura + 1
WHERE id_personagem = 1

-- Alterar sala que o personagem esta
UPDATE Jogador
SET id_sala = 2
WHERE id_personagem = 1;

-- Alterar a escolha da gangue do personagem
UPDATE Jogador
SET nome_gangue = 'Os Fox River Eight'
WHERE id_personagem = 1;

-- Desvincular personagem da gangue
UPDATE Jogador
SET nome_gangue = NULL
WHERE nome_gangue = 'Os Fox River Eight';



-- Aumenta a velocidade e o nível de alerta do personagem
UPDATE agente_penitenciario
SET velocidade = 6, nivel_de_alerta = 10
WHERE id_personagem = 6;

-- Diminui a velocidade e o nível de alerta do personagem
UPDATE agente_penitenciario
SET velocidade = 5, nivel_de_alerta = 5
WHERE id_personagem = 6;

-- Nivel difícil
UPDATE agente_penitenciario
SET velocidade = 10, nivel_de_perigo = 10, nivel_de_alerta = 10
WHERE id_personagem = 6;



-- Agente_Penitenciario_Jogador não possui update pois não há regra de negócio para isso



-- Aumentar velocidade do prisioneiro
UPDATE Prisioneiro
SET velocidade = 10
WHERE id_personagem = 8;

-- Alterar sala do prisioneiro de forma aleatória
UPDATE Prisioneiro
SET id_sala = S.id_sala
FROM (
    SELECT id_sala FROM Sala ORDER BY RANDOM() LIMIT 1
) AS S
WHERE id_personagem = 8;

-- Desvincular prisioneiros da gangue 
UPDATE Prisioneiro
SET nome_gangue = NULL
WHERE nome_gangue = 'Os Fox River Eight';


-- Mudança de dialogo
UPDATE Dialogo
SET texto = 'Lincoln eu te prometo que iremos sair daqu';
WHERE id_dialogo = 1;



-- Modifica a descrição de um objetivo
UPDATE Objetivo_Principal
SET descricao = 'Provar a inocência e libertar seu irmão Lincoln Burrows da prisão, evitando sua execução'
WHERE titulo_objetivo = 'Libertar Lincoln';



-- Objetivo_Principal_Missao não possui update pois não há regra de negócio para isso



-- Altera missão que libera uma sala específica
UPDATE Missao_Sala
SET nome_missao = 'Fuga de Fox River'
WHERE id_sala = 1;