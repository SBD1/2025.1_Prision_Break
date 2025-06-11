-- Inserts que inicializam o jogo

INSERT INTO gangue (nome_gangue, descricao, qtdd_membros, qtdd_recurso_gangue) VALUES
    ('Os Fox River Eight', 'Grupo formado pelos fugitivos de Fox River. Unidos pela fuga, cada membro tem uma habilidade estratégica.', 8, 60),
    ('Mafia Abruzzi', 'Facção italiana comandada por John Abruzzi, envolvida com crimes organizados e tráfico de influência dentro da prisão.', 10, 45),
    ('Irmandade Ariana', 'Grupo supremacista branco dentro da penitenciária, violento e radical. Liderado por T-Bag.', 12, 40),
    ('La Familia', 'Grupo latino composto por membros de origens mexicanas e porto-riquenhas. Atua com lealdade interna e controle de rotas internas.', 14, 37),
    ('Os Justiceiros', 'Prisioneiros que agem sob o pretexto de justiça interna, combatendo delatores e traidores. Inspirados em atitudes de C-Note.', 7, 28);

INSERT INTO inventario (id_inventario, qtd_itens, is_full) VALUES
	(100, 0, FALSE),		--Jogador
	(101, 0, FALSE),		--Cela do Jogador
	(102, 3, FALSE),		--Pátio Central
	(103, 0, FALSE);		--Enfermaria

INSERT INTO sala (id_sala, id_inventario, nome, descricao, nivel_perigo, bloqueado) VALUES
    (1, 101, 'Cela de Detenção', 'Pequena cela com uma cama e um lavatório.', 0, FALSE),
    (2, 102, 'Pátio Central', 'Área aberta para recreação, com segurança reforçada.', 5, FALSE),
    (3, 103, 'Enfermaria', 'Local onde os detentos recebem cuidados médicos. Acesso restrito.', 2, TRUE);

INSERT INTO Missao (nome_missao, descricao, status) VALUES
    ('Missão de Confiança', 'Ganhar a confiança de um membro influente da máfia para obter recursos essenciais', false),
    ('Aliança Perigosa', 'Fazer uma aliança temporária com uma gangue rival para obter acesso a áreas restritas', false),
    ('Túnel da Liberdade', 'Construir um túnel secreto que leve para fora dos muros da prisão', false),
    ('Informante Infiltrado', 'Descobrir e neutralizar um informante que está vazando informações para os guardas', false),
    ('Distração Programada', 'Criar um incidente que distraia a atenção dos guardas no momento crítico da fuga', false),
    ('Fuga de Fox River', 'Planejar e executar a fuga da penitenciária Fox River, envolvendo múltiplos prisioneiros e etapas complexas', false),
    ('Rota Segura', 'Estabelecer um caminho seguro após a fuga, evitando captura pelos agentes penitenciários', false),
    ('Arquivos da Sona', 'Obter documentos secretos que provam a conspiração contra Lincoln Burrows', false);

INSERT INTO Item (nome_item, descricao, durabilidade, pode_ser_vendido, nome_missao, utilidade, beneficio) VALUES
	('Chave Inglesa', 'Ferramenta para apertar parafusos', 100, TRUE, 'Missão de Confiança', 'Abrir portas', 'Facilita fuga'),
	('Lanterna', 'Ilumina ambientes escuros', 80, TRUE, 'Missão de Confiança', 'Iluminar', 'Ajuda em missões noturnas'),
	('Mapa', 'Mostra a planta da prisão', 50, TRUE, 'Missão de Confiança', 'Navegação', 'Evita se perder');

INSERT INTO Instancia_Item (id_instancia, nivel_de_gasto, id_inventario, nome_item) VALUES
	(1, 10, 102, 'Chave Inglesa'),
	(2, 5, 102, 'Lanterna'),
	(3, 2, 102, 'Mapa');

INSERT INTO Item_Loja (id_compra, nome_gangue, nome_item) VALUES
	(1, 'Mafia Abruzzi', 'Chave Inglesa'),
	(2, 'La Familia', 'Lanterna'),
	(3, 'Os Fox River Eight', 'Mapa');

INSERT INTO Loja (nome_gangue, preco, nome_item) VALUES
	('Mafia Abruzzi', 150.00, 'Chave Inglesa'),
	('La Familia', 75.50, 'Lanterna'),
	('Os Fox River Eight', 200.00, 'Mapa');

INSERT INTO Consulta_Personagem (
    tipo_personagem
) VALUES
    ('J'),
    ('AP'), ('AP'), ('AP'), ('AP'), ('AP'), ('AP'),
    ('P'), ('P'), ('P'), ('P'), ('P'), ('P'), ('P');

INSERT INTO Jogador (id_personagem, nome, velocidade, vida, qtded_recurso, qtded_captura, id_sala, id_inventario, nome_missao, titulo_objetivo, nome_gangue) VALUES
    (1, 'Mauricio', 9, 100, 5, 0, 1, 100, NULL, NULL, NULL);

-- Outros exemplos de inserção
--    (11, 'Gabriel Souza', 8, 95, 4, 1, 102, 2, 'Fuga de Fox River', 'Sobreviver até a fuga', 'Os Fox River Eight'),
--    (12, 'Rafael Costa', 7, 92, 3, 3, 103, 3, 'Rota Segura', 'Proteger a família', 'Os Justiceiros'),
--    (13, 'Matheus Oliveira', 8, 90, 2, 2, 104, 4, 'Missão de Confiança', 'Provar lealdade', 'Mafia Abruzzi'),
--    (14, 'João Almeida', 6, 85, 1, 1, 105, 5, 'Informante Infiltrado', 'Descobrir plano rival', 'La Familia');
	
INSERT INTO Agente_Penitenciario(
    id_personagem, 
    id_sala, 
    nome, 
    velocidade, 
    nivel_de_perigo, 
    nivel_de_alerta, 
    corrupto, 
    preco, 
    cargo
) VALUES
    (2, 1, 'Brad Bellick', DEFAULT, 4, DEFAULT, true, 5, DEFAULT),
    (3, 2, 'Alex Mahone', DEFAULT, 8, DEFAULT, DEFAULT, DEFAULT, 'Policial Chefe'),
    (4, 1, 'Paul Kellerman', DEFAULT, 6, DEFAULT, true, 20, DEFAULT),
    (5, 3, 'Donald Self', DEFAULT, 3, DEFAULT, true, 10, DEFAULT),
    (6, 2, 'Warden Pope', DEFAULT, 10, DEFAULT, DEFAULT, DEFAULT, 'Diretor'),
    (7, 3, 'Sara Tancredi', DEFAULT, 0, DEFAULT, DEFAULT, DEFAULT, 'Médica');

INSERT INTO Agente_Penitenciario_Jogador(
    id_personagem_jogador,		
    id_personagem_agente_penitenciario 
) VALUES
	(1, 2);

INSERT INTO Prisioneiro (id_personagem, nome, velocidade, vida, crime, id_sala, nome_gangue) VALUES
    (8, 'Michael Scofield', 8, 100, 'Assalto a banco (planejado para entrar na prisão)', 2, 'Os Fox River Eight'),
    (9, 'John Abruzzi', 6, 90, 'Homicídio e chefia em organização criminosa', 1, 'Mafia Abruzzi'),
    (10, 'Theodore "T-Bag" Bagwell', 5, 80, 'Estupro, sequestro e assassinato', 1, 'Irmandade Ariana'),
    (11, 'Fernando Sucre', 7, 95, 'Roubo à mão armada', 2, 'Os Fox River Eight'),
    (12, 'Benjamin "C-Note" Franklin', 8, 93, 'Tráfico e deserção militar', 2, 'Os Justiceiros'),
    (13, 'David "Tweener" Apolskis', 7, 85, 'Roubo e desacato', 2, 'Os Fox River Eight'),
    (14, 'Carlos Ortega', 6, 88, 'Tráfico de drogas e agressão', 3, 'La Familia'); 

