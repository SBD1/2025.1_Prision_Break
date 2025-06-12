# DQL - Linguagem de Consulta de Dados 

## Introdução

O DQL - Linguagem de Consulta de Dados (Data Query Language), é um dos subconjuntos da linguagem SQL e tem como principal objetivo consultar dados armazenados em um banco relacional. Através da DQL, é possível recuperar informações específicas das tabelas de forma eficiente, utilizando filtros, ordenações e junções entre dados relacionados.

O principal e único comando da DQL é o SELECT, que permite extrair dados de uma ou mais tabelas com base em critérios definidos.A DQL é, portanto, a interface entre o usuário e os dados já armazenados, permitindo a leitura, análise e visualização das informações.Por meio de consultas SQL bem definidas, é possível compreender o funcionamento interno do jogo, acompanhar o progresso dos jogadores, analisar estatísticas como recursos acumulados, capturas realizadas e status das missões.

## Metodologia 

Para a realização das consultas, foi utilizado o sistema gerenciador de banco de dados PostgreSQL, com base na estrutura previamente construída por meio dos modelos Entidade-Relacionamento e Relacional. As instruções da Linguagem de Consulta de Dados (DQL) foram aplicadas utilizando o comando SELECT, com variações de filtragem, agrupamento e ordenação.

As consultas foram realizadas diretamente no ambiente SQL do PostgreSQL, com o objetivo de extrair informações relevantes das tabelas criadas, como dados de jogadores, prisioneiros e suas respectivas gangues, missões e salas.

## Consultas realizadas

### Retorna todas as informações do inventário
```
SELECT
    id_inventario,
    qtd_itens,
    is_full
FROM
    Inventario;
```

### Retorna inventários de uma Sala Específica
```
SELECT
    I.id_inventario,
    I.qtd_itens,
    I.is_full
FROM
    Inventario AS I
JOIN
    Sala AS S ON I.id_inventario = S.id_inventario
WHERE
    S.id_sala = 1; -- Substitua pelo ID da sala desejada
```

### Retorna apenas os Inventários Cheios
```
SELECT
    id_inventario,
    qtd_itens,
    is_full
FROM
    Inventario
WHERE
    is_full = TRUE;
```

### Retorna apenas os Inventários que Não Estão Cheios
```
SELECT
    id_inventario,
    qtd_itens,
    is_full
FROM
    Inventario
WHERE
    is_full = FALSE;
```

### Retorna todos os personagens cadastrados
```
SELECT 
    * 
FROM 
    consulta_personagem;
```

### Retorna o tipo de um personagem específico
```
SELECT 
    tipo_personagem
FROM 
    consulta_personagem
WHERE 
    id_personagem = 5 -- Substitua pelo ID do personagem
```

### Retorna todas as informações das salas
```
SELECT
    id_sala,
    id_inventario,
    nome,
    descricao,
    nivel_perigo,
    bloqueado
FROM
    Sala;
```

### Retorna apenas as Salas que Não Estão Bloqueadas
```
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
```

### Retorna apenas a Sala que um personagem Está Presente (Sala por ID do personagem)
```
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
    J.id_personagem = 1; -- Substitua pelo ID desejado
```

-- 

## 📑 Histórico de versão

| Versão| Data      | Descrição | Autor |
| :-:   | :-:       | :--       | --    |
| `1.0`   | 05/06/2025 |Criação da introdução e metodologia utilizada no DQL | [Mayara A. Oliveira](https://github.com/Mayara-tech)  || `1.1`   | 12/06/2025 |Adicionar consultas referente às tabelas; Inventario,  | [Mayara A. Oliveira](https://github.com/Mayara-tech)  |