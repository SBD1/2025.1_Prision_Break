-- Inserts que inicializam o jogo
INSERT INTO gangue (nome_gangue, descricao, qtdd_membros, qtdd_recurso_gangue) VALUES
    ('Os Fox River Eight', 'Grupo formado pelos fugitivos de Fox River. Unidos pela fuga, cada membro tem uma habilidade estratégica.', 8, 60),
    ('Mafia Abruzzi', 'Facção italiana comandada por John Abruzzi, envolvida com crimes organizados e tráfico de influência dentro da prisão.', 10, 45),
    ('Irmandade Ariana', 'Grupo supremacista branco dentro da penitenciária, violento e radical. Liderado por T-Bag.', 12, 40),
    ('La Familia', 'Grupo latino composto por membros de origens mexicanas e porto-riquenhas. Atua com lealdade interna e controle de rotas internas.', 14, 37),
    ('Os Justiceiros', 'Prisioneiros que agem sob o pretexto de justiça interna, combatendo delatores e traidores. Inspirados em atitudes de C-Note.', 7, 28);

INSERT INTO inventario (id_inventario, qtd_itens, is_full) VALUES
    (101, 20, FALSE),
    (102, 5, FALSE),
    (103, 100, FALSE);

INSERT INTO sala (id_sala, id_inventario, nome, descricao, nivel_perigo, bloqueado) VALUES
    (1, 101, 'Cela de Detenção', 'Pequena cela com uma cama e um lavatório.', 0, FALSE),
    (2, 102, 'Pátio Central', 'Área aberta para recreação, com segurança reforçada.', 5, FALSE),
    (3, 103, 'Enfermaria', 'Local onde os detentos recebem cuidados médicos. Acesso restrito.', 2, TRUE);

-- Inserindo em Item -> Tem que ser criada após missão
INSERT INTO Item (nome_item, descricao, durabilidade, pode_ser_vendido, nome_missao, utilidade, beneficio) VALUES
	('Chave Inglesa', 'Ferramenta para apertar parafusos', 100, TRUE, 'Fuga', 'Abrir portas', 'Facilita fuga'),
	('Lanterna', 'Ilumina ambientes escuros', 80, TRUE, 'Fuga', 'Iluminar', 'Ajuda em missões noturnas'),
	('Mapa', 'Mostra a planta da prisão', 50, FALSE, 'Fuga', 'Navegação', 'Evita se perder');

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

-- Consulta_Personagem
INSERT INTO Consulta_Personagem (
    tipo_personagem
) VALUES
    -- ('J'), -- Descomentar depois de inserir a tabela de Jogador
    -- ('P'), -- Descomentar depois de inserir a tabela de Prisioneiros
    ('AP')
REFERENCES id_personagem 

-- Agente_Penitenciario
INSERT INTO Agente_Penitenciario(
    id_personagem, 
    -- id_sala, 
    nome, 
    velocidade, 
    nivel_de_perigo, 
    nivel_de_alerta, 
    corrupto, 
    preco, 
    cargo
) VALUES
    (1, 'Brad Bellick', DEFAULT, 4, DEFAULT, true, 5, DEFAULT),
    (2, 'Alex Mahone', DEFAULT, 8, DEFAULT, DEFAULT, DEFAULT, 'Policial Chefe'),
    (3, 'Paul Kellerman', DEFAULT, 6, DEFAULT, true, 20, DEFAULT),
    (4, 'Donald Self', DEFAULT, 3, DEFAULT, true, 10, DEFAULT),
    (5, 'Warden Pope', DEFAULT, 10, DEFAULT, DEFAULT, DEFAULT, 'Diretor'),
    (6, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

-- Inserindo em Agente_Penitenciario_Jogador
INSERT INTO Agente_Penitenciario_Jogador(
    -- id_personagem_jogador,		--Descomentar depois de adicionar tabela de Jogador 
    id_personagem_agente_penitenciario 
) VALUES
	(1);
-- (1, 2);

INSERT INTO Jogador (id_personagem, nome, velocidade, vida, qtded_recurso, qtded_captura, id_sala, id_inventario, nome_missao, titulo_objetivo, nome_gangue) VALUES
    (10, 'Lucas Silva', 9, 100, 5, 2, 101, 1, 'Fuga de Fox River', 'Libertar Lincoln', 'Os Fox River Eight'),
    (11, 'Gabriel Souza', 8, 95, 4, 1, 102, 2, 'Fuga de Fox River', 'Sobreviver até a fuga', 'Os Fox River Eight'),
    (12, 'Rafael Costa', 7, 92, 3, 3, 103, 3, 'Rota Segura', 'Proteger a família', 'Os Justiceiros'),
    (13, 'Matheus Oliveira', 8, 90, 2, 2, 104, 4, 'Missão de Confiança', 'Provar lealdade', 'Mafia Abruzzi'),
    (14, 'João Almeida', 6, 85, 1, 1, 105, 5, 'Informante Infiltrado', 'Descobrir plano rival', 'La Familia');

INSERT INTO Prisioneiro (id_personagem, nome, velocidade, vida, crime, id_sala, nome_gangue) VALUES
    (1, 'Michael Scofield', 8, 100, 'Assalto a banco (planejado para entrar na prisão)', 101, 'Os Fox River Eight'),
    (2, 'John Abruzzi', 6, 90, 'Homicídio e chefia em organização criminosa', 102, 'Mafia Abruzzi'),
    (3, 'Theodore "T-Bag" Bagwell', 5, 80, 'Estupro, sequestro e assassinato', 103, 'Irmandade Ariana'),
    (4, 'Fernando Sucre', 7, 95, 'Roubo à mão armada', 101, 'Os Fox River Eight'),
    (5, 'Benjamin "C-Note" Franklin', 8, 93, 'Tráfico e deserção militar', 104, 'Os Justiceiros'),
    (6, 'David "Tweener" Apolskis', 7, 85, 'Roubo e desacato', 105, 'Os Fox River Eight'),
    (7, 'Carlos Ortega', 6, 88, 'Tráfico de drogas e agressão', 106, 'La Familia'); 

