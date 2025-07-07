CREATE TRIGGER trigger_movimento_jogador
BEFORE UPDATE OF id_sala ON Jogador
FOR EACH ROW
EXECUTE FUNCTION verificar_e_atualizar_captura();