# Imagen base con Java y Maven
FROM maven:3.9.9-eclipse-temurin-11

ENV DEBIAN_FRONTEND=noninteractive

# Instalar git + Node.js + Newman + Allure reporter
RUN apt-get update && apt-get install -y \
    git curl gnupg \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g newman newman-reporter-allure \
    && apt-get clean

# Directorio de trabajo
WORKDIR /app

# Clonar repositorio (CAMBIA LA URL)
RUN git clone https://github.com/arcralch/mvn-newman-allure.git -b main .

# Permisos
RUN chmod -R 755 /app

# Ejecutar pruebas
CMD ["mvn", "clean", "test"]