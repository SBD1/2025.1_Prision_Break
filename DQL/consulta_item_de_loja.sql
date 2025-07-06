-- Busca todos os itens de uma gangue específica na loja
-- Retorna detalhes dos itens vendidos por uma gangue, incluindo preço, descrição, durabilidade, utilidade e benefício.
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
-- Retorna o total de itens e o valor total dos itens vendidos por uma gangue específica.
SELECT 
    L.nome_gangue,
    COUNT(L.nome_item) as total_itens,
    SUM(L.preco) as valor_total
FROM Loja L
INNER JOIN Item_Loja IL ON L.nome_gangue = IL.nome_gangue
WHERE L.nome_gangue = 'Nome da Gangue'
GROUP BY L.nome_gangue;

-- Conta quantidade de cada item de uma loja específica de uma gangue
-- Retorna a quantidade de cada item vendido por uma gangue, incluindo o preço unitário e o valor total.
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

-- Consulta itens comprados por uma gangue específica
-- Retorna os itens comprados por uma gangue, incluindo o preço. Útil para analisar compras realizadas.
SELECT 
    IL.nome_item,
    IL.nome_gangue,
    L.preco
FROM Item_Loja IL
INNER JOIN Loja L ON IL.nome_item = L.nome_item AND IL.nome_gangue = L.nome_gangue
WHERE IL.nome_gangue = 'Os Fox River Eight'  -- Substitua pelo nome da gangue
ORDER BY L.preco;

-- Consulta itens vendidos por uma gangue específica
-- Retorna os itens vendidos por uma gangue, incluindo quantidade, descrição e durabilidade. Útil para analisar vendas realizadas.
SELECT 
    II.nome_item,
    COUNT(II.nome_item) AS quantidade,
    I.descricao,
    I.durabilidade
FROM Instancia_Item II
INNER JOIN Item I ON II.nome_item = I.nome_item
WHERE II.id_inventario = 100  -- Substitua pelo ID do inventário do jogador
GROUP BY II.nome_item, I.descricao, I.durabilidade
ORDER BY quantidade DESC;