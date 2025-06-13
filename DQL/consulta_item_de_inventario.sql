-- Consulta todo os itens de um iventário específico
SELECT 
    INV.id_inventario,
    INV.qtd_itens,
    II.id_instancia,
    I.nome_item,
    I.descricao,
    I.durabilidade,
    II.nivel_de_gasto,
    I.utilidade,
    I.beneficio
FROM Inventario INV
INNER JOIN Instancia_Item II ON INV.id_inventario = II.id_inventario
INNER JOIN Item I ON II.nome_item = I.nome_item
WHERE INV.id_inventario = 1  -- Substitua pelo ID do inventário
ORDER BY I.nome_item;

-- Consulta quantidade de todos os itens em um inventário
SELECT 
    I.nome_item,
    COUNT(II.nome_item) as quantidade_total,
    I.descricao,
    I.durabilidade
FROM Item I
RIGHT JOIN Instancia_Item II ON I.nome_item = II.nome_item
WHERE II.id_inventario = 1  -- Substitua pelo ID do inventário, se necessário
GROUP BY I.nome_item, I.descricao, I.durabilidade
ORDER BY quantidade_total DESC;

-- Consulta o total de itens em um inventário específico
SELECT 
    INV.id_inventario,
    COUNT(II.id_instancia) as total_itens,
    COUNT(DISTINCT II.nome_item) as tipos_diferentes_itens
FROM Inventario INV
INNER JOIN Instancia_Item II ON INV.id_inventario = II.id_inventario
WHERE INV.id_inventario = 1  -- Substitua pelo ID do inventário
GROUP BY INV.id_inventario;






