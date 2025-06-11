-- Exemplo de DELETE usando o id de cada tabela


DELETE FROM Objetivo_Principal_Missao 
WHERE titulo_objetivo = 'Provar lealdade' AND nome_missao = 'Missão de Confiança';


DELETE FROM Dialogo
WHERE id_dialogo = 3;


DELETE FROM Instancia_Item 
WHERE id_instancia = 1;


DELETE FROM Missao_Sala 
WHERE nome_missao = 'Rota Segura' AND id_sala = 3;


DELETE FROM Item_Loja 
WHERE id_compra = 1;


DELETE FROM Loja 
WHERE nome_gangue = 'Os Fugitivos' AND nome_item = 'Chave Inglesa';


DELETE FROM agente_penitenciario_jogador 
WHERE id_personagem_agente_penitenciario = 6;


DELETE FROM Jogador
WHERE id_personagem = 1;


DELETE FROM agente_penitenciario 
WHERE id_personagem = 6;


DELETE FROM Prisioneiro
WHERE id_personagem = 8;


DELETE FROM consulta_personagem 
WHERE id_personagem = 6;


DELETE FROM Item 
WHERE nome_item = 'Chave Inglesa';


-- Remover sala de id = 1 (Detenção)
DELETE FROM Sala
WHERE id_sala = 1;


DELETE FROM Missao
WHERE noma_missao = 'Aliança Perigosa';


DELETE FROM Objetivo_Principal
WHERE titulo_objetivo = 'Distrair guardas';


-- Deleta o inventário de id = 102 (Ele não deve estar associado a nenhuma sala)
DELETE FROM Inventario
WHERE id_inventario = 102;

-- Deleta gangue nao deve ter nenhum personagem associado a esta gangue
DELETE FROM Gangue
WHERE nome_gangue = 'Os Fox River Eight';