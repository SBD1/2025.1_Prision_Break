# DDL - Linguagem de Definição de Dados 

## Introdução 
O DDL - Linguagem de Definição de Dados, é um dos principais componentes da linguagem SQL e tem como objetivo definir e organizar a estrutura de um banco de dados. Por meio de comandos específicos, como CREATE, ALTER e DROP, é possível criar tabelas, modificar colunas, excluir objetos e estabelecer a base estrutural sobre a qual os dados serão armazenados e manipulados.

Esses comandos são fundamentais para o desenvolvimento e manutenção de bancos de dados relacionais, garantindo que os dados sejam organizados de forma lógica e eficiente. Diferente de outras linguagens SQL que lidam com o conteúdo (como a DML), a DDL atua diretamente sobre a arquitetura do banco, moldando seu funcionamento.

## Metodologia 

O banco de dados relacional utilizado para o desenvolvimento do jogo foi o PostgreSQL. A criação da estrutura seguiu o modelo desenvolvido no diagrama Entidade-Relacionamento e representado no modelo relacional. Foram utilizados comandos da linguagem SQL, especificamente da Linguagem de Definição de Dados (DDL), como CREATE, ALTER, e DROP, para a definição e organização das tabelas e de suas restrições.

## Criação das Tabelas

#### Jogador

    CREATE TABLE Jogador (

    id_personagem     INT           NOT NULL,
    nome              VARCHAR(50)   NOT NULL,
    velocidade        INT           DEFAULT 0,
    vida              INT           DEFAULT 0,
    qtded_recurso     INT           DEFAULT 0,
    qtded_captura     INT           DEFAULT 0,
    id_sala           INT           NOT NULL,
    id_inventario     INT           NOT NULL,
    nome_missao       VARCHAR(255)  NOT NULL,
    titulo_objetivo   VARCHAR(255)  NOT NULL,
    nome_gangue       VARCHAR(50)   NOT NULL,

    PRIMARY KEY (id_personagem),
    UNIQUE (nome),

    FOREIGN KEY (id_sala)           REFERENCES Sala (id_sala),
    FOREIGN KEY (id_inventario)     REFERENCES Inventario (id_inventario),
    FOREIGN KEY (nome_missao)       REFERENCES Missao (nome_missao),
    FOREIGN KEY (titulo_objetivo)   REFERENCES Objetivo_principal (titulo_objetivo),
    FOREIGN KEY (nome_gangue)       REFERENCES Gangue (nome_gangue)

    );


#### Prisioneiro

    CREATE TABLE Prisioneiro (

    id_personagem   INT           NOT NULL,
    nome            VARCHAR(50)   NOT NULL,
    velocidade      INT           DEFAULT 0,
    vida            INT           DEFAULT 0,
    crime           VARCHAR(255)  DEFAULT NULL,
    id_sala         INT           NOT NULL,
    nome_gangue     VARCHAR(50)   NOT NULL,

    PRIMARY KEY (id_personagem),
    UNIQUE (nome),

    FOREIGN KEY (id_sala)       REFERENCES Sala (id_sala),
    FOREIGN KEY (nome_gangue)   REFERENCES Gangue (nome_gangue)

    );

#### Gangue

    CREATE TABLE Gangue (

    nome_gangue          VARCHAR(50)   NOT NULL,
    descricao            VARCHAR(1000) NOT NULL,
    qtdd_membros         INT           DEFAULT 0,
    qtdd_recurso_gangue  INT           DEFAULT 0,

    PRIMARY KEY (nome_gangue)
    
    );




## 📑 Histórico de versão

| Versão| Data      | Descrição | Autor |
| :-:   | :-:       | :--       | --    |
| `1.0`   | 05/06/2025 |Criação da introdução e metodologia utilizada no DDL | [Mayara A. Oliveira](https://github.com/Mayara-tech)  |
| `1.1`   | 07/06/2025 |adicionando tabelas jogador, prisioneiro e gangue | [Mayara A. Oliveira](https://github.com/Mayara-tech)  |