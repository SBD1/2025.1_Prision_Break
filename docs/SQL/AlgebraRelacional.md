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

- **Retorna todas as informações de uma missão** <br>
R ← σ(nome_missao = ’Fuga’)(Missao) <br>
T ← π(nome_missao, descricao, status)(R) <br>

- **Retorna todas as missões desbloqueadas** <br>
R ← σ(status = TRUE)(Missao) <br>
T ← π(nome_missao, descricao, status)(R) <br>

- **Retorna todas as missões bloqueadas** <br>
R ← σ(status = FALSE)(Missao)<br>
T ← π(nome_missao, descricao, status)(R)<br>

### Inventário

- **Retorna todas as informações do inventário** <br>
T ← π(id_inventario, qtd_itens, is_full)(Inventario) <br>

- **Apenas os Inventários Cheios** <br>
R ← (σ (is_full = TRUE)(Inventario)) <br>
T ← π (id_inventario, qtd_itens, is_full)(R) <br>

- **Apenas os Inventários que Não Estão Cheios** <br>
R ← σ(is_full = FALSE)(Inventario) <br>
T ← π(id_inventario, qtd_itens, is_full)(R) <br>

### Sala

- **Inventário de uma Sala Específica** <br>
R ← σ(S.id_sala = 1)(Inventario⋈I.id_inventario = S.id_inventario Sala)
T ← π(I.id_inventario, I.qtd_itens, I.is_full)(R) <br>

- **Retorna todas as informações das salas** <br>
T ← π(id_sala, id_inventario, nome, descricao, nivel_perigo, bloqueado)(Sala) <br>

- **Apenas as Salas que Não Estão Bloqueadas** <br>
R ← σ(bloqueado = FALSE)(Sala) <br>
T ← π(id_sala, id_inventario, nome, descricao, nivel_perigo, bloqueado)(R) <br>

- **Apenas a Sala que um personagem Está Presente** <br>
R ← σ(J.id_personagem = 1)(Sala⋈S.id_sala = J.id_sala)(Jogador) <br>
T ← π(S.id_sala, S.nome, S.descricao, S.nivel_perigo, S.bloqueado, J.nome)(R) <br>

### Instancia-Item
### Loja
### Item-Loja

## 📑 Histórico de versão

| Versão| Data      | Descrição | Autor |
| :-:   | :-:       | :--       | --    |
| `1.0`   | 05/06/2025 |Criação da introdução e metodologia utilizada na Algebra Relacional | [Mayara A. Oliveira](https://github.com/Mayara-tech)  |
| `1.1`   | 11/06/2025 | Adiciona agente_penitenciario, agente_penitenciario_jogador, consulta_personagem e missao_sala| [Maria Alice](https://github.com/Maliz30)  |
