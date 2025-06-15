-- Retorna todas as informações do inventário
SELECT
    id_inventario,
    qtd_itens,
    is_full
FROM
    Inventario;

-- Inventários de uma Sala Específica
SELECT
    I.id_inventario,
    I.qtd_itens,
    I.is_full
FROM
    Inventario AS I
JOIN
    Sala AS S ON I.id_inventario = S.id_inventario
WHERE
    S.id_sala = 1; -- Substitua '1' pelo ID da sala desejada

-- Apenas os Inventários Cheios
SELECT
    id_inventario,
    qtd_itens,
    is_full
FROM
    Inventario
WHERE
    is_full = TRUE;

-- Apenas os Inventários que Não Estão Cheios
SELECT
    id_inventario,
    qtd_itens,
    is_full
FROM
    Inventario
WHERE
    is_full = FALSE;

    