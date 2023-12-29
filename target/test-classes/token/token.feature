@token
Feature: Probando apis con token

  --elementos bearer token:
  https://api.github.com/user/repos
  token :  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

  --elementos basic authentication:
  https://postman-echo.com/basic-auth
  username : postman
  password : password

  @ignore
  Scenario: Obtener token para consumir
    * configure connectTimeout = 5000
    * configure readTimeout = 5000
    * url = 'https://seguridad.test.uat.cl'
    * header 'Content-Type' = 'application/x-www-form-urlencode'
    * form fields grant_type = 'password'
    * form fields client_id = 'ID'
    * form fields client_secret = 'secret'
    * form fields username = 'user'
    * form fields password = 'password'
    When method POST
    Then status 200
    And match reponseType == 'json'

  @ignore
  Scenario: Obtener token para consumir 2
    * configure connectTimeout = 5000
    * configure readTimeout = 5000
    * url 'https://demoqa.com/Account/v1/GenerateToken'
    * header 'Content-Type' = 'application/json'
    * header 'accept' = 'application/json'
    When request {"userName": "jeff","password": "Backinblack12#"}
    And method POST
    Then status 200

  @ignore
  Scenario: Obtener bearer token
    Given url 'https://api.github.com/user/repos'
    When header Authorization = 'bearer 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'
    And method GET
    Then status 200

  @ignore
  Scenario: Obtener token básico
    Given url 'https://postman-echo.com/basic-auth'
    When header Authorization = 'Basic cG9zdG1hbjpwYXNzd29yZA=='
    And method GET
    Then status 200

  Scenario: Obtener token básico desde archivo
    Given url 'https://postman-echo.com/basic-auth'
    When header Authorization = call read('tokenB.js') {username:'postman', password:'password'}
    And method GET
    Then status 200
