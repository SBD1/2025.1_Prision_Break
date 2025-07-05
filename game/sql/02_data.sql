-- Inserts que inicializam o jogo

INSERT INTO gangue (nome_gangue, descricao, qtdd_membros, qtdd_recurso_gangue) VALUES
    ('Os Fox River Eight', 'Grupo formado pelos fugitivos de Fox River. Unidos pela fuga, cada membro tem uma habilidade estratégica.', 8, 60),
    ('Mafia Abruzzi', 'Facção italiana comandada por John Abruzzi, envolvida com crimes organizados e tráfico de influência dentro da prisão.', 10, 45),
    ('Irmandade Ariana', 'Grupo supremacista branco dentro da penitenciária, violento e radical. Liderado por T-Bag.', 12, 40),
    ('La Familia', 'Grupo latino composto por membros de origens mexicanas e porto-riquenhas. Atua com lealdade interna e controle de rotas internas.', 14, 37),
    ('Os Justiceiros', 'Prisioneiros que agem sob o pretexto de justiça interna, combatendo delatores e traidores. Inspirados em atitudes de C-Note.', 7, 28);

INSERT INTO inventario (id_inventario, qtd_itens, is_full) VALUES
	(1, 0, FALSE),		-- Cela do Jogador
	(2, 0, FALSE),		-- Cela do Irmão
	(3, 0, FALSE),		-- Bloco A
    (4, 0, FALSE),		-- Bloco B
    (5, 0, FALSE),		-- Bloco C
    (6, 0, FALSE),		-- Bloco D
    (7, 0, FALSE),		-- Bloco E
    (8, 0, FALSE),		-- Solitária
    (9, 0, FALSE),		-- Banheiro
    (10, 0, FALSE),		-- Biblioteca
    (11, 0, FALSE),		-- Patio Principal
    (12, 0, FALSE),		-- Cozinha
    (13, 0, FALSE),		-- Refeitório
    (14, 0, FALSE),		-- Enfermaria
    (15, 0, FALSE),		-- Telhado da Enfermaria
    (16, 0, FALSE),		-- Copa dos Policiais
    (17, 0, FALSE),		-- Recepção
    (18, 0, FALSE),		-- Diretoria
    (19, 0, FALSE),		-- Sala de Câmeras
    (20, 0, FALSE),		-- Entrada
    (21, 0, FALSE),		-- Área externa leste
    (22, 0, FALSE),		-- Área externa sul
    (23, 0, FALSE),		-- Oficina
    (24, 0, FALSE),		-- Corredor da Cela do Irmão
    (25, 0, FALSE),		-- Corredor do Bloco A
    (26, 0, FALSE),		-- Corredor da Bloco B
    (27, 0, FALSE),		-- Corredor do Ala Norte
    (28, 0, FALSE),		-- Corredor do Bloco D
    (29, 0, FALSE),		-- Corredor do Bloco E
    (30, 0, FALSE),		-- Corredor longo
    (31, 0, FALSE),		-- Corredor da Solitária
    (32, 0, FALSE),		-- Corredor da Ala Oeste
    (33, 0, FALSE),		-- Corredor da Ala Leste
    (34, 0, FALSE),		-- Corredor da Ala Sul
    (35, 0, FALSE);		-- Corredor dos guardas

INSERT INTO sala (id_sala, id_inventario, nome, descricao, nivel_perigo, bloqueado) VALUES
    (1, 1, 'Cela do Jogador', 'Um espaço apertado com uma cama, uma pia e as quatro paredes que te separam do mundo. É o único lugar para pensar sem olhares curiosos.', 0, FALSE),
    (2, 2, 'Cela do Irmão', 'Idêntica à sua, mas carrega o peso da urgência. É o motivo pelo qual os planos são traçados e os riscos são tomados.', 1, FALSE),
    (3, 3, 'Bloco A', 'Fileiras de celas que abrigam centenas de detentos. Território da gangue Mafia Abruzzi.', 5, FALSE),
    (4, 4, 'Bloco B', 'Fileiras de celas que abrigam centenas de detentos. Território da gangue La Familia.', 5, FALSE),
    (5, 5, 'Bloco C', 'Fileiras de celas que abrigam centenas de detentos. Território da gangue Irmandade Ariana.', 6, FALSE),
    (6, 6, 'Bloco D', 'Fileiras de celas que abrigam centenas de detentos. Território de La Familia, onde o líder se encontra.', 6, FALSE),
    (7, 7, 'Bloco E', 'Fileiras de celas que abrigam centenas de detentos. Território da gangue Os Justiceiros.', 5, FALSE),
    (8, 8, 'Solitária', 'Um cômodo escuro e vazio para onde os guardas enviam os problemáticos para quebrar seu espírito.', 8, TRUE),
    (9, 9, 'Banheiro', 'Úmido, sujo e com pouca privacidade. É um ponto de encontro para negócios escusos, trocas de informações e confrontos.', 3, FALSE),
    (10, 10, 'Biblioteca', 'Um refúgio de silêncio em meio ao caos. As estantes empoeiradas guardam conhecimento, códigos e segredos.', 2, FALSE),
    (11, 11, 'Patio Principal', 'Vasta área a céu aberto, cercada por muros altos. É onde os detentos se exercitam, socializam e conspiram.', 7, FALSE),
    (12, 12, 'Cozinha', 'O coração quente e barulhento da prisão. Fonte de ferramentas improvisadas e conflitos.', 4, FALSE),
    (13, 13, 'Refeitório', 'Um grande salão onde toda a população carcerária se reúne. Palco principal para demonstrações de poder.', 6, FALSE),
    (14, 14, 'Enfermaria', 'Um oásis de limpeza. O cheiro de antisséptico domina o ar. Local para tratar ferimentos e obter medicamentos.', 4, FALSE),
    (15, 15, 'Telhado da Enfermaria', 'Uma rota de fuga perigosa e exposta. Oferece uma visão panorâmica, mas também te transforma em um alvo fácil.', 9, TRUE),
    (16, 16, 'Copa dos Policiais', 'A área de descanso dos guardas. Um lugar para café, conversas e negócios corruptos.', 8, TRUE),
    (17, 17, 'Recepção', 'A primeira barreira entre a prisão e o mundo exterior. Área de alta segurança, com detectores de metal.', 8, FALSE),
    (18, 18, 'Diretoria', 'O escritório do Diretor. Símbolo máximo de autoridade. É aqui que os segredos da administração estão trancados.', 10, TRUE),
    (19, 19, 'Sala de Câmeras', 'O centro nervoso da segurança. Monitores exibem cada corredor e cada cela.', 9, TRUE),
    (20, 20, 'Entrada', 'O portão principal. A última barreira de aço e concreto entre você e a liberdade. Fortemente guardado.', 9, TRUE),
    (21, 21, 'Área externa leste', 'Ao emergir no telhado, você é recebido pelo abraço do céu aberto. O som distante dos grilos substitui o zumbido das luzes.', 0, TRUE),
    (22, 22, 'Área externa sul', 'Ao passar pelo último portão de aço, o ar da noite muda completamente. O cheiro de terra molhada e grama fresca domina.', 0, TRUE),
    (23, 23, 'Oficina', 'O som de metal contra metal preenche o ar. Fonte inestimável de materiais brutos, ferramentas e potenciais armas.', 5, FALSE),
    (24, 24, 'Corredor da Cela do Irmão', 'Um corredor estreito e mais silencioso, terminando na cela que guarda o motivo de sua luta.', 2, FALSE),
    (25, 25, 'Corredor do Bloco A', 'O som das grades e das conversas é constante. Este corredor serve como fronteira do território da Mafia Abruzzi.', 4, FALSE),
    (26, 26, 'Corredor do Bloco B', 'O som das grades e das conversas é constante. Este corredor serve como fronteira do território de La Familia.', 4, FALSE),
    (27, 27, 'Corredor da Ala Norte', 'O principal eixo da área residencial da prisão, conectando os diversos blocos de celas.', 3, FALSE),
    (28, 28, 'Corredor do Bloco D', 'O som das grades e das conversas é constante. Este corredor serve como fronteira do território de La Familia.', 4, FALSE),
    (29, 29, 'Corredor do Bloco E', 'O som das grades e das conversas é constante. Este corredor serve como fronteira do território dos Justiceiros.', 4, FALSE),
    (30, 30, 'Corredor longo', 'Um trecho monótono e retilíneo de concreto, vigiado por câmeras em ambas as extremidades.', 5, FALSE),
    (31, 31, 'Corredor da Solitária', 'O caminho para o inferno. Um corredor frio e mal iluminado que leva à sala mais temida da prisão.', 7, FALSE),
    (32, 32, 'Corredor da Ala Oeste', 'A artéria que leva ao barulho da oficina e do refeitório. Frequentemente patrulhado.', 4, FALSE),
    (33, 33, 'Corredor da Ala Leste', 'Conduz ao silêncio da biblioteca e ao cheiro de antisséptico da enfermaria. É uma rota mais calma, mas não menos vigiada.', 3, FALSE),
    (34, 34, 'Corredor da Ala Sul', 'O limiar do poder. Este corredor dá acesso à recepção e à entrada principal. A presença de guardas aqui é muito mais intensa.', 7, TRUE),
    (35, 35, 'Corredor dos guardas', 'Território proibido. Limpo, bem iluminado e silencioso, conecta áreas vitais de segurança.', 8, TRUE);


INSERT INTO Missao (nome_missao, descricao, status) VALUES
    -- Missões do Objetivo: Virar líder de uma gangue
        ('Fazendo um Nome', 'Chame a atenção da Máfia Abruzzi ao resolver um problema para eles.', false),
        ('Protegendo a Família', 'Demonstre lealdade ao proteger os interesses financeiros da gangue.', false),
        ('O Fantasma do Passado', 'Conquiste a confiança de Abruzzi resolvendo um problema pessoal para ele.', false),
        ('O Lance de Mestre', 'Execute uma operação tão lucrativa que seu prestígio supere o do líder.', false),
        ('O Trono e a Coroa', 'Desafie e deponha o antigo chefe para se tornar o novo líder da gangue.', false),
    -- Missões do Objetivo: Resgatar o irmão
        ('Ecos da Cela 17', 'Investigue rumores de que seu irmão está vivo e preso na mesma unidade.', false),
        ('Olhos nas Sombras', 'Acesse a sala de câmeras para descobrir a localização exata do seu irmão.', false),
        ('Silêncio no Bloco B', 'Negocie com um detento do Bloco B que possui informações cruciais.', false),
        ('A Palavra do Diretor', 'Encontre documentos na diretoria que confirmem a transferência do seu irmão.', false),
        ('Entre Refeições e Informantes', 'Use o refeitório para fazer alianças e conseguir informações.', false),
        ('Mapa Manchado de Sangue', 'Obtenha um mapa com rotas secretas que está em posse de uma gangue rival.', false),
        ('A Voz da Solitária', 'Contate um ex-colega de cela do seu irmão que está isolado na solitária.', false),
        ('Códigos e Corrupção', 'Encontre e negocie com um guarda corrupto para obter códigos de acesso.', false),
        ('Sinais da Cela Esquecida', 'Investigue a antiga cela do seu irmão em busca de pistas sobre seu paradeiro.', false),
        ('Laços de Sangue', 'Encontre seu irmão e execute o plano de fuga final para tirá-lo da prisão.', false),
    -- Missões do Objetivo: Fugir com a própria gangue
        ('Prova de Fogo', 'Ganhe o respeito da gangue La Familia para ser aceito como um membro.', false),
        ('O Doutor Está Ocupado', 'Roube suprimentos médicos da enfermaria para fortalecer os recursos da gangue.', false),
        ('Olhos e Ouvidos', 'Consiga as plantas da prisão e os horários de troca de guarda na diretoria.', false),
        ('A Chave Dourada', 'Obtenha uma chave mestra que abre os portões para o exterior.', false),
        ('O Grande Dia', 'Execute a fuga em massa com a sua gangue durante uma distração.', false),
    -- Missões do Objetivo: Identificar policiais corruptos
        ('O Preço do Silêncio', 'Descubra a primeira evidência tangível de corrupção de um guarda.', false),
        ('Decifrando a Conspiração', 'Decodifique um bilhete cifrado para identificar o próximo alvo na rede de corrupção.', false),
        ('O Rastro dos Medicamentos', 'Investigue o envolvimento de um oficial no desvio de medicamentos da enfermaria.', false),
        ('A Escuta', 'Grave uma conversa incriminadora para obter uma prova irrefutável da culpa dos alvos.', false),
        ('O Dia do Julgamento', 'Entregue todas as provas para uma autoridade incorruptível e derrube a rede.', false),
    -- Missões do Objetivo: Fugir da prisão sem ser pego
    ('O Sussurro nas Paredes', 'Descubra a rota de fuga pelos dutos de ventilação e obtenha a primeira ferramenta.', false),
    ('Escalada Silenciosa', 'Acesse e navegue pela rede de ventilação até um ponto estratégico.', false),
    ('Ponto Cego', 'Desative temporariamente a vigilância para passar por uma área de alta segurança.', false),
    ('Passeio ao Luar', 'Atravesse o telhado da prisão e encontre uma rota segura para o chão.', false),
    ('O Último Corte', 'Rompa a cerca final da prisão e escape para a liberdade.', false);

INSERT INTO Item (nome_item, descricao, durabilidade, pode_ser_vendido, nome_missao, utilidade, beneficio) VALUES
    -- Ferramentas
        ('Faca improvisada', 'Uma arma rudimentar, mas eficaz para intimidação.', 5, true, NULL, 'Intimidar alvos', 'Facilita a obtenção de informações ou itens de outros detentos.'),
        ('Pé de Cabra', 'Uma pequena barra de ferro, útil para abrir portas e armários.', 3, true, NULL, 'Arrombar trancas', 'Concede acesso a áreas ou contêineres trancados.'),
        ('Chave de Fenda', 'Uma ferramenta básica para parafusos e painéis elétricos.', 10, true, NULL, 'Manipular parafusos', 'Permite abrir grades de ventilação e painéis de acesso.'),
        ('Alicate Corta-Fio', 'Essencial para cortar cercas de arame e fios.', 1, true, NULL, 'Cortar cercas', 'Necessário para a rota de fuga final em alguns objetivos.'),
        ('Luvas de Borracha', 'Um par de luvas grossas de borracha da enfermaria.', 1, true, NULL, 'Isolamento elétrico', 'Protege contra choques ao mexer em painéis de energia.'),
        ('Isqueiro', 'Um isqueiro de metal, contrabandeado e recarregado várias vezes.', 15, true, NULL, 'Criar pequenas chamas para distrações ou como fonte de luz.', NULL),
        ('Molde de Gesso', 'Um kit improvisado com gesso roubado da enfermaria.', 2, true, NULL, 'Copiar o formato de chaves para fabricar duplicatas.', NULL),
        ('Espelho de Bolso', 'Um pequeno fragmento de espelho polido, fácil de esconder.', 20, true, NULL, 'Olhar ao redor de cantos sem se expor à vigilância.', NULL),
        ('Fio de Cobre', 'Um pedaço de fio de cobre retirado de um aparelho elétrico.', 1, true, NULL, 'Criar curtos-circuitos em painéis eletrônicos simples.', NULL),
    -- Itens de Missão (Obtidos como recompensa/descoberta)
        ('Planta dos Dutos de Ventilação', 'Um projeto antigo da rede de ventilação da prisão.', 1, false, 'O Sussurro nas Paredes', 'Revelar rotas secretas', 'Permite a navegação pelos dutos de ar para uma fuga furtiva.'),
        ('Bilhete Cifrado', 'Um pequeno pedaço de papel com um código misterioso.', 1, false, 'O Preço do Silêncio', 'Pista de investigação', 'Inicia a missão de decifrar a conspiração dos guardas.'),
        ('Agenda de Entregas', 'Uma agenda preta detalhando transações ilegais de medicamentos.', 1, false, 'O Rastro dos Medicamentos', 'Prova de corrupção', 'Incrimina um dos oficiais corruptos.'),
        ('Gravação Incriminadora', 'Uma fita de áudio com a prova definitiva da corrupção.', 1, false, 'A Escuta', 'Prova irrefutável', 'Usada para expor a rede de corrupção ao diretor.'),
        ('Chave Mestra', 'Uma chave eletrônica capaz de abrir portões de alta segurança.', 1, false, 'A Chave Dourada', 'Acesso principal', 'Abre o portão final na fuga com a gangue.'),
        ('Mapa Manchado de Sangue', 'Um mapa antigo com rotas internas secretas da prisão.', 1, false, 'Mapa Manchado de Sangue', 'Navegação avançada', 'Revela passagens secretas essenciais para resgatar o irmão.'),
        ('Arquivo de Fibonacci', 'Uma pasta confidencial com a localização de uma testemunha.', 1, false, 'O Fantasma do Passado', 'Moeda de troca', 'Usado para ganhar a total confiança de John Abruzzi.'),
        ('Macacão de Manutenção', 'Um macacão azul, sujo de graxa, usado pela equipe de manutenção.', 5, false, NULL, NULL, 'Permite acesso a áreas de serviço e oficinas sem levantar suspeitas.'),
        ('Crachá de Guarda', 'Um crachá de identificação de um guarda, "perdido" perto da copa.', 1, false, NULL, NULL, 'Completa um disfarce ou concede acesso a portas de baixo nível.'),
    -- Disfarces (Obtidos em missões específicas)
    ('Uniforme de Guarda', 'Um uniforme de guarda completo, mas sem identificação.', 3, false, 'Olhos e Ouvidos', 'Acesso a áreas restritas', 'Permite que o jogador ande por áreas administrativas sem levantar suspeitas.'),
    ('Livro de Apostas', 'Um caderno com nomes e valores de um esquema de apostas ilegal.', 1, false, NULL, 'Chantagem ou criação de conflitos.', 'Pode forçar a cooperação de um guarda ou iniciar uma guerra entre gangues.'),
    ('Relógio de Bolso Quebrado', 'Um relógio de prata, parado em 3:17, com uma inscrição no verso.', 1, false, NULL, 'Pista para quebra-cabeça.', 'Pode conter a senha de um computador ou uma mensagem secreta.'),
    ('Dossiê Médico Falso', 'Uma pasta com exames e diagnósticos falsificados.', 1, false, NULL, 'Manipulação de acesso.', 'Permite mover um personagem para a enfermaria de forma controlada.');

INSERT INTO Instancia_Item (id_instancia, nivel_de_gasto, id_inventario, nome_item) VALUES
    -- Ferramentas básicas 
        (1, 0, 12, 'Chave de Fenda'),         -- No inventário da Cozinha.
        (2, 0, 23, 'Fio de Cobre'),           -- No inventário da Oficina.
        (3, 0, 9, 'Espelho de Bolso'),       -- No inventário do Banheiro.
        (4, 0, 4, 'Isqueiro'),               -- No inventário do Bloco B.
    -- Itens de Missão em inventários de salas, para iniciar as investigações
        (5, 0, 11, 'Bilhete Cifrado'),        -- No inventário do Pátio Principal.
        (6, 0, 10, 'Relógio de Bolso Quebrado'); -- No inventário da Biblioteca.

INSERT INTO Loja (nome_gangue, preco, nome_item) VALUES
    ('Mafia Abruzzi', 15, 'Pé de Cabra'),
    ('Mafia Abruzzi', 25, 'Molde de Gesso'),
    ('La Familia', 5, 'Faca improvisada'),
    ('La Familia', 10, 'Isqueiro'),
    ('Os Fox River Eight', 50, 'Alicate Corta-Fio'),
    ('Os Fox River Eight', 30, 'Espelho de Bolso'),
    ('Os Justiceiros', 40, 'Livro de Apostas');

INSERT INTO Consulta_Personagem (
    tipo_personagem
) VALUES
    ('J'),
    ('AP'), ('AP'), ('AP'), ('AP'), ('AP'), ('AP'), ('AP'), ('AP'), ('AP'), ('AP'), ('AP'), ('AP'), ('AP'), ('AP'), ('AP'), ('AP'), ('AP'), ('AP'),
    ('P'), ('P'), ('P'), ('P'), ('P'), ('P'), ('P'), ('P'), ('P'), ('P'), ('P'), ('P'), ('P'), ('P');

INSERT INTO Jogador (id_personagem, nome, velocidade, vida, qtded_recurso, qtded_captura, id_sala, id_inventario, nome_missao, titulo_objetivo, nome_gangue) VALUES
    (1, 'Mauricio', 6, 100, 10, 0, 1, 1, NULL, NULL, NULL);
	
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
    (3, 19, 'Alex Mahone', DEFAULT, 8, DEFAULT, DEFAULT, DEFAULT, 'Policial Chefe'),
    (4, 1, 'Paul Kellerman', DEFAULT, 6, DEFAULT, true, 20, DEFAULT),
    (5, 3, 'Donald Self', DEFAULT, 3, DEFAULT, true, 10, DEFAULT),
    (6, 18, 'Warden Pope', DEFAULT, 10, DEFAULT, DEFAULT, DEFAULT, 'Diretor'),
    (7, 14, 'Sara Tancredi', DEFAULT, 0, DEFAULT, DEFAULT, DEFAULT, 'Médica'),
    --Guardas genéricos
    (8, 25, 'Guarda Miller', 5, 5, 5, false, NULL, 'Carcereiro'),
    (9, 28, 'Guarda Evans', 5, 6, 5, false, NULL, 'Carcereiro'),
    (10, 12, 'Guarda Wright', 6, 7, 6, false, NULL, 'Supervisor do Refeitório'),
    (11, 19, 'Guarda Davis', 5, 6, 6, false, NULL, 'Supervisor da Oficina'),
    (12, 16, 'Guarda Peterson', 5, 5, 7, false, NULL, 'Recepcionista'),
    (13, 35, 'Guarda Roy', 7, 8, 8, false, NULL, 'Patrulha Administrativa'),
    (14, 32, 'Guarda Baker', 6, 6, 6, true, 15, 'Carcereiro'),
    (15, 31, 'Guarda Stokes', 7, 9, 9, false, NULL, 'Guarda da Solitária'),
    (16, 11, 'Guarda Hayes', 5, 5, 6, false, NULL, 'Patrulha da Cozinha'),
    (17, 33, 'Guarda Wallace', 6, 6, 5, false, NULL, 'Patrulha da Ala Leste'),
    (18, 13, 'Guarda Fisher', 5, 7, 7, false, NULL, 'Vigilância do Pátio'),
    (19, 34, 'Guarda O''Malley', 6, 7, 7, false, NULL, 'Patrulha da Ala Sul');

INSERT INTO Prisioneiro (id_personagem, nome, velocidade, vida, crime, id_sala, nome_gangue) VALUES
    (20, 'Michael Scofield', 8, 100, 'Assalto a banco (planejado para entrar na prisão)', 2, 'Os Fox River Eight'),
    (21, 'John Abruzzi', 6, 90, 'Homicídio e chefia em organização criminosa', 1, 'Mafia Abruzzi'),
    (22, 'Theodore "T-Bag" Bagwell', 5, 80, 'Estupro, sequestro e assassinato', 1, 'Irmandade Ariana'),
    (23, 'Fernando Sucre', 7, 95, 'Roubo à mão armada', 2, 'Os Fox River Eight'),
    (24, 'Benjamin "C-Note" Franklin', 8, 93, 'Tráfico e deserção militar', 2, 'Os Justiceiros'),
    (25, 'David "Tweener" Apolskis', 7, 85, 'Roubo e desacato', 2, 'Os Fox River Eight'),
    (26, 'Carlos Ortega', 6, 88, 'Tráfico de drogas e agressão', 3, 'La Familia'),
    (27, 'Lincoln Burrows (O Irmão)', 6, 100, 'Acusado de assassinato', 2, 'Os Fox River Eight'),
    (28, 'Hector', 6, 90, 'Tráfico e extorsão', 13, 'La Familia'),
    (29, 'Eduardo (Líder)', 5, 100, 'Liderança de gangue', 6, 'La Familia'),
    (30, 'Samuel, o Velho', 3, 80, 'Contrabando (múltiplas sentenças)', 10, 'Mafia Abruzzi'),
    (31, 'Javier, o Informante', 5, 85, 'Roubo e falsificação', 4, 'La Familia'),
    (32, 'Silas, o Isolado', 7, 100, 'Agressão grave a um guarda', 8, 'Irmandade Ariana'),
    (33, 'Charles, o Intelectual', 4, 80, 'Fraude e lavagem de dinheiro', 10, 'Os Fox River Eight');

INSERT INTO Dialogo (id_dialogo, id_personagem, nome_missao, texto, ordem) VALUES
    -- ########## OBJETIVO: RESGATAR O IRMÃO ##########
        -- Missão: Ecos da Cela 17
            (1, 1, 'Ecos da Cela 17', 'Ouvi dizer que meu irmão, Lincoln, está aqui. Você sabe de alguma coisa?', 1),
            (2, 30, 'Ecos da Cela 17', 'Rumores correm como ratos neste lugar, garoto. Se quer a verdade, terá que sujar as mãos. Comece observando os registros, mas cuidado com os olhos dos guardas.', 2),
        -- Missão: Olhos nas Sombras
            (3, 1, 'Olhos nas Sombras', 'Preciso de um jeito de entrar na sala de câmeras para confirmar se é ele. Uma distração seria ideal.', 1),
            (4, 23, 'Olhos nas Sombras', 'Papi, você pode causar uma confusão no refeitório. Enquanto os guardas estiverem ocupados, você corre para a sala de câmeras. Mas seja rápido!', 2),
        -- Missão: Silêncio no Bloco B
            (5, 1, 'Silêncio no Bloco B', 'Javier. Me disseram que você viu para onde levaram meu irmão. Eu preciso saber.', 1),
            (6, 31, 'Silêncio no Bloco B', 'Informação custa caro aqui dentro, amigo. Ninguém fala de graça. Consiga um maço de cigarros raros para mim, e talvez minha memória melhore.', 2),
        -- Missão: A Palavra do Diretor
            (7, 1, 'A Palavra do Diretor', 'Preciso dos registros de transferência. Eles devem estar na sala do Diretor Pope. A segurança lá é máxima.', 1),
            (8, 4, 'A Palavra do Diretor', 'Acesso à sala do Diretor? Você é ambicioso. Consiga algo que eu queira, um item de valor da Máfia, e eu te dou uma janela de 5 minutos lá dentro. Sem perguntas.', 2),
        -- Missão: Mapa Manchado de Sangue
            (9, 1, 'Mapa Manchado de Sangue', 'Ouvi dizer que T-Bag tem um mapa antigo da prisão, com rotas que ninguém conhece. Preciso dele.', 1),
            (10, 22, 'Mapa Manchado de Sangue', 'Ora, ora, carne fresca querendo meus tesouros? Este mapa custou sangue. Se você o quer, terá que fazer um pequeno favor... Despache um rival meu no Bloco C. Sem testemunhas.', 2),
        -- Missão: A Voz da Solitária
            (11, 1, 'A Voz da Solitária', 'Silas, o antigo colega de cela do meu irmão, está na solitária. O mapa mostra uma rota pelos dutos, mas preciso de silêncio absoluto.', 1),
            (12, 15, 'A Voz da Solitária', 'O guarda Stokes é quem vigia a solitária. Ele é um sádico. A única forma de passar por ele é criando uma emergência na enfermaria. Ele não resiste a uma boa confusão.', 2),
        -- Missão: Códigos e Corrupção
            (13, 1, 'Códigos e Corrupção', 'Kellerman. Preciso de acesso a áreas restritas. Ouvi dizer que você pode ajudar... pelo preço certo.', 1),
            (14, 4, 'Códigos e Corrupção', 'Sempre direto ao ponto. Gosto disso. Acesso tem um preço, e o meu é 20. Pague, e eu te darei um código que abrirá algumas portas importantes. Mas se você for pego, nunca nos conhecemos.', 2),
        -- Missão: Laços de Sangue
            (15, 1, 'Laços de Sangue', 'Lincoln, eu estou aqui. Encontrei uma rota de fuga. Precisamos ir para a diretoria, usar o código de liberação e sair pelo portão sul. Prepare-se.', 1),
            (16, 27, 'Laços de Sangue', 'Michael? Eu sabia que você viria. Estou pronto. Vamos sair deste inferno.', 2),
    -- ########## OBJETIVO: VIRAR LÍDER DE UMA GANGUE ##########
        -- Missão: Fazendo um Nome
            (17, 1, 'Fazendo um Nome', 'Abruzzi. Ouvi dizer que você é o homem que comanda as coisas por aqui. Eu quero uma oportunidade.', 1),
            (18, 21, 'Fazendo um Nome', 'Oportunidade? (risos) Aqui dentro, oportunidade tem cheiro de sangue e traição. Prove seu valor. A La Familia está se metendo nos meus negócios na cozinha. Resolva isso, e talvez a gente converse.', 2),
        -- Missão: Protegendo a Família
            (19, 21, 'Protegendo a Família', 'Você tem coragem. Agora, mostre lealdade. A Irmandade no Bloco B se recusa a pagar pela proteção. Vá até lá e lembre a eles por que devem nos respeitar. Traga meu dinheiro.', 1),
            (20, 1, 'Protegendo a Família', 'Considere feito. Eles vão pagar, de um jeito ou de outro.', 2),
        -- Missão: O Fantasma do Passado
            (21, 21, 'O Fantasma do Passado', 'Você é útil. Agora, uma tarefa pessoal. O nome Fibonacci te diz algo? Ele me colocou aqui. Kellerman sabe onde ele está. Traga-me essa informação, e você será meu braço direito.', 1),
            (22, 1, 'O Fantasma do Passado', 'Kellerman é um agente federal. Isso é arriscado, mas por você, chefe, eu farei.', 2),
        -- Missão: O Lance de Mestre
            (23, 1, 'O Lance de Mestre', 'John, seu foco em Fibonacci está nos cegando. A verdadeira oportunidade é tomar o controle total da loja. Podemos dominar o comércio da prisão.', 1),
            (24, 21, 'O Lance de Mestre', 'Insolente! Acha que sabe mais do que eu? Uma guerra com todas as gangues? É suicídio! A conversa acabou.', 2),
        -- Missão: O Trono e a Coroa
            (25, 1, 'O Trono e a Coroa', 'Abruzzi! Seu tempo acabou. Você ficou velho e cego pela vingança. Eu trouxe poder e riqueza para a família. Agora, eu quero a liderança. Lute ou se ajoelhe.', 1),
            (26, 21, 'O Trono e a Coroa', 'Você... seu verme traidor! Você não vai tomar o que é meu! Vou te ensinar o que é respeito!', 2),
    -- ########## OBJETIVO: FUGIR COM A PRÓPRIA GANGUE ##########  
        -- Missão: Prova de Fogo
            (27, 1, 'Prova de Fogo', 'Hector. Me disseram que você é o contato de La Familia. Estou procurando trabalho.', 1),
            (28, 28, 'Prova de Fogo', 'Trabalho, é? Um verme da Irmandade roubou um mapa nosso. Ele está no Bloco B. Quer provar que é leal? Traga o mapa de volta. E deixe uma mensagem para que ele não se esqueça de nós.', 2),
        -- Missão: O Doutor Está Ocupado
            (29, 29, 'O Doutor Está Ocupado', 'Você provou seu valor. Agora, uma missão de verdade. Um dos nossos foi ferido. Precisamos de antibióticos da enfermaria. A Dra. Tancredi não vai nos dar, então você terá que roubar. Crie uma distração.', 1),
            (30, 1, 'O Doutor Está Ocupado', 'Uma distração... Bellick é ganancioso. Talvez ele possa ajudar, pelo preço certo.', 2),
    -- ########## OBJETIVO: IDENTIFICAR POLICIAIS CORRUPTOS #########
        -- Missão: O Preço do Silêncio
            (31, 1, 'O Preço do Silêncio', 'C-Note, preciso saber. A corrupção dos guardas... é real ou só história pra assustar novato?', 1),
            (32, 24, 'O Preço do Silêncio', 'Real? É o que mantém este lugar funcionando. Se quer um nome, comece com Bellick. Ele extorque a Máfia no Bloco A toda noite. Veja com seus próprios olhos. Mas não espere que eu te ajude se ele te pegar.', 2),
        -- Missão: Decifrando a Conspiração
            (33, 1, 'Decifrando a Conspiração', 'Charles, encontrei este bilhete. Parece um código. Você consegue ler?', 1),
            (34, 33, 'Decifrando a Conspiração', 'Interessante... É uma cifra antiga. Para decifrá-la, preciso do meu velho livro de códigos. Os guardas o confiscaram quando me trouxeram. Ele está na sala de evidências, perto da solitária. Traga-o para mim.', 2),
    -- ########## OBJETIVO: FUGIR DA PRISÃO SEM SER PEGO ##########
        -- Missão: O Sussurro nas Paredes
            (35, 1, 'O Sussurro nas Paredes', 'Ei, velho. O que tanto você murmura sobre "caminhos ocos"?', 1),
            (36, 30, 'O Sussurro nas Paredes', 'As paredes falam para quem sabe ouvir... Elas escondem os caminhos antigos, os dutos de ar. As plantas originais mostrariam a rota. Dizem que estão trancadas na sala de manutenção. Mas é só loucura de um velho, não é?', 2),
        -- Missão: Escalada Silenciosa
            (37, 1, 'Escalada Silenciosa', 'A chave de fenda não basta para a grade da minha cela. Preciso de algo mais forte, um pé de cabra. A Máfia deve ter um à venda.', 1),
            (38, 21, 'Escalada Silenciosa', 'Um pé de cabra? Para um projeto de carpintaria, suponho? (risos) Custa 15. Use-o bem.', 2);

INSERT INTO Objetivo_Principal (titulo_objetivo, descricao) VALUES(
        'Virar líder de uma gangue',
        'O poder é a única lei aqui dentro. Escolha uma facção, suba na hierarquia através de força e astúcia, e tome o controle para se tornar o verdadeiro chefe da prisão.'
    ),(
        'Resgatar o irmão',
        'Você não está aqui por acaso. Seu irmão foi injustamente condenado e te espera na Cela ao lado. Use todos os seus recursos para tirá-lo daqui antes que seja tarde demais.'
    ),(
        'Fugir com a própria gangue',
        'A união faz a força. Forme ou junte-se a uma gangue leal, planeje uma fuga em massa e liderem uns aos outros em direção à liberdade.'
    ),(
        'Identificar policiais corruptos',
        'As paredes desta prisão escondem mais do que apenas criminosos. Há um sistema podre por dentro, guardas que se vendem por alguns trocados e outros que orquestram grandes esquemas. Sua missão é mergulhar nessa escuridão, juntar as peças do quebra-cabeça e expor os oficiais que traíram seu juramento, sem que eles percebam que você está em seu encalço.'
    ),(
        'Fugir da prisão sem ser pego',
        'Confiar em alguém é um erro. Planeje uma fuga solo, movendo-se pelas sombras como um fantasma. Sua liberdade depende apenas da sua inteligência e furtividade.'
    );

INSERT INTO Objetivo_Principal_Missao (titulo_objetivo, nome_missao) VALUES
    -- Resgatar o irmão
        ('Resgatar o irmão', 'Ecos da Cela 17'),
        ('Resgatar o irmão', 'Olhos nas Sombras'),
        ('Resgatar o irmão', 'Silêncio no Bloco B'),
        ('Resgatar o irmão', 'A Palavra do Diretor'),
        ('Resgatar o irmão', 'Entre Refeições e Informantes'),
        ('Resgatar o irmão', 'Mapa Manchado de Sangue'),
        ('Resgatar o irmão', 'A Voz da Solitária'),
        ('Resgatar o irmão', 'Códigos e Corrupção'),
        ('Resgatar o irmão', 'Sinais da Cela Esquecida'),
        ('Resgatar o irmão', 'Laços de Sangue'),
    -- Virar líder de uma gangue
        ('Virar líder de uma gangue', 'Fazendo um Nome'),
        ('Virar líder de uma gangue', 'Protegendo a Família'),
        ('Virar líder de uma gangue', 'O Fantasma do Passado'),
        ('Virar líder de uma gangue', 'O Lance de Mestre'),
        ('Virar líder de uma gangue', 'O Trono e a Coroa'),
    -- Fugir com a própria gangue
        ('Fugir com a própria gangue', 'Prova de Fogo'),
        ('Fugir com a própria gangue', 'O Doutor Está Ocupado'),
        ('Fugir com a própria gangue', 'Olhos e Ouvidos'),
        ('Fugir com a própria gangue', 'A Chave Dourada'),
        ('Fugir com a própria gangue', 'O Grande Dia'),
    -- Identificar policiais corruptos
        ('Identificar policiais corruptos', 'O Preço do Silêncio'),
        ('Identificar policiais corruptos', 'Decifrando a Conspiração'),
        ('Identificar policiais corruptos', 'O Rastro dos Medicamentos'),
        ('Identificar policiais corruptos', 'A Escuta'),
        ('Identificar policiais corruptos', 'O Dia do Julgamento'),
    -- Fugir da prisão sem ser pego
    ('Fugir da prisão sem ser pego', 'O Sussurro nas Paredes'),
    ('Fugir da prisão sem ser pego', 'Escalada Silenciosa'),
    ('Fugir da prisão sem ser pego', 'Ponto Cego'),
    ('Fugir da prisão sem ser pego', 'Passeio ao Luar'),
    ('Fugir da prisão sem ser pego', 'O Último Corte');

INSERT INTO Missao_Sala (nome_missao, id_sala) VALUES
    -- Liberam a Diretoria
        ('Silêncio no Bloco B', 18),
        ('O Doutor Está Ocupado', 18),
        ('O Fantasma do Passado', 18),
        ('Sinais da Cela Esquecida', 18),
    -- Liberam a Solitaria
        ('Mapa Manchado de Sangue', 8),
        ('O Preço do Silêncio', 8),
        ('Protegendo a Família', 8),
    -- Liberam a Sala de Câmeras
        ('Ecos da Cela 17', 19), 
        ('Escalada Silenciosa', 19),
    -- Liberam as Áreas Externas
	    ('A Chave Dourada', 22),
	    ('Passeio ao Luar', 21),
	    ('Laços de Sangue', 22);
