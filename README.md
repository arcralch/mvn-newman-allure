# Maven-Newman-Allure Automation Project

Este proyecto está diseñado para ejecutar pruebas automatizadas de APIs mediante colecciones de **Postman**, utilizando **Newman** como motor de ejecución y **Maven** como orquestador del ciclo de vida. Además, integra **Allure Reports** para generar reportes visuales y detallados de los resultados de las pruebas.

## 🚀 Características Principales

*   **Orquestación con Maven**: Permite ejecutar pruebas de Newman directamente desde el ciclo de vida de Maven usando `exec-maven-plugin`.
*   **Pruebas de API con Postman**: Utiliza colecciones de Postman almacenadas en el proyecto, actualmente configurado para ejecutar `pokemon.postman_collection.json`.
*   **Reportes Visuales con Allure**: Genera de manera automática los resultados de Newman y levanta un servidor para visualizar el reporte en el navegador web con `allure-maven`.
*   **Limpieza Automática**: Limpia automáticamente los resultados de ejecuciones de pruebas de reportes obsoletos con `maven-antrun-plugin`.

## 📋 Requisitos Previos

Asegúrate de tener instalado lo siguiente en tu sistema:
1.  **[Java JDK 8 o superior](https://www.oracle.com/java/technologies/downloads/)**
2.  **[Apache Maven](https://maven.apache.org/download.cgi)**
3.  **[Node.js y npm](https://nodejs.org/es/)** instalado para poder utilizar Newman.

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

Para ejecutar las pruebas configuradas en la colección de Postman y limpiar cualquier resultado de ejecuciones previas de Allure, utiliza el comando estándar de pruebas en Maven por consola:

```bash
mvn clean test
```
*Este comando asegura una ejecución limpia borrando y volviendo a intentar cargar datos en la carpeta `allure-results/` antes de cada ejecución.*

## 📊 Visualización del Reporte (Allure Reports)

Estando las pruebas ejecutadas (terminen de manera exitosa o con fallas), puedes visualizar el reporte interactivo ejecutando este comando:

```bash
mvn allure:serve
```

Este comando interpretará los resultados JSON en la carpeta \`allure-results/\`, construirá un reporte HTML navegable de Allure, y abrirá automáticamente una pestaña en tu navegador web por defecto para visualizarlo interactivamente.