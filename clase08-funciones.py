
# FUNCIONES

#A DIFERENCIA DE LOS PROCEDURES:
# solo tienen parametros de entrada y NO tiene para metros out
#las funciones retornan un valor. EM CAMBIO LOS PROCEDURES, DEVUELVEN UNO MAS O NINGUNO
# Las funciones se pueden utilizar en una sentencia

#SINTAXIS
#? delimiter //
#? create funtion nombre (parametro_nombre tipo) returns tipo 
#? begin
#? declare variable int;
#? ACCIONES;
#? return variable;
#? end



# RECORDAR SIEMPRE EL INTO

#ejemplos
#? delimiter //
#?CREATE DEFINER=`root`@`localhost` FUNCTION `NAME`( PARAMETRO TYPE(255) ) RETURNS TYPE CHARSET utf8
#?begin 
#?	declare numero int;
 #?   select count(*) INTO NUMERO from ciudadano where  NOMBRE like 'letra%';
  #?  RETURN numero;
#?end//













































#