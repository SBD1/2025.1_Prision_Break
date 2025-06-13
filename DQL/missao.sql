-- Consultar todas as missoes
SELECT * FROM missao;

-- Consultar missoes ativas
SELECT * 
FROM missao
WHERE status = true;

-- Consultar missoes inativas
SELECT * 
FROM missao
WHERE status = false;

-- Consultar quantas missoes estao ativas e inativas
SELECT status, COUNT(*) AS total
FROM missao
GROUP BY status;

-- Consultar missoes com seus respectivos objetivos
SELECT 
    m.nome_missao,
    m.descricao AS descricao_missao,
    o.titulo_objetivo,
    op.descricao AS descricao_objetivo
FROM 
    missao m
JOIN 
    objetivo_principal_missao o ON m.nome_missao = o.nome_missao
JOIN 
    objetivo_principal op ON o.titulo_objetivo = op.titulo_objetivo;

-- Consultar as salas asscociadas a cada missao
SELECT 
    m.nome_missao,
    s.nome AS nome_sala,
    s.nivel_perigo
FROM 
    missao m
JOIN 
    missao_sala ms ON m.nome_missao = ms.nome_missao
JOIN 
    sala s ON ms.id_sala = s.id_sala;

-- Consultar missoes e seus itens associados
SELECT 
    m.nome_missao,
    m.descricao AS descricao_missao,
    i.nome_item,
    ii.id_instancia,
    ii.nivel_de_gasto
FROM 
    missao m
JOIN 
    item i ON m.nome_missao = i.nome_missao
JOIN 
    instancia_item ii ON i.nome_item = ii.nome_item;



