# Proyecto Maven-Newman
Este proyecto se creo para ejecutar pruebas automatizadas con elementos creados en postman

## Instalación de newman en el equipo
```bash
  npm install -g newman                                                            
  npm install -g newman-reporter-allure
```

## Ejecucion de pruebas
```bash 
  mvn clean test
```

## Ejecución de reporte Allure Reports
```bash
  mvn allure:serve
```