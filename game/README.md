## Como Rodar o Projeto

Siga os passos abaixo para configurar e iniciar o projeto:

1.  **Clone o Repositório:**
    Abra seu terminal e clone o repositório para sua máquina local:
    ```bash
    git clone https://github.com/SBD1/2025.1_Prision_Break.git
    cd 2025.1_Prision_Break
    ```

2.  **Verifique os Scripts SQL:**
    * Os arquivos `01_schema.sql` (contendo `CREATE TABLE`s) e `02_data.sql` (contendo `INSERT INTO`s) na pasta `sql/` serão executados automaticamente pelo contêiner PostgreSQL na primeira inicialização.
    * Eles são executados em ordem alfabética, por isso o prefixo `01_` e `02_` é importante para garantir que o esquema seja criado antes dos dados serem inseridos.

3.  **Inicie os Serviços Docker (Banco de Dados e Aplicação Python):**
    Na raiz do projeto (onde está o arquivo `docker-compose.yml`), execute o seguinte comando:
    ```bash
    docker-compose up -d --build
    ```
    * `docker-compose up`: Inicia os serviços definidos no `docker-compose.yml`.
    * `-d`: Inicia os contêineres em modo "detached" (em segundo plano), liberando seu terminal.
    * `--build`: Garante que a imagem da sua aplicação Python será construída (ou reconstruída se houver alterações no `Dockerfile` ou `requirements.txt`).
    * **O que acontece:** Este comando baixará a imagem do PostgreSQL, construirá a imagem da sua aplicação Python, e iniciará ambos os contêineres. O contêiner do PostgreSQL será inicializado e executará seus scripts SQL automaticamente. O contêiner da aplicação Python ficará "vivo" esperando por comandos (devido ao `tail -f /dev/null` no `docker-compose.yml`).

4.  **Acesse a Aplicação Python (Console Interativo):**
    Como a aplicação Python é interativa e espera entrada do usuário, você precisa de um terminal "anexado" a ela. Execute o seguinte comando:
    ```bash
    docker exec -it prision_break_app_container python app_console.py
    ```
    * `docker exec`: Executa um comando dentro de um contêiner em execução.
    * `-it`: Essencial para a interação, anexa um terminal interativo.
    * `prision_break_app_container`: O nome do contêiner da sua aplicação.
    * `python app_console.py`: O comando que inicia o script da sua aplicação Python dentro do contêiner.

    Agora, você verá o menu da aplicação no seu terminal e poderá interagir com ele (digitar `1` para listar tabelas, `2` para visualizar dados, `3` para sair).

## Parando o Projeto

Quando você terminar de usar o projeto, você pode parar e remover os contêineres para liberar recursos do sistema:

```bash
docker-compose down
