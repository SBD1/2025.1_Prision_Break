-- Retorna todas as informações de uma missão
SELECT
    nome_missao,
    descricao,
    status
FROM
    Missao
WHERE
    nome_missao = 'Fuga'; -- Substitua pelo nome da missão desejada

-- Retorna todas as missões desbloqueadas
SELECT
    nome_missao,
    descricao,
    status
FROM
    Missao
WHERE
    status = TRUE;

-- Retorna todas as missões bloqueadas
SELECT
    nome_missao,
    descricao,
    status
FROM
    Missao
WHERE
    status = FALSE;
