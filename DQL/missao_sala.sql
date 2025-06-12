-- Exibe todas as salas que uma missão desbloqueia
SELECT *
FROM missao_sala
WHERE nome_missao = 'Rota Segura'

-- Exibe as missões necessárias para desbloquear uma sala
SELECT nome_missao
FROM missao_sala
WHERE id_sala = 3