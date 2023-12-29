Feature: Probando api Rest
#karate.configure('connectTimeout', 5000);

  Background:
    * url 'https://reqres.in/api'

  #@ignore
  Scenario: Obteniendo un usuario
    * path 'users/2'
    When header 'Content-Type' = 'application/json'
    * configure connectTimeout = 5000
    * configure readTimeout = 5000
    When method GET
    Then status 200
    And match response.data.email == 'janet.weaver@reqres.in'

  @ignore
  Scenario: Creando un usuario
    * path 'users'
    When request {"name": "morpheus","job": "leader"}
    And method POST
    Then status 201

  @ignore
  Scenario: Creando un usuario 2
    * path 'users'
    When request
    """
      {
        "name": "jeff",
        "job": "qa"
      }
    """
    And method POST
    Then status 201

  @ignore
  Scenario: Eliminando un usuario
    * path 'users/2'
    When method DELETE
    Then status 204

  @ignore
  Scenario: Actualizando un usuario
    * path 'users/2'
    When request {"name": "jeff","job": "zion resident"}
    And method PUT
    Then status 200

  @ignore
  Scenario: Obteniendo datos con delay
    * path 'users'
    * params {delay: 3}
    * configure readTimeout = 4000
    When method GET
    Then status 200

  @ignore
  Scenario Outline: Obteniendo el usuario <nombreCaso>
    * path 'users/<id>'
    When header 'Content-Type' = 'application/json'
    * configure connectTimeout = 5000
    * configure readTimeout = 5000
    When method GET
    Then status <estadoHTTP>

    Examples:
      | nombreCaso       | id | estadoHTTP |
      | con id 1         | 1  | 200        |
      | con id 2         | 2  | 200        |
      | con id 3         | 3  | 200        |
      | con id not found | 50 | 404        |

  @ignore
  Scenario Outline: Creando un usuario <nombreCaso>
    * path 'users'
    When request {"name": <vName>,"job": <vJob>}
    And method POST
    Then status 201

    Examples:
      | nombreCaso          | vName | vJob         |
      | con nombre vacío    |       | "QA"         |
      | con nombre nulo     | null  | "QA Trainee" |
      | con nombre 3 letras | "Jef" | "QA Lead"    |

  @ignore
  Scenario Outline: Creando un usuario <nombreCaso> leyendo desde csv
    * path 'users'
    When request {"name": <vName>,"job": <vJob>}
    And method POST
    Then status 201

    Examples:
      | read('test.csv') |

  #@ignore
  Scenario Outline: Creando un usuario <nombreCaso> leyendo request desde json y leyendo ejemplos desde csv
    * path 'users'
    When def body = read ('body.json')
    And request body
    And method POST
    Then status 201

    Examples:
      | read('test.csv') |