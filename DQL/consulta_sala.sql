-- Retorna todas as informações das salas
SELECT
    id_sala,
    id_inventario,
    nome,
    descricao,
    nivel_perigo,
    bloqueado
FROM
    Sala;

-- Apenas as Salas que Não Estão Bloqueadas
SELECT
    id_sala,
    id_inventario,
    nome,
    descricao,
    nivel_perigo,
    bloqueado
FROM
    Sala
WHERE
    bloqueado = FALSE;

-- Apenas a Sala que um personagem Está Presente (Sala por ID do personagem)
SELECT
    S.id_sala,
    S.nome AS nome_sala,
    S.descricao AS descricao_sala,
    S.nivel_perigo,
    S.bloqueado,
    J.nome AS nome_jogador
FROM
    Sala AS S
JOIN
    Jogador AS J ON S.id_sala = J.id_sala
WHERE
    J.id_personagem = 1; -- Substitua '1' pelo ID desejado