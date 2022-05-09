
'''
select * from cliente;


select total from
(select sum(precio * cantidad) as total, rango_etario from venta v
join cliente c
on (v.idcliente = c.idcliente)
group by rango_etario) as t
where rango_etario = '4_De 51 a 60 años';


delimiter //
create procedure procedimiento_rango_etario_11(in rango varchar(50))
begin
set @m1 = 'introducir un rango etario correcto';
if exists (select rango_etario = rango from cliente) then
select total from
(select sum(precio * cantidad) as total, rango_etario from venta v
join cliente c
on (v.idcliente = c.idcliente)
group by rango_etario) as t
where rango_etario = rango;
select @m1;
elseif not exists (select rango_etario = rango from cliente) then
	select @m1 as error;
end if;
end //

call procedimiento_rango_etario_11 ('lll');
'''

'''
SET @NOMBRE = false;

SELECT @NOMBRE AS MINOMBRE;

#EJEMPLO. ver si el curso es corto
SET @duracion_meses = 10;
select *
from carrera
where duracion <= @duracion_meses;

#tambien puedo almacenar el valor de una consulta en una variable
use youtube;
set @cantidadcarreras = 0;  #----> le ponemos cero por default
select count(*) into @cantidadcarreras from carrera;
select @cantidadcarreras;

#ejemplo de procedimiento almacenado
#lo procedimientos almacenados tienen parametros de entrada y de salida; IN es la entrada y OUT es el return
delimiter //
create procedure procedimiento2(in numero int)
begin
select * from carrera where duracion > numero;
end//
#luego llamo la funcion
call procedimiento1(20);

#tambien puedo crear un procedure que devuelva la cantidad de carreras que tienen cierto nivel de duracion.
#eso lo puedo grabar en una variable
delimiter //
create procedure procedimiento2(in numero int, out numero2 int)
begin
select count(*) into numero2 from carrera where duracion > numero;
end//

#luego llamo la funcion
set @cantidad_carrera = 0;
call procedimiento2(20);

show local variables;

# SELECT 
-- 1) seleccionar las carreras SI su duracion es un numero par o si es impar 
delimiter //
create procedure procedimiento_par2(in palabra varchar(5))
begin
set @mensaje = 'por favor, escriba par o impar';
if palabra = 'par' then
	select * from carrera where duracion % 2 = 0;
ELSEIF palabra = 'impar' then
	select * from carrera where duracion % 2 != 0;
ELSEIF palabra not in ('par', 'impar') then
	select @mensaje as mensaje_error;
END IF;
end//

call procedimiento_par2('impar');

-- 2) el usuario mete el parametro "nombre de la carrera" y devuelve la duracion en numero si la carrera esta en la tabla

delimiter //
create procedure procedimiento_duracion1(in palabra varchar(20))
begin
if exists (select nombre from carrera where nombre = palabra) then
	select duracion from carrera where nombre = palabra;
END IF;
end//

call procedimiento_duracion1('economia');
#INSERT

delimiter //
create procedure procedimiento_insertion_carrera(in nombre_carrera varchar(20), in duracion_carrera int)
begin
set @mensaje1 = 'la carrera ya esta insertada';
set @mensaje2 = 'la carrera se inserto correctamente';
if not exists (select nombre from carrera where nombre = nombre_carrera) then
	insert into carrera(nombre, duracion) values (nombre_carrera, duracion_carrera);
    select @mensaje2;
ELSE 
	select @mensaje1;
END IF;
end//

call procedimiento_insertion_carrera('arquitecto', 10);


#DIFERENCIA ENTRE VARIABLES PROPIAS DEL PROCEDURE Y VARIABLES GLOBALES
delimiter //
create procedure procedimiento_prueba1()
begin
declare mens1 varchar(50) default null;
set mens1 = 'variable definida dentro de un procedure';
select mens1;
end//

call procedimiento_prueba1();

select mens1; #-----> no me sale. porque es una variable propia del procedure

#UPDATES
delimiter //
create procedure procedimiento_UPDATE_carrera(in nombre_carrera_vieja varchar(30), in nombre_carrera_nuevo varchar(30),  in duracion_carrera_vieja int, in duracion_carrera_nueva int)
begin
declare mensaje varchar(30);
set mensaje = 'los cambios se registraron satisfactoriamente';
update carrera set nombre = duracion_carrera_vieja, duracion = duracion_carrera_nueva where nombre = nombre_carrera_vieja and duracion = duracion_carrera_vieja;
select mensaje;
end//


call procedimiento_UPDATE_carrera('economia','lic. en economia',2 , 25);

##MAS EJEMPLOS

'''

