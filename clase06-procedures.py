#PROCEDURES
#Son basicamente precesos que podemos almacenar y que simplifican las tareas
#se crea con CREATE PROCEDURE NOMBRE
#puede tener cero, uno o varios parametros


#VENTAJAS
# Make database more secure
# Centralize business logic in the database
# Reduce network traffic

#DESVENTAJAS
# If you use many stored procedures, the memory usage of every connection will increase substantially.
# It’s difficult to debug stored procedures. Unfortunately, MySQL does not provide any facilities to debug stored procedures like other enterprise database products such as Oracle and SQL Server.
# Developing and maintaining stored procedures often requires a specialized skill set that not all application developers possess. This may lead to problems in both application development and maintenance

#LISTAR PROCEDURES
#https://www.mysqltutorial.org/listing-stored-procedures-in-mysql-database.aspx


#SINTAXIS BASICA
#?DELIMITER //

#?CREATE PROCEDURE GetAllProducts()
#?BEGIN
#?	SELECT *  FROM products;
#?END //

#?DELIMITER ;

#luego, para llamar el procedure:
#? call nameprocedure(parameters);


#VARIABLES
#https://www.youtube.com/watch?v=o6cHAEFxDBI
# Para crear una variable definida por el usuario
#?SET @NOMBRE = 'FFF';

#Una variable definida por el usuario definida por un cliente no es visible para otros clientes. 
#Tenga en cuenta que las variables definidas por el usuario son la extensión específica de MySQL 
#dos formas de asignar:
#con set
#? SET @variable_name := value;
# con select
#? SELECT @variable_name := value;


#ejemplo
#?SET @NOMBRE = 'FFF';

#?SELECT @NOMBRE AS MINOMBRE;

#EJEMPLO. ver si el curso es corto
#?SET @duracion_meses = 10;
#?select *
#?from carrera
#?where duracion <= @duracion_meses;

#! importante, puedo modificar las variables


#VARIABLES EN PROCEDURES
# Normalmente, se utilizan variables en los procedimientos almacenados para obtener resultados inmediatos. 
# Estas variables son locales para el procedimiento almacenado.
# Para declarar una variable dentro de un procedimiento almacenado, utilice la instrucción DECLARE
#? DECLARE variable_name datatype(size) [DEFAULT default_value];

# MySQL le permite declarar dos o más variables que comparten el mismo tipo de datos utilizando una sola instrucción:
#? DECLARE x, y INT DEFAULT 0;

#Una vez que se declara una variable, está lista para usar.
# Para asignar un valor a una variable, utilice la instrucción SET
#? DECLARE total INT DEFAULT 0;
#? SET total = 10;

# Además de la instrucción, puede utilizarla para asignar el resultado de una consulta a una variable,
# como se muestra en el ejemplo siguiente SET SELECT INTO

#? DECLARE productCount INT DEFAULT 0;

#? SELECT COUNT(*) 
#? INTO productCount
#? FROM products;


# en los procedures, las variavles pueden ser de entrada IN o de salida OUT
#Para los OUT, le tengo que pasar al call una variable @variable para guardar el dato

#condicionales

#? IF Condicion THEN ...;
#? END IF;
#O TAMBIEN
#? IF Condicion THEN ...;
#? ELSE ....;
#? END IF;

#VARIABLES
#dentro y fuera puedo declarar variables como set @cantidad_carrera = 0;
#dentro de los procedures tambien puedo declarar:
#? declare variable int;
#? set variable = 10; 

#SELECT EN UN STORE PROCEDURE
# ME PUEDEN RETORNAR: TABLA O ESCALAR
# PARAMETRIZADO O NO PARAMETRIZADO



#INSERT
#le paso en los parametros que serian los insert
# https://www.youtube.com/watch?v=-AxwYHcG2F4


#?SET @NOMBRE = false;

#?SELECT @NOMBRE AS MINOMBRE;

#EJEMPLO. ver si el curso es corto
#?SET @duracion_meses = 10;
#?select *
#?from carrera
#?where duracion <= @duracion_meses;

#tambien puedo almacenar el valor de una consulta en una variable
#?use youtube;
#?set @cantidadcarreras = 0;  #----> le ponemos cero por default
#?select count(*) into @cantidadcarreras from carrera;
#?select @cantidadcarreras;

#ejemplo de procedimiento almacenado
#lo procedimientos almacenados tienen parametros de entrada y de salida; IN es la entrada y OUT es el return
#?delimiter //
#?create procedure procedimiento2(in numero int)
#?begin
#?select * from carrera where duracion > numero;
#?end//
#luego llamo la funcion
#?call procedimiento1(20);

#tambien puedo crear un procedure que devuelva la cantidad de carreras que tienen cierto nivel de duracion.
#eso lo puedo grabar en una variable
#?delimiter //
#?create procedure procedimiento2(in numero int, out numero2 int)
#?begin
#?select count(*) into numero2 from carrera where duracion > numero;
#?end//

#luego llamo la funcion
#?set @cantidad_carrera = 0;
#?call procedimiento2(20);

#?show local variables;

# SELECT 
#?-- 1) seleccionar las carreras SI su duracion es un numero par o si es impar 
#?delimiter //
#?create procedure procedimiento_par2(in palabra varchar(5))
#?begin
#?set @mensaje = 'por favor, escriba par o impar';
#?if palabra = 'par' then
#?	select * from carrera where duracion % 2 = 0;
#?ELSEIF palabra = 'impar' then
#?	select * from carrera where duracion % 2 != 0;
#?ELSEIF palabra not in ('par', 'impar') then
#?	select @mensaje as mensaje_error;
#?END IF;
#?end//

#?call procedimiento_par2('impar');

#?-- 2) el usuario mete el parametro "nombre de la carrera" y devuelve la duracion en numero si la carrera esta en la tabla

#?delimiter //
#?create procedure procedimiento_duracion1(in palabra varchar(20))
#?begin
#?if exists (select nombre from carrera where nombre = palabra) then
#?	select duracion from carrera where nombre = palabra;
#?END IF;
#?end//

#?call procedimiento_duracion1('economia');
#INSERT

#?delimiter //
#?create procedure procedimiento_insertion_carrera(in nombre_carrera varchar(20), in duracion_carrera int)
#?begin
#?set @mensaje1 = 'la carrera ya esta insertada';
#?set @mensaje2 = 'la carrera se inserto correctamente';
#?if not exists (select nombre from carrera where nombre = nombre_carrera) then
#?	insert into carrera(nombre, duracion) values (nombre_carrera, duracion_carrera);
 #?   select @mensaje2;
#?ELSE 
#?	select @mensaje1;
#?END IF;
#?end//

#?call procedimiento_insertion_carrera('arquitecto', 10);


#DIFERENCIA ENTRE VARIABLES PROPIAS DEL PROCEDURE Y VARIABLES GLOBALES
#?delimiter //
#?create procedure procedimiento_prueba1()
#?begin
#?declare mens1 varchar(50) default null;
#?set mens1 = 'variable definida dentro de un procedure';
#?select mens1;
#?end//

#?call procedimiento_prueba1();

#?select mens1; #-----> no me sale. porque es una variable propia del procedure

#UPDATES
#?delimiter //
#?create procedure procedimiento_UPDATE_carrera(in nombre_carrera_vieja varchar(30), in nombre_carrera_nuevo varchar(30),  in duracion_carrera_vieja int, in duracion_carrera_nueva int)
#?begin
#?declare mensaje varchar(30);
#?set mensaje = 'los cambios se registraron satisfactoriamente';
#?update carrera set nombre = duracion_carrera_vieja, duracion = duracion_carrera_nueva where nombre = nombre_carrera_vieja and duracion = duracion_carrera_vieja;
#?select mensaje;
#?end//


#?call procedimiento_UPDATE_carrera('economia','lic. en economia',2 , 25);

##MAS EJEMPLOS 


























































































