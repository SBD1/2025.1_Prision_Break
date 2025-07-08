WITH loja_indexada AS (
    SELECT 
        row_number() OVER () AS id_loja,
        nome_item,
        nome_gangue
    FROM Loja
)
SELECT nome_item, nome_gangue
FROM loja_indexada
WHERE id_loja = %s;
