-- DML para popular as tabelas do banco de dados

-- Inserindo em Item
INSERT INTO Item (nome_item, descricao, durabilidade, pode_ser_vendido, nome_missao, utilidade, beneficio) VALUES
('Chave Inglesa', 'Ferramenta para apertar parafusos', 100, TRUE, 'Fuga1', 'Abrir portas', 'Facilita fuga'),
('Lanterna', 'Ilumina ambientes escuros', 80, TRUE, 'Fuga2', 'Iluminar', 'Ajuda em missões noturnas'),
('Mapa', 'Mostra a planta da prisão', 50, FALSE, 'Fuga3', 'Navegação', 'Evita se perder');

-- Inserindo em Instancia_Item
INSERT INTO Instancia_Item (id_instancia, nivel_de_gasto, id_inventario, nome_item) VALUES
(1, 10, 1, 'Chave Inglesa'),
(2, 5, 2, 'Lanterna'),
(3, 2, 3, 'Mapa');

-- Inserindo em Item_Loja
INSERT INTO Item_Loja (id_compra, nome_gangue, nome_item) VALUES
(1, 'Os Fugitivos', 'Chave Inglesa'),
(2, 'Os Noturnos', 'Lanterna'),
(3, 'Os Exploradores', 'Mapa');

-- Inserindo em Loja
INSERT INTO Loja (nome_gangue, preco, nome_item) VALUES
('Os Fugitivos', 150.00, 'Chave Inglesa'),
('Os Noturnos', 75.50, 'Lanterna'),
('Os Exploradores', 200.00, 'Mapa');

-- Inserindo em Inventário
INSERT INTO Inventario (id_inventario, qtd_itens, is_full)
VALUES
    (101, 20, FALSE),
    (102, 5, FALSE),
    (103, 100, FALSE);

-- Inserindo em Sala
INSERT INTO Sala (id_sala, id_inventario, nome, descricao, nivel_perigo, bloqueado)
VALUES
    (1, 101, 'Cela de Detenção', 'Pequena cela com uma cama e um lavatório.', 0, FALSE),
    (2, 102, 'Pátio Central', 'Área aberta para recreação, com segurança reforçada.', 5, FALSE),
    (3, 103, 'Enfermaria', 'Local onde os detentos recebem cuidados médicos. Acesso restrito.', 2, TRUE);


-- Inserindo em MissaoSala
-- Será adicionada quando tiver a tabela Missao

-- Aumentar capacidade do inventário de id = 101
UPDATE Inventario
SET
    qtd_itens = 25,
    is_full = TRUE
WHERE
    id_inventario = 101;

-- Deleta o inventário de id = 102 (Ele não deve estar associado a nenhuma sala)
DELETE FROM Inventario
WHERE
    id_inventario = 102;

-- Liberar o acesso à enfermaria
UPDATE Sala
SET
    bloqueado = FALSE,
WHERE
    id_sala = 3;

-- Remover sala de id = 1 (Detenção)
DELETE FROM Sala
WHERE
    id_sala = 1;
