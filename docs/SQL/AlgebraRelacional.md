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

- **Consultar todas as informações de um jogador em especifico:**<br>
T ← σ(nome = 'Mauricio')(Jogador)

- **Consultar dados importantes para o jogador:**<br>
T ← σ(nome = 'Mauricio')(Jogador)<br>
R ← π(nome, velocidade, vida, qtded_recurso, qtded_captura, nome_gangue, id_sala)(T)

- **Consultar objetivo da missão do jogador:**<br>
T ← σ(jogador.nome = 'Mauricio')(jogador ⨝ jogador.nome_missao = missao.nome_missao missao)<br>
R ← π(jogador.nome_missao, missao.descricao, missao.status)(T)

- **Consultar objetivo principal do jogador:**<br>
T ← σ(jogador.nome = 'Mauricio')(jogador ⨝ jogador.titulo_objetivo = objetivo_principal.titulo_objetivo objetivo_principal)<br>
R ← π(jogador.titulo_objetivo, objetivo_principal.descricao)(T)

- **Consultar missão do jogador:**<br>
T ← σ(jogador.nome = 'Mauricio')(jogador ⨝ jogador.nome_missao = missao.nome_missao missao)<br>
R ← π(jogador.nome_missao, missao.descricao, missao.status)

- **Consultar informações de um item especifico que esta no inventario:**<br>
T ← σ(jogador.nome = 'Mauricio' ∧ item.nome_item = 'Chave inglesa')((jogador ⨝ jogador.id_inventario = instancia_item.id_inventario instancia_item)⨝ instancia_item.nome_item = item.nome_item item)<br>
R ← π(item.nome_item, item.descricao, item.durabilidade, item.pode_ser_vendido,item.utilidade, item.beneficio, instancia_item.nivel_de_gasto)(T)

- **Consultar itens que estão no inventario:**<br>
T ← σ(jogador.nome = 'Mauricio')((jogador ⨝ jogador.id_inventario = instancia_item.id_inventario instancia_item) ⨝ instancia_item.nome_item = item.nome_item item)<br>
R ← π(item.nome_item)(T)

- **Consultar informações dos itens do inventario:** <br>
T ← σ(jogador.nome = 'Mauricio')((jogador ⨝ jogador.id_inventario = instancia_item.id_inventario instancia_item) ⨝ instancia_item.nome_item = item.nome_item item)<br>
R ← π(item.nome_item, item.descricao, item.durabilidade, item.pode_ser_vendido, item.utilidade, item.beneficio, instancia_item.nivel_de_gasto)(T)

### Prisioneiro

- **Consultar informação de todos os prisioneiros em ordem alfabetica:**<br>
T ← π(*)(prisioneiro) <br>
R ← τ_{nome ASC}(T)

- **Consultar todas as informações de um prisioneiro em especifico:**<br>
T ← σ(nome = 'Michael Scofield')(prisioneiro)

- **Consultar todos os dados dos prisioneiros que estão na sala:**<br>
T ← σ(id_sala = 1)(prisioneiro)

- **Consultar apenas nome e gangue dos prisioneiros que estão na sala:**<br>
T ← σ(id_sala = 1)(prisioneiro)<br>
R ← π(nome, nome_gangue)(T)

- **Consultar todas as gangues que estão na sala:** <br>
T ← σ(id_sala = 1)(prisioneiro)<br>
R ← π(nome_gangue)(T)

- **Consultar onde esta o prisioneiro:**<br>
T ← (prisioneiro ⨝ prisioneiro.id_sala = sala.id_sala sala)<br>
R ← σ(prisioneiro.nome = 'Michael Scofield')(T)<br>
Z ← π(prisioneiro.nome, sala.nome)(R)

- **Consultar localização de todos os prisioneiros em ordem alfabetica:**<br>
T ← π(prisioneiro.nome, sala.nome)(prisioneiro ⨝ prisioneiro.id_sala = sala.id_sala sala)<br>
R ← τ_{prisioneiro.nome ASC}(T)

### Gangue

- **Consultar informação de todas as gangues ordenados por quantidade de membros:**<br>
T ← π(*)(gangue) <br>
R ← τ_{qtdd_membros DESC}(T)

- **Consultar gangues ordenadas pelo mais fortes (maiores recursos):**<br>
T ← π(*)(gangue)<br>
R ← τ_{qtdd_recurso_gangue DESC}(T)

- **Consultar todas as informações de uma gangue em especifico:**<br>
T ← σ(nome_gangue = 'Os Fox River Eight')(gangue)


### Objetivo principal
### Objetivo_Principal_Missao
### Dialogo

### Missão
### Inventário
### Sala

### Instancia-Item
### Loja
### Item-Loja

## 📑 Histórico de versão

| Versão| Data      | Descrição | Autor |
| :-:   | :-:       | :--       | --    |
| `1.0`   | 05/06/2025 |Criação da introdução e metodologia utilizada na Algebra Relacional | [Mayara A. Oliveira](https://github.com/Mayara-tech)  |
| `1.1`   | 11/06/2025 | Adiciona agente_penitenciario, agente_penitenciario_jogador, consulta_personagem e missao_sala| [Maria Alice](https://github.com/Maliz30)  |
| `1.2`   | 13/06/2025 |adicionando algebra relacional jogador, prisioneiro e gangue | [Mayara A. Oliveira](https://github.com/Mayara-tech)  |
