# Algebra Relacional

## Introdução 

A Álgebra Relacional é um modelo teórico e formal de manipulação de dados em bancos de dados relacionais. Ela define um conjunto de operações matemáticas aplicadas a relações (tabelas), permitindo a criação de novas relações a partir de dados existentes. Essas operações incluem seleção (σ), projeção (π), união (∪), diferença (-), produto cartesiano (×), junção (⨝), entre outras.

Ao contrário da SQL, que é uma linguagem prática e implementável, a Álgebra Relacional oferece uma base teórica que permite analisar, validar e prever os resultados de consultas e manipulações de forma precisa e lógica

## Metodologia

A aplicação da Álgebra Relacional neste projeto foi realizada com base na estrutura conceitual do banco de dados relacional desenvolvido previamente, a partir do modelo Entidade-Relacionamento. As operações foram construídas em notação algébrica, simulando a execução de consultas sobre as tabelas do jogo, como Jogador, Prisioneiro, Gangue, Sala e Missao.

Foram utilizadas operações fundamentais como seleção (σ) para aplicar filtros, projeção (π) para escolher colunas específicas, e junção natural (⨝) para unir informações relacionadas entre diferentes tabelas. 

## Álgebra Relacional por tabela

### Consulta_Personagem

- **Lista todos os personagens cadastrados:** <br>
T ← π(*)(consulta_personagem)

- **Exibe o tipo de um personagem específico:** <br>
R ← σ(id_personagem = 5)(consulta_personagem)   <br>
T ← π(tipo_personagem)(R)

### Agente_Penitenciario

- **Consulta todas as informações de um agente penitenciário:** <br>
T ← σ(id_personagem = 2)(agente_penitenciario)

- **Verifica se um policial específico é corrupto e qual o seu preço:** <br>
R ← σ(id_personagem = 2)(agente_penitenciario)   <br>
T ← π(corrupto, preco)(R) 

- **Exibe os agentes penitenciários que estão na sala, ordenados pelo seu nível de perigo:** <br>
R ← σ(id_sala = 2)(agente_penitenciario)   <br>
T ← π(id_personagem, id_sala, nome, velocidade, nivel_de_perigo, nivel_de_alerta, cargo)(R)

- **Exibe a quantidade de agentes na sala:** <br>
R ← σ(id_sala = 2)(agente_penitenciario)   <br>
S ← γ(id_sala, COUNT(∗) → agentes_na_sala(R)) <br>
T ← π(id_sala, agentes_na_sala)(S)

- **Exibe os agentes penitenciarios e as informações referentes as salas em que eles estão:** <br>
AP ← ρ AP(nome → nome_agente) (agente_penitenciario) <br>
S ← ρ S(nome → nome_sala, nivel_perigo → nivel_perigo_sala) (sala) <br><br>
R ← AP ⨝ (AP.id_sala = S.id_sala) S <br>
T ← π(AP.id_personagem, nome_agente, S.id_sala, nome_sala, nivel_perigo_sala)(R)


### Agente_Penitenciario_Jogador

- **Exibe todos os agentes penitenciários que capturaram um jogador específico:** <br>
APJ ← ρ APJ(agente_penitenciario_jogador) <br>
AP ← ρ AP(agente_penitenciario) <br><br>
W ← APJ ⨝ (APJ.id_personagem_agente_penitenciario = AP.id_personagem) AP <br>
T ← σ(APJ.id_personagem_jogador = 1) W

- **Exibe quantas vezes um jogador foi capturado:** <br>
R ← σ(id_personagem_jogador = 1)(agente_penitenciario_jogador) <br>
S ← γ(id_personagem_jogador, COUNT(∗) → qtdd_capturas(R)) <br>
T ← π(id_personagem_jogador, qtdd_capturas)(S)

- **Exibe quantas vezes um jogador foi capturado por um agente específico:** <br>
R ← σ(id_personagem_jogador = 1 AND id_personagem_agente_penitenciario = 2)(agente_penitenciario_jogador) <br>
S ← γ(id_personagem_jogador, id_personagem_agente_penitenciario, COUNT(∗) → qtdd_capturas(R)) <br>
T ← π(id_personagem_jogador, id_personagem_agente_penitenciario, qtdd_capturas)(S)


### Missao_Sala

- **Exibe todas as salas que uma missão desbloqueia:** <br>
T ← σ(nome_missao = 'Rota Segura')(missao_sala) <br>

- **Exibe as missões necessárias para desbloquear uma sala:** <br>
R ← σ(id_sala = 3)(missao_sala) <br>
T ← π(nome_missao)(R)

### Jogador
### Prisioneiro
### Gangue

### Objetivo principal
### Objetivo_Principal_Missao
### Dialogo

### Missão
### Inventário
### Sala

### Item_Iventario

- **Exibe todos os itens e suas informações de um inventário específico:** <br>
INV ← ρ INV(Inventario) <br>
II ← ρ II(Instancia_Item) <br>
I ← ρ I(Item) <br>
R ← INV ⨝ (INV.id_inventario = II.id_inventario) II <br>
S ← R ⨝ (II.nome_item = I.nome_item) I <br>
W ← σ(INV.id_inventario = 1)(S) <br>
T ← π(INV.id_inventario, INV.qtd_itens, II.id_instancia, I.nome_item, I.descricao, I.durabilidade, II.nivel_de_gasto, I.utilidade, I.beneficio)(W)

- **Exibe a quantidade total de cada item em um inventário específico:** <br>
I ← ρ I(Item) <br>
II ← ρ II(Instancia_Item) <br>
R ← II ⨝ (II.nome_item = I.nome_item) I <br>
S ← σ(II.id_inventario = 1)(R) <br>
T ← γ(I.nome_item, I.descricao, I.durabilidade, COUNT(II.nome_item) → quantidade_total)(S)

- **Exibe o total de itens e tipos diferentes em um inventário específico:** <br>
INV ← ρ INV(Inventario) <br>
II ← ρ II(Instancia_Item) <br>
R ← INV ⨝ (INV.id_inventario = II.id_inventario) II <br>
S ← σ(INV.id_inventario = 1)(R) <br>
T ← γ(INV.id_inventario, COUNT(II.id_instancia) → total_itens, COUNT(DISTINCT II.nome_item) → tipos_diferentes_itens)(S)


### Item

- **Exibe todas as gangues que vendem um item específico:** <br>
I ← ρ I(Item) <br>
IL ← ρ IL(Item_Loja) <br>
L ← ρ L(Loja) <br>
R ← I ⨝ (I.nome_item = IL.nome_item) IL <br>
S ← R ⨝ (IL.nome_gangue = L.nome_gangue) L <br>
W ← σ(I.nome_item = 'Chave Inglesa')(S) <br>
T ← π(I.nome_item, IL.nome_gangue)(W)

- **Exibe todos os inventários que possuem um item específico:** <br>
I ← ρ I(Item) <br>
II ← ρ II(Instancia_Item) <br>
INV ← ρ INV(Inventario) <br>
R ← I ⨝ (I.nome_item = II.nome_item) II <br>
S ← R ⨝ (II.id_inventario = INV.id_inventario) INV <br>
W ← σ(I.nome_item = 'Chave Inglesa')(S) <br>
T ← π(I.nome_item, INV.id_inventario)(W)


### Loja

- **Exibe todos os itens e suas informações de uma gangue específica:** <br>
L ← ρ L(Loja) <br>
IL ← ρ IL(Item_Loja) <br>
I ← ρ I(Item) <br><br>
R ← L ⨝ (L.nome_gangue = IL.nome_gangue) IL <br>
S ← R ⨝ (IL.nome_item = I.nome_item) I <br>
W ← σ(L.nome_gangue = 'Nome da Gangue')(S) <br>
T ← π(L.nome_gangue, L.nome_item, I.descricao, L.preco, I.durabilidade, I.utilidade, I.beneficio)(W)

- **Exibe o total de itens e valor total dos itens de uma gangue específica:** <br>
L ← ρ L(Loja) <br>
IL ← ρ IL(Item_Loja) <br>
R ← L ⨝ (L.nome_gangue = IL.nome_gangue) IL <br>
S ← σ(L.nome_gangue = 'Nome da Gangue')(R) <br>
T ← γ(L.nome_gangue, COUNT(L.nome_item) → total_itens, SUM(L.preco) → valor_total)(S)

- **Exibe a quantidade e valor total de cada item em uma loja de uma gangue específica:** <br>
L ← ρ L(Loja) <br>
IL ← ρ IL(Item_Loja) <br>
R ← L ⨝ (L.nome_gangue = IL.nome_gangue AND L.nome_item = IL.nome_item) IL <br>
S ← σ(L.nome_gangue = 'Nome da Gangue')(R) <br>
T ← γ(L.nome_item, L.preco, COUNT(L.nome_item) → quantidade_item, SUM(L.preco) → valor_total_item)(S)


## 📑 Histórico de versão

| Versão| Data      | Descrição | Autor |
| :-:   | :-:       | :--       | --    |
| `1.0`   | 05/06/2025 |Criação da introdução e metodologia utilizada na Algebra Relacional | [Mayara A. Oliveira](https://github.com/Mayara-tech)  |
| `1.1`   | 11/06/2025 | Adiciona agente_penitenciario, agente_penitenciario_jogador, consulta_personagem e missao_sala| [Maria Alice](https://github.com/Maliz30)  |
