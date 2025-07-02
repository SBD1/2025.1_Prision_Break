-- Inserts que inicializam o jogo

INSERT INTO gangue (nome_gangue, descricao, qtdd_membros, qtdd_recurso_gangue) VALUES
    ('Os Fox River Eight', 'Grupo formado pelos fugitivos de Fox River. Unidos pela fuga, cada membro tem uma habilidade estratégica.', 8, 60),
    ('Mafia Abruzzi', 'Facção italiana comandada por John Abruzzi, envolvida com crimes organizados e tráfico de influência dentro da prisão.', 10, 45),
    ('Irmandade Ariana', 'Grupo supremacista branco dentro da penitenciária, violento e radical. Liderado por T-Bag.', 12, 40),
    ('La Familia', 'Grupo latino composto por membros de origens mexicanas e porto-riquenhas. Atua com lealdade interna e controle de rotas internas.', 14, 37),
    ('Os Justiceiros', 'Prisioneiros que agem sob o pretexto de justiça interna, combatendo delatores e traidores. Inspirados em atitudes de C-Note.', 7, 28);

INSERT INTO inventario (id_inventario, qtd_itens, is_full) VALUES
	(0, 0, FALSE),		--Jogador
	(1, 0, FALSE),		
	(2, 0, FALSE),		
	(3, 0, FALSE),		
	(4, 0, FALSE),		
	(5, 0, FALSE),		
	(6, 0, FALSE),		
	(7, 0, FALSE),		
	(8, 0, FALSE),		
	(9, 0, FALSE),		
	(10, 0, FALSE),		
	(11, 0, FALSE),		
	(12, 0, FALSE),		
	(13, 0, FALSE),		
	(14, 0, FALSE),		
	(15, 0, FALSE),		
	(16, 0, FALSE),		
	(17, 0, FALSE),		
	(18, 0, FALSE),		
	(19, 0, FALSE),		
	(20, 0, FALSE),		
	(21, 0, FALSE),		
	(22, 0, FALSE),		
	(23, 0, FALSE),		
	(24, 0, FALSE),		
	(25, 0, FALSE),		
	(26, 0, FALSE),		
	(27, 0, FALSE),		
	(28, 0, FALSE),		
	(29, 0, FALSE),		
	(30, 0, FALSE),		
	(31, 0, FALSE),		
	(32, 0, FALSE),		
	(33, 0, FALSE),		
	(34, 0, FALSE),		
	(35, 0, FALSE);		

INSERT INTO sala (id_sala, id_inventario, nome, descricao, nivel_perigo, bloqueado) VALUES
    (   
        1, 1, 'Cela do Jogador', 
        'Um espaço apertado com uma cama, uma pia e as quatro paredes que te separam do mundo. É o único lugar para pensar sem olhares curiosos.', 
        0, FALSE
    ), (   
        2, 2, 'Cela do Irmão', 
        'Idêntica à sua, mas carrega o peso da urgência. É o motivo pelo qual os planos são traçados e os riscos são tomados. Um lembrete constante do que está em jogo.', 
        0, FALSE
    ), (   
        3, 3, 'Bloco A', 
        'Fileiras de celas que abrigam centenas de detentos. Território da gangue Os Fox River Eight. O barulho é constante e a tensão, palpável', 
        0, FALSE
    ), (   
        4, 4, 'Bloco B', 
        'Fileiras de celas que abrigam centenas de detentos. Território da gangue Mafia Abruzzi. O barulho é constante e a tensão, palpável', 
        0, FALSE
    ), (   
        5, 5, 'Bloco C', 
        'Fileiras de celas que abrigam centenas de detentos. Território da gangue Irmandade Ariana. O barulho é constante e a tensão, palpável', 
        0, FALSE
    ), (   
        6, 6, 'Bloco D', 
        'Fileiras de celas que abrigam centenas de detentos. Território da gangue La Familia. O barulho é constante e a tensão, palpável', 
        0, FALSE
    ), (   
        7, 7, 'Bloco E', 
        'Fileiras de celas que abrigam centenas de detentos. Território da gangue Os Justiceiros. O barulho é constante e a tensão, palpável', 
        0, FALSE
    ),(   
        8, 8, 'Solitária', 
        'Um cômodo escuro e vazio para onde os guardas enviam os problemáticos para quebrar seu espírito. Passar tempo aqui é um teste de sanidade.', 
        0, TRUE
    ), (   
        9, 9, 'Banheiro', 
        'Úmido, sujo e com pouca privacidade. É um ponto de encontro para negócios escusos, trocas de informações e confrontos longe dos olhos da maioria dos guardas.', 
        0, FALSE
    ), (   
        10, 10, 'Biblioteca', 
        'Um refúgio de silêncio em meio ao caos. As estantes empoeiradas guardam mais do que livros; guardam conhecimento, códigos e segredos para aqueles que sabem onde procurar.', 
        0, FALSE
    ), (   
        11, 11, 'Patio Principal', 
        'Vasta área a céu aberto, cercada por muros altos e arame farpado. É onde os detentos se exercitam, socializam e conspiram sob o olhar atento das torres de vigia.', 
        0, FALSE
    ), (   
        12, 12, 'Cozinha', 
        'O coração quente e barulhento da prisão. Cheia de vapores, facas e panelas gigantes, é um local de trabalho forçado e uma fonte de ferramentas improvisadas e conflitos.', 
        0, FALSE
    ), (   
        13, 13, 'Refeitório', 
        'Um grande salão onde toda a população carcerária se reúne. As mesas são divididas por alianças. É o palco principal para demonstrações de poder e o lugar onde as brigas mais começam.', 
        0, FALSE
    ), (   
        14, 14, 'Enfermaria', 
        'Um oásis de limpeza. O cheiro de antisséptico domina o ar. É o lugar para tratar ferimentos, mas também para conseguir acesso a medicamentos e informações da equipe médica.', 
        7, TRUE
    ), (   
        15, 15, 'Telhado da Enfermaria', 
        'Uma rota de fuga perigosa e exposta. Oferece uma visão panorâmica, mas também te transforma em um alvo fácil para as torres. O vento frio é um gosto amargo da liberdade.', 
        10, TRUE
    ), (   
        16, 16, 'Copa dos Policiais', 
        'A área de descanso dos guardas. Um lugar para café, conversas e negócios corruptos. Um prisioneiro aqui é um alvo fácil, mas o lixo pode conter informações valiosas.', 
        0, TRUE
    ), (   
        17, 17, 'Recepção', 
        'A primeira barreira entre a prisão e o mundo exterior. Visitantes e novos prisioneiros passam por aqui. Área de alta segurança, com detectores de metal e guardas atentos.', 
        0, FALSE
    ), (   
        18, 18, 'Diretoria', 
        'O escritório do Diretor. Símbolo máximo de autoridade. É aqui que as decisões importantes são tomadas e onde os segredos da administração estão trancados.', 
        10, TRUE
    ), (   
        19, 19, 'Sala de Câmeras', 
        'O centro nervoso da segurança. Monitores exibem cada corredor e cada cela. Controlar o que se vê aqui é controlar a prisão inteira, mesmo que por poucos minutos.', 
        0, TRUE
    ), (   
        20, 20, 'Entrada', 
        'O portão principal. A última barreira de aço e concreto entre você e a liberdade. Fortemente guardado, é o caminho mais direto e o mais mortal para uma fuga.', 
        0, TRUE
    ), (   
        21, 21, 'Área externa leste', 
        'Ao emergir no telhado, você é recebido não por holofotes, mas pelo abraço do céu aberto. A brisa fresca lava o ar viciado da prisão de seus pulmões. Abaixo, a prisão parece uma maquete escura e impotente. Acima, um vasto oceano de estrelas brilha sem muros ou grades. O som distante dos grilos substitui o zumbido das luzes. É o seu primeiro momento de verdadeira paz, um prelúdio sereno para a liberdade que o aguarda.', 
        0, TRUE
    ), (   
        22, 22, 'Área externa sul', 
        'Ao passar pelo último portão de aço, o ar da noite muda completamente. O cheiro de poeira e desinfetante dá lugar ao aroma de terra molhada e grama fresca. O barulho da prisão se torna um eco distante, abafado pelo som suave do vento nas árvores. A estrada se estende sob a luz da lua, um caminho que te leva para longe do pesadelo, em direção a um futuro incerto, mas finalmente livre. A calmaria da natureza te envolve, uma promessa de paz.', 
        0, TRUE
    ), (   
        23, 23, 'Oficina', 
        'O som de metal contra metal preenche o ar. Um lugar de trabalho forçado, onde os detentos fabricam placas e consertam equipamentos. É um ambiente perigoso, mas também uma fonte inestimável de materiais brutos, ferramentas e potenciais armas.', 
        0, FALSE
    ), (   
        24, 24, 'Corredor da Cela do Irmão', 
        'Um corredor estreito e mais silencioso, terminando na cela que guarda o motivo de sua luta. A proximidade com o objetivo torna o ar pesado de expectativa e perigo.', 
        0, FALSE
    ), (   
        25, 25, 'Corredor do Bloco A', 
        'O som das grades e das conversas é constante. Este corredor serve como fronteira do território da gangue Os Fox River Eight. Pisar aqui sem permissão é um convite para problemas.', 
        0, FALSE
    ), (   
        26, 26, 'Corredor do Bloco B', 
        'O som das grades e das conversas é constante. Este corredor serve como fronteira do território da gangue Mafia Abruzzi. Pisar aqui sem permissão é um convite para problemas.', 
        0, FALSE
    ), (   
        27, 27, 'Corredor da Ala Norte', 
        'O principal eixo da área residencial da prisão, conectando os diversos blocos de celas. É um ponto de grande movimento, onde alianças e rivalidades se cruzam constantemente. O ar é gelado e o cheiro piora conforme você se aproxima. ', 
        0, FALSE
    ), (   
        28, 28, 'Corredor do Bloco D', 
        'O som das grades e das conversas é constante. Este corredor serve como fronteira do território da gangue La Familia. Pisar aqui sem permissão é um convite para problemas.', 
        0, FALSE
    ), (   
        29, 29, 'Corredor do Bloco E', 
        'O som das grades e das conversas é constante. Este corredor serve como fronteira do território da gangue Os Justiceiros. Pisar aqui sem permissão é um convite para problemas.', 
        0, FALSE
    ), (   
        30, 30, 'Corredor longo', 
        'Um trecho monótono e retilíneo de concreto, vigiado por câmeras em ambas as extremidades. A falta de cantos para se esconder o torna um lugar exposto, onde qualquer movimento suspeito é facilmente notado. Ao fim é possível ver o corredor frio e escuro da solitária.', 
        0, FALSE
    ), (   
        31, 31, 'Corredor da Solitária', 
        'O caminho para o inferno. Um corredor frio e mal iluminado que leva à sala mais temida da prisão. Apenas o eco dos seus passos quebra o silêncio opressor. Ninguém vem aqui por vontade própria.', 
        0, FALSE
    ), (   
        32, 32, 'Corredor da Ala Oeste', 
        'A artéria que leva ao barulho da oficina e do refeitório. Frequentemente patrulhado durante as horas de trabalho e refeições.', 
        0, FALSE
    ), (   
        33, 33, 'Corredor da Ala Leste', 
        'Conduz ao silêncio da biblioteca e ao cheiro de antisséptico da enfermaria. É uma rota mais calma, mas não menos vigiada.', 
        0, FALSE
    ), (   
        34, 34, 'Corredor da Ala Sul', 
        'O limiar do poder. Este corredor dá acesso à recepção e à entrada principal. A presença de guardas aqui é muito mais intensa.', 
        0, TRUE
    ), (   
        35, 35, 'Corredor dos guardas', 
        'Território proibido. Limpo, bem iluminado e silencioso, conecta áreas vitais de segurança. Ser pego aqui significa, no mínimo, uma passagem só de ida para a solitária.', 
        0, TRUE
    );


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

-- INSERT INTO Instancia_Item (id_instancia, nivel_de_gasto, id_inventario, nome_item) VALUES
-- 	(1, 10, 102, 'Chave Inglesa'),
-- 	(2, 5, 102, 'Lanterna'),
-- 	(3, 2, 102, 'Mapa');

INSERT INTO Loja (nome_gangue, preco, nome_item) VALUES
	('Mafia Abruzzi', 150.00, 'Chave Inglesa'),
	('La Familia', 75.50, 'Lanterna'),
	('Os Fox River Eight', 200.00, 'Mapa');
    
INSERT INTO Item_Loja (id_compra, nome_gangue, nome_item) VALUES
	(1, 'Mafia Abruzzi', 'Chave Inglesa'),
	(2, 'La Familia', 'Lanterna'),
	(3, 'Os Fox River Eight', 'Mapa');


INSERT INTO Consulta_Personagem (
    tipo_personagem
) VALUES
    ('J'),
    ('AP'), ('AP'), ('AP'), ('AP'), ('AP'), ('AP'),
    ('P'), ('P'), ('P'), ('P'), ('P'), ('P'), ('P');

INSERT INTO Jogador (id_personagem, nome, velocidade, vida, qtded_recurso, qtded_captura, id_sala, id_inventario, nome_missao, titulo_objetivo, nome_gangue) VALUES
    (1, 'Mauricio', 9, 100, 5, 0, 1, 0, NULL, NULL, NULL);

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
    ('Libertar Lincoln', 'Objetivo principal de Michael Scofield: provar a inocência e libertar seu irmão Lincoln Burrows da prisão'),
    ('Sobreviver até a fuga', 'Manter-se vivo e fora do radar dos guardas até o momento da fuga planejada'),
    ('Proteger a família', 'Garantir a segurança da família enquanto o plano de fuga está em andamento'),
    ('Provar lealdade', 'Ganhar a confiança de membros-chave da gangue para obter ajuda na fuga'),
    ('Descobrir plano rival', 'Identificar e neutralizar planos de outras gangues que possam interferir na fuga'),
    ('Coletar recursos', 'Obter itens essenciais para a fuga, como ferramentas, uniformes e informações'),
    ('Distrair guardas', 'Criar distrações para permitir que partes críticas do plano sejam executadas'),
    ('Encontrar Sara', 'Localizar e resgatar a Dra. Sara Tancredi, aliada crucial para o plano de fuga');

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
