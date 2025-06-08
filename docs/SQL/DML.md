# DML - Linguagem de Manipulação de Dados

## Introdução

A DML – Linguagem de Manipulação de Dados (Data Manipulation Language) é uma das principais categorias da linguagem SQL, sendo responsável pelas operações que envolvem a inserção, atualização, exclusão e consulta dos dados que estão armazenados nas tabelas do banco. Diferente da DDL, que se ocupa da definição da estrutura do banco (como a criação de tabelas e relações), a DML atua diretamente sobre os dados em si, permitindo que o sistema seja alimentado, mantido e consultado de forma dinâmica.

O uso correto da DML é fundamental para manter a integridade, consistência e atualidade dos dados, e seu domínio é indispensável para desenvolvedores, administradores de banco de dados e profissionais da área de tecnologia da informação. Entre os comandos mais utilizados da DML estão o INSERT que insere novos registros, o UPDATE que altera dados existentes, o DELETE que remove informações, e o SELECT que realiza consultas.

## Metodologia 

O banco de dados relacional utilizado foi o PostgreSQL. A manipulação dos dados foi realizada com base na estrutura definida anteriormente pelo modelo relacional e pelo diagrama Entidade-Relacionamento. Foram empregados comandos SQL pertencentes à Linguagem de Manipulação de Dados (DML), como INSERT para inserção de dados, UPDATE para alterações, DELETE para exclusões e SELECT para consultas. Todas as operações foram executadas diretamente no ambiente do PostgreSQL.

## Inserção de dados 

#### Jogador

    INSERT INTO Jogador (id_personagem, nome, velocidade, vida, qtded_recurso, qtded_captura, id_sala, id_inventario, nome_missao, titulo_objetivo, nome_gangue) VALUES
    (10, 'Lucas Silva', 9, 100, 5, 2, 101, 1, 'Fuga de Fox River', 'Libertar Lincoln', 'Os Fox River Eight'),
    (11, 'Gabriel Souza', 8, 95, 4, 1, 102, 2, 'Fuga de Fox River', 'Sobreviver até a fuga', 'Os Fox River Eight'),
    (12, 'Rafael Costa', 7, 92, 3, 3, 103, 3, 'Rota Segura', 'Proteger a família', 'Os Justiceiros'),
    (13, 'Matheus Oliveira', 8, 90, 2, 2, 104, 4, 'Missão de Confiança', 'Provar lealdade', 'Mafia Abruzzi'),
    (14, 'João Almeida', 6, 85, 1, 1, 105, 5, 'Informante Infiltrado', 'Descobrir plano rival', 'La Familia');


#### Prisioneiro

    INSERT INTO Prisioneiro (id_personagem, nome, velocidade, vida, crime, id_sala, nome_gangue) VALUES

    (1, 'Michael Scofield', 8, 100, 'Assalto a banco (planejado para entrar na prisão)', 101, 'Os Fox River Eight'),
    (2, 'John Abruzzi', 6, 90, 'Homicídio e chefia em organização criminosa', 102, 'Mafia Abruzzi'),
    (3, 'Theodore "T-Bag" Bagwell', 5, 80, 'Estupro, sequestro e assassinato', 103, 'Irmandade Ariana'),
    (4, 'Fernando Sucre', 7, 95, 'Roubo à mão armada', 101, 'Os Fox River Eight'),
    (5, 'Benjamin "C-Note" Franklin', 8, 93, 'Tráfico e deserção militar', 104, 'Os Justiceiros'),
    (6, 'David "Tweener" Apolskis', 7, 85, 'Roubo e desacato', 105, 'Os Fox River Eight'),
    (7, 'Carlos Ortega', 6, 88, 'Tráfico de drogas e agressão', 106, 'La Familia'); 


#### Gangue

    INSERT INTO Gangue (nome_gangue, descricao, qtdd_membros, qtdd_recurso_gangue) VALUES

    ('Os Fox River Eight', 'Grupo formado pelos fugitivos de Fox River. Unidos pela fuga, cada membro tem uma habilidade estratégica.', 8, 60),
    ('Mafia Abruzzi', 'Facção italiana comandada por John Abruzzi, envolvida com crimes organizados e tráfico de influência dentro da prisão.', 10, 45),
    ('Irmandade Ariana', 'Grupo supremacista branco dentro da penitenciária, violento e radical. Liderado por T-Bag.', 12, 40),
    ('La Familia', 'Grupo latino composto por membros de origens mexicanas e porto-riquenhas. Atua com lealdade interna e controle de rotas internas.', 14, 37),
    ('Os Justiceiros', 'Prisioneiros que agem sob o pretexto de justiça interna, combatendo delatores e traidores. Inspirados em atitudes de C-Note.', 7, 28);


## 📑 Histórico de versão

| Versão| Data      | Descrição | Autor |
| :-:   | :-:       | :--       | --    |
| `1.0`   | 05/06/2025 |Criação da introdução e metodologia utilizada no DML | [Mayara A. Oliveira](https://github.com/Mayara-tech)  |
| `1.1`   | 07/06/2025 |adicionando dados a tabela jogador, prisioneiro e gangue | [Mayara A. Oliveira](https://github.com/Mayara-tech)  |