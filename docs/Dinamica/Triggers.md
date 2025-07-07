## Introdução 

As Triggers (ou gatilhos) são mecanismos do banco de dados que permitem a execução automática de blocos de código SQL em resposta a eventos específicos, como inserções, atualizações ou exclusões de dados. No contexto do Prision Break Game, as triggers desempenham um papel fundamental para garantir que determinadas regras de negócio sejam aplicadas no momento exato em que uma ação relevante ocorre.

Elas são utilizadas, por exemplo, para acionar a concessão de recompensas ao jogador após a conclusão de uma missão, ou para desbloquear salas e atualizar atributos do ambiente do jogo. Com isso, eliminam-se etapas manuais e reduz-se a dependência da aplicação Python para validar ações importantes, promovendo maior consistência, reatividade e integridade no fluxo do jogo.

## Metodologia 

Para garantir a execução automática de certas regras de negócio sem a intervenção direta do jogador ou da aplicação, optou-se pelo uso de Triggers (gatilhos). A metodologia para sua implementação baseou-se na identificação de eventos críticos, como a atualização do status de uma missão ou a modificação dos recursos de um jogador.

Essas triggers foram associadas a comandos UPDATE ou INSERT, garantindo que procedimentos importantes fossem executados assim que determinadas condições fossem satisfeitas. Dessa forma, assegura-se que o fluxo do jogo siga seu curso natural sem a necessidade de chamadas manuais, promovendo fluidez e controle interno robusto no banco de dados.

## Triggers

## 📑 Histórico de Versões

| **Versão**   |   **Data**   | **Descrição** | **Autor** |
|--------|---------|-----------|--------|
|`1.0`| 07/07/2025 | Criação da página de Triggers| [Mayara Alves](https://github.com/Mayara-tech)| 