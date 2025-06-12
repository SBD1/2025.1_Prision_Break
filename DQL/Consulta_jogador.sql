-- Consultar todas as informações de um prisioneiro em especifico
SELECT *
FROM Jogador
Where nome= 'Mauricio' ;

-- Consultar dados importantes para o jogador
SELECT nome, velocidade, vida, qtded_recurso, qtded_captura, nome_item, id_sala
FROM Jogador
Where nome= 'Mauricio' ;

-- Consultar informações dos itens do inventario 
SELECT 
    item.nome_item,
    item.descricao,
    item.durabilidade,
    item.pode_ser_vendido,
    item.utilidade,
    item.beneficio,
    instancia_item.nivel_de_gasto
FROM jogador 
JOIN instancia_item  ON jogador.id_inventario = instancia_item.id_inventario
JOIN item ON instancia_item.nome_item = item.nome_item
WHERE jogador.nome = 'Mauricio';

-- Consultar itens que estão no inventario
SELECT 
    item.nome_item
FROM jogador 
JOIN instancia_item  ON jogador.id_inventario = instancia_item.id_inventario
JOIN item ON instancia_item.nome_item = item.nome_item
WHERE jogador.nome = 'Mauricio';

-- Consultar informações de um item especifico que esta no inventario
SELECT 
    item.nome_item,
    item.descricao,
    item.durabilidade,
    item.pode_ser_vendido,
    item.utilidade,
    item.beneficio,
    instancia_item.nivel_de_gasto
FROM jogador 
JOIN instancia_item  ON jogador.id_inventario = instancia_item.id_inventario
JOIN item ON instancia_item.nome_item = item.nome_item
WHERE jogador.nome = 'Mauricio'
	 AND item.nome_item = 'Chave inglesa';

-- Consultar missão do jogador
SELECT 
    jogador.nome_missao,
    missao.descricao,
    missao.status
FROM jogador 
JOIN missao ON jogador.nome_missao = missao.nome_missao
WHERE jogador.nome = 'Mauricio';

-- Consultar objetivo principal do jogador
SELECT 
    jogador.titulo_objetivo,
    objetivo_principal.descricao
FROM jogador
JOIN objetivo_principal ON jogador.titulo_objetivo = objetivo_principal.titulo_objetivo
WHERE jogador.nome = 'Mauricio';

-- Consultar objetivo da missão
SELECT 
    jogador.nome_missao,
    opm.titulo_objetivo,
    o.descricao
FROM jogador 
JOIN objetivo_principal_missao opm ON jogador.nome_missao = opm.nome_missao
JOIN objetivo_principal o ON opm.titulo_objetivo = o.titulo_objetivo
WHERE jogador.nome = 'Mauricio';