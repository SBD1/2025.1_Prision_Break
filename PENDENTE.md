Documentação:
- Corrigir texto "durabilidade	Quantidade de vezes que essa instância já foi utilizada/gasta" no dicionário de dados, tabela Item


Ordem de criação das tabelas:
- Gangue
- Inventario
- Sala
- Item

- Objetivo_principal 
- Missao 
- Dialogo
- Consulta_Personagem
- Prisioneiro 
- Agente_Penitenciario
- Jogador 
- Agente_Penitenciario_Jogador
- Loja 
- Item_Loja 
- Missao_Sala
- Instancia_Item 


______________________________________________________________________
Consultas:

Consulta_Personagem:
    Receber o id criar tupla
    Consultar tipo do personagem

Agente_Penitenciario:
    Consultar todas as informações de um policial específico
    Consultar agentes que estão na sala
    Se é corrupto e o preço

Agente_Penitenciario_Jogador:
    Contagem de quantas vezes o policial prendeu o Jogador

Jogador
    Receber todos os dados de um determinado Jogador:
        nome
        velocidade
        vida
        qtdd-recurso
        qtdd-captura
        nome-gangue
        id-sala
    Consultar inventario
    Consultar missão
    Consultar objetivo

Prisioneiro:
    Consultar todas as informações:
        nome
        velocidade
        vida
        crime
        nome-gangue
        id-sala
    Consultar Prisioneiros que estão na sala
    Consultar Gangues que estão na sala

Gangue:
    Consultar todas as informações da gangue

Objetivo principal:
    Consultar todas as informações do objetivo

Objetivo_Principal_Missao:
    Listar todas as missões do objetivo principal

Dialogo:
    Consultar texto e ordem

missão
    Consultar todos os dados

Inventário
    Consultar todos os dados

sala
    Consultar todos os dados
    Consultar inventario da sala
    Consultar todas as missões necessárias para desbloquear uma sala (Missao_Sala)

Instancia-Item
    Consultar todos os itens de um inventário específico
    Consultar todos os dados do Item (Item)

Loja:
    Consultar todos os dados
    Consultar todos os dados de uma gangue específica
    Consultar todos os dados do Item (Item)

Item-Loja
    Consultar todos os dados
    Consultar todos os dados com detalhes do item


______________________________________________________________________
Prontas:

Consulta_Personagem
Agente_Penitenciario
Agente_Penitenciario_Jogador
Missao_Sala

_______________________________________________________________________
Pendentes:

Jogador
Prisioneiro
Gangue

Objetivo principal
Objetivo_Principal_Missao
Dialogo

missão
Inventário
sala

Instancia-Item
Loja
Item-Loja