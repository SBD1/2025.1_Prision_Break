## Introdução 

As Triggers (ou gatilhos) são mecanismos do banco de dados que permitem a execução automática de blocos de código SQL em resposta a eventos específicos, como inserções, atualizações ou exclusões de dados. No contexto do Prision Break Game, as triggers desempenham um papel fundamental para garantir que determinadas regras de negócio sejam aplicadas no momento exato em que uma ação relevante ocorre.

Elas são utilizadas, por exemplo, para acionar a concessão de recompensas ao jogador após a conclusão de uma missão, ou para desbloquear salas e atualizar atributos do ambiente do jogo. Com isso, eliminam-se etapas manuais e reduz-se a dependência da aplicação Python para validar ações importantes, promovendo maior consistência, reatividade e integridade no fluxo do jogo.

## Metodologia 

Para garantir a execução automática de certas regras de negócio sem a intervenção direta do jogador ou da aplicação, optou-se pelo uso de Triggers (gatilhos). A metodologia para sua implementação baseou-se na identificação de eventos críticos, como a atualização do status de uma missão ou a modificação dos recursos de um jogador.

Essas triggers foram associadas a comandos UPDATE ou INSERT, garantindo que procedimentos importantes fossem executados assim que determinadas condições fossem satisfeitas. Dessa forma, assegura-se que o fluxo do jogo siga seu curso natural sem a necessidade de chamadas manuais, promovendo fluidez e controle interno robusto no banco de dados.

## Triggers

### Atualizar quantidade no inventário 

Essas triggers garantem que o inventário do jogador seja mantido automaticamente consistente com a adição ou remoção de itens. Sempre que um item é inserido, o número total de itens é incrementado e o status de inventário cheio é atualizado conforme a capacidade máxima. Da mesma forma, ao remover um item, a contagem é reduzida e o inventário é marcado como não cheio. Esse mecanismo evita inconsistências e elimina a necessidade de atualizações manuais no inventário, mantendo a lógica de jogo automatizada e confiável.

```
CREATE OR REPLACE FUNCTION trg_atualizar_inventario_insert()
RETURNS TRIGGER AS $$
DECLARE
    v_qtd_max_itens INT := 10; -- Capacidade máxima do inventário
BEGIN
    UPDATE Inventario
    SET
        qtd_itens = qtd_itens + 1,
        is_full = CASE WHEN (qtd_itens + 1) >= v_qtd_max_itens THEN TRUE ELSE FALSE END
    WHERE id_inventario = NEW.id_inventario;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_instancia_item_insert
AFTER INSERT ON Instancia_Item
FOR EACH ROW
EXECUTE FUNCTION trg_atualizar_inventario_insert();

-- Trigger para atualizar qtd_itens e is_full no Inventario após DELEÇÃO em Instancia_Item
CREATE OR REPLACE FUNCTION trg_atualizar_inventario_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Inventario
    SET
        qtd_itens = qtd_itens - 1,
        is_full = FALSE -- Se um item foi removido, o inventário não está mais cheio
    WHERE id_inventario = OLD.id_inventario;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_instancia_item_delete
AFTER DELETE ON Instancia_Item
FOR EACH ROW
EXECUTE FUNCTION trg_atualizar_inventario_delete();
```
### Atualizar captura

Tem como objetivo simular a chance de um jogador ser capturado ao mudar de sala no jogo, considerando fatores como o perigo da sala, os agentes presentes, modificadores de dificuldade e aleatoriedade. Ao detectar a mudança do campo id_sala do jogador, a função é ativada e realiza uma série de operações: primeiro, obtém o nível de perigo da nova sala e soma os níveis de perigo de todos os agentes penitenciários presentes nela. Em seguida, coleta o modificador de dificuldade do jogo com base na configuração do jogador e o modificador de equipamento que ele possui. Um valor aleatório de 0 a 10 é gerado para adicionar imprevisibilidade ao cálculo. 

A função então realiza uma operação que combina todos esses elementos, e, se o resultado final for maior que zero, a quantidade de capturas (qtded_captura) do jogador é incrementada em 1. Essa lógica adiciona uma camada de risco e estratégia à movimentação no jogo, incentivando os jogadores a considerarem o ambiente antes de avançarem pelas salas.

```
CREATE OR REPLACE FUNCTION verificar_e_atualizar_captura()
RETURNS TRIGGER AS $$
DECLARE
    v_nivel_perigo_sala INT;
    v_soma_nivel_perigo_agentes INT;
    v_modificador_dificuldade INT;
    v_modificador_equipamento INT;
    v_valor_aleatorio INT;
    v_resultado_calculo INT;
BEGIN
    -- 1) Verifica se o atributo 'id_sala' do Jogador mudou
    IF NEW.id_sala IS DISTINCT FROM OLD.id_sala THEN
        -- Obter nivel_perigo da nova Sala
        SELECT nivel_perigo INTO v_nivel_perigo_sala
        FROM Sala
        WHERE id_sala = NEW.id_sala;

        -- Calcular a soma de todos os niveis de perigo dos agentes penitenciários na nova sala
        SELECT COALESCE(SUM(AP.nivel_de_perigo), 0) INTO v_soma_nivel_perigo_agentes
        FROM Agente_Penitenciario AP
        WHERE AP.id_sala = NEW.id_sala;

        -- Obter o modificador da dificuldade do jogo do Jogador
        SELECT modificador INTO v_modificador_dificuldade
        FROM Modificador_dificuldade
        WHERE tag_dificuldade = NEW.dificuldade_jogo;

        -- Obter o modificador de equipamento do Jogador
        v_modificador_equipamento := NEW.modificador_equipamento;

        -- Gerar um valor aleatório entre 0 e 10
        v_valor_aleatorio := FLOOR(RANDOM() * 11); -- Multiplica por 11 para incluir o 10

        -- Realizar o cálculo: Sala.nivel_perigo + (soma agentes) - modificador dificuldade + modificador equipamento + aleatório
        v_resultado_calculo := v_nivel_perigo_sala + v_soma_nivel_perigo_agentes - v_modificador_dificuldade + v_modificador_equipamento + v_valor_aleatorio;

        -- 2) Se o valor for maior que 0, incrementa 1 no atributo 'qtded_captura' de Jogador
        IF v_resultado_calculo > 0 THEN
            NEW.qtded_captura := NEW.qtded_captura + 1;
        END IF;
    END IF;
```

### Movimentação do jogador 

Antes de qualquer atualização no campo id_sala da tabela Jogador, ou seja, sempre que um jogador tenta se mover para outra sala. Ela executa a função verificar_e_atualizar_captura, que calcula o risco de captura com base no nível de perigo da nova sala, nos agentes presentes, na dificuldade do jogo, nos equipamentos do jogador e em um fator aleatório. Caso o resultado da avaliação seja maior que zero, o contador de capturas do jogador é incrementado. Essa trigger é essencial para aplicar a lógica de risco a cada movimentação, integrando de forma automática e imersiva a mecânica de detecção e punição dentro do jogo.

```
CREATE TRIGGER trigger_movimento_jogador
BEFORE UPDATE OF id_sala ON Jogador
FOR EACH ROW
EXECUTE FUNCTION verificar_e_atualizar_captura();
```

### Jogador capturado 

Atua como uma trigger de resposta à captura do jogador. Ela é ativada quando há uma mudança no valor do campo qtded_captura da tabela Jogador, verificando especificamente se esse valor aumentou em relação ao anterior. Se isso ocorrer, a função atualiza a sala do jogador, movendo-o automaticamente para a sala de ID 1 — que provavelmente representa a solitária ou uma cela de punição no contexto do jogo. Ao retornar NULL, a função impede que a atualização original prossiga, ou seja, ela intercepta e altera o comportamento padrão do banco de dados após uma captura ser registrada. Essa lógica simula, de forma automática, a penalidade de ser capturado, reforçando a mecânica de risco e consequência durante o jogo.

```
CREATE OR REPLACE FUNCTION handle_player_capture()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se qtded_captura mudou para um valor maior que o anterior
    IF NEW.qtded_captura > OLD.qtded_captura THEN
        -- O atributo id_sala muda para 1
        UPDATE Jogador
        SET id_sala = 1
        WHERE id_personagem = NEW.id_personagem;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_player_capture
AFTER UPDATE OF qtded_captura ON Jogador
FOR EACH ROW
EXECUTE FUNCTION handle_player_capture();

```


## 📑 Histórico de Versões

| **Versão**   |   **Data**   | **Descrição** | **Autor** |
|--------|---------|-----------|--------|
|`1.0`| 07/07/2025 | Criação da página de Triggers| [Mayara Alves](https://github.com/Mayara-tech)| 