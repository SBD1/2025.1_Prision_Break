-- Retorna todas as informações do inventário
-- Útil para verificar o estado geral de todos os inventários.
SELECT
    id_inventario,
    qtd_itens,
    is_full
FROM
    Inventario;

-- Inventários de uma Sala Específica
-- Retorna os inventários associados a uma sala específica, útil para localizar itens em salas específicas.
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
-- Retorna os inventários que estão cheios, útil para identificar inventários que não podem receber mais itens.
SELECT
    id_inventario,
    qtd_itens,
    is_full
FROM
    Inventario
WHERE
    is_full = TRUE;

-- Apenas os Inventários que Não Estão Cheios
-- Retorna os inventários que ainda têm espaço, útil para identificar inventários que podem receber mais itens.
SELECT
    id_inventario,
    qtd_itens,
    is_full
FROM
    Inventario
WHERE
    is_full = FALSE;

-- Consulta itens no inventário do jogador após compra ou venda
-- Retorna os itens no inventário do jogador, incluindo quantidade, descrição e durabilidade. Útil para verificar o estado

