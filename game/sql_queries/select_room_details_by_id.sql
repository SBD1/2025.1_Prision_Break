SELECT
    id_sala,
    nome,
    descricao,
    nivel_perigo,
    bloqueado
FROM
    Sala
WHERE
    id_sala = %s;