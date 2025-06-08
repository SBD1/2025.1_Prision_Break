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

