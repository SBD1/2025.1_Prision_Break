## Introdução 

O dicionário de dados é um recurso fundamental para documentar de forma precisa os elementos que compõem um conjunto de dados dentro de um projeto ou sistema. Ele reúne nomes, atributos e descrições que ajudam a compreender o conteúdo, o uso e a estrutura dos dados envolvidos.

Seu principal objetivo é esclarecer o significado de cada variável presente em uma planilha ou banco de dados, indicando, por exemplo, o nome exato da variável, uma versão abreviada mais amigável, os valores permitidos ou esperados, além de descrições que contextualizam seu papel no sistema.

## Metodologia 

A construção do dicionário de dados seguiu os seguintes passos:

- Levantamento e listagem de todos os elementos de dados utilizados utilizando Miro e Lucidchart.
- Definição clara do propósito e do uso de cada elemento dentro do contexto do projeto.
- Especificação do tipo de dado e tamanho correspondente, especialmente para colunas de tabelas.
- Indicação de restrições aplicáveis, como a definição de chaves primárias, chaves estrangeiras ou outras regras de integridade.

## Dicionário de Dados

### Tabela: `ConsultaPersonagem`

**Descrição:** Tabela que armazena o id de todos os personagens para que seja possível consultar de qual tipo o personagem é.

| Nome            | Descrição                                                                                           | Tipo de dado | Tamanho | Restrições de domínio |
| --------------- | --------------------------------------------------------------------------------------------------- | ------------ | ------- | --------------------- |
| id-personagem   | Identificador único do personagem                                                                   | int          |         | FK                    |
| tipo-personagem | Tipo que descreve em qual tabela estão os dados específicos do personagem. Pode ser "AP", "J" e "P" | varchar      | 4       | Not Null              |


### Tabela: `AgentePenitenciario`

**Descrição:** Tabela que armazena todos os personagens do tipo "AP", ou seja, agentes penitenciários.

| Nome            | Descrição                                                                              | Tipo de dado | Tamanho | Restrições de domínio |
| --------------- | -------------------------------------------------------------------------------------- | ------------ | ------- | --------------------- |
| id-personagem   | Identificador único do Agente Penitenciário                                            | int          |         | PK                    |
| id-sala         | Identificador da sala onde o personagem se encontra atualmente                         | int          |         | FK                    |
| nome            | Nome do personagem                                                                     | varchar      | 50      | Default               |
| velocidade      | Velocidade máxima do personagem                                                        | int          |         | Default               |
| nivel-de-perigo | Intervalo de 0 a 10 que indica o quão durão é o agente penitenciário                   | int          |         |                       |
| nivel-de-alerta | Intervalo de 0 a 10 que representa o nível de alerta e atenção do agente penitenciário | int          |         | Default               |
| corrupto        | Valor booleano que classifica um agente penitenciário como corrupto ou não             | boolean      |         |                       |
| preco           | Preço que o policial cobra por vantagens na prisão                                     | int          |         | Default               |
| cargo           | Cargo que o agente penitenciário possui dentro da prisão                               | varchar      | 255     | Default               |


### Tabela: `Jogador`

**Descrição:** Tabela que armazena o personagem do tipo "J", ou seja, o jogador.

| Nome            | Descrição                                                                   | Tipo de dado | Tamanho | Restrições de domínio |
| --------------- | --------------------------------------------------------------------------- | ------------ | ------- | --------------------- |
| id-personagem   | Identificador único do jogador                                              | int          |         | FK                    |
| id-sala         | Identificador da sala onde o personagem se encontra atualmente              | int          |         | FK                    |
| id-inventario   | Identificador único do inventário pessoal                                   | int          |         | FK                    |
| nome-missao     | Identificador único da missão                                               | varchar      | 255     | FK                    |
| titulo-objetivo | Objetivo principal escolhido pelo jogador                                   | varchar      | 255     | FK                    |
| nome-gangue     | Identificador da gangue                                                     | varchar      | 50      | FK                    |
| nome            | Nome do personagem                                                          | varchar      | 50      | Not Null              |
| velocidade      | Velocidade máxima do personagem                                             | int          |         | Default               |
| vida            | Quantidade de vida do jogador (0 a 100)                                     | int          |         | Default               |
| qtded-recurso   | Quantidade monetária do jogador (cigarro)                                   | int          |         | Default               |
| qtded-captura   | Quantidade de vezes que o jogador foi capturado por um agente penitenciário | int          |         | Default               |


### Tabela: `AgentePenitenciarioJogador`

**Descrição:** Tabela que armazena as capturas que os agentes penitenciários realizaram com o jogador.

| Nome                               | Descrição                                   | Tipo de dado | Tamanho | Restrições de domínio |
| ---------------------------------- | ------------------------------------------- | ------------ | ------- | --------------------- |
| id-captura                         | Identificador único da captura              | int          |         | PK                    |
| id-personagem-jogador              | Identificador único do jogador              | int          |         | FK                    |
| id-personagem-agente-penitenciario | Identificador único do agente penitenciário | int          |         | FK                    |


### Tabela: `Prisioneiro`

**Descrição:** Tabela que armazena todos os personagens do tipo "P", ou seja, prisioneiros.

| Nome          | Descrição                                                                               | Tipo de dado | Tamanho | Restrições de domínio |
| ------------- | --------------------------------------------------------------------------------------- | ------------ | ------- | --------------------- |
| id-personagem | Identificador único do prisioneiro na tabela genérica                                   | int          |         | PK                    |
| id-sala       | Identificador da sala onde o personagem se encontra                                     | int          |         | FK                    |
| nome-gangue   | Identificador da gangue que o prisioneiro participa                                     | varchar      | 50      | FK                    |
| nome          | Nome do personagem                                                                      | varchar      | 50      | Default               |
| velocidade    | Velocidade máxima do personagem                                                         | int          |         | Default               |
| vida          | Quantidade de vida que o Prisioneiro possui. É um intervalo que pode variar de 0 a 100. | int          |         | Default               |
| crime         | Crime cometido pelo prisioneiro                                                         | varchar      | 255     | Default               |


### Tabela: `Gangue`

**Descrição:** Tabela que armazena todas as gangues da penitenciária.

| Nome                 | Descrição                                                                         | Tipo de dado | Tamanho | Restrições de domínio |
| -------------------- | --------------------------------------------------------------------------------- | ------------ | ------- | --------------------- |
| nome-gangue          | Nome que identifica a gangue                                                      | varchar      | 50      | PK                    |
| descricao            | Texto que descreve a gangue e sua história                                        | varchar      | 1000    |                       |
| qtdd-membros         | Quantidade de membros que participam daquela gangue                               | int          |         |                       |
| qtdd-recursos-gangue | Quantidade monetária que a gangue possui. Na narrativa será nomeada como cigarro. | int          | Default |                       |

### Tabela: `Sala`

**Descrição:** Tabela que lista todas as salas da penitenciária  
**Observações:** A sala com o menor id é o checkpoint do usuário, ou seja, sua cela

| Nome            | Descrição                                                                                              | Tipo de dado | Tamanho | Restrições de domínio |
| --------------- | ------------------------------------------------------------------------------------------------------ | ------------ | ------- | --------------------- |
| id-sala         | Identificador único da sala                                                                            | int          |         | PK                    |
| id-inventario   | Identificador único do inventário. Pode ser um inventário de sala ou o inventário pessoal do jogador.  | int          |         | FK                    |
| nome            | Nome da sala                                                                                           | varchar      | 50      | Not Null              |
| descricao       | Texto que descreve a sala                                                                              | varchar      | 1000    |                       |
| nivel-de-perigo | Nível de perígo da sala. É um intervalo de 0 a 10 que informa a probabilidade do usuário ser capturado | int          |         |                       |
| bloqueado       | Valor booleano que informa se a sala está com acesso bloqueado                                         | boolean      |         | Default               |

---

### Tabela: `Missao`

**Descrição:** Tabela que apresenta todas as missões jogáveis do game, com suas descrições e indicadores se foram ou não finalizadas.			

| Nome        | Descrição                                              | Tipo de dado | Tamanho | Restrições de domínio |
| ----------- | ------------------------------------------------------ | ------------ | ------- | --------------------- |
| nome-missao | Identificador único da missão                          | varchar      | 255     | PK                    |
| descricao   | Características gerais da missão e seus objetivos      | varchar      | 1000    | Not Null              |
| status      | Indica se a missão foi concluída (true) ou não (false) | boolean      |         | Default               |

---

### Tabela: `Inventario`

**Descrição:** Tabela que lista as características dos inventários do jogo

| Nome          | Descrição                                                                                             | Tipo de dado | Tamanho | Restrições de domínio |
| ------------- | ----------------------------------------------------------------------------------------------------- | ------------ | ------- | --------------------- |
| id-inventario | Identificador único do inventário. Pode ser um inventário de sala ou o inventário pessoal do jogador. | int          |         | PK                    |
| qtd-itens     | Quantidade máxima de itens que o inventário pode armazenar                                            | int          |         | Not Null              |
| is-full       | Booleano que informa se o inventário está cheio ou não                                                | boolean      |         | Default               |


### Tabela: `InstanciaItem`

**Descrição:** Tabela que lista todas as instâncias de itens que há no jogo

| Nome           | Descrição                                                                                                                          | Tipo de dado | Tamanho | Restrições de domínio |
| -------------- | ---------------------------------------------------------------------------------------------------------------------------------- | ------------ | ------- | --------------------- |
| id-instancia   | Identificador único da instância do item                                                                                           | int          |         | PK                    |
| id-inventario  | Identificador único do inventário onde a instância se encontra. Pode ser um inventário de sala ou o inventário pessoal do jogador. | int          |         | FK                    |
| nome-item      | Nome que identifica de qual item é a instância                                                                                     | varchar      | 50      | FK                    |
| nivel-de-gasto | Quantidade de vezes que essa instância já foi utilizada                                                                            | int          |         | Default               |

### Tabela: `Dialogo`

**Descrição:** Esta tabela lista todos os diálogos possíveis presentes no game.

| Nome          | Descrição                                                                    | Tipo de dado | Tamanho | Restrições de domínio |
| ------------- | ---------------------------------------------------------------------------- | ------------ | ------- | --------------------- |
| id-dialogo    | Identificador único do diálogo                                               | int          |         | PK                    |
| id-personagem | Identificador estrangeiro que indica a qual personagem este diálogo pertence | int          |         | FK                    |
| nome-missao   | Identificador único da missão                                                | varchar      | 255     | FK                    |
| texto         | Texto referente ao diálogo                                                   | varchar      | 500     | Not Null              |
| ordem         | Ordem em que o diálogo está em relação a todos os outros                     | int          |         | Not Null              |

### Tabela: `ObjetivoPrincipal`

**Descrição:** Esta tabela apresenta todos os objetivos pelos quais o jogador pode seguir ao longo do game.

| Nome            | Descrição                                                                               | Tipo de dado | Tamanho | Restrições de domínio |
| --------------- | --------------------------------------------------------------------------------------- | ------------ | ------- | --------------------- |
| titulo-objetivo | Identificador único do objetivo principal                                               | varchar      | 255     | PK                    |
| descricao       | Texto que descreve e caracteriza cada objetivo principal pelo qual o jogador pode optar | varchar      | 1000    | Not Null              |


### Tabela: `Item`

**Descrição:** Tabela que armazena todos os itens disponíveis no jogo.

| Nome             | Descrição                                                            | Tipo de dado | Tamanho | Restrições de domínio |
| ---------------- | -------------------------------------------------------------------- | ------------ | ------- | --------------------- |
| nome-item        | Identificador único do item                                          | varchar      | 50      | PK                    |
| nome-missao      | Identificador único da missão                                        | varchar      | 255     | FK                    |
| descricao        | Texto que descreve as características do item                        | varchar      | 500     |                       |
| durabilidade     | Quantidade de vezes que essa instância já foi utilizada/gasta        | int          | Default |                       |
| pode-ver-vendido | Indicador que informa se o item pode ou não ser vendido na loja      | boolean      | Default |                       |
| utilidade        | Utilidade que o item oferece ao jogador, caso seja uma ferramenta    | varchar      | 500     |                       |
| beneficio        | Benefício que o item oferece ao jogador, caso o item esteja equipado | varchar      | 500     |                       |


### Tabela: `Loja`

**Descrição:** Tabela que armazena preços e itens que são vendidos pelas gangues.

| Nome        | Descrição                                  | Tipo de dado | Tamanho | Restrições de domínio |
| ----------- | ------------------------------------------ | ------------ | ------- | --------------------- |
| nome-gangue | Identificador da gangue que é dona da loja | int          |         | FK                    |
| nome-item   | Identificador do item vendido              | varchar      | 100     | FK                    |
| preco       | Preço do item da loja                      | int          |         | Not Null              |


### Tabela: `ItemLoja`

**Descrição:** Tabela que armazena as compras realizadas ao longo do jogo.

| Nome        | Descrição                                 | Tipo de dado | Tamanho | Restrições de domínio |
| ----------- | ----------------------------------------- | ------------ | ------- | --------------------- |
| id-compra   | Identificador único da compra             | int          |         | PK                    |
| nome-gangue | Identificador da gangue que vendeu o item | varchar      | 50      | FK                    |
| nome-item   | Identificador do item                     | varchar      | 100     | FK                    |


### Tabela: `MissaoSala`

**Descrição:** Tabela relaciona as salas que só podem ser acessadas depois que alguma missão for cumprida.

| Nome        | Descrição                     | Tipo de dado | Tamanho | Restrições de domínio |
| ----------- | ----------------------------- | ------------ | ------- | --------------------- |
| nome-missao | Identificador único da missão | varchar      | 255     | FK                    |
| id-sala     | Identificador único da sala   | int          |         | FK                    |


## 📑 Histórico de Versões

| **Versão** | **Data**   | **Descrição**                          | **Autor**                                                                                 |
| ---------- | ---------- | -------------------------------------- | ----------------------------------------------------------------------------------------- |
| `1.0`      | 21/04/2025 | Adição do texto do dicionário de dados | [Mayara Alves](https://github.com/Mayara-tech)                                            |
| `2.0`      | 30/05/2025 | Criação do Dicionário de Dados         | [Maria Alice](https://github.com/Maliz30) e [Marllon Cardoso](https://github.com/m4rllon) |

