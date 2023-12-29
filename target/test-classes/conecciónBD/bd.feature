Feature: Conección a base de datos

  Background:
    * def config = {username: 'root', password: '', url: 'jdbc:mysQL://localhost:3306/registros', driverClassName: 'com.mysql.cj.jdbc.Driver'}
    * def DBUtils = Java.type('conecciónBD.DbUtils')
    * def db = new DBUtils(config)

    Scenario: Lectura de valores de la Base de Datos
      * def usuario = db.readRows('SELECT * FROM usuarios')
      Then print 'usuario--' ,usuario