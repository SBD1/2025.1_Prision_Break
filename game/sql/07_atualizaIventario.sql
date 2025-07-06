-- Trigger para atualizar qtd_itens e is_full no Inventario após INSERÇÃO em Instancia_Item
CREATE OR REPLACE FUNCTION trg_atualizar_inventario_insert()
RETURNS TRIGGER AS $$
DECLARE
    v_qtd_max_itens INT := 10; -- Capacidade máxima do inventário
BEGIN
    UPDATE Inventario
    SET
        qtd_itens = qtd_itens + 1,
        is_full = CASE WHEN (qtd_itens + 1) >= v_qtd_max_itens THEN TRUE ELSE FALSE END
    WHERE id_inventario = NEW.id_inventario;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_instancia_item_insert
AFTER INSERT ON Instancia_Item
FOR EACH ROW
EXECUTE FUNCTION trg_atualizar_inventario_insert();

-- Trigger para atualizar qtd_itens e is_full no Inventario após DELEÇÃO em Instancia_Item
CREATE OR REPLACE FUNCTION trg_atualizar_inventario_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Inventario
    SET
        qtd_itens = qtd_itens - 1,
        is_full = FALSE -- Se um item foi removido, o inventário não está mais cheio
    WHERE id_inventario = OLD.id_inventario;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_instancia_item_delete
AFTER DELETE ON Instancia_Item
FOR EACH ROW
EXECUTE FUNCTION trg_atualizar_inventario_delete();