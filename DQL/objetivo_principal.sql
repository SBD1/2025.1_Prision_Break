-- Consultar todos os objetivos 
SELECT * FROM Objetivo_Principal;

-- Consultar algum objetivo em especifico com sua descrição
SELECT titulo_objetivo, descricao
FROM Objetivo_Principal
WHERE titulo_objetivo = 'Libertar o prisioneiro';

-- Consultar apenas os títulos dos objetivos
SELECT titulo_objetivo FROM Objetivo_Principal;

-- Consultar quantos objetivos existem
SELECT COUNT(*) FROM Objetivo_Principal;

-- Consultar objetivos que possuem a palavra 'família' na descrição
SELECT *
FROM Objetivo_Principal
WHERE descricao LIKE '%família%';

-- Consultar objetivos em ordem alfabética
SELECT *
FROM Objetivo_Principal
ORDER BY titulo_objetivo ASC;

-- Consultar quantas vezes cada objetivo aparece
SELECT titulo_objetivo, COUNT(*) AS quantidade
FROM Objetivo_Principal
GROUP BY titulo_objetivo

-- Consultar se há objetivos duplicados
SELECT titulo_objetivo, COUNT(*)
FROM Objetivo_Principal
GROUP BY titulo_objetivo
HAVING COUNT(*) > 1;





