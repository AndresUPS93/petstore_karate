# ============================================================
# Feature: Gestión de Usuarios - PetStore API
# Descripción: Pruebas end-to-end del ciclo de vida de un usuario:
#              Crear → Buscar → Actualizar → Buscar actualizado → Eliminar
# Base URL: https://petstore.swagger.io/v2
# Autor: QA Junior
# Fecha: 2026-06-17
# ============================================================

Feature: Gestión completa del ciclo de vida de un usuario en PetStore API

  Background:
    # URL base de la API
    * url 'https://petstore.swagger.io/v2'

    # Datos del usuario a crear (se usa en múltiples escenarios)
    * def username = 'qauser_karate_2026'
    * def userPayload =
      """
      {
        "id": 999001,
        "username": "#(username)",
        "firstName": "Carlos",
        "lastName": "Ramirez",
        "email": "carlos.ramirez@qatest.com",
        "password": "Pass@1234",
        "phone": "3001234567",
        "userStatus": 1
      }
      """

  # ----------------------------------------------------------
  # ESCENARIO 1: Crear un usuario
  # Endpoint: POST /user
  # ----------------------------------------------------------
  Scenario: 1 - Crear un usuario nuevo en PetStore
    Given path '/user'
    And request userPayload
    When method POST
    Then status 200
    And match response.type == 'unknown'
    And match response.message == '#string'
    * print 'Usuario creado con ID:', response.message

  # ----------------------------------------------------------
  # ESCENARIO 2: Buscar el usuario creado
  # Endpoint: GET /user/{username}
  # ----------------------------------------------------------
  Scenario: 2 - Buscar el usuario recién creado por username
    Given path '/user/' + username
    When method GET
    Then status 200
    And match response.id == 999001
    And match response.username == username
    And match response.firstName == 'Carlos'
    And match response.lastName == 'Ramirez'
    And match response.email == 'carlos.ramirez@qatest.com'
    And match response.phone == '3001234567'
    And match response.userStatus == 1
    * print 'Usuario encontrado:', response

  # ----------------------------------------------------------
  # ESCENARIO 3: Actualizar nombre y correo del usuario
  # Endpoint: PUT /user/{username}
  # ----------------------------------------------------------
  Scenario: 3 - Actualizar nombre y correo del usuario existente
    * def updatedPayload =
      """
      {
        "id": 999001,
        "username": "#(username)",
        "firstName": "Carlos Actualizado",
        "lastName": "Ramirez",
        "email": "carlos.updated@qatest.com",
        "password": "Pass@1234",
        "phone": "3001234567",
        "userStatus": 1
      }
      """
    Given path '/user/' + username
    And request updatedPayload
    When method PUT
    Then status 200
    And match response.type == 'unknown'
    And match response.message == '#string'
    * print 'Usuario actualizado, mensaje:', response.message

  # ----------------------------------------------------------
  # ESCENARIO 4: Buscar el usuario actualizado y validar cambios
  # Endpoint: GET /user/{username}
  # ----------------------------------------------------------
  Scenario: 4 - Buscar el usuario y verificar que los cambios fueron aplicados
    Given path '/user/' + username
    When method GET
    Then status 200
    And match response.username == username
    And match response.firstName == 'Carlos Actualizado'
    And match response.email == 'carlos.updated@qatest.com'
    # Campos que NO deben haber cambiado
    And match response.lastName == 'Ramirez'
    And match response.phone == '3001234567'
    * print 'Datos actualizados verificados:', response

  # ----------------------------------------------------------
  # ESCENARIO 5: Eliminar el usuario
  # Endpoint: DELETE /user/{username}
  # ----------------------------------------------------------
  Scenario: 5 - Eliminar el usuario creado
    Given path '/user/' + username
    When method DELETE
    Then status 200
    And match response.type == 'unknown'
    And match response.message == username
    * print 'Usuario eliminado:', response.message

  # ----------------------------------------------------------
  # ESCENARIO 6 (validación final): Confirmar que el usuario fue eliminado
  # Endpoint: GET /user/{username} → debe retornar 404
  # ----------------------------------------------------------
  Scenario: 6 - Confirmar que el usuario eliminado ya no existe
    Given path '/user/' + username
    When method GET
    Then status 404
    And match response.type == 'error'
    And match response.message == 'User not found'
    * print 'Confirmado: usuario ya no existe en el sistema'
