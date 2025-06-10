-- Exemplo de UPDATE para cada tabela
UPDATE Item 
SET durabilidade = 120 
WHERE nome_item = 'Chave Inglesa';

UPDATE Instancia_Item S
ET nivel_de_gasto = 20 
WHERE id_instancia = 1;

UPDATE Item_Loja 
SET nome_gangue = 'Os Renovados' 
WHERE id_compra = 1;

UPDATE Loja 
SET preco = 180.00 
WHERE nome_gangue = 'Os Fugitivos' AND nome_item = 'Chave Inglesa';

-- Aumentar capacidade do inventário de id = 101
UPDATE Inventario 
SET qtd_itens = 25, is_full = TRUE
WHERE id_inventario = 101;

-- Liberar o acesso à enfermaria
UPDATE Sala SET bloqueado = FALSE, WHERE id_sala = 3;

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