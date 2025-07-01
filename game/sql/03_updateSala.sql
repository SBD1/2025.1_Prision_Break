UPDATE Sala      -- Cela do Jogador             --Deixar dinâmico, de acordo com a escolha da gangue
SET sul = 5
WHERE id_sala = 1; 

UPDATE Sala         -- Cela do Irmão
SET sul = 24
WHERE id_sala = 2; 

UPDATE Sala         -- Bloco A
SET sul = 25
WHERE id_sala = 3; 

UPDATE Sala         -- Bloco B  
SET sul = 26
WHERE id_sala = 4; 

UPDATE Sala         -- Bloco C
SET norte = 1, sul = 27
WHERE id_sala = 5; 

UPDATE Sala         -- Bloco D
SET sul = 28
WHERE id_sala = 6; 

UPDATE Sala         -- Bloco E
SET sul = 29
WHERE id_sala = 7; 

UPDATE Sala         -- Solitária
SET sul = 31
WHERE id_sala = 8;

UPDATE Sala         -- Banheiro
SET norte = 24, sul = 32
WHERE id_sala = 9; 

UPDATE Sala         -- Biblioteca
SET sul = 33
WHERE id_sala = 10;

UPDATE Sala         -- Patio Principal
SET norte = 27, sul = 34, leste = 33, oeste = 32
WHERE id_sala = 11; 

UPDATE Sala         -- Cozinha
SET leste = 13
WHERE id_sala = 12; 

UPDATE Sala         -- Refeitório
SET norte = 32, oeste = 12
WHERE id_sala = 13; 

UPDATE Sala         -- Enfermaria
SET norte = 33, leste = 15
WHERE id_sala = 14; 

UPDATE Sala         -- Telhado da Enfermaria
SET leste = 21, oeste = 14
WHERE id_sala = 15; 

UPDATE Sala         -- Copa dos Policiais
SET sul = 19, leste = 35
WHERE id_sala = 16; 

UPDATE Sala         -- Recepção
SET norte = 34, sul = 20, leste = 18, oeste = 35
WHERE id_sala = 17; 

UPDATE Sala         -- Diretoria
SET oeste = 17
WHERE id_sala = 18; 

UPDATE Sala         -- Sala das cameras
SET norte = 16
WHERE id_sala = 19; 

UPDATE Sala         -- Entrada
SET norte = 17, sul = 22
WHERE id_sala = 20; 

UPDATE Sala         -- Área externa leste
SET oeste = 15
WHERE id_sala = 21; 

UPDATE Sala         -- Área externa sul
SET norte = 20
WHERE id_sala = 22; 

UPDATE Sala         -- Oficina
SET leste = 32
WHERE id_sala = 23; 

UPDATE Sala         -- Corredor da Cela do Irmão
SET norte = 2, sul = 9, leste = 25
WHERE id_sala = 24; 

UPDATE Sala         -- Corredor do Bloco A
SET norte = 3, leste = 26, oeste = 24
WHERE id_sala = 25; 

UPDATE Sala         -- Corredor do Bloco B
SET norte = 4, leste = 27, oeste = 25
WHERE id_sala = 26; 

UPDATE Sala         -- Corredor da Ala Norte
SET norte = 5, sul = 11,leste = 28, oeste = 26
WHERE id_sala = 27; 

UPDATE Sala         -- Corredor do Bloco D
SET norte = 6, leste = 29, oeste = 27
WHERE id_sala = 28; 

UPDATE Sala         -- Corredor do Bloco E
SET norte = 7, leste = 30, oeste = 28
WHERE id_sala = 29; 

UPDATE Sala         -- Corredor longo
SET leste = 31, oeste = 29
WHERE id_sala = 30; 

UPDATE Sala         -- Corredor da Solitária
SET norte = 8, oeste = 30
WHERE id_sala = 31; 

UPDATE Sala         -- Corredor da Ala Oeste
SET norte = 9, sul = 13, leste = 11, oeste = 23
WHERE id_sala = 32; 

UPDATE Sala         -- Corredor da Ala Leste
SET norte = 10, sul = 14, oeste = 11
WHERE id_sala = 33; 

UPDATE Sala         -- Corredor da Ala Sul
SET norte = 11, sul = 17
WHERE id_sala = 34; 

UPDATE Sala         -- Corredor dos guardas
SET leste = 17, oeste = 16
WHERE id_sala = 35; 

