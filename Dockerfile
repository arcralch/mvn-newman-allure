FROM maven:3.9.9-eclipse-temurin-11

ENV DEBIAN_FRONTEND=noninteractive

# Instalar git + Node.js + Newman + Allure reporter
RUN apt-get update && apt-get install -y \
    git curl gnupg unzip \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g newman newman-reporter-allure \
    && apt-get clean

# Validar instalación (evita errores silenciosos)
RUN newman -v

# Copiar el código del proyecto local al contenedor
COPY . /app

# Directorio de trabajo
WORKDIR /app

# Permisos
RUN chmod -R 755 /app

# Ejecutar pruebas y generar reporte Allure
# mvn site ejecuta pruebas (phase test) y genera reporte Allure (phase site)
CMD ["sh", "-c", "mvn site"]