-- sql_queries/listar_inventario_jogador.sql
SELECT 
    i.id_instancia_item,
    it.nome AS item,
    it.pode_vender
FROM Instancia_Item i
JOIN Item it ON i.id_item = it.id_item
WHERE i.id_personagem = %s
ORDER BY it.nome;