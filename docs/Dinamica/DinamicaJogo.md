## Introdução 

A dinâmica do Prision Break Game foi projetada para criar uma experiência interativa e progressiva, na qual o jogador evolui dentro de um ambiente controlado por regras estabelecidas diretamente no banco de dados. Cada ação do jogador — como completar missões, interagir com agentes, explorar salas ou utilizar recursos — desencadeia alterações no estado do jogo, refletidas em tempo real nas tabelas do sistema.

Essa lógica é implementada por meio da integração entre Stored Procedures, Triggers e a estrutura relacional do banco, permitindo que o mundo do jogo reaja às decisões tomadas de forma inteligente e coerente. Por exemplo, ao concluir uma missão, o jogador recebe recursos automaticamente e novas salas são desbloqueadas; ao negociar com agentes corruptos, o nível de perigo de determinadas áreas é reduzido, abrindo novas possibilidades estratégicas.

A aplicação do jogo é controlada pelo script Python app_console.py, que funciona como uma interface interativa via terminal. Ele conecta-se diretamente ao banco de dados e envia os comandos necessários para executar as procedures, consultar informações e registrar o progresso do jogador. Essa arquitetura promove uma separação clara entre a lógica de aplicação (Python) e a lógica de negócio (SQL), assegurando um fluxo de jogo fluido, seguro e facilmente extensível.

## Metodologia 
A dinâmica do Prision Break Game foi desenvolvida com base na integração entre banco de dados e aplicação Python. Toda a lógica central como recompensas, desbloqueio de salas e interação com agentes é implementada em Stored Procedures e Triggers, garantindo consistência e automatização das regras de negócio diretamente no banco.

A aplicação, escrita em Python (app_console.py), funciona como uma interface de terminal interativa. Ela se conecta ao banco via psycopg2, executando consultas e chamadas de procedures conforme as ações do jogador. Essa estrutura modular facilita a expansão do jogo, separando claramente a lógica do banco e da aplicação.

## Dinâmica 

O projeto é organizado em módulos que controlam diferentes aspectos do jogo:

- **`jogo.py`** – Criação e configuração do personagem.
- **`start_game.py`** – Loop principal de navegação e ações do jogador.
- **`captura.py`** – Sistema de risco ao mover-se para outras salas.
- **`transacoes.py`** – Lógica de compra e venda de itens.
- **`move_npc.py`** – Movimentação automática de NPCs.
- **`utils.py`** – Funções utilitárias para o sistema.
- **`db_operations.py`** – Operações diretas com o banco de dados.

### Criação do Jogador (`jogo.py`)

No início da partida, o jogador define seu nome, gangue, dificuldade e objetivo principal. Essas informações são persistidas com comandos SQL dinâmicos:

```python
query_update_player_name = load_sql_query('update_player_field') % ('nome', '%s', '%s')
cursor.execute(query_update_player_name, (novo_nome, ID_JOGADOR))
```

A função `escolher_objetivo_principal` busca e exibe os objetivos disponíveis com `tabulate` e `textwrap`.


### Navegação (`start_game.py`)

A função `start_game` permite ao jogador navegar pelas salas e visualizar informações do ambiente:

```python
cursor.execute(query_available_rooms, (id_sala_atual,))
available_rooms_data = cursor.fetchall()
```

O jogador escolhe uma sala e, caso ela esteja desbloqueada, o sistema atualiza seu ID no banco:

```python
cursor.execute(query_update_player_room, (escolha_sala_id, id_jogador))
conn.commit()
```

### Sistema de Captura (`captura.py`)

A função `tentar_mudar_sala` verifica o nível de perigo da sala:

```python
if nivel_perigo_sala > NIVEL_PERIGO_ALTO_LIMITE:
    print("!!! ALERTA DE PERIGO !!!")
```

Futuramente, esse sistema será integrado com lógica baseada em agentes e modificadores de dificuldade.


### Loja e Inventário (`transacoes.py`)

A compra de itens envolve confirmação do jogador e execução de procedure:

```python
execute_procedure(conn, sql, (id_jogador, nome_item, nome_gangue))
```

A função `listar_loja` exibe os itens e permite que o jogador selecione e compre com base no ID.


### Movimento de NPCs (`move_npc.py`)

NPCs (prisioneiros e agentes) se movimentam automaticamente em segundo plano:

```python
thread_movimentacao = threading.Thread(target=loop_movimentacao, daemon=True)
thread_movimentacao.start()
```

Eles são movidos por procedures no banco chamadas ciclicamente a cada 10 segundos.


### Utilitários e Banco

#### `utils.py`

- `clear_console()`: limpa a tela
- `load_sql_query()`: carrega arquivos `.sql`
- `pause_and_clear()`: pausa e limpa
- `quit_application()`: encerra o jogo

#### `db_operations.py`

Centraliza a comunicação com o banco:

```python
def executar_query_update(conn, cursor, query_sql: str, params: tuple = None) -> int:
    try:
        cursor.execute(query_sql, params)
        conn.commit()
        return cursor.rowcount
    except Error as e:
        conn.rollback()
        print(f"Erro ao executar UPDATE/INSERT/DELETE: {e}")
        return 0
```


## 📑 Histórico de Versões

| **Versão**   |   **Data**   | **Descrição** | **Autor** |
|--------|---------|-----------|--------|
|`1.0`| 07/07/2025 | Criação da página de dinâmica | [Mayara Alves](https://github.com/Mayara-tech)| 

