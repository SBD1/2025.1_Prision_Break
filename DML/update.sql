-- Exemplo de UPDATE para cada tabela



-- Gangue (PENDENTE)



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



-- Jogador (PENDENTE)



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



-- Prisioneiro (PENDENTE)


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