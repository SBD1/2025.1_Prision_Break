## Introdução

O Modelo Entidade-Relacionamento (MER) é uma ferramenta essencial na engenharia de software e na modelagem de dados, utilizada para representar de forma conceitual os componentes fundamentais de um sistema de banco de dados. Ele fornece uma visão visual e estruturada das entidades que compõem um domínio de negócio, incluindo seus atributos e os relacionamentos que mantêm entre si.

- **Entidades:** Representam objetos ou conceitos distintos do mundo real que fazem parte do sistema a ser modelado.
- **Relacionamentos:** Indicam as conexões ou interações existentes entre as entidades.
- **Atributos:** São as características que descrevem as entidades, fornecendo informações detalhadas sobre cada uma.

## Metodologia

A construção do MER seguiu uma abordagem sistemática, iniciando pela identificação das principais entidades envolvidas no contexto do jogo, bem como seus atributos relevantes. Em seguida, foram definidos os relacionamentos entre essas entidades, buscando representar com precisão a forma como se conectam e interagem dentro do sistema de banco de dados. Para isso utilizamos a ferramenta Miro para colocamos nossas ideias principais pro jogos e o que considerariamos entidades.

## Modelo Entidade-Relacionamento

> Entidades: Representações dos elementos ou objetos da realidade que estão sendo modelados.<br>
> Relacionamentos: Conexões ou associações entre as entidades, que definem como elas interagem entre si. <br>
> tributos: Propriedades ou características específicas que descrevem uma entidade de maneira detalhada. <br>

### Entidades e atributos 

#### Personagem 
- id-personagem
- nome
- tipo
- velocidade
#### Agente penitenciario
- nivel-de-perigo
- nivel-de-alerta
- corrupto
- preço 
- cargo
#### Jogador
- vida
- qtdd-recurso
- qtdd-capturas
#### Prisioneiro 
- vida
- crime
#### Gangue
- nome-gangue
- descrição
- qtdd-membros
- qtdd-recurso-gangue
#### Sala
- id-sala
- nome
- descrição
- nivel-de-perigo
- pre-requisito
- bloqueada
#### Loja
- preco
#### Item 
- nome-item
- descrição
- durabilidade
- pode-ser-vendido
#### Item missão
#### Ferramenta
- utilidade
#### Disfarce
- beneficio
- slot
#### Instancia item
- id-instancia
- nivel-de-gasto
#### Inventário
- id-inventário
- qtdd-item
#### Objetivo principal
- titulo-objetivo
- descrição
#### Diálogo
- id-dialogo
- texto
- ordem
#### Missão
- nome-missao
- descrição
- status

### Relacionamentos 

#### Personagem pode ser agente penitênciario, jogador ou prisioneiro
- Um personagem pode ser unicamente um agente penitenciario ou um jogador ou um prisioneiro. 

#### Agente penitênciario prende jogador 
- Um agente penitênciario pode prender zero ou um jogador.
- um jogador pode ser preso por um ou n agentes penitênciarios.

#### Prisioneiro participa gangue
- Um prisioneiro tem que participar de um gangue.
- Uma gangue tem que ter pelo menos um prisioneiro e no máximo n prisioneiros. 

#### Jogador participa gangue 
- Um jogador tem que participar de uma gangue.
- Uma gangue pode ter zero ou um jogador. 

#### Gangue possui loja



## 📑 Histórico de Versões

| **Versão**   |   **Data**   | **Descrição** | **Autor** |
|--------|---------|-----------|--------|
|`1.0`| 21/04/2025 | Criação da página do modelo entidade relacionamento| [Mayara Alves](https://github.com/Mayara-tech)| 
|`2.0`| 02/05/2025 | Criação do modelo entidade relacionamento| [Mayara Alves](https://github.com/Mayara-tech)| 