@soapRequest
Feature: Probando api Soap

  #soap solo funciona con POST
  @ignore
  Scenario: Convertir número a palabras en Soap
    Given url 'https://www.dataaccess.com/webservicesserver/NumberConversion.wso'
    When header Content-Type = 'text/xml'
    And request
    """
    <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <NumberToWords xmlns="http://www.dataaccess.com/webservicesserver/">
          <ubiNum>500</ubiNum>
        </NumberToWords>
      </soap:Body>
    </soap:Envelope>
    """
    And method POST
    And match response/Envelope/Body/NumberToWordsResponse/NumberToWordsResult == 'five hundred '
    Then status 200

  @ignore
  Scenario Outline: Convertir <casoPrueba> a palabras en Soap
    Given url 'https://www.dataaccess.com/webservicesserver/NumberConversion.wso'
    When header Content-Type = 'text/xml'
    And request
    """
    <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <NumberToWords xmlns="http://www.dataaccess.com/webservicesserver/">
          <ubiNum><num></ubiNum>
        </NumberToWords>
      </soap:Body>
    </soap:Envelope>
    """
    And method POST
    #And match response/Envelope/Body/NumberToWordsResponse/NumberToWordsResult == 'five hundred '
    Then status <status>

    Examples:
      | casoPrueba            | num   | status |
      | número 500            | 500   | 200    |
      | número 800            | 800   | 200    |
      | número formato string | "800" | 200    |
      | número null           | null  | 200    |
      | número vacío          |       | 200    |

  @ignore
  Scenario Outline: Convertir <casoPrueba> a palabras en Soap 2
    Given url 'https://www.dataaccess.com/webservicesserver/NumberConversion.wso'
    When header Content-Type = 'text/xml'
    And request
    """
    <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <NumberToWords xmlns="http://www.dataaccess.com/webservicesserver/">
          <ubiNum><num></ubiNum>
        </NumberToWords>
      </soap:Body>
    </soap:Envelope>
    """
    And method POST
    #And match response/Envelope/Body/NumberToWordsResponse/NumberToWordsResult == '<asercion> '
    And match response/Envelope/Body/NumberToWordsResponse/NumberToWordsResult == '<asercion>'
    Then status 200

    Examples:
      | casoPrueba | num | asercion |
      #| número 500 | 500 | five hundred |
      #| número 11  | 11  | eleven       |
      | número 200 | 200 | #string  |

  #@ignore
  Scenario Outline: Leer archivo xml
    Given url 'https://www.dataaccess.com/webservicesserver/NumberConversion.wso'
    When header Content-Type = 'text/xml'
    And def body = read ('body.xml')
    And request body
    And method POST
    Then status 200

    Examples:
      | num |
      | 2   |
      | 800 |
      | 11  |
      | 999 |