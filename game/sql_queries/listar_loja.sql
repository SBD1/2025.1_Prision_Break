SELECT
    ROW_NUMBER() OVER (ORDER BY nome_gangue, nome_item) AS id_loja, -- ADICIONADO: ORDER BY para IDs determinísticos
    nome_item,
    preco,
    quantidade_disponivel,
    nome_gangue
FROM Loja
WHERE quantidade_disponivel > 0;