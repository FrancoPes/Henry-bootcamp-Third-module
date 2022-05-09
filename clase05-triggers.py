# TRIGGERS
#https://www.youtube.com/watch?v=kDu_5F159QA&list=LL&index=4

#-----------------------------------------------------------------------------------------------------------------------------------------------
#QUE SON LOS TRIGGERS?

# significa disparador y es ante todo un objeto
# es un objeto que realiza una accion cuando sucede algo
#? EL TRIGGER DEBE ESTAR RELACIONADO CON UNA TABLA SIEMPRE
# el trigger desencadena una accion predeterminada de forma automatica cuando ocurre una de las siguientes acciones:
#? INSERT
#? UPDATE
#? DELETE


#-----------------------------------------------------------------------------------------------------------------------------------------------
#APLICACIONES

#Puede actuar como registro, que usuario y a que hora y que cambios hizo
#es util para cargar los datos en el ware house
#es una proteccion, porque puedo crear una tabla antes de eliminar algo
#es decir que creamos una especie de copia de seguridad
# tareas de comprobacion (por ejemplo que los datos en edad no sean negativos por ejemplo)
#Los desencadenadores proporcionan otra forma de comprobar la integridad de los datos.
#Los desencadenadores controlan los errores de la capa de base de datos.
#Los desencadenadores ofrecen una forma alternativa de ejecutar tareas programadas. 
# Mediante el uso de desencadenadores, no tiene que esperar a que se ejecuten los eventos programados porque los desencadenadores se invocan automáticamente antes o después de que se realice un cambio en los datos de una tabla.
#Los desencadenadores pueden ser útiles para auditar los cambios de datos en las tablas.
#-----------------------------------------------------------------------------------------------------------------------------------------------
#sintaxis basica

#?CREATE TRIGGER trigger_name
#?{BEFORE | AFTER} {INSERT | UPDATE| DELETE }
#?ON table_name FOR EACH ROW \ FOR EACH STATEMENT
#?trigger_body;

#?To distinguish between the value of the columns BEFORE and AFTER the DML has fired, you use the NEW and OLD modifiers.

#-----------------------------------------------------------------------------------------------------------------------------------------------
#cuando hace la accion? 
#? puede ser antes o despues, depende de la situacion

#INSERT: No tiene sentido que sea antes, lo que nos interesa es llevar un registro de quien y cuando lo hizo, 
# con lo cual el trigger se hara despes

#-----------------------------------------------------------------------------------------------------------------------------------------------
#trigger de insercion: este simple trigger nos dara un registro de que se inserto y a que hora

#primero creamos una tabla, donde se alojen dichos registros
#?create table log_carrera (codigocarrera varchar(25), nombrecarrera varchar (50), tiempo datetime);

#luego creamos el trigger propiamente dicho
#le tenemos que dar un nombre. generalmente le ponemos el nombre de la tabla, si esta after, y si es inserty, update o delete
#luego del nombre, ponemos after si la accion se realiza despues o before si es antes
#luego le ponemos la accion que disparara el tigger (insert en este case) y a que tabla correspone
#debemos indicarle que se dispare por el lote de registros nuevos(FOR EACH STATEMENT) o por cada uno (FOR EACH ROW)
#ahora le decimos al trigger cual es su tarea. en esete caso en insertar en la tabla log carrera
# new hace referencia a el nuevo dato y old al viejo
#?create trigger carrera_ai after insert on carrera for each row insert into log_carrera(codigocarrera, nombrecarrera, tiempo) values (new.idcarrera, new.nombre, now());


#insertamos en carrera para ver el correcto funcionamiento del trigger
#?insert into carrera (nombre, duracion) values ('ingenieria espacial', 10);
#?select * from log_carrera;

#lo repetimos pero en este caso tendra un contador
#?insert into carrera (nombre, duracion) values ('ingenieria aeroespacial', 55);
#?select * from log_carrera;



#SE PUEDE AGREGAR UNA COLUMNA QUE CUENTE LOS NUEVOS INSERTS
#MODIFICAMOS LA TABLA Y CREAMOS UN NUEO TRIGGER
#?drop trigger carrera_ai;

#?ALTER TABLE `youtube`.`log_carrera` 
#?ADD COLUMN `idlogcarrera` INT NULL DEFAULT 0;
#?ALTER TABLE `youtube`.`log_carrera` 
#?CHANGE COLUMN `idlogcarrera` `idlogcarrera` INT NULL AUTO_INCREMENT ;


# creamos el nuevo trigger
#?create trigger carrera_ai after insert on carrera for each row insert into log_carrera(codigocarrera, nombrecarrera, tiempo) values (new.idcarrera, new.nombre, now());
# hacemos un insert nuevamente

#?insert into carrera (nombre, duracion) values (' biologia', 69);
#?select * from log_carrera;


#--------------------------------------------------------------------------------------------------------------------------------------------------------
#TRIGGER DE ACTUALIZACION
#aqui nos interesa guardar un registro de que se actualizo. es decir que nos interesa saber que valor habia antes
#ESTE TRIGGER DEBE EJECUTARSE ANTES, PORQUE SI SE EJECUTA DESPUES DE LA MODIFICACION, ENTONCES SE PIERDE EL VALOR VIEJO

#?create table log_carrera_update (idlogupdate int, antes_carrera varchar(25), despues_carrera varchar(25), antes_duracion int, despues_duracion int , tiempo_update datetime, usuario varchar(25));
#?ALTER TABLE `youtube`.`log_carrera_update` 
#?CHANGE COLUMN `idlogupdate` `idlogupdate` INT NOT NULL AUTO_INCREMENT ,
#?ADD PRIMARY KEY (`idlogupdate`);
#current_user() ---> usamos esta funcion para que almacene.
#?create trigger carrera_update_before before update on carrera for each row 
#?insert into log_carera_update(antes_carrera, despues_carrera, antes_duracion, despues_duracion, tiempo_update, usuario) 
#?values (old.nombre, new.nombre, old.duracion, new.duracion, now(), current_user());

#hacemos un update para chequear el correcto funcionamiento 
#?update carrera 
#?set duracion = 10 
#?where idcarrera = 3;

#ejemplos de triggers

'''
select * from log_carrera_update;

#procedures
#son procedimientos almacenados
#es una linea de codigo que se ejecuta cuando llamamos 

create procedure muestra_alumnos() 
select * from alumno;

#luego para ejecutar ese procedimiento almacenada, usamos la palabra CALL
call muestra_alumnos();

#creamos un procedure que sirva para insertar una nueva carrera
select * from carrera;
# tengo que pasarle parametros al igual que enlas funciones en python
create procedure insertar_nuevas_carreras(nombre_par varchar(25), duracion_par int)
insert into carrera(nombre, duracion) values (nombre = nombre_par, duracion = duracion_par);

#llamamos la procedure y le pasamos parametros
call insertar_nuevas_carreras('neurobiologia', 30);

select * from log_carrera;
#create trigger carrera_update_before before update on carrera for each row 
#insert into log_carera_update(antes_carrera, despues_carrera, antes_duracion, despues_duracion, tiempo_update, usuario) 
#values (old.nombre, new.nombre, old.duracion, new.duracion, now(), current_user());
#--------------------------------------------------------------------------------------------------------------------------------------
#TRIGGERS CONDICIONALES
#Los triggers nos pueden servir tambien como correctores. por ejemplo si inserto un valor y este no tiene que ser negativo, el trigger me lo puede pasar a cero
Delimiter $$
CREATE TRIGGER CORRECTOR_INSERTS_CARRERA AFTER INSERT ON CARRERA FOR EACH ROW
BEGIN
IF NEW.DURACION < 0 THEN 
SET NEW.DURATION = 0;
END IF;
END;$$

INSERT INTO CARRERA(NOMBRE, DURACION) VALUES ('ABOGACIA', -10); 

SELECT COUNT(*) FROM CARRERA;

DROP TRIGGER CORRECTOR_UPDATES_CARRERA;

'''
