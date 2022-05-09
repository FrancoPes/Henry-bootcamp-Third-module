
'''

#homework 08
#1. Obtener un listado del nombre y apellido de cada cliente que haya adquirido algun producto junto al id del producto y su respectivo precio.
use checkpoint_m2;
select distinct (v.idcliente) as idcliente, c.Nombre_y_Apellido as nombre, v.precio as precio, v.idproducto as idproducto  from venta v 
join cliente c 
on (v.idcliente = c.idcliente);

#2. Obteber un listado de clientes con la cantidad de productos adquiridos, incluyendo aquellos que nunca compraron algún producto.

select c.idcliente as id, c.Nombre_y_Apellido as nombre_cliente, SUM(ifnull(v.Cantidad,0)) as total_producto_adq
from venta v
right outer join cliente c on (v.idcliente = c.idcliente) 
group by c.idcliente
order by total_producto_adq desc
LIMIT 100;   #-----> VEMOS QUIEN ES EL MAYOT COMPRADOR

#3. Obtener un listado de cual fue el volumen de compra por año de cada cliente. 

select (v.idcliente) as idcliente, c.Nombre_y_Apellido as nombre, sum(v.cantidad) as volumen, year(v.fecha) as anio
from venta v 
join cliente c on (v.idcliente = c.idcliente)  group by  v.idcliente, anio;


SELECT COUNT(*) FROM
(select (v.idcliente) as idcliente, c.Nombre_y_Apellido as nombre, sum(v.cantidad) as volumen, year(v.fecha) as anio
from venta v 
join cliente c on (v.idcliente = c.idcliente)  group by  v.idcliente, anio) AS T;


#4. Obtener un listado del nombre y apellido de cada cliente que haya adquirido algun producto junto al id del producto, la cantidad de productos adquiridos y el precio promedio.
select v.idcliente, c.Nombre_y_Apellido as nombre, sum(v.cantidad) as total_producto, avg(v.cantidad) as promedio
from venta v 
join cliente c on (v.idcliente = c.idcliente) group by v.idcliente;

#5. Cacular la cantidad de productos vendidos y la suma total de ventas para cada localidad, presentar el análisis en un listado con el nombre de cada localidad.
SELECT c.localidad as localidad, v.precio * v.cantidad as total FROM VENTA v join cliente c group by localidad;

#6. Cacular la cantidad de productos vendidos y la suma total de ventas para cada provincia, presentar el análisis en un listado con el nombre de cada provincia, pero solo en aquellas donde la suma total de las ventas fue superior a $100.000.
select sum(v.cantidad) as total_cant, sum(v.cantidad * v.precio) as total_venta, c.provincia as provincia
from venta v 
join cliente c on (v.idcliente = c.idcliente) group by provincia having total_venta > 100000;




#7. Obtener un listado de dos campos en donde por un lado se obtenga la cantidad de productos vendidos por rango etario y las ventas totales en base a esta misma dimensión. El resultado debe obtenerse en un solo listado.

USE CHECKPOINT_M2;
select sum(v.cantidad) as total_cant, sum(v.cantidad * v.precio) as total_venta, Rango_Etario as RANGO_EDAD
from venta v
join cliente c on (v.idcliente = c.idcliente) group by Rango_Etario;

#8. Obtener la cantidad de clientes por provincia.
select count(idcliente), provincia from cliente group by provincia;

'''