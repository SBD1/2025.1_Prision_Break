SELECT OP.titulo_objetivo, OP.descricao, COUNT(OPM.nome_missao) AS total_missoes
FROM Objetivo_Principal OP
JOIN Objetivo_principal_missao OPM ON OP.titulo_objetivo = OPM.titulo_objetivo
GROUP BY OP.titulo_objetivo, OP.descricao
HAVING COUNT(OPM.nome_missao) > 0;