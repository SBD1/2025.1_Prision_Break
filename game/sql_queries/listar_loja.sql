SELECT 
    row_number() OVER () AS id_loja,
    nome_item,
    preco,
    quantidade_disponivel,
    nome_gangue
FROM Loja;
