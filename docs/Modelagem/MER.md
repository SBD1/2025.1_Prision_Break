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

#### Agente penitênciario captura jogador 
- Um agente penitênciario pode captura zero ou um jogador.
- um jogador pode ser preso por um ou n agentes penitênciarios.

#### Prisioneiro participa gangue
- Um prisioneiro tem que participar de um gangue.
- Uma gangue tem que ter pelo menos um prisioneiro e no máximo n prisioneiros. 

#### Jogador participa gangue 
- Um jogador tem que participar de uma gangue.
- Uma gangue pode ter zero ou um jogador. 

#### Gangue possui loja
- Uma gangue possui uma loja.
- Uma loja é de uma gangue.

#### Loja vende item
- Uma loja pode vender um ou n itens.
- Um item pode esta associado a zero ou n lojas.

#### Jogador Compra um item vendido
- Um jogador pode comprar zero ou n itens.
- um item pode ser vendido zero ou um vez.

#### Item pode ser apenas um item, um item de missão, uma ferramenta, um disfarce
- Um item pode ser um ou mais item, item de missão, ferramenta ou disfarce. 

#### Item tem instancia item
- Um item pode ser intanciado uma ou n vezes.
- Uma instancia item pode ser de um unico item. 

#### Inventário possui instancia item
- Um inventário pode ter zero ou uma intancia de um item.
- Uma instancia de um item pode esta em um ou n inventários. 

#### Jogador possui inventário 
- Um jogador possui um inventário.
- Um inventario pertence a um jogador. 

#### Sala possui inventário 
- uma sala possui um inventário. 
- Um inventário pode está em zero ou uma sala.

#### Personagem está sala 
- Um personagem tem que está em uma sala.
- Uma sala pode ter zero ou n personagens.

#### Sala vai para sala 
- Uma sala entra em um ou n sala.
- Uma sala sai de uma sala.

#### Missão é pré-requisito de sala 
- Uma missão é pre-requisito de zero ou n salas. 
- Uma sala tem como pre-requisito zero ou n missões.

#### Jogador executa missão
- Um jogador executa uma missão.
- Uma missão pode ser ou não executada por um jogador.

#### Jogador escolhe objetivo principal 
- Um jogador escolhe um objetivo principal. 
- Um objetivo principal pode ou não ser escolhido por um jogador.

#### Objetivo principal possui missão
- Um objetivo principal possui uma ou n missões. 
- Uma missão pode está relacionada a um ou n objetivos principais.

#### Missão tem instancia item
- Uma missão possui um ou n instancia item.
- Uma instancia item pode esta ou não relacionada a uma missão.

#### Missão possui dialogo
- Uma missão possui um ou n dialogos.
- Um dialogo esta relacionado a uma missão. 



## 📑 Histórico de Versões

| **Versão**   |   **Data**   | **Descrição** | **Autor** |
|--------|---------|-----------|--------|
|`1.0`| 21/04/2025 | Criação da página do modelo entidade relacionamento| [Mayara Alves](https://github.com/Mayara-tech)| 
|`2.0`| 02/05/2025 | Criação do modelo entidade relacionamento| [Mayara Alves](https://github.com/Mayara-tech)| 