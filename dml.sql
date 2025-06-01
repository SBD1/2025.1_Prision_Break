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
