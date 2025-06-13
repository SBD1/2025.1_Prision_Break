-- Consulta para listar todos objetivos e suas missoes relacionadas
SELECT 
    opm.titulo_objetivo,
    op.descricao AS descricao_objetivo,
    m.nome_missao,
    m.descricao AS descricao_missao
FROM 
    objetivo_principal_missao opm
JOIN 
    objetivo_principal op ON opm.titulo_objetivo = op.titulo_objetivo
JOIN 
    missao m ON opm.nome_missao = m.nome_missao;

-- Consulta para contar quantas missoes estao associados a um objetivo especiridco
SELECT 
    m.nome_missao,
    COUNT(*) AS total_objetivos
FROM 
    objetivo_principal_missao opm
JOIN 
    missao m ON opm.nome_missao = m.nome_missao
GROUP BY 
    m.nome_missao
ORDER BY 
    total_objetivos DESC;

-- Consultar todas as missoes com seus objetivos
SELECT 
    opm.nome_missao,
    opm.titulo_objetivo,
    op.descricao AS descricao_objetivo
FROM 
    objetivo_principal_missao opm
JOIN 
    objetivo_principal op ON opm.titulo_objetivo = op.titulo_objetivo
ORDER BY 
    opm.nome_missao;

-- consultar objetivos que possuem pelo menos uma missao ativa
SELECT DISTINCT
    op.titulo_objetivo,
    op.descricao
FROM
    objetivo_principal op
JOIN
    objetivo_principal_missao opm ON op.titulo_objetivo = opm.titulo_objetivo
JOIN
    missao m ON opm.nome_missao = m.nome_missao
WHERE
    m.status = TRUE;  -- Missões ativas

