# DQL - Linguagem de Consulta de Dados 

## Introdução

O DQL - Linguagem de Consulta de Dados (Data Query Language), é um dos subconjuntos da linguagem SQL e tem como principal objetivo consultar dados armazenados em um banco relacional. Através da DQL, é possível recuperar informações específicas das tabelas de forma eficiente, utilizando filtros, ordenações e junções entre dados relacionados.

O principal e único comando da DQL é o SELECT, que permite extrair dados de uma ou mais tabelas com base em critérios definidos.A DQL é, portanto, a interface entre o usuário e os dados já armazenados, permitindo a leitura, análise e visualização das informações.Por meio de consultas SQL bem definidas, é possível compreender o funcionamento interno do jogo, acompanhar o progresso dos jogadores, analisar estatísticas como recursos acumulados, capturas realizadas e status das missões.

## Metodologia 

Para a realização das consultas, foi utilizado o sistema gerenciador de banco de dados PostgreSQL, com base na estrutura previamente construída por meio dos modelos Entidade-Relacionamento e Relacional. As instruções da Linguagem de Consulta de Dados (DQL) foram aplicadas utilizando o comando SELECT, com variações de filtragem, agrupamento e ordenação.

As consultas foram realizadas diretamente no ambiente SQL do PostgreSQL, com o objetivo de extrair informações relevantes das tabelas criadas, como dados de jogadores, prisioneiros e suas respectivas gangues, missões e salas.

## DQL das Tabelas

### Gangue
```sql
-- Consultar informação de todas as gangues ordenados por quantidade de membros
SELECT *
FROM gangue
ORDER BY qtdd_membros DESC;

-- Consultar gangues ordenadas pelo mais fortes (maiores recursos)
SELECT *
FROM gangue
ORDER BY qtdd_recurso_gangue DESC;

-- Consultar todas as informações de uma gangue em especifico
SELECT *
FROM gangue
Where nome_gangue = 'Os Fox River Eight' ;
```

### Inventario
```sql
-- Retorna todas as informações do inventário
SELECT
    id_inventario,
    qtd_itens,
    is_full
FROM
    Inventario;

-- Inventários de uma Sala Específica
SELECT
    I.id_inventario,
    I.qtd_itens,
    I.is_full
FROM
    Inventario AS I
JOIN
    Sala AS S ON I.id_inventario = S.id_inventario
WHERE
    S.id_sala = 1; -- Substitua '1' pelo ID da sala desejada

-- Apenas os Inventários Cheios
SELECT
    id_inventario,
    qtd_itens,
    is_full
FROM
    Inventario
WHERE
    is_full = TRUE;

-- Apenas os Inventários que Não Estão Cheios
SELECT
    id_inventario,
    qtd_itens,
    is_full
FROM
    Inventario
WHERE
    is_full = FALSE;

```

### Objetivo Principal
```sql
-- Consultar todos os objetivos 
SELECT * FROM Objetivo_Principal;

-- Consultar algum objetivo em especifico com sua descrição
SELECT titulo_objetivo, descricao
FROM Objetivo_Principal
WHERE titulo_objetivo = 'Libertar o prisioneiro';

-- Consultar apenas os títulos dos objetivos
SELECT titulo_objetivo FROM Objetivo_Principal;

-- Consultar quantos objetivos existem
SELECT COUNT(*) FROM Objetivo_Principal;

-- Consultar objetivos que possuem a palavra 'família' na descrição
SELECT *
FROM Objetivo_Principal
WHERE descricao LIKE '%família%';

-- Consultar objetivos em ordem alfabética
SELECT *
FROM Objetivo_Principal
ORDER BY titulo_objetivo ASC;

-- Consultar quantas vezes cada objetivo aparece
SELECT titulo_objetivo, COUNT(*) AS quantidade
FROM Objetivo_Principal
GROUP BY titulo_objetivo

-- Consultar se há objetivos duplicados
SELECT titulo_objetivo, COUNT(*)
FROM Objetivo_Principal
GROUP BY titulo_objetivo
HAVING COUNT(*) > 1;
```

### Missao
```sql
-- Consultar todas as missoes
SELECT * FROM missao;

-- Consultar missoes ativas
SELECT * 
FROM missao
WHERE status = true;

-- Consultar missoes inativas
SELECT * 
FROM missao
WHERE status = false;

-- Consultar quantas missoes estao ativas e inativas
SELECT status, COUNT(*) AS total
FROM missao
GROUP BY status;

-- Consultar missoes com seus respectivos objetivos
SELECT 
    m.nome_missao,
    m.descricao AS descricao_missao,
    o.titulo_objetivo,
    op.descricao AS descricao_objetivo
FROM 
    missao m
JOIN 
    objetivo_principal_missao o ON m.nome_missao = o.nome_missao
JOIN 
    objetivo_principal op ON o.titulo_objetivo = op.titulo_objetivo;

-- Consultar as salas asscociadas a cada missao
SELECT 
    m.nome_missao,
    s.nome AS nome_sala,
    s.nivel_perigo
FROM 
    missao m
JOIN 
    missao_sala ms ON m.nome_missao = ms.nome_missao
JOIN 
    sala s ON ms.id_sala = s.id_sala;

-- Consultar missoes e seus itens associados
SELECT 
    m.nome_missao,
    m.descricao AS descricao_missao,
    i.nome_item,
    ii.id_instancia,
    ii.nivel_de_gasto
FROM 
    missao m
JOIN 
    item i ON m.nome_missao = i.nome_missao
JOIN 
    instancia_item ii ON i.nome_item = ii.nome_item;
```

### Sala
```sql
-- Retorna todas as informações das salas
SELECT
    id_sala,
    id_inventario,
    nome,
    descricao,
    nivel_perigo,
    bloqueado
FROM
    Sala;

-- Apenas as Salas que Não Estão Bloqueadas
SELECT
    id_sala,
    id_inventario,
    nome,
    descricao,
    nivel_perigo,
    bloqueado
FROM
    Sala
WHERE
    bloqueado = FALSE;

-- Apenas a Sala que um personagem Está Presente (Sala por ID do personagem)
SELECT
    S.id_sala,
    S.nome AS nome_sala,
    S.descricao AS descricao_sala,
    S.nivel_perigo,
    S.bloqueado,
    J.nome AS nome_jogador
FROM
    Sala AS S
JOIN
    Jogador AS J ON S.id_sala = J.id_sala
WHERE
    J.id_personagem = 1; -- Substitua '1' pelo ID desejado
```

### Item
```sql
-- Consulta as gangues que vendem determinado item
SELECT DISTINCT
    I.nome_item,
    IL.nome_gangue,
FROM Item I
INNER JOIN Item_Loja IL ON I.nome_item = IL.nome_item
INNER JOIN Loja L ON IL.nome_gangue = L.nome_gangue 
WHERE I.nome_item = 'Chave Inglesa'  -- Substitua pelo nome do item desejado
GROUP BY I.nome_item, IL.nome_gangue
ORDER BY IL.nome_gangue;

-- Consulta todos os inventários que possuem um item específico
SELECT DISTINCT
    I.nome_item,
    INV.id_inventario
FROM Item I
INNER JOIN Instancia_Item II ON I.nome_item = II.nome_item
INNER JOIN Inventario INV ON II.id_inventario = INV.id_inventario
WHERE I.nome_item = 'Chave Inglesa'  -- Substitua pelo nome do item desejado
GROUP BY INV.id_inventario, I.nome_item
ORDER BY I.nome_item;
```

### Consulta Personagem
```sql
-- Lista todos os personagens cadastrados
SELECT * FROM consulta_personagem

-- Exibe o tipo de um personagem específico
SELECT tipo_personagem
FROM consulta_personagem
WHERE id_personagem = 5
```

### Prisioneiro
```sql
-- Consultar informação de todos os prisioneiros em ordem alfabetica
SELECT *
FROM Prisioneiro
ORDER BY nome DESC;

-- Consultar todas as informações de um prisioneiro em especifico
SELECT *
FROM Prisioneiro
Where nome= 'Michael Scofield' ;

-- Consultar todos os dados dos prisioneiros que estão na sala
SELECT *
FROM prisioneiro
WHERE id_sala = '1';

-- Consultar apenas nome e gangue dos prisioneiros que estão na sala
SELECT nome, nome_gangue
FROM prisioneiro
WHERE id_sala = '1';

-- Consultar todas as gangues que estão na sala 
SELECT nome_gangue
FROM prisioneiro
WHERE id_sala = '1';

-- Consultar onde esta o prisioneiro 
SELECT prisioneiro.nome, sala.nome
FROM prisioneiro 
JOIN sala  ON prisioneiro.id_sala = sala.id_sala
WHERE prisioneiro.nome = 'Michael Scofield';

-- Consultar localização de todos os prisioneiros em ordem alfabetica
SELECT prisioneiro.nome, sala.nome
FROM prisioneiro 
JOIN sala  ON prisioneiro.id_sala = sala.id_sala
ORDER BY prisioneiro.nome ASC;
```

### Agente Penitenciario
```sql
-- Consulta todas as informações de um agente penitenciário
SELECT * 
FROM agente_penitenciario
WHERE id_personagem = 2

-- Verifica se um policial específico é corrupto e qual o seu preço
SELECT corrupto, preco
FROM agente_penitenciario
WHERE id_personagem = 2

-- Exibe os agentes penitenciários que estão na sala, ordenados pelo seu nível de perigo
SELECT id_personagem, id_sala, nome, velocidade, nivel_de_perigo, nivel_de_alerta, cargo
FROM agente_penitenciario
WHERE id_sala = 2
ORDER BY nivel_de_perigo DESC

-- Exibe a quantidade de agentes na sala
SELECT id_sala, COUNT(*) AS agentes_na_sala
FROM agente_penitenciario
WHERE id_sala = 2
GROUP BY id_sala 

-- Exibe os agentes penitenciarios e as informações referentes as salas em que eles estão
SELECT AP.id_personagem, AP.nome AS nome_agente, S.id_sala, S.nome AS nome_sala, S.nivel_perigo AS nivel_perigo_sala 
FROM agente_penitenciario AP
JOIN sala S ON AP.id_sala = S.id_sala
ORDER BY S.id_sala ASC
```

### Jogador
```sql
-- Consultar todas as informações de um prisioneiro em especifico
SELECT *
FROM Jogador
Where nome= 'Mauricio' ;

-- Consultar dados importantes para o jogador
SELECT nome, velocidade, vida, qtded_recurso, qtded_captura, nome_item, id_sala
FROM Jogador
Where nome= 'Mauricio' ;

-- Consultar informações dos itens do inventario 
SELECT 
    item.nome_item,
    item.descricao,
    item.durabilidade,
    item.pode_ser_vendido,
    item.utilidade,
    item.beneficio,
    instancia_item.nivel_de_gasto
FROM jogador 
JOIN instancia_item  ON jogador.id_inventario = instancia_item.id_inventario
JOIN item ON instancia_item.nome_item = item.nome_item
WHERE jogador.nome = 'Mauricio';

-- Consultar itens que estão no inventario
SELECT 
    item.nome_item
FROM jogador 
JOIN instancia_item  ON jogador.id_inventario = instancia_item.id_inventario
JOIN item ON instancia_item.nome_item = item.nome_item
WHERE jogador.nome = 'Mauricio';

-- Consultar informações de um item especifico que esta no inventario
SELECT 
    item.nome_item,
    item.descricao,
    item.durabilidade,
    item.pode_ser_vendido,
    item.utilidade,
    item.beneficio,
    instancia_item.nivel_de_gasto
FROM jogador 
JOIN instancia_item  ON jogador.id_inventario = instancia_item.id_inventario
JOIN item ON instancia_item.nome_item = item.nome_item
WHERE jogador.nome = 'Mauricio'
	 AND item.nome_item = 'Chave inglesa';

-- Consultar missão do jogador
SELECT 
    jogador.nome_missao,
    missao.descricao,
    missao.status
FROM jogador 
JOIN missao ON jogador.nome_missao = missao.nome_missao
WHERE jogador.nome = 'Mauricio';

-- Consultar objetivo principal do jogador
SELECT 
    jogador.titulo_objetivo,
    objetivo_principal.descricao
FROM jogador
JOIN objetivo_principal ON jogador.titulo_objetivo = objetivo_principal.titulo_objetivo
WHERE jogador.nome = 'Mauricio';

-- Consultar objetivo da missão
SELECT 
    jogador.nome_missao,
    opm.titulo_objetivo,
    o.descricao
FROM jogador 
JOIN objetivo_principal_missao opm ON jogador.nome_missao = opm.nome_missao
JOIN objetivo_principal o ON opm.titulo_objetivo = o.titulo_objetivo
WHERE jogador.nome = 'Mauricio';
```

### Agente Penitenciario - Jogador
```sql
-- Exibe todos os agentes penitenciários que capturaram um jogador específico
SELECT APJ.id_personagem_jogador, AP.id_personagem, AP.nome, AP.nivel_de_perigo
FROM agente_penitenciario_jogador APJ
JOIN agente_penitenciario AP ON APJ.id_personagem_agente_penitenciario = AP.id_personagem 
WHERE APJ.id_personagem_jogador = 1
ORDER BY AP.nivel_de_perigo DESC

-- Exibe quantas vezes um jogador foi capturado
SELECT id_personagem_jogador, COUNT(*) AS qtdd_capturas
FROM agente_penitenciario_jogador
WHERE id_personagem_jogador = 1
GROUP BY id_personagem_jogador

-- Exibe quantas vezes um jogador foi capturado por um agente específico
SELECT id_personagem_jogador, id_personagem_agente_penitenciario, COUNT(*) AS qtdd_capturas
FROM agente_penitenciario_jogador
WHERE id_personagem_jogador = 1 AND id_personagem_agente_penitenciario = 2
GROUP BY id_personagem_jogador, id_personagem_agente_penitenciario
```

### Loja
```sql
-- Busca todos os itens de uma gangue especifica na loja, incluindo detalhes do item
-- e o preço de cada item na loja
SELECT 
    L.nome_gangue,
    L.nome_item,
    I.descricao,
    L.preco,
    I.durabilidade,
    I.utilidade,
    I.beneficio
FROM Loja L
INNER JOIN Item_Loja IL ON L.nome_gangue = IL.nome_gangue
INNER JOIN Item I ON IL.nome_item = I.nome_item
WHERE L.nome_gangue = 'Nome da Gangue';

-- Conta itens de uma loja de uma gangue
SELECT 
    L.nome_gangue,
    COUNT(L.nome_item) as total_itens,
    SUM(L.preco) as valor_total
FROM Loja L
INNER JOIN Item_Loja IL ON L.nome_gangue = IL.nome_gangue
WHERE L.nome_gangue = 'Nome da Gangue'
GROUP BY L.nome_gangue;

-- Conta quantidade de cada item de uma loja especifica de uma gangue
SELECT 
    L.nome_item,
    COUNT(L.nome_item) as quantidade_item,
    L.preco as preco_unidade,
    SUM(L.preco) as valor_total_item
FROM Loja L
INNER JOIN Item_Loja IL ON L.nome_gangue = IL.nome_gangue
    AND L.nome_item = IL.nome_item
WHERE L.nome_gangue = 'Nome da Gangue'
GROUP BY L.nome_item, L.preco
ORDER BY L.nome_item;
```

### Item - Loja
```sql

```

### Missao - Sala
```sql
-- Exibe todas as salas que uma missão desbloqueia
SELECT *
FROM missao_sala
WHERE nome_missao = 'Rota Segura'

-- Exibe as missões necessárias para desbloquear uma sala
SELECT nome_missao
FROM missao_sala
WHERE id_sala = 3
```

### Instancia Item
```sql
-- Consulta todo os itens de um inventário específico
SELECT 
    INV.id_inventario,
    INV.qtd_itens,
    II.id_instancia,
    I.nome_item,
    I.descricao,
    I.durabilidade,
    II.nivel_de_gasto,
    I.utilidade,
    I.beneficio
FROM Inventario INV
INNER JOIN Instancia_Item II ON INV.id_inventario = II.id_inventario
INNER JOIN Item I ON II.nome_item = I.nome_item
WHERE INV.id_inventario = 1  -- Substitua pelo ID do inventário
ORDER BY I.nome_item;

-- Consulta quantidade de todos os itens em um inventário
SELECT 
    I.nome_item,
    COUNT(II.nome_item) as quantidade_total,
    I.descricao,
    I.durabilidade
FROM Item I
RIGHT JOIN Instancia_Item II ON I.nome_item = II.nome_item
WHERE II.id_inventario = 1  -- Substitua pelo ID do inventário, se necessário
GROUP BY I.nome_item, I.descricao, I.durabilidade
ORDER BY quantidade_total DESC;

-- Consulta o total de itens em um inventário específico
SELECT 
    INV.id_inventario,
    COUNT(II.id_instancia) as total_itens,
    COUNT(DISTINCT II.nome_item) as tipos_diferentes_itens
FROM Inventario INV
INNER JOIN Instancia_Item II ON INV.id_inventario = II.id_inventario
WHERE INV.id_inventario = 1  -- Substitua pelo ID do inventário
GROUP BY INV.id_inventario;
```

### Dialogo
```sql
-- Contulstar todos os diálogos
SELECT * FROM Dialogo;

-- Consultar todos os diálogos com nome da missão e ordem 
SELECT nome_missao, ordem, texto
FROM Dialogo
ORDER BY nome_missao, ordem;

-- Consultar diálogos de uma missao específica
SELECT *
FROM Dialogo 
WHERE nome_missao = 'Fuga de Fox River'
ORDER BY ordem;

-- Conultar diálogos de um personagem específico
SELECT *
FROM  Dialogo 
WHERE id_personagem = '9'
ORDER BY ordem;

-- Consultar quantos dialogos cada personagem tem
SELECT id_personagem, COUNT(*) AS qtd_dialogos
FROM Dialogo
GROUP BY id_personagem;

-- Consultar quantos dialogo existem por missao
SELECT id_personagem, COUNT(*) AS qtd_dialogos
FROM Dialogo
GROUP BY nome_missao;

-- Consultar missoes com mais de tres dialogos
SELECT nome_missao, COUNT(*) AS qtd_dialogos
FROM Dialogo
GROUP BY nome_missao
HAVING COUNT (*) > 3;

-- Consultar se há dialogos repetidos
SELECT texto, COUNT(*) 
FROM Dialogo
GROUP BY texto
HAVING COUNT(*) > 1;

-- Consultar o texto dos dialogos com o nome e descricao da missao
SELECT 
    D.id_dialogo,
    D.texto,
    D.ordem,
    D.nome_missao,
    M.descricao AS descricao_missao
FROM 
    Dialogo D
JOIN 
    Missao M ON D.nome_missao = M.nome_missao
ORDER BY 
    D.ordem;

-- Consultar dialogos e tipo do personagem
SELECT 
    D.texto,
    CP.tipo_personagem
FROM 
    Dialogo D
JOIN 
    Consulta_Personagem CP ON D.id_personagem = CP.id_personagem;

-- Consultar missoes pela quantidade de dialogos
SELECT 
    d.nome_missao,
    m.descricao,
    COUNT(*) AS total_dialogos
FROM 
    dialogo d
JOIN 
    missao m ON d.nome_missao = m.nome_missao
GROUP BY 
    d.nome_missao, m.descricao
ORDER BY 
    total_dialogos DESC;
```

### Objetivo principal - Missao
```sql
-- Consulta para listar todos objetivos e suas missoes relacionadas
SELECT 
    opm.titulo_objetivo,
    op.descricao AS descricao_objetivo,
    m.nome_missao,
    m.descricao AS descricao_missao
FROM 
    objetivo_principal_missao opm
JOIN 
    objetivo_principal op ON opm.titulo_objetivo = op.titulo_objetivo
JOIN 
    missao m ON opm.nome_missao = m.nome_missao;

-- Consulta para contar quantas missoes estao associados a um objetivo especiridco
SELECT 
    m.nome_missao,
    COUNT(*) AS total_objetivos
FROM 
    objetivo_principal_missao opm
JOIN 
    missao m ON opm.nome_missao = m.nome_missao
GROUP BY 
    m.nome_missao
ORDER BY 
    total_objetivos DESC;

-- Consultar todas as missoes com seus objetivos
SELECT 
    opm.nome_missao,
    opm.titulo_objetivo,
    op.descricao AS descricao_objetivo
FROM 
    objetivo_principal_missao opm
JOIN 
    objetivo_principal op ON opm.titulo_objetivo = op.titulo_objetivo
ORDER BY 
    opm.nome_missao;

-- consultar objetivos que possuem pelo menos uma missao ativa
SELECT DISTINCT
    op.titulo_objetivo,
    op.descricao
FROM
    objetivo_principal op
JOIN
    objetivo_principal_missao opm ON op.titulo_objetivo = opm.titulo_objetivo
JOIN
    missao m ON opm.nome_missao = m.nome_missao
WHERE
    m.status = TRUE;  -- Missões ativas
```

## 📑 Histórico de versão

| Versão |    Data    | Descrição                                            | Autor                                                |
| :----: | :--------: | :--------------------------------------------------- | ---------------------------------------------------- |
| `1.0`  | 05/06/2025 | Criação da introdução e metodologia utilizada no DQL | [Mayara A. Oliveira](https://github.com/Mayara-tech) |
| `1.1`  | 13/06/2025 | Adiciona códigos pendentes que já estavam no .sql    | [Maria Alice](https://github.com/Maliz30)            |
