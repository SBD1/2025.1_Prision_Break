SELECT
    adjacente.id_sala,
	adjacente.nome,
    adjacente.bloqueado,
    CASE
        WHEN adjacente.id_sala = Atual.norte THEN 'Norte'
        WHEN adjacente.id_sala = Atual.sul   THEN 'Sul'
        WHEN adjacente.id_sala = Atual.leste THEN 'Leste'
        WHEN adjacente.id_sala = Atual.oeste THEN 'Oeste'
    END AS direcao
FROM
    Sala AS Atual
JOIN
    Sala AS adjacente ON adjacente.id_sala IN (Atual.norte, Atual.sul, Atual.leste, Atual.oeste)
WHERE
    Atual.id_sala = %s; 