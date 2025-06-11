-- Exemplo de DELETE usando o id de cada tabela
DELETE FROM Item 
WHERE nome_item = 'Chave Inglesa';

DELETE FROM Instancia_Item 
WHERE id_instancia = 1;

DELETE FROM Item_Loja 
WHERE id_compra = 1;

DELETE FROM Loja 
WHERE nome_gangue = 'Os Fugitivos' AND nome_item = 'Chave Inglesa';

-- Deleta o inventário de id = 102 (Ele não deve estar associado a nenhuma sala)
DELETE FROM Inventario
WHERE id_inventario = 102;

-- Remover sala de id = 1 (Detenção)
DELETE FROM Sala
WHERE id_sala = 1;

-- Apaga personagem
DELETE FROM agente_penitenciario_jogador 
WHERE id_personagem_agente_penitenciario = 6;

DELETE FROM agente_penitenciario 
WHERE id_personagem = 6;

DELETE FROM consulta_personagem 
WHERE id_personagem = 6;
