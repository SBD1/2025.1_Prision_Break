SELECT J.id_personagem, J.nome, J.qtded_recurso, G.nome_gangue AS gangue, J.titulo_objetivo, J.nome_missao
FROM Jogador J
JOIN gangue G ON J.nome_gangue = G.nome_gangue
WHERE J.id_personagem = %s