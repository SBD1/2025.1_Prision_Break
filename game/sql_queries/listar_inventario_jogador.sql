-- sql_queries/listar_inventario_jogador.sql
SELECT
    ii.id_instancia,         -- Correção: usar 'id_instancia' em vez de 'id_instancia_item'
    it.nome_item AS item,    -- Correção: usar 'nome_item' da tabela Item e renomear para 'item'
    it.pode_ser_vendido      -- Correção: usar 'pode_ser_vendido' da tabela Item
FROM Instancia_Item ii
JOIN Item it ON ii.nome_item = it.nome_item    -- Correção: JOIN usando 'nome_item' em ambas as tabelas
JOIN Inventario inv ON ii.id_inventario = inv.id_inventario -- Adição: JOIN com Inventario
JOIN Jogador j ON inv.id_inventario = j.id_inventario       -- Adição: JOIN com Jogador para filtrar por id_personagem
WHERE j.id_personagem = %s
ORDER BY it.nome_item;