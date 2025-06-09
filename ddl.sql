CREATE TABLE Item (
    nome_item            VARCHAR(100) PRIMARY KEY,
    descricao            TEXT,
    durabilidade         INT,
    pode_ser_vendido     BOOLEAN,
    nome_missao          VARCHAR(100),
    utilidade            TEXT,
    beneficio            TEXT,

    FOREIGN KEY (nome_missao) REFERENCES Missao(nome_missao)
);

CREATE TABLE Instancia_Item (
    id_instancia          INT PRIMARY KEY,
    nivel_de_gasto        INT,
    id_inventario         INT,
    nome_item             VARCHAR(100),

    FOREIGN KEY (id_inventario) REFERENCES Inventario(id_inventario),
    FOREIGN KEY (nome_item) REFERENCES Item(nome_item)
);

CREATE TABLE Item_Loja (
    id_compra              INT PRIMARY KEY,
    nome_gangue            VARCHAR(100),
    nome_item              VARCHAR(100),

    FOREIGN KEY (nome_gangue) REFERENCES Gangue(nome_gangue),
    FOREIGN KEY (nome_item) REFERENCES Item(nome_item)
);

CREATE TABLE Loja (
    nome_gangue            VARCHAR(100),
    preco                  DECIMAL(10,2),
    nome_item              VARCHAR(100),

    FOREIGN KEY (nome_gangue) REFERENCES Gangue(nome_gangue),
    FOREIGN KEY (nome_item) REFERENCES Item(nome_item)
);

CREATE TABLE Inventario (
    id_inventario    INT      PRIMARY KEY,
    qtd_itens        INT      NOT NULL,
    is_full          BOOLEAN  DEFAULT FALSE
);

CREATE TABLE Sala (
    id_sala         INT           PRIMARY KEY,
    id_inventario   INT           NOT NULL,
    nome            VARCHAR(50)   NOT NULL,
    descricao       VARCHAR(1000)  ,
    nivel_perigo    INT           CHECK (nivel_perigo >= 0 AND nivel_perigo <= 10),
    bloqueado       BOOLEAN       DEFAULT FALSE,

    FOREIGN KEY     (id_inventario) REFERENCES Inventario(id_inventario)
);

CREATE TABLE Missao_Sala (
    nome_missao            VARCHAR(255),
    id_sala                INT,
    
    PRIMARY KEY (nome_missao, id_sala), 
    FOREIGN KEY (id_sala) REFERENCES Sala(id_sala)
    FOREIGN KEY (nome_missao) REFERENCES Missao(nome_missao)
);
CREATE TABLE Consulta_Personagem(
    id_personagem        SERIAL PRIMARY KEY,    
    tipo_personagem      VARCHAR(2) NOT NULL      	
);

CREATE TABLE Agente_Penitenciario(
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

CREATE TABLE Agente_Penitenciario_Jogador(
    id_captura                         SERIAL PRIMARY KEY,        	
    id_personagem_jogador              INT,           
    id_personagem_agente_penitenciario INT,

    FOREIGN KEY (id_personagem_jogador) REFERENCES Jogador(id_personagem),
    FOREIGN KEY (id_personagem_agente_penitenciario) REFERENCES Agente_Penitenciario(id_personagem)
);

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

CREATE TABLE Gangue (
    nome_gangue          VARCHAR(50)   NOT NULL,
    descricao            VARCHAR(1000) NOT NULL,
    qtdd_membros         INT           DEFAULT 0,
    qtdd_recurso_gangue  INT           DEFAULT 0,

    PRIMARY KEY (nome_gangue)  
);

-- Apaga tabelas E colunas
DROP TABLE Item [RESTRICT];
DROP TABLE Instancia_Item [RESTRICT];
DROP TABLE Item_Loja [RESTRICT];
DROP TABLE Loja [RESTRICT];
DROP TABLE Inventario [RESTRICT];
DROP TABLE Sala [RESTRICT]
DROP TABLE Missao_Sala [RESTRICT];
DROP TABLE Consulta_personagem [RESTRICT];
DROP TABLE Agente_Penitenciario [RESTRICT];
DROP TABLE Agente_Penitenciario_Jogador [RESTRICT];
DROP TABLE Jogador [RESTRICT];
DROP TABLE Prisioneiro [RESTRICT];
DROP TABLE Gangue [RESTRICT];


-- Alterar tabelas E colunas

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