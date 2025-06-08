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

CREATE TABLE Consulta_Personagem(
    id_personagem SERIAL PRIMARY KEY,       --Alterar no dicionario de dados
    tipo_personagem VARCHAR(2) NOT NULL      	
); -- Colocar restrição no tipo (AP, J, P)

CREATE TABLE Agente_Penitenciario(
    id_personagem INT PRIMARY KEY,
    -- id_sala INT,         				-- descomentar depois de inserir a tabela de salas
    nome VARCHAR(50) DEFAULT 'Tira',
    velocidade INT DEFAULT 5,
    nivel_de_perigo INT DEFAULT 5, --Alterar no dicionário 
    nivel_de_alerta INT DEFAULT 5,
    corrupto BOOLEAN DEFAULT false, --Alterar no dicionário 
    preco INT DEFAULT 0,
    cargo VARCHAR(255) DEFAULT 'Carcereiro',

    -- FOREIGN KEY (id_sala) REFERENCES Sala(id_sala), -- descomentar depois de inserir a tabela de salas
    FOREIGN KEY (id_personagem) REFERENCES Consulta_Personagem(id_personagem)
);

CREATE TABLE Agente_Penitenciario_Jogador(
    id_captura SERIAL PRIMARY KEY,        	--Alterar no dicionario de dados
    -- id_personagem_jogador INT,           -- descomentar depois de inserir a tabela de Jogador
    id_personagem_agente_penitenciario INT,

    -- FOREIGN KEY (id_personagem_jogador) REFERENCES Jogador(id_personagem), -- descomentar depois de inserir a tabela de Jogador
    FOREIGN KEY (id_personagem_agente_penitenciario) REFERENCES Agente_Penitenciario(id_personagem)
);

-- Apaga tabelas
DROP TABLE agente_penitenciario_jogador;
DROP TABLE agente_penitenciario;
DROP TABLE consulta_personagem;