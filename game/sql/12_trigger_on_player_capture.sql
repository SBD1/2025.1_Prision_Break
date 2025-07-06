CREATE TRIGGER trigger_player_capture
AFTER UPDATE OF qtded_captura ON Jogador
FOR EACH ROW
EXECUTE FUNCTION handle_player_capture();