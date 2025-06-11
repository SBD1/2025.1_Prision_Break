# DDL - Linguagem de Definição de Dados 

## Introdução 
O DDL - Linguagem de Definição de Dados, é um dos principais componentes da linguagem SQL e tem como objetivo definir e organizar a estrutura de um banco de dados. Por meio de comandos específicos, como CREATE, ALTER e DROP, é possível criar tabelas, modificar colunas, excluir objetos e estabelecer a base estrutural sobre a qual os dados serão armazenados e manipulados.

Esses comandos são fundamentais para o desenvolvimento e manutenção de bancos de dados relacionais, garantindo que os dados sejam organizados de forma lógica e eficiente. Diferente de outras linguagens SQL que lidam com o conteúdo (como a DML), a DDL atua diretamente sobre a arquitetura do banco, moldando seu funcionamento.

## Metodologia 

O banco de dados relacional utilizado para o desenvolvimento do jogo foi o PostgreSQL. A criação da estrutura seguiu o modelo desenvolvido no diagrama Entidade-Relacionamento e representado no modelo relacional. Foram utilizados comandos da linguagem SQL, especificamente da Linguagem de Definição de Dados (DDL), como CREATE, ALTER, e DROP, para a definição e organização das tabelas e de suas restrições.

## Criação das Tabelas

#### Gangue 

    CREATE TABLE Gangue (
        nome_gangue          VARCHAR(50)   NOT NULL,
        descricao            VARCHAR(1000) NOT NULL,
        qtdd_membros         INT           DEFAULT 0,
        qtdd_recurso_gangue  INT           DEFAULT 0,

        PRIMARY KEY (nome_gangue)  
    );

#### Inventario

    CREATE TABLE Inventario (
        id_inventario    INT      PRIMARY KEY,
        qtd_itens        INT      NOT NULL,
        is_full          BOOLEAN  DEFAULT FALSE
    );

#### Objetivo principal 

    CREATE TABLE Objetivo_Principal(
        titulo_objetivo     VARCHAR(255)    PRIMARY KEY,
        descricao           VARCHAR(1000)   NOT NULL
    );

#### Missão 

    CREATE TABLE Missao(
        nome_missao        VARCHAR(255)   PRIMARY KEY,
        descricao          VARCHAR(1000)  NOT NULL,
        status             BOOLEAN        DEFAULT false
    );

#### Sala

    CREATE TABLE Sala (
        id_sala         INT           PRIMARY KEY,
        id_inventario   INT           NOT NULL,
        nome            VARCHAR(50)   NOT NULL,
        descricao       VARCHAR(1000) NOT NULL,
        nivel_perigo    INT           CHECK (nivel_perigo >= 0 AND nivel_perigo <= 10),
        bloqueado       BOOLEAN       DEFAULT FALSE,

        FOREIGN KEY     (id_inventario) REFERENCES Inventario(id_inventario)
    );

#### Item

    CREATE TABLE Item (
        nome_item            VARCHAR(50)  PRIMARY KEY,
        descricao            VARCHAR (500) NOT NULL,
        durabilidade         INT           DEFAULT 1,
        pode_ser_vendido     BOOLEAN       DEFAULT FALSE,
        nome_missao          VARCHAR(255)  NOT NULL,
        utilidade            VARCHAR (500) DEFAULT NULL,
        beneficio            VARCHAR(500)  DEFAULT NULL,

        FOREIGN KEY (nome_missao) REFERENCES Missao(nome_missao)
    );


#### Consulta personagem

    CREATE TABLE Consulta_Personagem(
        id_personagem        SERIAL      PRIMARY KEY,    
        tipo_personagem      VARCHAR(2)  NOT NULL      	
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

#### Agente penitenciario

    CREATE TABLE Agente_Penitenciario (
        id_personagem          INT         PRIMARY KEY,
        id_sala                INT         NOT NULL,         			
        nome                   VARCHAR(50) DEFAULT 'Tira',
        velocidade             INT         DEFAULT 5,
        nivel_de_perigo        INT         DEFAULT 5,
        nivel_de_alerta        INT         DEFAULT 5,
        corrupto               BOOLEAN     DEFAULT false, 
        preco                  INT         DEFAULT 0,
        cargo                 VARCHAR(255) DEFAULT 'Carcereiro',

        FOREIGN KEY (id_sala) REFERENCES Sala(id_sala), 
        FOREIGN KEY (id_personagem) REFERENCES Consulta_Personagem(id_personagem)
    );

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

#### Agente penitenciario - Jogador

    CREATE TABLE Agente_Penitenciario_Jogador(
        id_captura                         SERIAL PRIMARY KEY,        	
        id_personagem_jogador              INT,           
        id_personagem_agente_penitenciario INT,

        FOREIGN KEY (id_personagem_jogador) REFERENCES Jogador(id_personagem),
        FOREIGN KEY (id_personagem_agente_penitenciario) REFERENCES Agente_Penitenciario(id_personagem)
    );

#### Objetivo_Principal

    CREATE TABLE Objetivo_Principal(
        titulo_objetivo VARCHAR(255) PRIMARY KEY,
        descricao VARCHAR(1000) NOT NULL
    );

#### Missao

    CREATE TABLE Missao(
        nome_missao VARCHAR(255) PRIMARY KEY,
        descricao VARCHAR(1000) NOT NULL,
        status BOOLEAN DEFAULT false
    );


#### Dialogo

    CREATE TABLE Dialogo(
        id_dialogo INT PRIMARY KEY,
        id_personagem INT,
        nome_missao VARCHAR(255),
        texto VARCHAR (500),
        ordem INT,

        FOREIGN KEY (id_personagem) REFERENCES Personagem(id_personagem),
        FOREIGN KEY (nome_missao) REFERENCES Missao(nome_missao)

    );

#### Loja

    CREATE TABLE Loja (
        nome_gangue            VARCHAR(50)     NOT NULL,
        preco                  INT             NOT NULL,
        nome_item              VARCHAR(100)    NOT NULL,

        FOREIGN KEY (nome_gangue) REFERENCES Gangue(nome_gangue),
        FOREIGN KEY (nome_item) REFERENCES Item(nome_item)
    );

#### Item - Loja

    CREATE TABLE Item_Loja (
        id_compra              INT          PRIMARY KEY,
        nome_gangue            VARCHAR(50)  NOT NULL,
        nome_item              VARCHAR(100) NOT NULL,

        FOREIGN KEY (nome_gangue) REFERENCES Gangue(nome_gangue),
        FOREIGN KEY (nome_item) REFERENCES Item(nome_item)
    );

#### Missão - sala
    CREATE TABLE Missao_Sala (
        nome_missao            VARCHAR(255)  NOT NULL,
        id_sala                INT           NOT NULL,
    
        PRIMARY KEY (nome_missao, id_sala), 
        FOREIGN KEY (id_sala) REFERENCES Sala(id_sala),
        FOREIGN KEY (nome_missao) REFERENCES Missao(nome_missao)
    );


#### Instancia - item

    CREATE TABLE Instancia_Item (
        id_instancia          INT         PRIMARY KEY,
        nivel_de_gasto        INT         DEFAULT 1,
        id_inventario         INT         NOT NULL,
        nome_item             VARCHAR(50) NOT NULL,

        FOREIGN KEY (id_inventario) REFERENCES Inventario(id_inventario),
        FOREIGN KEY (nome_item) REFERENCES Item(nome_item)
    );

#### Dialogo

    CREATE TABLE Dialogo(
        id_dialogo       INT     PRIMARY KEY,
        id_personagem    INT,
        nome_missao      VARCHAR(255),
        texto            VARCHAR (500),
        ordem            INT,

        FOREIGN KEY (id_personagem) REFERENCES Consulta_Personagem(id_personagem),
        FOREIGN KEY (nome_missao) REFERENCES Missao(nome_missao)
    );

#### Objetivo principal - missao

    CREATE TABLE Objetivo_principal_missao (
        titulo_objetivo     VARCHAR(255)    NOT NULL,
        nome_missao        VARCHAR(255)     NOT NULL,

        FOREIGN KEY (titulo_objetivo) REFERENCES Objetivo_Principal(titulo_objetivo),
        FOREIGN KEY (nome_missao) REFERENCES Missao(nome_missao)
    );


### Delete das tabelas

    DROP TABLE Instancia_Item [RESTRICT];
    DROP TABLE Missao_Sala [RESTRICT];
    DROP TABLE Item_Loja [RESTRICT];
    DROP TABLE Loja [RESTRICT];
    DROP TABLE Agente_Penitenciario_Jogador [RESTRICT];
    DROP TABLE Jogador [RESTRICT];
    DROP TABLE Agente_Penitenciario [RESTRICT];
    DROP TABLE Prisioneiro [RESTRICT];
    DROP TABLE Consulta_personagem [RESTRICT];
    DROP TABLE Item [RESTRICT];
    DROP TABLE Sala [RESTRICT];
    DROP TABLE Inventario [RESTRICT];
    DROP TABLE Gangue [RESTRICT];
    DROP TABLE Objetivo_Principal [RESTRICT];
    DROP TABLE Missao [RESTRICT];
    DROP TABLE Dialogo [RESTRICT];
    DROP TABLE Objetivo_principal_missao [RESTRICT];

### Alterar colunas e restições da tabela

    ALTER TABLE Item [DROP CONSTRAINT | DROP COLUMN] [ADD CONSTRAINT | ADD COLUMN];
    ALTER TABLE Instancia_Item  [DROP CONSTRAINT | DROP COLUMN] [ADD CONSTRAINT | ADD COLUMN];
    ALTER TABLE Item_Loja  [DROP CONSTRAINT | DROP COLUMN] [ADD CONSTRAINT | ADD COLUMN];
    ALTER TABLE Loja [DROP CONSTRAINT | DROP COLUMN] [ADD CONSTRAINT | ADD COLUMN];
    ALTER TABLE Inventario [DROP CONSTRAINT | DROP COLUMN] [ADD CONSTRAINT | ADD COLUMN];
    ALTER TABLE Sala [DROP CONSTRAINT | DROP COLUMN] [ADD CONSTRAINT | ADD COLUMN];
    ALTER TABLE Missao_Sala  [DROP CONSTRAINT | DROP COLUMN] [ADD CONSTRAINT | ADD COLUMN];
    ALTER TABLE Consulta_personagem [DROP CONSTRAINT | DROP COLUMN] [ADD CONSTRAINT | ADD COLUMN];
    ALTER TABLE Agente_Penitenciario [DROP CONSTRAINT | DROP COLUMN] [ADD CONSTRAINT | ADD COLUMN];
    ALTER TABLE Agente_Penitenciario_Jogador [DROP CONSTRAINT | DROP COLUMN] [ADD CONSTRAINT | ADD COLUMN];
    ALTER TABLE Jogador  [DROP CONSTRAINT | DROP COLUMN] [ADD CONSTRAINT | ADD COLUMN];
    ALTER TABLE Prisioneiro [DROP CONSTRAINT | DROP COLUMN] [ADD CONSTRAINT | ADD COLUMN];
    ALTER TABLE Gangue [DROP CONSTRAINT | DROP COLUMN] [ADD CONSTRAINT | ADD COLUMN];
    ALTER TABLE Objetivo_Principal [DROP CONSTRAINT | DROP COLUMN] [ADD CONSTRAINT | ADD COLUMN];
    ALTER TABLE Missao [DROP CONSTRAINT | DROP COLUMN] [ADD CONSTRAINT | ADD COLUMN];
    ALTER TABLE Dialogo [DROP CONSTRAINT | DROP COLUMN] [ADD CONSTRAINT | ADD COLUMN];
    ALTER TABLE Objetivo_principal_missao [DROP CONSTRAINT | DROP COLUMN] [ADD CONSTRAINT | ADD COLUMN];


## 📑 Histórico de versão

| Versão| Data      | Descrição | Autor |
| :-:   | :-:       | :--       | --    |
| `1.0`   | 05/06/2025 |Criação da introdução e metodologia utilizada no DDL | [Mayara A. Oliveira](https://github.com/Mayara-tech)  |
| `1.1`   | 07/06/2025 |adicionando tabelas jogador, prisioneiro e gangue | [Mayara A. Oliveira](https://github.com/Mayara-tech)  |
| `1.2`   | 09/06/2025 | Adiciona dados a tabela consulta_personagem, agente_penitenciario e agente_penitenciario_jogador | [Maria Alice](https://github.com/Maliz30)  |
| `1.3`   | 09/06/2025 | Adiciona tabelas missao, diálogo e objetivo principal | [Ana Carolina](https://github.com/anawcarol)  |
