-- Consultar informação de todas as gangues ordenados por quantidade de membros
SELECT *
FROM gangue
ORDER BY qtdd_membros DESC;

-- Consultar gangues ordenadas pelo mais fortes (maiores recursos)
SELECT *
FROM gangue
ORDER BY qtdd_recurso_gangue DESC;

-- Consultar todas as informações de uma gangue em especifico
SELECT *
FROM gangue
Where nome_gangue = 'Os Fox River Eight' ;