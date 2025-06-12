-- Consulta todas as informações de um agente penitenciário
SELECT * 
FROM agente_penitenciario
WHERE id_personagem = 2

-- Verifica se um policial específico é corrupto e qual o seu preço
SELECT corrupto, preco
FROM agente_penitenciario
WHERE id_personagem = 2

-- Exibe os agentes penitenciários que estão na sala, ordenados pelo seu nível de perigo
SELECT id_personagem, id_sala, nome, velocidade, nivel_de_perigo, nivel_de_alerta, cargo
FROM agente_penitenciario
WHERE id_sala = 2
ORDER BY nivel_de_perigo DESC

-- Exibe a quantidade de agentes na sala
SELECT id_sala, COUNT(*) AS agentes_na_sala
FROM agente_penitenciario
WHERE id_sala = 2
GROUP BY id_sala 

-- Exibe os agentes penitenciarios e as informações referentes as salas em que eles estão
SELECT AP.id_personagem, AP.nome AS nome_agente, S.id_sala, S.nome AS nome_sala, S.nivel_perigo AS nivel_perigo_sala 
FROM agente_penitenciario AP
JOIN sala S ON AP.id_sala = S.id_sala
ORDER BY S.id_sala ASC
