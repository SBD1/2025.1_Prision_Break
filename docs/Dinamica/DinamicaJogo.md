## Introdução 

A dinâmica do Prision Break Game foi projetada para criar uma experiência interativa e progressiva, na qual o jogador evolui dentro de um ambiente controlado por regras estabelecidas diretamente no banco de dados. Cada ação do jogador — como completar missões, interagir com agentes, explorar salas ou utilizar recursos — desencadeia alterações no estado do jogo, refletidas em tempo real nas tabelas do sistema.

Essa lógica é implementada por meio da integração entre Stored Procedures, Triggers e a estrutura relacional do banco, permitindo que o mundo do jogo reaja às decisões tomadas de forma inteligente e coerente. Por exemplo, ao concluir uma missão, o jogador recebe recursos automaticamente e novas salas são desbloqueadas; ao negociar com agentes corruptos, o nível de perigo de determinadas áreas é reduzido, abrindo novas possibilidades estratégicas.

A aplicação do jogo é controlada pelo script Python app_console.py, que funciona como uma interface interativa via terminal. Ele conecta-se diretamente ao banco de dados e envia os comandos necessários para executar as procedures, consultar informações e registrar o progresso do jogador. Essa arquitetura promove uma separação clara entre a lógica de aplicação (Python) e a lógica de negócio (SQL), assegurando um fluxo de jogo fluido, seguro e facilmente extensível.

## Metodologia 
A dinâmica do Prision Break Game foi desenvolvida com base na integração entre banco de dados e aplicação Python. Toda a lógica central como recompensas, desbloqueio de salas e interação com agentes é implementada em Stored Procedures e Triggers, garantindo consistência e automatização das regras de negócio diretamente no banco.

A aplicação, escrita em Python (app_console.py), funciona como uma interface de terminal interativa. Ela se conecta ao banco via psycopg2, executando consultas e chamadas de procedures conforme as ações do jogador. Essa estrutura modular facilita a expansão do jogo, separando claramente a lógica do banco e da aplicação.

## Dinâmica 

## 📑 Histórico de Versões

| **Versão**   |   **Data**   | **Descrição** | **Autor** |
|--------|---------|-----------|--------|
|`1.0`| 07/07/2025 | Criação da página de dinâmica | [Mayara Alves](https://github.com/Mayara-tech)| 

