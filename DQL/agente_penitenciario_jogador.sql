-- Exibe todos os agentes penitenciários que capturaram um jogador específico
SELECT APJ.id_personagem_jogador, AP.id_personagem, AP.nome, AP.nivel_de_perigo
FROM agente_penitenciario_jogador AS APJ
JOIN agente_penitenciario AP ON APJ.id_personagem_agente_penitenciario = AP.id_personagem 
WHERE APJ.id_personagem_jogador = 1
ORDER BY AP.nivel_de_perigo DESC

-- Exibe quantas vezes um jogador foi capturado
SELECT id_personagem_jogador, COUNT(*) AS qtdd_capturas
FROM agente_penitenciario_jogador
WHERE id_personagem_jogador = 1
GROUP BY id_personagem_jogador

-- Exibe quantas vezes um jogador foi capturado por um agente específico
SELECT id_personagem_jogador, id_personagem_agente_penitenciario, COUNT(*) AS qtdd_capturas
FROM agente_penitenciario_jogador
WHERE id_personagem_jogador = 1 AND id_personagem_agente_penitenciario = 2
GROUP BY id_personagem_jogador, id_personagem_agente_penitenciario