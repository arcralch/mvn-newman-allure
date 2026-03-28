FROM maven:3.8.7-eclipse-temurin-11

# Instalar Node.js (necesario para Newman)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Instalar Newman y el reportero de Allure de forma global
RUN npm install -g newman newman-reporter-allure

# Directorio de trabajo en el contenedor
WORKDIR /app

# Esto preparará el contenedor. El código fuente será montado por el docker-compose.
