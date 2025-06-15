-- Consulta as gangues que vendem determinado item
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
SELECT DISTINCT
    I.nome_item,
    INV.id_inventario
FROM Item I
INNER JOIN Instancia_Item II ON I.nome_item = II.nome_item
INNER JOIN Inventario INV ON II.id_inventario = INV.id_inventario
WHERE I.nome_item = 'Chave Inglesa'  -- Substitua pelo nome do item desejado
GROUP BY INV.id_inventario, I.nome_item
ORDER BY I.nome_item;

