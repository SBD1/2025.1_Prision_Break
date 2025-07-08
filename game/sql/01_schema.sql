CREATE TABLE IF NOT EXISTS Gangue (
    nome_gangue          VARCHAR(50)   NOT NULL,
    descricao            VARCHAR(1000) NOT NULL,
    qtdd_membros         INT           DEFAULT 0,
    qtdd_recurso_gangue  INT           DEFAULT 0,
    PRIMARY KEY (nome_gangue)
);

CREATE TABLE IF NOT EXISTS Inventario (
    id_inventario        SERIAL        PRIMARY KEY,
    qtd_itens            INT           DEFAULT 0,
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
    id_sala              SERIAL        PRIMARY KEY,
    norte                INT           DEFAULT NULL,
    sul                  INT           DEFAULT NULL,
    leste                INT           DEFAULT NULL,
    oeste                INT           DEFAULT NULL,
    id_inventario        INT           NOT NULL,
    nome                 VARCHAR(50)   NOT NULL,
    descricao            VARCHAR(1000) NOT NULL,
    nivel_perigo         INT           CHECK (nivel_perigo >= 0 AND nivel_perigo <= 10),
    bloqueado            BOOLEAN       DEFAULT FALSE,
    FOREIGN KEY (id_inventario) REFERENCES Inventario(id_inventario),
    FOREIGN KEY (norte)   REFERENCES Sala(id_sala),
    FOREIGN KEY (sul)     REFERENCES Sala(id_sala),
    FOREIGN KEY (leste)   REFERENCES Sala(id_sala),
    FOREIGN KEY (oeste)   REFERENCES Sala(id_sala)
);

CREATE TABLE IF NOT EXISTS Item (
    nome_item            VARCHAR(50)   PRIMARY KEY,
    descricao            VARCHAR(500)  NOT NULL,
    durabilidade         INT           DEFAULT 1,
    pode_ser_vendido     BOOLEAN       DEFAULT FALSE,
    nome_missao          VARCHAR(255)  DEFAULT NULL,
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
    nome_missao       VARCHAR(255)  DEFAULT NULL,    
    titulo_objetivo   VARCHAR(255)  DEFAULT NULL,     
    nome_gangue       VARCHAR(50)   DEFAULT NULL,      
    nome              VARCHAR(50)   NOT NULL,
    dificuldade_jogo  VARCHAR(1) DEFAULT 'M',
    modificador_equipamento        INT           DEFAULT 0,
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
    FOREIGN KEY (nome_gangue)       REFERENCES Gangue (nome_gangue),
    CONSTRAINT chk_dificuldade CHECK (dificuldade_jogo IN ('F', 'M', 'D'))
);

CREATE TABLE IF NOT EXISTS Modificador_dificuldade (
    tag_dificuldade VARCHAR(1) PRIMARY KEY,
    modificador INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Agente_Penitenciario_Jogador (
    id_captura                      SERIAL        PRIMARY KEY,
    id_personagem_jogador           INT,
    id_personagem_agente_penitenciario INT,
    FOREIGN KEY (id_personagem_jogador) REFERENCES Jogador(id_personagem),
    FOREIGN KEY (id_personagem_agente_penitenciario) REFERENCES Agente_Penitenciario(id_personagem)
);

-- Tabela Loja corrigida: Agora nome_gangue e nome_item formam a chave primária
CREATE TABLE IF NOT EXISTS Loja (
    nome_gangue          VARCHAR(50)   NOT NULL,
    preco                INT           NOT NULL,
    nome_item            VARCHAR(100)  NOT NULL,
    quantidade_disponivel INT          DEFAULT 0, -- Coluna renomeada para consistência
    PRIMARY KEY (nome_gangue, nome_item), -- Chave primária composta
    FOREIGN KEY (nome_gangue) REFERENCES Gangue(nome_gangue),
    FOREIGN KEY (nome_item) REFERENCES Item(nome_item)
);

-- A tabela Item_Loja foi removida por ser redundante com a nova estrutura de Loja

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
    ordem                INT           NOT NULL,
    FOREIGN KEY (titulo_objetivo) REFERENCES Objetivo_Principal(titulo_objetivo),
    FOREIGN KEY (nome_missao) REFERENCES Missao(nome_missao)
);

CREATE TABLE IF NOT EXISTS LogCaptura (
    log_id            SERIAL        PRIMARY KEY,
    jogador_id        INT           NOT NULL,
    data_captura      TIMESTAMP     DEFAULT NOW(),
    sala_antiga       INT           NOT NULL,
    sala_nova         INT           NOT NULL,
    FOREIGN KEY (jogador_id) REFERENCES Jogador(id_personagem),
    FOREIGN KEY (sala_antiga) REFERENCES Sala(id_sala),
    FOREIGN KEY (sala_nova) REFERENCES Sala(id_sala)
);