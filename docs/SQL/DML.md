# DML - Linguagem de Manipulação de Dados

## Introdução

A DML – Linguagem de Manipulação de Dados (Data Manipulation Language) é uma das principais categorias da linguagem SQL, sendo responsável pelas operações que envolvem a inserção, atualização, exclusão e consulta dos dados que estão armazenados nas tabelas do banco. Diferente da DDL, que se ocupa da definição da estrutura do banco (como a criação de tabelas e relações), a DML atua diretamente sobre os dados em si, permitindo que o sistema seja alimentado, mantido e consultado de forma dinâmica.

O uso correto da DML é fundamental para manter a integridade, consistência e atualidade dos dados, e seu domínio é indispensável para desenvolvedores, administradores de banco de dados e profissionais da área de tecnologia da informação. Entre os comandos mais utilizados da DML estão o INSERT que insere novos registros, o UPDATE que altera dados existentes, o DELETE que remove informações, e o SELECT que realiza consultas.

## Metodologia 

O banco de dados relacional utilizado foi o PostgreSQL. A manipulação dos dados foi realizada com base na estrutura definida anteriormente pelo modelo relacional e pelo diagrama Entidade-Relacionamento. Foram empregados comandos SQL pertencentes à Linguagem de Manipulação de Dados (DML), como INSERT para inserção de dados, UPDATE para alterações, DELETE para exclusões e SELECT para consultas. Todas as operações foram executadas diretamente no ambiente do PostgreSQL.

## DML das Tabelas

### Gangue
- Insert
``` sql
INSERT INTO gangue (nome_gangue, descricao, qtdd_membros, qtdd_recurso_gangue) VALUES
    ('Os Fox River Eight', 'Grupo formado pelos fugitivos de Fox River. Unidos pela fuga, cada membro tem uma habilidade estratégica.', 8, 60),
    ('Mafia Abruzzi', 'Facção italiana comandada por John Abruzzi, envolvida com crimes organizados e tráfico de influência dentro da prisão.', 10, 45),
    ('Irmandade Ariana', 'Grupo supremacista branco dentro da penitenciária, violento e radical. Liderado por T-Bag.', 12, 40),
    ('La Familia', 'Grupo latino composto por membros de origens mexicanas e porto-riquenhas. Atua com lealdade interna e controle de rotas internas.', 14, 37),
    ('Os Justiceiros', 'Prisioneiros que agem sob o pretexto de justiça interna, combatendo delatores e traidores. Inspirados em atitudes de C-Note.', 7, 28);
```

- Update
``` sql
-- Aumentar quantidade de membros da Gangue
UPDATE Gangue
SET qtdd_membros = qtdd_membros + 1
WHERE nome_gangue = 'Os Fox River Eight'

-- Aumentar quantidade de recursos da Gangue
UPDATE Gangue
SET qtdd_recurso_gangue = qtdd_recurso_gangue + 1
WHERE nome_gangue = 'Os Fox River Eight'
```

- Delete
``` sql
-- Deleta uma gangue (Não deve haver nenhum personagem associado a ela)
DELETE FROM Gangue
WHERE nome_gangue = 'Os Fox River Eight';
```

### Inventario
- Insert
``` sql
INSERT INTO inventario (id_inventario, qtd_itens, is_full) VALUES
    (100, 0, FALSE),		--Jogador
    (101, 0, FALSE),		--Cela do Jogador
    (102, 3, FALSE),		--Pátio Central
    (103, 0, FALSE);		--Enfermaria
```

- Update
``` sql
-- Aumentar capacidade do inventário de id = 101
UPDATE Inventario 
SET qtd_itens = 25, is_full = TRUE
WHERE id_inventario = 101;
```

- Delete
``` sql
-- Deleta o inventário de id = 102 (Ele não deve estar associado a nenhuma sala)
DELETE FROM Inventario
WHERE id_inventario = 102;
```

### Sala
- Insert
``` sql
INSERT INTO sala (id_sala, id_inventario, nome, descricao, nivel_perigo, bloqueado) VALUES
    (1, 101, 'Cela de Detenção', 'Pequena cela com uma cama e um lavatório.', 0, FALSE),
    (2, 102, 'Pátio Central', 'Área aberta para recreação, com segurança reforçada.', 5, FALSE),
    (3, 103, 'Enfermaria', 'Local onde os detentos recebem cuidados médicos. Acesso restrito.', 2, TRUE);
```

- Update
``` sql
-- Liberar o acesso à enfermaria
UPDATE Sala SET bloqueado = FALSE, WHERE id_sala = 3;
```

- Delete
``` sql
-- Remover sala de id = 1 (Detenção)
DELETE FROM Sala
WHERE id_sala = 1;
```

### Missao
- Insert
``` sql
INSERT INTO Missao (nome_missao, descricao, status) VALUES
    ('Missão de Confiança', 'Ganhar a confiança de um membro influente da máfia para obter recursos essenciais', false),
    ('Aliança Perigosa', 'Fazer uma aliança temporária com uma gangue rival para obter acesso a áreas restritas', false),
    ('Túnel da Liberdade', 'Construir um túnel secreto que leve para fora dos muros da prisão', false),
    ('Informante Infiltrado', 'Descobrir e neutralizar um informante que está vazando informações para os guardas', false),
    ('Distração Programada', 'Criar um incidente que distraia a atenção dos guardas no momento crítico da fuga', false),
    ('Fuga de Fox River', 'Planejar e executar a fuga da penitenciária Fox River, envolvendo múltiplos prisioneiros e etapas complexas', false),
    ('Rota Segura', 'Estabelecer um caminho seguro após a fuga, evitando captura pelos agentes penitenciários', false),
    ('Arquivos da Sona', 'Obter documentos secretos que provam a conspiração contra Lincoln Burrows', false);
```

- Update
``` sql
-- Atualiza o status de missões concluídas
UPDATE Missao
SET status = true
WHERE nome_missao IN ('Arquivos da Sona', 'Rota Segura');

-- Corrige a descrição de uma missão
UPDATE Missao
SET descricao = 'Construir um túnel secreto que leve para fora dos muros da prisão, usando ferramentas improvisadas'
WHERE noma_missao IN 'Túnel da Liberdade';
```

- Delete
``` sql
DELETE FROM Missao
WHERE noma_missao = 'Aliança Perigosa';
```

### Item
- Insert
``` sql
INSERT INTO Item (nome_item, descricao, durabilidade, pode_ser_vendido, nome_missao, utilidade, beneficio) VALUES
	('Chave Inglesa', 'Ferramenta para apertar parafusos', 100, TRUE, 'Missão de Confiança', 'Abrir portas', 'Facilita fuga'),
	('Lanterna', 'Ilumina ambientes escuros', 80, TRUE, 'Missão de Confiança', 'Iluminar', 'Ajuda em missões noturnas'),
	('Mapa', 'Mostra a planta da prisão', 50, TRUE, 'Missão de Confiança', 'Navegação', 'Evita se perder');
```

- Update
``` sql
-- Altera a durabilidade de um item
UPDATE Item 
SET durabilidade = 120 
WHERE nome_item = 'Chave Inglesa';
```

- Delete
``` sql
DELETE FROM Item 
WHERE nome_item = 'Chave Inglesa';
```

### Instancia Item
- Insert
``` sql
INSERT INTO Instancia_Item (id_instancia, nivel_de_gasto, id_inventario, nome_item) VALUES
	(1, 10, 102, 'Chave Inglesa'),
	(2, 5, 102, 'Lanterna'),
	(3, 2, 102, 'Mapa');
```

- Update
``` sql
-- Altera o nível de gasto de um item (Conserto ou uso do item)
UPDATE Instancia_Item S
SET nivel_de_gasto = 20 
WHERE id_instancia = 1;
```

- Delete
``` sql
DELETE FROM Instancia_Item 
WHERE id_instancia = 1;
```

### Item Loja
- Insert
``` sql
INSERT INTO Item_Loja (id_compra, nome_gangue, nome_item) VALUES
	(1, 'Mafia Abruzzi', 'Chave Inglesa'),
	(2, 'La Familia', 'Lanterna'),
	(3, 'Os Fox River Eight', 'Mapa');
```

- Update
``` sql
-- Altera a gangue que está vendendo o item
UPDATE Item_Loja 
SET nome_gangue = 'Os Renovados' 
WHERE id_compra = 1;
```

- Delete
``` sql
DELETE FROM Item_Loja 
WHERE id_compra = 1;
```

### Loja
- Insert
``` sql
INSERT INTO Loja (nome_gangue, preco, nome_item) VALUES
	('Mafia Abruzzi', 150.00, 'Chave Inglesa'),
	('La Familia', 75.50, 'Lanterna'),
	('Os Fox River Eight', 200.00, 'Mapa');
```

- Update
``` sql
-- Altera o preço de um item
UPDATE Loja 
SET preco = 180.00 
WHERE nome_gangue = 'Os Fugitivos' AND nome_item = 'Chave Inglesa';
```

- Delete
``` sql
DELETE FROM Loja 
WHERE nome_gangue = 'Os Fugitivos' AND nome_item = 'Chave Inglesa';
```

### Consulta Personagem
- Insert
``` sql
INSERT INTO Consulta_Personagem (
    tipo_personagem
) VALUES
    ('J'),
    ('AP'), ('AP'), ('AP'), ('AP'), ('AP'), ('AP'),
    ('P'), ('P'), ('P'), ('P'), ('P'), ('P'), ('P');
```

- Update: A tabela Consulta_Personagem não possui update pois não há regra de negócio para isso.

- Delete
``` sql
DELETE FROM consulta_personagem 
WHERE id_personagem = 6;
```

### Jogador
- Insert
``` sql
INSERT INTO Jogador (id_personagem, nome, velocidade, vida, qtded_recurso, qtded_captura, id_sala, id_inventario, nome_missao, titulo_objetivo, nome_gangue) VALUES
    (1, 'Mauricio', 9, 100, 5, 0, 1, 100, NULL, NULL, NULL);

-- Outros exemplos de inserção (Foi inserida somente uma tupla pois o jogo não é multiplayer)
--    (11, 'Gabriel Souza', 8, 95, 4, 1, 102, 2, 'Fuga de Fox River', 'Sobreviver até a fuga', 'Os Fox River Eight'),
--    (12, 'Rafael Costa', 7, 92, 3, 3, 103, 3, 'Rota Segura', 'Proteger a família', 'Os Justiceiros'),
--    (13, 'Matheus Oliveira', 8, 90, 2, 2, 104, 4, 'Missão de Confiança', 'Provar lealdade', 'Mafia Abruzzi'),
--    (14, 'João Almeida', 6, 85, 1, 1, 105, 5, 'Informante Infiltrado', 'Descobrir plano rival', 'La Familia');
```

- Update
``` sql
-- Aumentar a velocidade do personagem 
UPDATE Jogador
SET velocidade = 8,
WHERE id_personagem = 1;

-- Aumentar vida do personagem 
UPDATE Jogador
SET vida = Vida + 25
WHERE id_personagem = 1

-- Aumentar quantidade de recurso do personagem
UPDATE Jogador
SET qtded_recurso = qtded_recurso + 1
WHERE id_personagem = 1

-- Aumentar quantidade de capturas do persoangem
UPDATE Jogador
SET qtded_captura = qtded_captura + 1
WHERE id_personagem = 1

-- Alterar sala que o personagem esta
UPDATE Jogador
SET id_sala = 2
WHERE id_personagem = 1;

-- Alterar a escolha da gangue do personagem
UPDATE Jogador
SET nome_gangue = 'Os Fox River Eight'
WHERE id_personagem = 1;

-- Desvincular personagem da gangue
UPDATE Jogador
SET nome_gangue = NULL
WHERE nome_gangue = 'Os Fox River Eight';
```

- Delete
``` sql
DELETE FROM Jogador
WHERE id_personagem = 1;
```

### Agente Penitenciario
- Insert
``` sql
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
```

- Update
``` sql
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
```

- Delete
``` sql
DELETE FROM agente_penitenciario 
WHERE id_personagem = 6;
```

### Agente Penitenciario - Jogador
- Insert
``` sql
INSERT INTO Agente_Penitenciario_Jogador(
    id_personagem_jogador,		
    id_personagem_agente_penitenciario 
) VALUES
	(1, 2);
```

- Update: A tabela Agente_Penitenciario_Jogador não possui update pois não há regra de negócio para isso.

- Delete
``` sql
DELETE FROM agente_penitenciario_jogador 
WHERE id_personagem_agente_penitenciario = 6;
```

### Prisioneiro
- Insert
``` sql
INSERT INTO Prisioneiro (id_personagem, nome, velocidade, vida, crime, id_sala, nome_gangue) VALUES
    (8, 'Michael Scofield', 8, 100, 'Assalto a banco (planejado para entrar na prisão)', 2, 'Os Fox River Eight'),
    (9, 'John Abruzzi', 6, 90, 'Homicídio e chefia em organização criminosa', 1, 'Mafia Abruzzi'),
    (10, 'Theodore "T-Bag" Bagwell', 5, 80, 'Estupro, sequestro e assassinato', 1, 'Irmandade Ariana'),
    (11, 'Fernando Sucre', 7, 95, 'Roubo à mão armada', 2, 'Os Fox River Eight'),
    (12, 'Benjamin "C-Note" Franklin', 8, 93, 'Tráfico e deserção militar', 2, 'Os Justiceiros'),
    (13, 'David "Tweener" Apolskis', 7, 85, 'Roubo e desacato', 2, 'Os Fox River Eight'),
    (14, 'Carlos Ortega', 6, 88, 'Tráfico de drogas e agressão', 3, 'La Familia'); 
```

- Update
``` sql
-- Aumentar velocidade do prisioneiro
UPDATE Prisioneiro
SET velocidade = 10
WHERE id_personagem = 8;

-- Alterar sala do prisioneiro de forma aleatória
UPDATE Prisioneiro
SET id_sala = S.id_sala
FROM (
    SELECT id_sala FROM Sala ORDER BY RANDOM() LIMIT 1
) AS S
WHERE id_personagem = 8;

-- Desvincular prisioneiros da gangue 
UPDATE Prisioneiro
SET nome_gangue = NULL
WHERE nome_gangue = 'Os Fox River Eight';
```

- Delete
``` sql
DELETE FROM Prisioneiro
WHERE id_personagem = 8;
```

###  Dialogo
- Insert
``` sql
INSERT INTO Dialogo (id_dialogo, id_personagem, nome_missao, texto, ordem) VALUES
    (1, 8, 'Fuga de Fox River', 'Lincoln, eu vou te tirar daqui. Confie em mim.', 1),
    (2, 8, 'Fuga de Fox River', 'Precisamos do plano exato da penitenciária. Alguém tem acesso aos arquivos?', 2),
    (3, 11, 'Fuga de Fox River', 'Michael, você tá maluco? Eles vão nos pegar!', 3),
    (4, 8, 'Fuga de Fox River', 'Cada segundo conta. O túnel deve estar pronto em 72 horas.', 4),
    (5, 9, 'Fuga de Fox River', 'Você tem meu avião, Scofield? Sem avião, sem ajuda.', 5),
    (6, 9, 'Missão de Confiança', 'Na minha família, lealdade se prova com sangue.', 1),
    (7, 8, 'Missão de Confiança', 'O que devo fazer para ganhar sua confiança, Abruzzi?', 2),
    (8, 9, 'Missão de Confiança', 'Traga-me a cabeça do traidor da ala oeste. Literalmente.', 3);
```

- Update
``` sql
-- Mudança de dialogo
UPDATE Dialogo
SET texto = 'Lincoln eu te prometo que iremos sair daqu';
WHERE id_dialogo = 1;
```

- Delete
``` sql
DELETE FROM Dialogo
WHERE id_dialogo = 3;
```

### Objetivo Principal
- Insert
``` sql
INSERT INTO Objetivo_Principal (titulo_objetivo, descricao) VALUES
    ('Libertar Lincoln', 'Objetivo principal de Michael Scofield: provar a inocência e libertar seu irmão Lincoln Burrows da prisão'),
    ('Sobreviver até a fuga', 'Manter-se vivo e fora do radar dos guardas até o momento da fuga planejada'),
    ('Proteger a família', 'Garantir a segurança da família enquanto o plano de fuga está em andamento'),
    ('Provar lealdade', 'Ganhar a confiança de membros-chave da gangue para obter ajuda na fuga'),
    ('Descobrir plano rival', 'Identificar e neutralizar planos de outras gangues que possam interferir na fuga'),
    ('Coletar recursos', 'Obter itens essenciais para a fuga, como ferramentas, uniformes e informações'),
    ('Distrair guardas', 'Criar distrações para permitir que partes críticas do plano sejam executadas'),
    ('Encontrar Sara', 'Localizar e resgatar a Dra. Sara Tancredi, aliada crucial para o plano de fuga');
```

- Update
``` sql
-- Modifica a descrição de um objetivo
UPDATE Objetivo_Principal
SET descricao = 'Provar a inocência e libertar seu irmão Lincoln Burrows da prisão, evitando sua execução'
WHERE titulo_objetivo = 'Libertar Lincoln';
```

- Delete
``` sql
DELETE FROM Objetivo_Principal_Missao 
WHERE titulo_objetivo = 'Provar lealdade' AND nome_missao = 'Missão de Confiança';
```

### Objetivo Principal - Missao
- Insert
``` sql
INSERT INTO Objetivo_Principal_Missao (titulo_objetivo, nome_missao) VALUES
	('Provar lealdade', 'Missão de Confiança'),
    ('Coletar recursos', 'Aliança Perigosa'),
    ('Sobreviver até a fuga', 'Túnel da Liberdade'),
    ('Descobrir plano rival', 'Informante Infiltrado'),
    ('Distrair guardas', 'Distração Programada'),
    ('Encontrar Sara', 'Fuga de Fox River'),
    ('Proteger a família', 'Rota Segura'),
    ('Libertar Lincoln', 'Arquivos da Sona');
```

- Update: A tabela Objetivo_Principal_Missao não possui update pois não há regra de negócio para isso

- Delete
``` sql
DELETE FROM Objetivo_Principal_Missao 
WHERE titulo_objetivo = 'Provar lealdade' AND nome_missao = 'Missão de Confiança';
```

### Missao - Sala
- Insert
``` sql
INSERT INTO Missao_Sala (nome_missao, id_sala) VALUES
	('Rota Segura', 3);
```

- Update
``` sql
-- Altera missão que libera uma sala específica
UPDATE Missao_Sala
SET nome_missao = 'Fuga de Fox River'
WHERE id_sala = 1;
```

- Delete
``` sql
DELETE FROM Missao_Sala 
WHERE nome_missao = 'Rota Segura' AND id_sala = 3;
```

## 📑 Histórico de versão

| Versão| Data      | Descrição | Autor |
| :-:   | :-:       | :--       | --    |
| `1.0`   | 05/06/2025 |Criação da introdução e metodologia utilizada no DML | [Mayara A. Oliveira](https://github.com/Mayara-tech)  |
| `1.1`   | 07/06/2025 |adicionando dados a tabela jogador, prisioneiro e gangue | [Mayara A. Oliveira](https://github.com/Mayara-tech)  |
| `1.2`   | 09/06/2025 | Adiciona dados a tabela consulta_personagem, agente_penitenciario e agente_penitenciario_jogador | [Maria Alice](https://github.com/Maliz30)  |
| `1.3`   | 09/06/2025 | Adiciona tabelas missao, diálogo e objetivo principal | [Ana Carolina](https://github.com/anawcarol)  |
| `1.4`   | 12/06/2025 | Organiza tabelas e adiciona códigos pendentes que já estão no .sql | [Maria Alice](https://github.com/Maliz30)  |