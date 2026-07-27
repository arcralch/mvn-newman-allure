# Maven-Newman-Allure Automation Project

Este proyecto está diseñado para ejecutar pruebas automatizadas de APIs mediante colecciones de **Postman**, utilizando **Newman** como motor de ejecución y **Maven** como orquestador del ciclo de vida. Además, integra **Allure Reports** para generar reportes visuales y detallados de los resultados de las pruebas.

## 🚀 Características Principales

*   **Orquestación con Maven**: Permite ejecutar pruebas de Newman directamente desde el ciclo de vida de Maven usando `exec-maven-plugin`.
*   **Pruebas de API con Postman**: Utiliza colecciones de Postman almacenadas en el proyecto, actualmente configurado para ejecutar `pokemon.postman_collection.json`.
*   **Reportes Visuales con Allure**: Genera automáticamente los resultados de Newman y el reporte HTML con `allure-maven`. Incluye la copia automática de propiedades de entorno (`environment.properties`).
*   **Limpieza Automática**: Limpia automáticamente los resultados de ejecuciones de pruebas de reportes obsoletos con `maven-antrun-plugin`.
*   **Java 17**: Proyecto configurado con Java 17 (`maven.compiler.source=17`, `maven.compiler.target=17`).
*   **Ejecución con Docker**: Entorno en contenedor (`Dockerfile`) con Java 17, listo para instalar todas las dependencias (Node, Newman, etc.) y correr las pruebas de forma aislada.
*   **GitHub Actions Integration**: Workflow configurado para ejecutar pruebas en CI, generar reportes y descargar artefactos (resultados JSON y reporte HTML).

## 📋 Requisitos Previos

Para ejecutar localmente en tu máquina:
1.  **[Java JDK 17](https://www.oracle.com/java/technologies/downloads/)** o superior
2.  **[Apache Maven](https://maven.apache.org/download.cgi)** 3.6+
3.  **[Node.js y npm](https://nodejs.org/es/)** instalado para poder utilizar Newman.

Para ejecutar con Docker, solo necesitas tener instalado Docker.

## 📦 Instalación de Dependencias (Newman y Allure)

Para que el proyecto pueda ejecutar las pruebas correctamente y generar los reportes de Allure, debes instalar local o globalmente **Newman** y el plugin reportero de Allure mediante `npm`:

```bash
npm install -g newman
npm install -g newman-reporter-allure
```

## ⚙️ Estructura del Proyecto

La colección de pruebas de Postman configurada para ejecutarse por defecto se encuentra dentro del repositorio en:
`src/test/java/postman/pokemon.postman_collection.json`

Si deseas cambiar la colección o agregar variables de entorno adicionales (`-e`), puedes modificar los argumentos de ejecución de Newman desde el archivo `pom.xml`, ubicados en la configuración del plugin `exec-maven-plugin`.

## 🏃 Ejecución de Pruebas

### Ejecución Local

Para ejecutar las pruebas configuradas en la colección de Postman y generar el reporte Allure:

```bash
mvn clean test
mvn allure:report
```

Esto generará:
*   `target/allure-results/`: Archivos JSON con los resultados de las pruebas
*   `target/allure-report/`: Reporte HTML interactivo

### Ejecución con Docker

Si prefieres no instalar las dependencias localmente, puedes construir y ejecutar el contenedor que se encargará de correr los tests y generar el reporte automáticamente:

```bash
docker build -t mvn-newman-allure .
docker run --rm mvn-newman-allure
```

**Nota**: El contenedor usa Java 17 (`maven:3.9.9-eclipse-temurin-17`) e incluye Newman y el reporter de Allure.

### Ejecución con GitHub Actions

El proyecto incluye un workflow de GitHub Actions (`/.github/workflows/maven-newman-docker.yml`) que:

1. Construye la imagen Docker
2. Ejecuta las pruebas dentro del contenedor
3. Extrae los resultados y reporte
4. Sube ambos artefactos a GitHub Actions

Los artefactos disponibles son:
*   `allure-results`: Resultados JSON para análisis posterior
*   `allure-report`: Reporte HTML listo para visualizar

## 📊 Visualización del Reporte (Allure Reports)

### Localmente

Después de ejecutar `mvn allure:report`, puedes visualizar el reporte interactivo ejecutando:

```bash
mvn allure:serve
```

Este comando abrirá automáticamente una pestaña en tu navegador web con el reporte interactivo.

### Desde GitHub Actions

1. Ve a la pestaña **Actions** de tu repositorio
2. Selecciona el workflow ejecutado
3. Baja a la sección **Artifacts** al final de la página
4. Descarga el artefacto `allure-report`
5. Extrae el archivo y abre `index.html` en tu navegador

### Con Docker

Para visualizar el reporte directamente desde el contenedor, ejecuta:

```bash
docker run -p 8080:8080 -v $(pwd)/target/allure-results:/app/target/allure-results mvn-newman-allure sh -c "allure serve /app/target/allure-results"
```

## 🔧 Configuración del Proyecto

### Configuración de SonarCloud

Para realizar y enviar el análisis de calidad de código a SonarCloud (debes tener configurado tu token):

```bash
export SONAR_TOKEN=tu_token_aqui
mvn verify sonar:sonar
```

### Modificar la Colección de Postman

La colección de pruebas se configura en el plugin `exec-maven-plugin` dentro del `pom.xml`. Puedes cambiar la colección modificando el argumento de la ruta del archivo JSON.

## 📝 Notas

*   El plugin SonarQube está deshabilitado por defecto (`<phase>none</phase>`) para evitar conflictos. Si deseas habilitarlo, edita el `pom.xml` y cambia el phase a `verify`.
*   El reporte HTML se genera usando el plugin `allure-maven` versión 2.12.0.
*   Los artefactos subidos a GitHub Actions se mantienen por 30 días.