===============================================================
  PETSTORE API - PRUEBAS AUTOMATIZADAS CON KARATE DSL
  Ejercicio 2 - QA Junior
  Fecha: 2026-06-17
===============================================================

DESCRIPCIÓN DEL PROYECTO
--------------------------
Pruebas automatizadas del ciclo de vida de un usuario sobre la API
pública de PetStore (https://petstore.swagger.io/).

Casos de prueba implementados:
  1. Crear un usuario            → POST /user
  2. Buscar el usuario creado    → GET  /user/{username}
  3. Actualizar nombre y correo  → PUT  /user/{username}
  4. Buscar el usuario actualizado → GET /user/{username}
  5. Eliminar el usuario         → DELETE /user/{username}
  6. Confirmar eliminación       → GET /user/{username} (espera 404)

===============================================================
  PRE-REQUISITOS
===============================================================

1. Java JDK 11 o superior
   - Verificar: java -version
   - Descargar: https://adoptium.net/

2. Apache Maven 3.6 o superior
   - Verificar: mvn -version
   - Descargar: https://maven.apache.org/download.cgi

3. Conexión a Internet (para alcanzar https://petstore.swagger.io)

4. Git (para clonar el repositorio)
   - Verificar: git --version

===============================================================
  ESTRUCTURA DEL PROYECTO
===============================================================

petstore_karate/
│
├── pom.xml                              ← Configuración Maven + dependencias Karate
├── README.txt                           ← Este archivo
├── conclusiones.txt                     ← Hallazgos y conclusiones
│
└── src/
    └── test/
        └── java/
            ├── com/petstore/
            │   └── PetstoreRunner.java  ← Clase ejecutora JUnit5
            │
            └── features/
                ├── karate-config.js     ← Configuración global (URL, headers, timeouts)
                └── petstore_user.feature ← Escenarios de prueba (Gherkin/Karate DSL)

===============================================================
  PASOS DE EJECUCIÓN
===============================================================

--- OPCIÓN A: Línea de Comandos (Maven) ---

Paso 1: Clonar el repositorio
  git clone https://github.com/<tu-usuario>/petstore_karate.git
  cd petstore_karate

Paso 2: Descargar dependencias (solo la primera vez)
  mvn dependency:resolve

Paso 3: Ejecutar todas las pruebas
  mvn test

Paso 4: Ver el reporte HTML generado
  Abrir en el navegador:
  target\karate-reports\karate-summary.html

--- OPCIÓN B: Ejecutar un escenario específico ---

  mvn test -Dkarate.options="--tags @nombre_tag"

--- OPCIÓN C: Desde un IDE (IntelliJ IDEA / VS Code) ---

  1. Abrir el proyecto como proyecto Maven
  2. Esperar que descargue las dependencias automáticamente
  3. Abrir src/test/java/com/petstore/PetstoreRunner.java
  4. Click derecho → "Run PetstoreRunner"
  5. El reporte se genera en target/karate-reports/

===============================================================
  DÓNDE VER LOS RESULTADOS
===============================================================

• Reporte HTML visual:
    target\karate-reports\karate-summary.html

• Reporte XML (para CI/CD):
    target\surefire-reports\

• Log en consola:
    Visible directamente al ejecutar mvn test

===============================================================
  NOTAS IMPORTANTES
===============================================================

- La API de PetStore es pública y compartida. Si un test falla
  intermitentemente, puede deberse a que otro usuario modificó
  los mismos datos. Re-ejecutar suele resolver el problema.

- El username usado es 'qauser_karate_2026' para minimizar
  colisiones con otros usuarios de la API pública.

- Los tests están diseñados para ejecutarse en orden secuencial
  (escenario 1 al 6), ya que cada uno depende del anterior.

===============================================================
  TECNOLOGÍAS UTILIZADAS
===============================================================

  - Karate DSL 1.4.1  → Framework de pruebas API
  - JUnit 5           → Motor de ejecución de tests
  - Apache Maven      → Gestión de dependencias y build
  - Java 11           → Lenguaje base

===============================================================
