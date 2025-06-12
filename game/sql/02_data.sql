-- Inserts que inicializam o jogo
INSERT INTO gangue (nome_gangue, descricao, qtdd_membros, qtdd_recurso_gangue) VALUES
    ('Os Fox River Eight', 'Grupo formado pelos fugitivos de Fox River. Unidos pela fuga, cada membro tem uma habilidade estratégica.', 8, 60),
    ('Mafia Abruzzi', 'Facção italiana comandada por John Abruzzi, envolvida com crimes organizados e tráfico de influência dentro da prisão.', 10, 45),
    ('Irmandade Ariana', 'Grupo supremacista branco dentro da penitenciária, violento e radical. Liderado por T-Bag.', 12, 40),
    ('La Familia', 'Grupo latino composto por membros de origens mexicanas e porto-riquenhas. Atua com lealdade interna e controle de rotas internas.', 14, 37),
    ('Os Justiceiros', 'Prisioneiros que agem sob o pretexto de justiça interna, combatendo delatores e traidores. Inspirados em atitudes de C-Note.', 7, 28);

INSERT INTO inventario (id_inventario, qtd_itens, is_full) VALUES
    (1, 20, FALSE),
    (2, 5, FALSE),
    (3, 100, FALSE),
    (4, 10, FALSE),
    (5, 5, FALSE);

INSERT INTO sala (id_sala, id_inventario, nome, descricao, nivel_perigo, bloqueado) VALUES
    (1, 1, 'Cela de Detenção', 'Pequena cela com uma cama e um lavatório.', 0, FALSE),
    (2, 2, 'Pátio Central', 'Área aberta para recreação, com segurança reforçada.', 5, FALSE),
    (3, 3, 'Enfermaria', 'Local onde os detentos recebem cuidados médicos. Acesso restrito.', 2, FALSE),
    (4, 5, 'Sala para telefonemas', 'Local onde os detentos podem fazer ligações.', 5, FALSE);

INSERT INTO Missao (nome_missao, descricao, status) VALUES
    ('Fuga', 'Fuja da prisão.', false),
    ('Missão de Confiança', 'Ganhar a confiança de um membro influente da máfia para obter recursos essenciais', false),
    ('Aliança Perigosa', 'Fazer uma aliança temporária com uma gangue rival para obter acesso a áreas restritas', false),
    ('Túnel da Liberdade', 'Construir um túnel secreto que leve para fora dos muros da prisão', false),
    ('Informante Infiltrado', 'Descobrir e neutralizar um informante que está vazando informações para os guardas', false),
    ('Distração Programada', 'Criar um incidente que distraia a atenção dos guardas no momento crítico da fuga', false),
    ('Fuga de Fox River', 'Planejar e executar a fuga da penitenciária Fox River, envolvendo múltiplos prisioneiros e etapas complexas', false),
    ('Rota Segura', 'Estabelecer um caminho seguro após a fuga, evitando captura pelos agentes penitenciários', false),
    ('Arquivos da Sona', 'Obter documentos secretos que provam a conspiração contra Lincoln Burrows', false);

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
    (1, 'Mafia Abruzzi', 'Chave Inglesa'),
    (2, 'Irmandade Ariana', 'Lanterna'),
    (3, 'La Familia', 'Mapa');

-- Inserindo em Loja
INSERT INTO Loja (nome_gangue, preco, nome_item) VALUES
    ('Mafia Abruzzi', 150.00, 'Chave Inglesa'),
    ('Irmandade Ariana', 75.50, 'Lanterna'),
    ('La Familia', 200.00, 'Mapa');

INSERT INTO Consulta_Personagem (id_personagem, tipo_personagem) VALUES
    (8, 'PR'),
    (9, 'PR'), 
    (10, 'PR'), 
    (11, 'PR'); 

-- Agente_Penitenciario
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
    (1, 2, 'Agente A', 4, 5, 5, true, 5, 'Guarda'),
    (2, 2, 'Agente B', 8, 7, 6, false, 0, 'Policial Chefe'),
    (3, 2, 'Agente C', 6, 5, 5, true, 20, 'Carcereiro'),
    (4, 2, 'Agente D', 3, 4, 4, true, 10, 'Guarda'),
    (5, 2, 'Agente E', 10, 8, 8, false, 0, 'Diretor');

INSERT INTO Prisioneiro (id_personagem, nome, velocidade, vida, crime, id_sala, nome_gangue) VALUES
    (1001, 'João Ligeiro', 5, 80, 'Pequeno Furto', 2, 'Mafia Abruzzi'),
    (1002, 'Maria Silenciosa', 7, 75, 'Invasão', 2, 'Mafia Abruzzi'),
    (1003, 'Carlos Esperto', 6, 90, 'Fraude', 2, 'Mafia Abruzzi'),
    (1004, 'Ana Forte', 4, 110, 'Agressão', 2, 'Irmandade Ariana'),
    (1005, 'Pedro Sombra', 8, 70, 'Evasão Fiscal', 2, 'Mafia Abruzzi'),
    (1006, 'Sofia Vigilante', 5, 85, 'Vandalismo', 2, 'Mafia Abruzzi'),
    (1007, 'Marcelo Desenhista', 3, 60, 'Falsificação', 2, 'La Familia'),
    (1008, 'Beatriz Rápida', 9, 95, 'Roubo de Informações', 2, 'La Familia'),
    (1009, 'Fernando Mudo', 2, 50, 'Contrabando', 2, 'La Familia'),
    (1010, 'Gabriela Ágil', 7, 88, 'Sequestro', 2, 'Irmandade Ariana');
INSERT INTO Dialogo (id_dialogo, id_personagem, nome_missao, texto, ordem) VALUES
    (1, 8, 'Fuga de Fox River', 'Lincoln, eu vou te tirar daqui. Confie em mim.', 1),
    (2, 8, 'Fuga de Fox River', 'Precisamos do plano exato da penitenciária. Alguém tem acesso aos arquivos?', 2),
    (3, 11, 'Fuga de Fox River', 'Michael, você tá maluco? Eles vão nos pegar!', 3),
    (4, 8, 'Fuga de Fox River', 'Cada segundo conta. O túnel deve estar pronto em 72 horas.', 4),
    (5, 9, 'Fuga de Fox River', 'Você tem meu avião, Scofield? Sem avião, sem ajuda.', 5),
    (6, 9, 'Missão de Confiança', 'Na minha família, lealdade se prova com sangue.', 1),
    (7, 8, 'Missão de Confiança', 'O que devo fazer para ganhar sua confiança, Abruzzi?', 2),
    (8, 9, 'Missão de Confiança', 'Traga-me a cabeça do traidor da ala oeste. Literalmente.', 3);

INSERT INTO Objetivo_Principal (titulo_objetivo, descricao) VALUES
    ('Escapar da Prisão', 'Encontrar uma maneira de sair da prisão sem ser detectado pelos guardas.'),
    ('Coletar Recursos', 'Reunir itens essenciais como ferramentas, mapas e suprimentos para a fuga.'),
    ('Desativar Alarmes', 'Localizar e desativar os sistemas de alarme da prisão para garantir uma saída silenciosa.'),
    ('Subornar Guarda', 'Conseguir informações ou ajuda de um guarda corrupto oferecendo algo em troca.'),
    ('Libertar Lincoln', 'Objetivo principal de Michael Scofield: provar a inocência e libertar seu irmão Lincoln Burrows da prisão'),
    ('Sobreviver até a fuga', 'Manter-se vivo e fora do radar dos guardas até o momento da fuga planejada'),
    ('Proteger a família', 'Garantir a segurança da família enquanto o plano de fuga está em andamento'),
    ('Provar lealdade', 'Ganhar a confiança de membros-chave da gangue para obter ajuda na fuga'),
    ('Descobrir plano rival', 'Identificar e neutralizar planos de outras gangues que possam interferir na fuga'),
    ('Coletar recursos', 'Obter itens essenciais para a fuga, como ferramentas, uniformes e informações'),
    ('Distrair guardas', 'Criar distrações para permitir que partes críticas do plano sejam executadas'),
    ('Encontrar Sara', 'Localizar e resgatar a Dra. Sara Tancredi, aliada crucial para o plano de fuga');

INSERT INTO Jogador (id_personagem, nome, velocidade, vida, qtded_recurso, qtded_captura, id_sala, id_inventario, nome_missao, titulo_objetivo, nome_gangue) VALUES
    (1, 'Michael Scofield', 10, 100, 50, 0, 1, 4, 'Fuga', 'Escapar da Prisão', 'Mafia Abruzzi');


INSERT INTO Objetivo_Principal_Missao (titulo_objetivo, nome_missao) VALUES
	('Provar lealdade', 'Missão de Confiança'),
    ('Coletar recursos', 'Aliança Perigosa'),
    ('Sobreviver até a fuga', 'Túnel da Liberdade'),
    ('Descobrir plano rival', 'Informante Infiltrado'),
    ('Distrair guardas', 'Distração Programada'),
    ('Encontrar Sara', 'Fuga de Fox River'),
    ('Proteger a família', 'Rota Segura'),
    ('Libertar Lincoln', 'Arquivos da Sona');

INSERT INTO Missao_Sala (nome_missao, id_sala) VALUES
	('Rota Segura', 3);