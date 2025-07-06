-- =============================================
-- ATUALIZAÇÕES DA TABELA Gangue
-- =============================================

-- Aumentar quantidade de membros da Gangue
UPDATE Gangue
SET qtdd_membros = qtdd_membros + 1
WHERE nome_gangue = 'Os Fox River Eight';

-- Aumentar quantidade de recursos da Gangue
UPDATE Gangue
SET qtdd_recurso_gangue = qtdd_recurso_gangue + 1
WHERE nome_gangue = 'Os Fox River Eight';

-- =============================================
-- ATUALIZAÇÕES DA TABELA Inventario
-- =============================================

-- Aumentar capacidade do inventário
UPDATE Inventario 
SET qtd_itens = 25, is_full = TRUE
WHERE id_inventario = 101;

-- =============================================
-- ATUALIZAÇÕES DA TABELA Sala
-- =============================================

-- Liberar o acesso à enfermaria
UPDATE Sala 
SET bloqueado = FALSE
WHERE id_sala = 3;

-- =============================================
-- ATUALIZAÇÕES DA TABELA Missao
-- =============================================

-- Atualiza o status de missões concluídas
UPDATE Missao
SET status = true
WHERE nome_missao IN ('Arquivos da Sona', 'Rota Segura');

-- Corrige a descrição de uma missão
UPDATE Missao
SET descricao = 'Construir um túnel secreto que leve para fora dos muros da prisão, usando ferramentas improvisadas'
WHERE nome_missao = 'Túnel da Liberdade';

-- =============================================
-- ATUALIZAÇÕES DA TABELA Item
-- =============================================

-- Altera a durabilidade de um item
UPDATE Item 
SET durabilidade = 120 
WHERE nome_item = 'Chave Inglesa';

-- =============================================
-- ATUALIZAÇÕES DA TABELA Instancia_Item
-- =============================================

-- Altera o nível de gasto de um item
UPDATE Instancia_Item
SET nivel_de_gasto = 20 
WHERE id_instancia = 1;

-- =============================================
-- ATUALIZAÇÕES DA TABELA Item_Loja
-- =============================================

-- Altera a gangue que está vendendo o item
UPDATE Item_Loja 
SET nome_gangue = 'Os Renovados' 
WHERE id_compra = 1;

-- =============================================
-- ATUALIZAÇÕES DA TABELA Loja
-- =============================================

-- Altera o preço de um item
UPDATE Loja 
SET preco = 180.00 
WHERE nome_gangue = 'Os Fugitivos' AND nome_item = 'Chave Inglesa';

-- =============================================
-- ATUALIZAÇÕES DA TABELA Jogador
-- =============================================

-- Atributos básicos
UPDATE Jogador
SET 
    velocidade = 8,
    vida = vida + 25,
    qtded_recurso = qtded_recurso + 1,
    qtded_captura = qtded_captura + 1
WHERE id_personagem = 1;

-- Alterar localização
UPDATE Jogador
SET id_sala = 2
WHERE id_personagem = 1;

-- Alterar afiliação a gangue
UPDATE Jogador
SET nome_gangue = 'Os Fox River Eight'
WHERE id_personagem = 1;

-- Desvincular de gangue
UPDATE Jogador
SET nome_gangue = NULL
WHERE nome_gangue = 'Os Fox River Eight';

-- =============================================
-- ATUALIZAÇÕES DA TABELA Agente_Penitenciario
-- =============================================

-- Aumenta atributos
UPDATE agente_penitenciario
SET 
    velocidade = 6, 
    nivel_de_alerta = 10
WHERE id_personagem = 6;

-- Diminui atributos
UPDATE agente_penitenciario
SET 
    velocidade = 5, 
    nivel_de_alerta = 5
WHERE id_personagem = 6;

-- Configuração de nível difícil
UPDATE agente_penitenciario
SET 
    velocidade = 10, 
    nivel_de_perigo = 10, 
    nivel_de_alerta = 10
WHERE id_personagem = 6;

-- =============================================
-- ATUALIZAÇÕES DA TABELA Prisioneiro
-- =============================================

-- Aumentar velocidade
UPDATE Prisioneiro
SET velocidade = 10
WHERE id_personagem = 8;

-- Alterar sala aleatoriamente
UPDATE Prisioneiro
SET id_sala = (
    SELECT id_sala FROM Sala ORDER BY RANDOM() LIMIT 1
)
WHERE id_personagem = 8;

-- Desvincular de gangue
UPDATE Prisioneiro
SET nome_gangue = NULL
WHERE nome_gangue = 'Os Fox River Eight';

-- =============================================
-- ATUALIZAÇÕES DA TABELA Dialogo
-- =============================================

-- Alterar texto de diálogo
UPDATE Dialogo
SET texto = 'Lincoln eu te prometo que iremos sair daqu'
WHERE id_dialogo = 1;

-- =============================================
-- ATUALIZAÇÕES DA TABELA Objetivo_Principal
-- =============================================

-- Modificar descrição de objetivo
UPDATE Objetivo_Principal
SET descricao = 'Provar a inocência e libertar seu irmão Lincoln Burrows da prisão, evitando sua execução'
WHERE titulo_objetivo = 'Libertar Lincoln';

-- =============================================
-- ATUALIZAÇÕES DA TABELA Missao_Sala
-- =============================================

-- Alterar missão associada a uma sala
UPDATE Missao_Sala
SET nome_missao = 'Fuga de Fox River'
WHERE id_sala = 1;

-- =============================================
-- NOVOS UPDATES PARA O SISTEMA DE LOJA 
-- =============================================

-- Atualizar inventário após compra (exemplo)
UPDATE Instancia_Item
SET id_inventario = 100  -- Inventário do jogador
WHERE id_instancia = 4;  -- ID do item comprado

-- Atualizar recursos após compra/venda (exemplo)
UPDATE Jogador
SET qtded_recurso = qtded_recurso - 150  -- Compra
WHERE id_personagem = 1;

UPDATE Jogador
SET qtded_recurso = qtded_recurso + 80   -- Venda
WHERE id_personagem = 1;