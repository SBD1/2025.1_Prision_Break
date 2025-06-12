-- Consultar informação de todos os prisioneiros em ordem alfabetica
SELECT *
FROM Prisioneiro
ORDER BY nome DESC;

-- Consultar todas as informações de um prisioneiro em especifico
SELECT *
FROM Prisioneiro
Where nome= 'Michael Scofield' ;

-- Consultar todos os dados dos prisioneiros que estão na sala
SELECT *
FROM prisioneiro
WHERE id_sala = '1';

-- Consultar apenas nome e gangue dos prisioneiros que estão na sala
SELECT nome, nome_gangue
FROM prisioneiro
WHERE id_sala = '1';

-- Consultar todas as gangues que estão na sala 
SELECT nome_gangue
FROM prisioneiro
WHERE id_sala = '1';

-- Consultar onde esta o prisioneiro 
SELECT prisioneiro.nome, sala.nome
FROM prisioneiro 
JOIN sala  ON prisioneiro.id_sala = sala.id_sala
WHERE prisioneiro.nome = 'Michael Scofield';

-- Consultar localização de todos os prisioneiros em ordem alfabetica
SELECT prisioneiro.nome, sala.nome
FROM prisioneiro 
JOIN sala  ON prisioneiro.id_sala = sala.id_sala
ORDER BY prisioneiro.nome ASC;
