@graphqlRequest
Feature: Probando api Graphql
  https://rickandmortyapi.com/documentation/

  @ignore
  Scenario: Filtrar un usuario en Graphql
    Given url 'https://rickandmortyapi.com/graphql'
    When text query =
    """
    query {
      character(id: 2) {
		name,
        status,
        gender
      }
    }
    """
    And request {query: '#(query)'}
    And method POST
    And match response.data.character.gender == 'Male'
    Then status 200

  @ignore
  Scenario Outline: Filtrar un usuario <nombreCaso> en Graphql
    Given url 'https://rickandmortyapi.com/graphql'
    When text query =
    """
    query {
      character(id: <id>) {
		<propiedades>,
        gender
      }
    }
    """
    And request {query: '#(query)'}
    And method POST
    And match response.data.character.gender == 'Male'
    Then status 200

    Examples:
      | nombreCaso | id | propiedades  |
      | con id 2   | 2  | name         |
      | con id 5   | 5  | name, status |

  #@ignore
  Scenario Outline: Filtrar un usuario <nombreCaso> en Graphql leyendo query desde txt
    Given url 'https://rickandmortyapi.com/graphql'
    When def query = read ('query.txt')
    And replace query.id = <id>
    And request {query: '#(query)'}
    And method POST
    And match response.data.character.gender == 'Male'
    Then status 200

    Examples:
      | nombreCaso | id |
      | con id 2   | 2  |
      | con id 5   | 5  |
      | con id 10  | 10 |