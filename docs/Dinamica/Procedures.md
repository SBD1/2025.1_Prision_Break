## Introdução 

As Stored Procedures (Procedimentos Armazenados) são blocos de código SQL que encapsulam operações lógicas e rotinas do sistema, permitindo sua reutilização de forma estruturada e segura dentro do banco de dados. No contexto do jogo Prision Break, essas procedures são responsáveis por automatizar regras de negócio importantes, como a conclusão de missões, concessão de recompensas ao jogador, desbloqueio de novas salas e negociação com agentes penitenciários corruptos.

Utilizar procedures melhora a organização da lógica do sistema, reduz acoplamentos com a aplicação Python e garante que ações críticas ocorram de forma padronizada, segura e eficiente. Além disso, facilita a manutenção do código e o controle sobre os dados do jogo, já que todas as ações sensíveis passam a ser centralizadas no próprio banco.

## Metodologia 

A metodologia aplicada para o desenvolvimento das Stored Procedures consistiu em mapear os principais comportamentos esperados durante o jogo e convertê-los em operações reutilizáveis diretamente no banco de dados. Foram identificadas ações frequentes como concluir uma missão, conceder recompensas e desbloquear conteúdos e transformadas em rotinas SQL encapsuladas, visando reduzir a duplicidade de lógica e aumentar a segurança e consistência dos dados.

A definição dos parâmetros das procedures seguiu o princípio de clareza e padronização, utilizando prefixos identificáveis (como p_) e limitando o tamanho dos VARCHARs conforme o modelo relacional. Isso favoreceu tanto a organização quanto a fácil integração com a aplicação Python. A estrutura modular permite acionar essas procedures de forma isolada ou combinada, conforme os eventos ocorram no jogo.

## Stored procedures

## 📑 Histórico de Versões

| **Versão**   |   **Data**   | **Descrição** | **Autor** |
|--------|---------|-----------|--------|
|`1.0`| 07/07/2025 | Criação da página de Stored de procedures| [Mayara Alves](https://github.com/Mayara-tech)| 
