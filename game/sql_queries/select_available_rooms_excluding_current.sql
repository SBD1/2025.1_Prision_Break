SELECT id_sala, nome, descricao FROM Sala
WHERE bloqueado = FALSE AND id_sala != %s;