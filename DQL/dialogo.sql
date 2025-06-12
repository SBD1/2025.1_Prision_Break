-- Contulstar todos os diálogos
SELECT * FROM Dialogo;

-- Consultar todos os diálogos com nome da missão e ordem 
SELECT nome_missao, ordem, texto
FROM Dialogo
ORDER BY nome_missao, ordem;

-- Consultar diálogos de uma missao específica
SELECT *
FROM Dialogo 
WHERE nome_missao = 'Fuga de Fox River'
ORDER BY ordem;

-- Conultar diálogos de um personagem específico
SELECT *
FROM  Dialogo 
WHERE id_personagem = '9'
ORDER BY ordem;

-- Consultar quantos dialogos cada personagem tem
SELECT id_personagem, COUNT(*) AS qtd_dialogos
FROM Dialogo
GROUP BY id_personagem;

-- Consultar quantos dialogo existem por missao
SELECT id_personagem, COUNT(*) AS qtd_dialogos
FROM Dialogo
GROUP BY nome_missao;

-- Consultar missoes com mais de tres dialogos
SELECT nome_missao, COUNT(*) AS qtd_dialogos
FROM Dialogo
GROUP BY nome_missao
HAVING COUNT (*) > 3;

-- Consultar se há dialogos repetidos
SELECT texto, COUNT(*) 
FROM Dialogo
GROUP BY texto
HAVING COUNT(*) > 1;

-- Consultar o texto dos dialogos com o nome e descricao da missao
SELECT 
    D.id_dialogo,
    D.texto,
    D.ordem,
    D.nome_missao,
    M.descricao AS descricao_missao
FROM 
    "Dialogo" D
JOIN 
    "Missao" M ON D.nome_missao = M.nome_missao
ORDER BY 
    D.ordem;

-- Consultar dialogos e tipo do personagem
SELECT 
    D.texto,
    CP.tipo_personagem
FROM 
    "Dialogo" D
JOIN 
    "Consulta_Personagem" CP ON D.id_personagem = CP.id_personagem;

-- Consultar missoes pela quantidade de dialogos
SELECT 
    d.nome_missao,
    m.descricao,
    COUNT(*) AS total_dialogos
FROM 
    dialogo d
JOIN 
    missao m ON d.nome_missao = m.nome_missao
GROUP BY 
    d.nome_missao, m.descricao
ORDER BY 
    total_dialogos DESC;




