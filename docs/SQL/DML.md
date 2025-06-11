# DML - Linguagem de Manipulação de Dados

## Introdução

A DML – Linguagem de Manipulação de Dados (Data Manipulation Language) é uma das principais categorias da linguagem SQL, sendo responsável pelas operações que envolvem a inserção, atualização, exclusão e consulta dos dados que estão armazenados nas tabelas do banco. Diferente da DDL, que se ocupa da definição da estrutura do banco (como a criação de tabelas e relações), a DML atua diretamente sobre os dados em si, permitindo que o sistema seja alimentado, mantido e consultado de forma dinâmica.

O uso correto da DML é fundamental para manter a integridade, consistência e atualidade dos dados, e seu domínio é indispensável para desenvolvedores, administradores de banco de dados e profissionais da área de tecnologia da informação. Entre os comandos mais utilizados da DML estão o INSERT que insere novos registros, o UPDATE que altera dados existentes, o DELETE que remove informações, e o SELECT que realiza consultas.

## Metodologia 

O banco de dados relacional utilizado foi o PostgreSQL. A manipulação dos dados foi realizada com base na estrutura definida anteriormente pelo modelo relacional e pelo diagrama Entidade-Relacionamento. Foram empregados comandos SQL pertencentes à Linguagem de Manipulação de Dados (DML), como INSERT para inserção de dados, UPDATE para alterações, DELETE para exclusões e SELECT para consultas. Todas as operações foram executadas diretamente no ambiente do PostgreSQL.

## Inserção de dados 

#### Jogador

``` sql
    INSERT INTO Jogador (id_personagem, nome, velocidade, vida, qtded_recurso, qtded_captura, id_sala, id_inventario, nome_missao, titulo_objetivo, nome_gangue) VALUES
    (10, 'Lucas Silva', 9, 100, 5, 2, 101, 1, 'Fuga de Fox River', 'Libertar Lincoln', 'Os Fox River Eight'),
    (11, 'Gabriel Souza', 8, 95, 4, 1, 102, 2, 'Fuga de Fox River', 'Sobreviver até a fuga', 'Os Fox River Eight'),
    (12, 'Rafael Costa', 7, 92, 3, 3, 103, 3, 'Rota Segura', 'Proteger a família', 'Os Justiceiros'),
    (13, 'Matheus Oliveira', 8, 90, 2, 2, 104, 4, 'Missão de Confiança', 'Provar lealdade', 'Mafia Abruzzi'),
    (14, 'João Almeida', 6, 85, 1, 1, 105, 5, 'Informante Infiltrado', 'Descobrir plano rival', 'La Familia');
```

#### Prisioneiro

``` sql
    INSERT INTO Prisioneiro (id_personagem, nome, velocidade, vida, crime, id_sala, nome_gangue) VALUES

    (1, 'Michael Scofield', 8, 100, 'Assalto a banco (planejado para entrar na prisão)', 101, 'Os Fox River Eight'),
    (2, 'John Abruzzi', 6, 90, 'Homicídio e chefia em organização criminosa', 102, 'Mafia Abruzzi'),
    (3, 'Theodore "T-Bag" Bagwell', 5, 80, 'Estupro, sequestro e assassinato', 103, 'Irmandade Ariana'),
    (4, 'Fernando Sucre', 7, 95, 'Roubo à mão armada', 101, 'Os Fox River Eight'),
    (5, 'Benjamin "C-Note" Franklin', 8, 93, 'Tráfico e deserção militar', 104, 'Os Justiceiros'),
    (6, 'David "Tweener" Apolskis', 7, 85, 'Roubo e desacato', 105, 'Os Fox River Eight'),
    (7, 'Carlos Ortega', 6, 88, 'Tráfico de drogas e agressão', 106, 'La Familia'); 
```

#### Gangue

``` sql
    INSERT INTO Gangue (nome_gangue, descricao, qtdd_membros, qtdd_recurso_gangue) VALUES

    ('Os Fox River Eight', 'Grupo formado pelos fugitivos de Fox River. Unidos pela fuga, cada membro tem uma habilidade estratégica.', 8, 60),
    ('Mafia Abruzzi', 'Facção italiana comandada por John Abruzzi, envolvida com crimes organizados e tráfico de influência dentro da prisão.', 10, 45),
    ('Irmandade Ariana', 'Grupo supremacista branco dentro da penitenciária, violento e radical. Liderado por T-Bag.', 12, 40),
    ('La Familia', 'Grupo latino composto por membros de origens mexicanas e porto-riquenhas. Atua com lealdade interna e controle de rotas internas.', 14, 37),
    ('Os Justiceiros', 'Prisioneiros que agem sob o pretexto de justiça interna, combatendo delatores e traidores. Inspirados em atitudes de C-Note.', 7, 28);
```


#### Consulta_Personagem

``` SQL 
INSERT INTO Consulta_Personagem (
        tipo_personagem
    ) VALUES
        -- ('J'), -- Descomentar depois de inserir a tabela de Jogador
        -- ('P'), -- Descomentar depois de inserir a tabela de Prisioneiros
        ('AP')
    REFERENCES id_personagem 
```

#### Agente_Penitenciario

``` SQL 
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
```

#### Agente_Penitenciario_Jogador

``` SQL 
-- Inserindo em Agente_Penitenciario_Jogador
INSERT INTO Agente_Penitenciario_Jogador(
    -- id_personagem_jogador,		--Descomentar depois de adicionar tabela de Jogador 
    id_personagem_agente_penitenciario 
) VALUES
	(1);
-- (1, 2);

-- UPDATE
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

-- DELETE
-- Apaga personagem
DELETE FROM agente_penitenciario_jogador 
WHERE id_personagem_agente_penitenciario = 6;

DELETE FROM agente_penitenciario 
WHERE id_personagem = 6;

DELETE FROM consulta_personagem 
WHERE id_personagem = 6;
```
#### Objetivo principal

``` SQL
    -- Inserção de dados na tabela Objetivo_Principal
INSERT INTO Objetivo_Principal (titulo_objetivo, descricao) VALUES
    ('Libertar Lincoln', 'Objetivo principal de Michael Scofield: provar a inocência e libertar seu irmão Lincoln Burrows da prisão'),
    ('Sobreviver até a fuga', 'Manter-se vivo e fora do radar dos guardas até o momento da fuga planejada'),
    ('Proteger a família', 'Garantir a segurança da família enquanto o plano de fuga está em andamento'),
    ('Provar lealdade', 'Ganhar a confiança de membros-chave da gangue para obter ajuda na fuga'),
    ('Descobrir plano rival', 'Identificar e neutralizar planos de outras gangues que possam interferir na fuga'),
    ('Coletar recursos', 'Obter itens essenciais para a fuga, como ferramentas, uniformes e informações'),
    ('Distrair guardas', 'Criar distrações para permitir que partes críticas do plano sejam executadas'),
    ('Encontrar Sara', 'Localizar e resgatar a Dra. Sara Tancredi, aliada crucial para o plano de fuga');

-- UPDATE (modificar descrição de um objetivo)
UPDATE Objetivo_Principal
SET descricao = 'Provar a inocência e libertar seu irmão Lincoln Burrows da prisão, evitando sua execução'
WHERE titulo_objetivo = 'Libertar Lincoln';

-- DELETE (remover objetivo menos relevante)
DELETE FROM Objetivo_Principal
WHERE titulo_objetivo = 'Distrair guardas';

```

#### Missao
``` SQL
-- Inserção de dados na tablea Missao
INSERT TO Missao (nome_missao, descricao, status) VALUES
    ('Fuga de Fox River', 'Planejar e executar a fuga da penitenciária Fox River, envolvendo múltiplos prisioneiros e etapas complexas', false),
    ('Rota Segura', 'Estabelecer um caminho seguro após a fuga, evitando captura pelos agentes penitenciários', false),
    ('Missão de Confiança', 'Ganhar a confiança de um membro influente da máfia para obter recursos essenciais', true),
    ('Informante Infiltrado', 'Descobrir e neutralizar um informante que está vazando informações para os guardas', false),
    ('Túnel da Liberdade', 'Construir um túnel secreto que leve para fora dos muros da prisão', false),
    ('Distração Programada', 'Criar um incidente que distraia a atenção dos guardas no momento crítico da fuga', false),
    ('Arquivos da Sona', 'Obter documentos secretos que provam a conspiração contra Lincoln Burrows', false),
    ('Aliança Perigosa', 'Fazer uma aliança temporária com uma gangue rival para obter acesso a áreas restritas', false);

-- Atualizar status de missões concluídas
UPDATE Missao
SET status = true
WHERE nome_missao IN ('Arquivos da Sona', 'Rota Segura');

-- Corrigir descrição de uma missão
UPDATE Missao
SET descricao = 'Construir um túnel secreto que leve para fora dos muros da prisão, usando ferramentas improvisadas'
WHERE noma_missao IN 'Túnel da Liberdade';

-- Remover missão menos relevante
DELETE FROM Missao
WHERE noma_missao = 'Aliança Perigosa';



```

#### Dialogo
``` SQL
-- Inserindo na tabela diálogo
INSERT TO Dialogo (
    id_dialogo,
    id_personagem,
    nome_missao,
    texto,
    ordem
) VALUES
-- Diálogos para a missão 'Fuga de Fox River'
INSERT INTO Dialogo (id_dialogo, id_personagem, nome_missao, texto, ordem) VALUES
    (1, 1, 'Fuga de Fox River', 'Lincoln, eu vou te tirar daqui. Confie em mim.', 1),
    (2, 1, 'Fuga de Fox River', 'Precisamos do plano exato da penitenciária. Alguém tem acesso aos arquivos?', 2),
    (3, 4, 'Fuga de Fox River', 'Michael, você tá maluco? Eles vão nos pegar!', 3),
    (4, 1, 'Fuga de Fox River', 'Cada segundo conta. O túnel deve estar pronto em 72 horas.', 4),
    (5, 2, 'Fuga de Fox River', 'Você tem meu avião, Scofield? Sem avião, sem ajuda.', 5);

-- Diálogos para a missão 'Missão de Confiança'
INSERT INTO Dialogo (id_dialogo, id_personagem, nome_missao, texto, ordem) VALUES
    (6, 2, 'Missão de Confiança', 'Na minha família, lealdade se prova com sangue.', 1),
    (7, 13, 'Missão de Confiança', 'O que devo fazer para ganhar sua confiança, Abruzzi?', 2),
    (8, 2, 'Missão de Confiança', 'Traga-me a cabeça do traidor da ala oeste. Literalmente.', 3);

-- Mudança de dialogo
UPDATE Dialogo
SET texto = 'Lincoln eu te prometo que iremos sair daqu';
WHERE id_dialogo = 1;

-- DELETE dialogo
DELETE FROM Dialogo
WHERE id_dialogo = 3;



```

## 📑 Histórico de versão

| Versão| Data      | Descrição | Autor |
| :-:   | :-:       | :--       | --    |
| `1.0`   | 05/06/2025 |Criação da introdução e metodologia utilizada no DML | [Mayara A. Oliveira](https://github.com/Mayara-tech)  |
| `1.1`   | 07/06/2025 |adicionando dados a tabela jogador, prisioneiro e gangue | [Mayara A. Oliveira](https://github.com/Mayara-tech)  |
| `1.2`   | 09/06/2025 | Adiciona dados a tabela consulta_personagem, agente_penitenciario e agente_penitenciario_jogador | [Maria Alice](https://github.com/Maliz30)  |
| `1.3`   | 09/06/2025 | Adiciona tabelas missao, diálogo e objetivo principal | [Ana Carolina](https://github.com/anawcarol)  |