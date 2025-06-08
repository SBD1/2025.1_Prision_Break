CREATE TABLE Item (
    nome_item VARCHAR(100) PRIMARY KEY,
    descricao TEXT,
    durabilidade INT,
    pode_ser_vendido BOOLEAN,
    nome_missao VARCHAR(100),
    utilidade TEXT,
    beneficio TEXT,
    FOREIGN KEY (nome_missao) REFERENCES Missao(nome_missao)
);

CREATE TABLE Instancia_Item (
    id_instancia INT PRIMARY KEY,
    nivel_de_gasto INT,
    id_inventario INT,
    nome_item VARCHAR(100),
    FOREIGN KEY (id_inventario) REFERENCES Inventario(id_inventario),
    FOREIGN KEY (nome_item) REFERENCES Item(nome_item)
);

CREATE TABLE Item_Loja (
    id_compra INT PRIMARY KEY,
    nome_gangue VARCHAR(100),
    nome_item VARCHAR(100),
    FOREIGN KEY (nome_gangue) REFERENCES Gangue(nome_gangue),
    FOREIGN KEY (nome_item) REFERENCES Item(nome_item)
);

CREATE TABLE Loja (
    nome_gangue VARCHAR(100),
    preco DECIMAL(10,2),
    nome_item VARCHAR(100),
    FOREIGN KEY (nome_gangue) REFERENCES Gangue(nome_gangue),
    FOREIGN KEY (nome_item) REFERENCES Item(nome_item)
);

CREATE TABLE Inventario (
    id_inventario INT PRIMARY KEY,
    qtd_itens INT NOT NULL,
    is_full BOOLEAN DEFAULT FALSE
);

CREATE TABLE Sala (
    id_sala INT PRIMARY KEY,
    id_inventario INT,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(1000),
    nivel_perigo INT CHECK (nivel_perigo >= 0 AND nivel_perigo <= 10),
    bloqueado BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_inventario) REFERENCES Inventario(id_inventario)
);

CREATE TABLE Missao_Sala (
    nome_missao VARCHAR(255),
    id_sala INT,
    PRIMARY KEY (nome_missao, id_sala), -- alterar no dicionário
    FOREIGN KEY (id_sala) REFERENCES Sala(id_sala)
    -- FOREIGN KEY (nome_missao) REFERENCES Missao(nome_missao) -- descomentar quando tiver a tabela de missao
);

DROP TABLE IF EXISTS Missao_Sala;
DROP TABLE IF EXISTS Sala;
DROP TABLE IF EXISTS Inventario;

