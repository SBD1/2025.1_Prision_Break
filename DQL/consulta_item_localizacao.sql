-- Consulta as gangues que vendem determinado item
-- Retorna o nome do item e as gangues que o vendem, útil para identificar vendedores de um item específico.
SELECT DISTINCT
    I.nome_item,
    IL.nome_gangue,
FROM Item I
INNER JOIN Item_Loja IL ON I.nome_item = IL.nome_item
INNER JOIN Loja L ON IL.nome_gangue = L.nome_gangue 
WHERE I.nome_item = 'Chave Inglesa'  -- Substitua pelo nome do item desejado
GROUP BY I.nome_item, IL.nome_gangue
ORDER BY IL.nome_gangue;

-- Consulta todos os inventários que possuem um item específico
-- Retorna o nome do item e os inventários que o possuem, útil para localizar itens em diferentes inventários.
SELECT DISTINCT
    I.nome_item,
    INV.id_inventario
FROM Item I
INNER JOIN Instancia_Item II ON I.nome_item = II.nome_item
INNER JOIN Inventario INV ON II.id_inventario = INV.id_inventario
WHERE I.nome_item = 'Chave Inglesa'  -- Substitua pelo nome do item desejado
GROUP BY INV.id_inventario, I.nome_item
ORDER BY I.nome_item;

-- Consulta itens disponíveis para compra na loja
-- Retorna os itens disponíveis na loja, incluindo o preço e a gangue que os vende. Útil para realizar compras.
SELECT 
    IL.nome_item,
    IL.nome_gangue,
    L.preco
FROM Item_Loja IL
INNER JOIN Loja L ON IL.nome_item = L.nome_item AND IL.nome_gangue = L.nome_gangue
WHERE IL.nome_item = 'Chave Inglesa'  -- Substitua pelo nome do item desejado
ORDER BY L.preco;

-- Consulta itens disponíveis para venda no inventário
-- Retorna os itens disponíveis no inventário do jogador, incluindo quantidade, descrição e durabilidade. Útil para realizar vendas.
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

