# Usa uma imagem base oficial do Python
FROM python:3.9-slim-buster

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de requisitos e instala as dependências
# Usar a abordagem de copiar apenas requirements.txt primeiro
# aproveita o cache do Docker, acelerando reconstruções
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação
COPY . .

# Define variáveis de ambiente padrão para o banco de dados
# Estas serão sobrescritas pelo docker-compose.yml
ENV PG_HOST=db
ENV PG_DB_NAME=prision_break_db
ENV PG_USER=prision_break_user
ENV PG_PASSWORD=123

# Comando para rodar a aplicação quando o contêiner iniciar
# Este é o comando padrão, pode ser sobrescrito pelo docker-compose.yml
CMD ["python", "app_console.py"]
