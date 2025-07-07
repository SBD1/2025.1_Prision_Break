# 🎮 Como jogar Prision Break Game

Este guia apresenta um passo a passo completo para iniciar e executar o Prision Break Game, detalhando o funcionamento de cada etapa do processo de inicialização.


## 📦 1. Clonagem do Repositório

Primeiramente, é necessário baixar os arquivos do projeto para a sua máquina local. Para isso, utilize o seguinte comando:

`git clone https://github.com/SBD1/2025.1_Prision_Break.git` <br>
`cd ./2025.1_Prision_Break/game`

A pasta game/ contém todos os arquivos essenciais para o funcionamento do sistema:

`Dockerfile`: define como a aplicação Python será empacotada.

`docker-compose.yml`: coordena o banco de dados e a aplicação no Docker.

`Pasta sql/`: armazena os scripts SQL que configuram o banco.

`app_console.py`: o jogo em si, rodado no terminal.

## 🗃️ 2. Scripts de Banco de Dados

Na pasta sql/, há dois arquivos principais:

`01_schema.sql`: contém os comandos CREATE TABLE, definindo a estrutura do banco de dados.

`02_data.sql`: contém os comandos INSERT INTO, populando o banco com dados iniciais, como missões, salas, agentes e jogadores.

⚠️ Esses arquivos são executados automaticamente pelo Docker, quando o contêiner PostgreSQL é inicializado pela primeira vez.

A ordem de execução é garantida pelo prefixo 01_, 02_, etc.

## 🐳 3. Iniciando com Docker

Na raiz da pasta game/, execute o seguinte comando para subir os contêineres do banco e da aplicação:

`docker compose up -d --build`

O que esse comando faz:

`docker compose up`: Inicializa todos os serviços definidos no docker-compose.yml.

`-d (detached)`: Executa os serviços em segundo plano.

`--build`: Força a reconstrução das imagens (caso tenham sido alteradas).

Durante essa etapa:

- O Docker baixa a imagem oficial do PostgreSQL (caso não exista localmente).
- Cria uma imagem personalizada da aplicação Python.
- Executa os scripts SQL automaticamente ao iniciar o banco.
- Deixa o contêiner da aplicação rodando (sem fechar), pronto para receber comandos interativos.

## 🕹️ 4. Acessando o Console do Jogo

Após os contêineres estarem ativos, o jogo pode ser iniciado no modo interativo com o comando:

`docker exec -it prision_break_app_container python app_console.py`

Esse comando:

- Acessa o terminal da aplicação dentro do contêiner.
- Executa o script app_console.py, que inicializa o menu do jogo.

 
Ao finalizar o uso do jogo, você pode encerrar todos os contêineres e liberar os recursos do sistema com:

`docker compose down`

## 🛠️ Observações Técnicas

Certifique-se de que o Docker Desktop está rodando antes de iniciar o projeto.

Se ocorrerem erros, utilize:

`docker compose logs`

Para verificar os detalhes da execução e diagnosticar possíveis falhas.

## 📑 Histórico de Versões

| Versão |    Data    | Descrição |            Autor(es)            |
| :----: | :--------: | :-------: | :-----------------------------: |
| `1.0`  | 20/05/2025 |   Criação do readme do game  |[Marllon Cardoso](https://github.com/m4rllon)  |
| `1.1`  | 22/05/2025 |   Correção do comando usado para construir o docker |[Maria Alice Silva](https://github.com/maliz30)    |
| `1.2`  | 07/07/2025 |   Criação da página de instrução |[Mayara Oliveira](https://github.com/Mayara-tech)   |


