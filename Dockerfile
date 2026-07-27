FROM maven:3.9.9-eclipse-temurin-17

ENV DEBIAN_FRONTEND=noninteractive

# Instalar git + Node.js + Newman + Allure reporter + Allure CLI
RUN apt-get update && apt-get install -y \
    git curl gnupg unzip \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g newman newman-reporter-allure \
    && curl -L -o /tmp/allure.zip https://github.com/allure-framework/allure2/releases/latest/download/allure.zip \
    && unzip -o /tmp/allure.zip -d /opt/allure \
    && ln -s /opt/allure/bin/allure /usr/bin/allure \
    && apt-get clean

# Validar instalación
RUN newman -v
RUN allure --version

# Copiar el código del proyecto local al contenedor
COPY . /app

# Directorio de trabajo
WORKDIR /app

# Permisos
RUN chmod -R 755 /app

# Ejecutar pruebas y generar reporte Allure
# mvn test ejecuta pruebas, mvn allure:report genera el reporte HTML
CMD ["sh", "-c", "mvn test && mvn allure:report"]