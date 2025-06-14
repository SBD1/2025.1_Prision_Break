CREATE TABLE IF NOT EXISTS Gangue (
    nome_gangue          VARCHAR(50)   NOT NULL,
    descricao            VARCHAR(1000) NOT NULL,
    qtdd_membros         INT           DEFAULT 0,
    qtdd_recurso_gangue  INT           DEFAULT 0,
    PRIMARY KEY (nome_gangue)
);

CREATE TABLE IF NOT EXISTS Inventario (
    id_inventario        INT           PRIMARY KEY,
    qtd_itens            INT           NOT NULL,
    is_full              BOOLEAN       DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS Objetivo_Principal (
    titulo_objetivo      VARCHAR(255)  PRIMARY KEY,
    descricao            VARCHAR(1000) NOT NULL
);

CREATE TABLE IF NOT EXISTS Missao (
    nome_missao          VARCHAR(255)  PRIMARY KEY,
    descricao            VARCHAR(1000) NOT NULL,
    status               BOOLEAN       DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS Consulta_Personagem (
    id_personagem        SERIAL        PRIMARY KEY,
    tipo_personagem      VARCHAR(2)    NOT NULL
);

CREATE TABLE IF NOT EXISTS Sala (
    id_sala              INT           PRIMARY KEY,
    id_inventario        INT           NOT NULL,
    nome                 VARCHAR(50)   NOT NULL,
    descricao            VARCHAR(1000) NOT NULL,
    nivel_perigo         INT           CHECK (nivel_perigo >= 0 AND nivel_perigo <= 10),
    bloqueado            BOOLEAN       DEFAULT FALSE,
    FOREIGN KEY (id_inventario) REFERENCES Inventario(id_inventario)
);

CREATE TABLE IF NOT EXISTS Item (
    nome_item            VARCHAR(50)   PRIMARY KEY,
    descricao            VARCHAR(500)  NOT NULL,
    durabilidade         INT           DEFAULT 1,
    pode_ser_vendido     BOOLEAN       DEFAULT FALSE,
    nome_missao          VARCHAR(255)  NOT NULL,
    utilidade            VARCHAR(500)  DEFAULT NULL,
    beneficio            VARCHAR(500)  DEFAULT NULL,
    FOREIGN KEY (nome_missao) REFERENCES Missao(nome_missao)
);

CREATE TABLE IF NOT EXISTS Prisioneiro (
    id_personagem   INT           NOT NULL,
    nome            VARCHAR(50)   NOT NULL,
    velocidade      INT           DEFAULT 0,
    vida            INT           DEFAULT 0,
    crime           VARCHAR(255)  DEFAULT NULL,
    id_sala         INT           NOT NULL,
    nome_gangue     VARCHAR(50)   NOT NULL,
    FOREIGN KEY (id_personagem) REFERENCES Consulta_Personagem(id_personagem),
    UNIQUE (id_personagem),
    UNIQUE (nome),
    FOREIGN KEY (id_sala)       REFERENCES Sala (id_sala),
    FOREIGN KEY (nome_gangue)   REFERENCES Gangue (nome_gangue)
);

CREATE TABLE IF NOT EXISTS Agente_Penitenciario (
    id_personagem          INT         NOT NULL,
    id_sala                INT         NOT NULL,         			
    nome                   VARCHAR(50) DEFAULT 'Tira',
    velocidade             INT         DEFAULT 5,
    nivel_de_perigo        INT         DEFAULT 5,
    nivel_de_alerta        INT         DEFAULT 5,
    corrupto               BOOLEAN     DEFAULT false, 
    preco                  INT         DEFAULT 0,
    cargo                 VARCHAR(255) DEFAULT 'Carcereiro',
    FOREIGN KEY (id_personagem) REFERENCES Consulta_Personagem(id_personagem),
    UNIQUE (id_personagem),
    FOREIGN KEY (id_sala) REFERENCES Sala(id_sala)
);

CREATE TABLE IF NOT EXISTS Jogador (
    id_personagem     INT           NOT NULL,
    id_sala           INT           NOT NULL,
    id_inventario     INT           NOT NULL,
    nome_missao       VARCHAR(255),    
    titulo_objetivo   VARCHAR(255),     
    nome_gangue       VARCHAR(50),      
    nome              VARCHAR(50)   NOT NULL,
    velocidade        INT           DEFAULT 0,
    vida              INT           DEFAULT 0,
    qtded_recurso     INT           DEFAULT 0,
    qtded_captura     INT           DEFAULT 0,
    UNIQUE (id_personagem),
    UNIQUE (nome),
    FOREIGN KEY (id_personagem) REFERENCES Consulta_Personagem(id_personagem),
    FOREIGN KEY (id_sala)           REFERENCES Sala (id_sala),
    FOREIGN KEY (id_inventario)     REFERENCES Inventario (id_inventario),
    FOREIGN KEY (nome_missao)       REFERENCES Missao (nome_missao),
    FOREIGN KEY (titulo_objetivo)   REFERENCES Objetivo_principal (titulo_objetivo),
    FOREIGN KEY (nome_gangue)       REFERENCES Gangue (nome_gangue)
);

CREATE TABLE IF NOT EXISTS Agente_Penitenciario_Jogador (
    id_captura                      SERIAL        PRIMARY KEY,
    id_personagem_jogador           INT,
    id_personagem_agente_penitenciario INT,
    FOREIGN KEY (id_personagem_jogador) REFERENCES Jogador(id_personagem),
    FOREIGN KEY (id_personagem_agente_penitenciario) REFERENCES Agente_Penitenciario(id_personagem)
);

CREATE TABLE IF NOT EXISTS Loja (
    nome_gangue          VARCHAR(50)   NOT NULL,
    preco                INT           NOT NULL,
    nome_item            VARCHAR(100)  NOT NULL,
    UNIQUE (nome_gangue),
    FOREIGN KEY (nome_gangue) REFERENCES Gangue(nome_gangue),
    FOREIGN KEY (nome_item) REFERENCES Item(nome_item)
);

CREATE TABLE IF NOT EXISTS Item_Loja (
    id_compra              INT          PRIMARY KEY,
    nome_gangue            VARCHAR(50)  NOT NULL,
    nome_item              VARCHAR(100) NOT NULL,
    FOREIGN KEY (nome_gangue) REFERENCES Loja(nome_gangue),
    FOREIGN KEY (nome_item) REFERENCES Item(nome_item)
);

CREATE TABLE IF NOT EXISTS Missao_Sala (
    nome_missao          VARCHAR(255)  NOT NULL,
    id_sala              INT           NOT NULL,
    PRIMARY KEY (nome_missao, id_sala),
    FOREIGN KEY (id_sala) REFERENCES Sala(id_sala),
    FOREIGN KEY (nome_missao) REFERENCES Missao(nome_missao)
);

CREATE TABLE IF NOT EXISTS Instancia_Item (
    id_instancia         INT           PRIMARY KEY,
    nivel_de_gasto       INT           DEFAULT 1,
    id_inventario        INT           NOT NULL,
    nome_item            VARCHAR(50)   NOT NULL,
    FOREIGN KEY (id_inventario) REFERENCES Inventario(id_inventario),
    FOREIGN KEY (nome_item) REFERENCES Item(nome_item)
);

CREATE TABLE IF NOT EXISTS Dialogo (
    id_dialogo       INT            PRIMARY KEY,
    id_personagem    INT,
    nome_missao      VARCHAR(255),
    texto            VARCHAR (500)  NOT NULL,
    ordem            INT            NOT NULL,
    FOREIGN KEY (id_personagem)     REFERENCES Consulta_Personagem(id_personagem),
    FOREIGN KEY (nome_missao)       REFERENCES Missao(nome_missao)
);

CREATE TABLE IF NOT EXISTS Objetivo_principal_missao (
    titulo_objetivo      VARCHAR(255)  NOT NULL,
    nome_missao          VARCHAR(255)  NOT NULL,
    FOREIGN KEY (titulo_objetivo) REFERENCES Objetivo_Principal(titulo_objetivo),
    FOREIGN KEY (nome_missao) REFERENCES Missao(nome_missao)
);