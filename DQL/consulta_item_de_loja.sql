-- Busca todos os itens de uma gangue especifica na loja, incluindo detalhes do item
-- e o preço de cada item na loja
SELECT 
    L.nome_gangue,
    L.nome_item,
    I.descricao,
    L.preco,
    I.durabilidade,
    I.utilidade,
    I.beneficio
FROM Loja L
INNER JOIN Item_Loja IL ON L.nome_gangue = IL.nome_gangue
INNER JOIN Item I ON IL.nome_item = I.nome_item
WHERE L.nome_gangue = 'Nome da Gangue';

-- Conta itens de uma loja de uma gangue
SELECT 
    L.nome_gangue,
    COUNT(L.nome_item) as total_itens,
    SUM(L.preco) as valor_total
FROM Loja L
INNER JOIN Item_Loja IL ON L.nome_gangue = IL.nome_gangue
WHERE L.nome_gangue = 'Nome da Gangue'
GROUP BY L.nome_gangue;

-- Conta quantidade de cada item de uma loja especifica de uma gangue
SELECT 
    L.nome_item,
    COUNT(L.nome_item) as quantidade_item,
    L.preco as preco_unidade,
    SUM(L.preco) as valor_total_item
FROM Loja L
INNER JOIN Item_Loja IL ON L.nome_gangue = IL.nome_gangue
    AND L.nome_item = IL.nome_item
WHERE L.nome_gangue = 'Nome da Gangue'
GROUP BY L.nome_item, L.preco
ORDER BY L.nome_item;