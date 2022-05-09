USE `henry_checkpoint_m3`;
select * from cliente;
select * from calendario;
select * from canal_venta;
select * from cargo;
select * from cliente;
select * from compra;
select * from empleado;
select * from gasto;
select * from localidad;
select * from producto;
select * from producto;
select * from proveedor;
select * from sector;
select * from sucursal;
select * from tipo_gasto;
select * from tipo_producto;
select * from venta;
################################################################################################################################################################################
### 6) La ganancia neta por sucursal es las ventas menos los gastos (Ganancia = Venta - Gasto) ¿Cuál es la sucursal con mayor ganancia neta en 2020? 

-- 1) saco las ventas totales por sucursale en 2020
#select * from venta;
#select * from sucursal

select v.idsucursal as idsucursal, 
s.sucursal as sucursal, 
sum(v.precio * v.cantidad) as total_venta 
from venta v join sucursal s on (v.idsucursal = s.idsucursal) and year(fecha) = 2020
group by v.idsucursal;

-- 2) sacos los gastos totales por sucursal en 2020
select * from gasto;
#select * from tipo_gasto;

select g.IdSucursal as idsucursal, 
s.Sucursal as sucursal, 
sum(g.monto) as gasto_total 
from gasto g join sucursal s on (g.Idsucursal = s.idsucursal) and year(fecha) = 2020 
group by s.IdSucursal; 

-- 3) los junto y hago el kpi

SELECT *, V.TOTAL_VENTA - G.GASTO_TOTAL AS GANANCIA
 FROM (select v.idsucursal as idsucursal, 
s.sucursal as sucursal, 
sum(v.precio * v.cantidad) as total_venta 
from venta v join sucursal s on (v.idsucursal = s.idsucursal) and year(fecha) = 2020
group by v.idsucursal) AS V
JOIN (select g.IdSucursal as idsucursal, 
s.Sucursal as sucursal, 
sum(g.monto) as gasto_total 
from gasto g join sucursal s on (g.Idsucursal = s.idsucursal) and year(fecha) = 2020 
group by s.IdSucursal) AS G 
ON (V.IDSUCURSAL = G.IDSUCURSAL) ORDER BY GANANCIA DESC ;


### 7) La ganancia neta por producto es las ventas menos las compras (Ganancia = Venta - Compra) ¿Cuál es el tipo de producto con mayor ganancia neta en 2020?

-- SACO LAS VENTAS TOTALES POR TIPO
SELECT T.IDTIPOPRODUCTO AS IDTIPOPRODUCTO, T.TIPOPRODUCTO AS TIPO, SUM(V.PRECIO * V.CANTIDAD) AS VENTA_POR_TIPO
 FROM VENTA V JOIN PRODUCTO P ON (V.IDPRODUCTO = P.IDPRODUCTO) 
 JOIN tipo_producto AS T ON (T.IdTipoProducto = P.IdTipoProducto) AND YEAR(FECHA) = 2020
 group by T.IDTIPOPRODUCTO;

# V
-- SACO LAS COMPRAS POR TIPO DE PRODUCTO

SELECT T.IDTIPOPRODUCTO AS IDTIPOPRODUCTO, T.TIPOPRODUCTO AS TIPO, SUM(C.PRECIO * C.CANTIDAD) AS COMPRA_POR_TIPO
 FROM COMPRA C JOIN PRODUCTO P ON (C.IDPRODUCTO = P.IDPRODUCTO) 
 JOIN tipo_producto AS T ON (T.IdTipoProducto = P.IdTipoProducto) AND YEAR(FECHA) = 2020
 group by T.IDTIPOPRODUCTO;
#C

-- JOIN Y COMPRA
SELECT *, V.VENTA_POR_TIPO - C.COMPRA_POR_TIPO AS GANANCIA_TIPO_2020 FROM (SELECT T.IDTIPOPRODUCTO AS IDTIPOPRODUCTO, T.TIPOPRODUCTO AS TIPO, SUM(V.PRECIO * V.CANTIDAD) AS VENTA_POR_TIPO
 FROM VENTA V JOIN PRODUCTO P ON (V.IDPRODUCTO = P.IDPRODUCTO) 
 JOIN tipo_producto AS T ON (T.IdTipoProducto = P.IdTipoProducto) AND YEAR(FECHA) = 2020
 group by T.IDTIPOPRODUCTO) AS V
 JOIN 
 (SELECT T.IDTIPOPRODUCTO AS IDTIPOPRODUCTO, T.TIPOPRODUCTO AS TIPO, SUM(C.PRECIO * C.CANTIDAD) AS COMPRA_POR_TIPO
 FROM COMPRA C JOIN PRODUCTO P ON (C.IDPRODUCTO = P.IDPRODUCTO) 
 JOIN tipo_producto AS T ON (T.IdTipoProducto = P.IdTipoProducto) AND YEAR(FECHA) = 2020
 group by T.IDTIPOPRODUCTO) AS C
 ON (V.IDTIPOPRODUCTO = C.IDTIPOPRODUCTO)
 ORDER BY GANANCIA_TIPO_2020 DESC;
 
 ### 8) Del total de clientes que realizaron compras en 2020 ¿Qué porcentaje lo hizo sólo en una única sucursal?
 -- TOTAL DE CLIENTES QUE HICIERON COMPRA EN 2020 (DISTINCT DE CLIENTES QUE WHERE YEAR 2020)
 SELECT COUNT(*) FROM (SELECT * FROM VENTA WHERE YEAR(FECHA) = 2020 group by IDCLIENTE) AS C; #2415
 -- HECHO DE OTRA FORMA
  SELECT COUNT(*) FROM ( SELECT distinct(IDCLIENTE) FROM VENTA WHERE YEAR(FECHA) = 2020) AS C; #2415 CLIENTES HICIERON COMPRA EN 2020
 
 -- EN CUANTAS SUCURSALES LO HICIERON
 CREATE TABLE TABLASIETE AS(
SELECT * FROM VENTA WHERE YEAR(FECHA) = 2020 group by IDCLIENTE, IDSUCURSAL order by IDCLIENTE
);
SELECT * FROM VENTA WHERE YEAR(FECHA) = 2020 group by IDCLIENTE, IDSUCURSAL order by IDCLIENTE;

-- CONTAR LA CANTIDAD DE VECES QUE SE REPITE IDCLIENTE EN LA TABLA ANTERIOR
SELECT COUNT(IDCLIENTE) AS SUCURSAL_DISTINTA, IDCLIENTE FROM TABLASIETE GROUP BY IDCLIENTE;
 
 #A LA TABLA ANTERIOR LE AGREGAMOS LA CONDICION
 SELECT COUNT(IDCLIENTE) AS SUCURSAL_DISTINTA, IDCLIENTE FROM TABLASIETE GROUP BY IDCLIENTE HAVING COUNT(IDCLIENTE) = 1;
 
 #LOS CONTAMOS
 SELECT COUNT(*) FROM ( SELECT COUNT(IDCLIENTE) AS SUCURSAL_DISTINTA, IDCLIENTE FROM TABLASIETE GROUP BY IDCLIENTE HAVING COUNT(IDCLIENTE) = 1) AS P;  #817
 #############################################################################################################################################
   ### 9) Del total de clientes que realizaron compras en 2020 ¿Qué porcentaje no había realizado compras en 2019?
  # SE RESUELVE CON UN IN OR NOT IN 
  
 # QUIENES COMPRAROS EN 2020 
SELECT IDCLIENTE FROM VENTA WHERE YEAR(FECHA) = 2020 group by IDCLIENTE; #---> LISTA DE CLIENTES QUE REALIZARON UNA COMPRA EN 2020
#LISTA DE CLIENTES DE QUIENES COMPRARON EN 2019
SELECT IDCLIENTE FROM VENTA WHERE YEAR(FECHA) = 2019 group by IDCLIENTE;   #---> REALIZARON UNA COMPRA EN 2019



#QUIENES NO REALIZARON UNA COMPRA EN 2019
SELECT IDCLIENTE FROM CLIENTE WHERE IDCLIENTE NOT IN (SELECT IDCLIENTE FROM VENTA WHERE YEAR(FECHA) = 2019 group by IDCLIENTE); #CLIENTES QUE NO REALIZARON 


#SELECT COUNT(*) FROM (SELECT IDCLIENTE FROM CLIENTE WHERE IDCLIENTE NOT IN (SELECT IDCLIENTE FROM VENTA WHERE YEAR(FECHA) = 2019 group by IDCLIENTE)) AS H; 

#TABLA CON LO ANTERIOR
CREATE TABLE TABLAOCHO AS (SELECT IDCLIENTE FROM CLIENTE WHERE IDCLIENTE NOT IN (SELECT IDCLIENTE FROM VENTA WHERE YEAR(FECHA) = 2019 group by IDCLIENTE));

#SACO LA INTERSECCION DE LAS DOS LISTAS
SELECT IDCLIENTE FROM TABLAOCHO WHERE IDCLIENTE IN (SELECT IDCLIENTE FROM VENTA WHERE YEAR(FECHA) = 2020 group by IDCLIENTE);

#CUENTO LA TABLA ANTERIOR
SELECT COUNT(*) FROM (SELECT IDCLIENTE FROM TABLAOCHO WHERE IDCLIENTE IN (SELECT IDCLIENTE FROM VENTA WHERE YEAR(FECHA) = 2020 group by IDCLIENTE)) AS T;


#COMPROVACION
SELECT * FROM VENTA WHERE IDCLIENTE = 21;


 #############################################################################################################################################
  ### 10) Del total de clientes que realizaron compras en 2019 ¿Qué porcentaje lo hizo también en 2020?
  
  
   # QUIENES COMPRAROS EN 2019
SELECT IDCLIENTE FROM VENTA WHERE YEAR(FECHA) = 2019 group by IDCLIENTE;

#CREO UNA TABLA CON LO ANTERIOR
CREATE TABLE TABLADIEZ AS (SELECT IDCLIENTE FROM VENTA WHERE YEAR(FECHA) = 2019 group by IDCLIENTE);

#CONTAMOS TOTAL DE CLIENTES QUE COMPRARON EN 2019
SELECT COUNT(*) FROM (SELECT IDCLIENTE FROM VENTA WHERE YEAR(FECHA) = 2019 group by IDCLIENTE) AS D;  #1674
   # QUIENES COMPRAROS EN 2020 
SELECT IDCLIENTE FROM VENTA WHERE YEAR(FECHA) = 2020 group by IDCLIENTE;

#INTERSECCION
SELECT IDCLIENTE FROM TABLADIEZ WHERE IDCLIENTE IN (SELECT IDCLIENTE FROM VENTA WHERE YEAR(FECHA) = 2020 group by IDCLIENTE);

#CONTAMOS LO ANTERIOR

SELECT COUNT(*) FROM (SELECT IDCLIENTE FROM TABLADIEZ WHERE IDCLIENTE IN (SELECT IDCLIENTE FROM VENTA WHERE YEAR(FECHA) = 2020 group by IDCLIENTE)) AS H; #1430

  #############################################################################################################################################
  ### 11) ¿Qué cantidad de clientes realizó compras sólo por el canal OnLine entre 2019 y 2020?
  
  #CLIENTES QUE COMPRARON POR VENTA IN (2019, 2020)
  SELECT * FROM VENTA;
  SELECT * FROM canal_venta;
  
  #ventas en el 2020 o 2019:
  SELECT * FROM VENTA V JOIN canal_venta c on (c.idcanal = v.idcanal) where year(fecha) in (2019,2020); 
  
  # agrupo por cliente y por canal
    SELECT v.idcliente as idcliente, v.idcanal as idcanal, c.canal as canal
    FROM VENTA V JOIN canal_venta c on (c.idcanal = v.idcanal) where year(fecha) in (2019,2020)
    group by v.idcliente, c.idcanal order by idcliente;
  
  #creo una tabla con lo anterior
  create table tablaonce as ( SELECT v.idcliente as idcliente, v.idcanal as idcanal, c.canal as canal
    FROM VENTA V JOIN canal_venta c on (c.idcanal = v.idcanal) where year(fecha) in (2019,2020)
    group by v.idcliente, c.idcanal order by idcliente);
  #tengo los clientes que que compraron en 2019 o 2020 organizados por canal
  
  select * from tablaonce;
  
  #sumo los idcanal y agrupo por cliente
  select idcliente, sum(idcanal) from tablaonce group by idcliente;
 
  # condicion que sum idcliente = 2
  select idcliente, sum(idcanal) as sumidcanal from tablaonce group by idcliente having sumidcanal = 2;
  
  #cuento lo anterior
  select count(*) from  ( select idcliente, sum(idcanal) as sumidcanal from tablaonce group by idcliente having sumidcanal = 2) as f; #564
  

  #############################################################################################################################################
  ### 12) ¿Cuál es la sucursal que más Venta (Precio * Cantidad) hizo en 2020 a clientes que viven fuera de su provincia?
#### Elige la opción correcta:
 -- 1- flores<br>   7
  -- 2- cordoba quiroz<br>   26
  -- 3- cordoba centro <br>   25
  
  
  select * from sucursal;
  
    select * from sucursal s join localidad l on (l.idlocalidad = s.idlocalidad) join  provincia p on (p.idprovincia = l.idprovincia);
  
  #consulta estandar
  #cantidad de ventas por sucursal en 2020 
  select v.IdSucursal, s.sucursal,sum( v.cantidad * v.precio) as venta_total
  from venta v join sucursal s on(s.idsucursal = v.idsucursal) and year(fecha) = 2020
  group by v.idsucursal; 
  
  
  #ventas de la sucursal de bariloche a clientes que no son de rionegro
  # clientes que no son de cordoba (2)
  # representa las ventas totales por sucursal, excluyendo a los clientes de cordoba
  select v.idsucursal as idsucursal,  SUM(v.cantidad * v.precio) as venta_total  from venta v join cliente c on(c.idcliente = v.idcliente) 
  join localidad l on (c.IdLocalidad = l.IdLocalidad) and l.idprovincia <> 2 
  where year(fecha) = 2020
  group by v.idsucursal
  order by venta_total desc; 
  
  
  # 26 cordoba quiroz da 973117.280    ## MENOS DE UN MILLON  
  # 25 cordoba centro da 915323.740
  
  
  ##HAGO LO MISMO PERO PARA BUENOS AIRES
   select v.idsucursal as idsucursal,  SUM(v.cantidad * v.precio) as venta_total  from venta v join cliente c on(c.idcliente = v.idcliente) 
  join localidad l on (c.IdLocalidad = l.IdLocalidad) and l.idprovincia <> 1 
  where year(fecha) = 2020
  group by v.idsucursal
  order by venta_total desc; 
  
  #FLORES DA  1108610.860  #MAS DE UN MILLON
  
  
    ### 13) ¿Cuál fué el mes del año 2020, de mayor crecimiento con respecto al mismo mes del año 2019 
    #si se toman en cuenta a nivel general Ventas (Precio * Cantidad) - Compras (Precio * Cantidad) - Gastos? 
#### Responder el Número del Mes:

# SACO VENTAS MENSUALES EN 2020
SELECT MONTH(FECHA) AS MES, SUM(CANTIDAD * PRECIO) AS TOTAL_VENTA   FROM VENTA WHERE YEAR(FECHA) = 2020 group by MES ORDER BY MES ASC;
#SACO COMPRAS MENSUALES EN 2020
SELECT MONTH(FECHA) AS MES, SUM(CANTIDAD * PRECIO) AS TOTAL_COMPRA  FROM COMPRA WHERE YEAR(FECHA) = 2020 group by MES ORDER BY MES ASC;
#SACO GASTOS MENSUALES EN 2020
SELECT MONTH(FECHA) AS MES, SUM(MONTO) AS TOTAL_GASTOS  FROM GASTO WHERE YEAR(FECHA) = 2020 group by MES ORDER BY MES ASC;
# SACO VENTAS MENSUALES EN 2019
SELECT MONTH(FECHA) AS MES, SUM(CANTIDAD * PRECIO) AS TOTAL_VENTA   FROM VENTA WHERE YEAR(FECHA) = 2019 group by MES ORDER BY MES ASC;
#SACO COMPRAS MENSUALES EN 2019
SELECT MONTH(FECHA) AS MES, SUM(CANTIDAD * PRECIO) AS TOTAL_COMPRA  FROM COMPRA WHERE YEAR(FECHA) = 2019 group by MES ORDER BY MES ASC;
# SACO GASTOS MENSUALES EN 2019
SELECT MONTH(FECHA) AS MES, SUM(MONTO) AS TOTAL_GASTOS  FROM GASTO WHERE YEAR(FECHA) = 2019 group by MES ORDER BY MES ASC;

select * FROM cliente;
### 14) Considerando que se requiere consultar las ventas por Rangos Etarios de Productos que corresponden a los tipos 'Estucheria', 'Informatica', 'Impresión' y 'Audio', hechas por Sucursales ubicadas en la Provincia de Buenos Aires durante la segunda mitad del año 2020 y a travéz del Canal de Venta OnLine.
#### Elegir la opción correcta en términos de desempeño o performance:
#1)

Select	cl.Rango_Etario,
		   tp.TipoProducto,
        sum(v.Precio * v.Cantidad) as Venta
from 	venta v Join cliente cl
		On (v.IdCliente = cl.IdCliente)
	Join producto p
		On (v.IdProducto = p.IdProducto)
	Join tipo_producto tp
		On (p.IdTipoProducto = tp.IdTipoProducto)
	Join canal_venta cp
		On (cp.IdCanal = v.IdCanal)
	Join sucursal s
		On (s.IdSucursal = v.IdSucursal)
	Join localidad lo
		On (s.IdLocalidad = lo.IdLocalidad)
	Join provincia pr
		On (lo.IdProvincia = pr.IdProvincia)
Where 	Year(v.Fecha) = 2020
		   And Month(v.Fecha) >= 6
		   And cp.Canal = 'OnLine'
         And pr.Provincia = 'Buenos Aires'
         And TipoProducto In ('Estucheria','Informatica','Impresión','Audio')
Group by cl.Rango_Etario,
		tp.TipoProducto
Order by cl.Rango_Etario,
		Venta Desc;     #####0.079

#2)

Select	cl.Rango_Etario,
		tp.TipoProducto,
        sum(v.Precio * v.Cantidad) as Venta
from 	venta v Join cliente cl
		On (v.IdCliente = cl.IdCliente
			And Year(v.Fecha) = 2020
            And Month(v.Fecha) >= 6)
	Join producto p
		On (v.IdProducto = p.IdProducto)
	Join tipo_producto tp
		On (p.IdTipoProducto = tp.IdTipoProducto
			And TipoProducto In ('Estucheria','Informatica','Impresión','Audio'))
	Join canal_venta cp
		On (cp.IdCanal = v.IdCanal
			And cp.Canal = 'OnLine')
	Join sucursal s
		On (s.IdSucursal = v.IdSucursal)
	Join localidad lo
		On (s.IdLocalidad = lo.IdLocalidad)
	Join provincia pr
		On (lo.IdProvincia = pr.IdProvincia
			And pr.Provincia = 'Buenos Aires')   #######and 
Group by cl.Rango_Etario,
		tp.TipoProducto
Order by cl.Rango_Etario,
		Venta Desc; ## 0.125

#3)

Select	cl.Rango_Etario,
		   tp.TipoProducto,
        sum(v.Precio * v.Cantidad) as Venta
from 	venta v Join cliente cl
		On (v.IdCliente = cl.IdCliente
			And Year(v.Fecha) = 2020
         And Month(v.Fecha) >= 6)
	Join producto p
		On (v.IdProducto = p.IdProducto)
	Join tipo_producto tp
		On (p.IdTipoProducto = tp.IdTipoProducto
			And TipoProducto In ('Estucheria','Informatica','Impresión','Audio'))
	Join canal_venta cp
		On (cp.IdCanal = v.IdCanal
			And cp.Canal = 'OnLine')
	Join sucursal s
		On (s.IdSucursal = v.IdSucursal)
	Join localidad lo
		On (cl.IdLocalidad = lo.IdLocalidad)
	Join provincia pr
		On (lo.IdProvincia = pr.IdProvincia
			And pr.Provincia = 'Buenos Aires')
Group by cl.Rango_Etario,
		tp.TipoProducto
Order by cl.Rango_Etario,
		Venta Desc;  #0.156

### 15) El negocio suele requerir con gran frecuencia consultas a nivel trimestral tanto sobre las ventas, como las compras y los gastos...
#### Elige la opción correcta:
   -- 1- Con los índices creados existentes, sólo sobre las claves primarias y foráneas, sería suficiente para cubrir cualquier necesidad de consulta.<br>
   -- 2- Sería aduecuado colocar un índice sobre el campo trimestre de la tabla calendario aunque este no sea una clave foránea.<br>   (2) correcta
   -- 3- No se puede crear índices sobre campos que no son clave.<br>  ffff



select * from comisiones_córdoba_centro;
select * from comisiones_córdoba_cerro_de_las_rosas;
select * from comisiones_córdoba_quiróz;

### Cada una de las sucursales de la provincia de Córdoba, disponibilizaron un excel donde registraron el porcentaje de comisión que se le otorgó a cada uno de los empleados sobre la venta que realizaron. Es necesario incluir esas tablas (Comisiones Córdoba Centro.xlsx, Comisiones Córdoba Quiróz.xlsx y Comisiones Córdoba Cerro de las Rosas.xlsx) en el modelo y contestar las siguientes preguntas:
### 16) ¿Cuál es el código de empleado del empleado que mayor comisión obtuvo en diciembre del año 2020?

SELECT * FROM comisiones_córdoba_centro WHERE ANIO = 2020 AND MES = 12 ORDER BY PORCENTAJE DESC;  #17
SELECT * FROM comisiones_córdoba_cerro_de_las_rosas WHERE ANIO = 2020 AND MES = 12 ORDER BY PORCENTAJE DESC; #20
SELECT * FROM comisiones_córdoba_quiróz WHERE ANIO = 2020 AND MES = 12 ORDER BY PORCENTAJE DESC; #20 

###########################
create table  tabla_uno as (
SELECT CODIGOEMPLEADO, Apellido_y_Nombre, porcentaje  FROM comisiones_córdoba_centro WHERE ANIO = 2020 AND MES = 12 group by CodigoEmpleado
union
SELECT CODIGOEMPLEADO, Apellido_y_Nombre, porcentaje FROM comisiones_córdoba_cerro_de_las_rosas WHERE ANIO = 2020 AND MES = 12 group by CodigoEmpleado 
union
SELECT CODIGOEMPLEADO, Apellido_y_Nombre, porcentaje  FROM comisiones_córdoba_quiróz WHERE ANIO = 2020 AND MES = 12 group by CodigoEmpleado); 

select * from tabla_uno;

select t.codigoempleado as codigoempleado, porcentaje as porcentaje, e.idempleado as edempleado from tabla_uno t join empleado e on (t.codigoempleado = e.codigoempleado);

# empleado y comision
create table tabla_dos as (
select t.codigoempleado as codigoempleado, porcentaje as porcentaje, e.idempleado as edempleado from tabla_uno t join empleado e on (t.codigoempleado = e.codigoempleado));

select * from tabla_dos;
#venta total por empleado en 2020, diciembre;
create table tabla_tres (
select idempleado, sum(cantidad * precio) as total_venta from venta where year(fecha) = 2020 and month(fecha) = 12 group by idempleado);
select * from tabla_tres ;

select *, tt.total_venta * (td.porcentaje/100) as total_comision from tabla_dos td join tabla_tres tt on (td.edempleado = tt.idempleado) order by total_comision desc;

###3929
### 17) ¿Cuál es la sucursal que menos comisión pagó en el año 2020?
#### Elige la opción correcta:
#--	1- Córdoba Centro.<br>
#	2- Córdoba Quiroz.<br>
#	3- Cerro De Las Rosas.<br>

#
create table  tabla_one as (
SELECT CODIGOEMPLEADO, Apellido_y_Nombre, porcentaje  FROM comisiones_córdoba_centro WHERE ANIO = 2020
union
SELECT CODIGOEMPLEADO, Apellido_y_Nombre, porcentaje FROM comisiones_córdoba_cerro_de_las_rosas WHERE ANIO = 2020 
union
SELECT CODIGOEMPLEADO, Apellido_y_Nombre, porcentaje  FROM comisiones_córdoba_quiróz WHERE ANIO = 2020 ); 

select * from tabla_one;

select v.IdSucursal, sum(cantidad * precio) as total_venta, s.sucursal as sucursal from venta v join sucursal s on (s.idsucursal = v.idsucursal) where year(fecha) = 2020 group by idsucursal order by total_venta asc;

#cerro 7 millones

select idsucursal, sucursal , avg (porcentaje) from comisiones_córdoba_cerro_de_las_rosas where anio = 2020;   #0.125
select idsucursal, sucursal , avg (porcentaje) from comisiones_córdoba_centro where anio = 2020; ##0,127
select idsucursal, sucursal , avg (porcentaje) from comisiones_córdoba_quiróz where anio = 2020;  #11
### 18) La ganancia neta por sucursal es las ventas menos los gastos (Ganancia = Venta - Gasto) ¿Cuál es la sucursal con mayor ganancia neta en 2020 en la provincia de Córdoba si además quitamos los pagos por comisiones? 
#### Elige la opción correcta:
#   1- Córdoba Quiroz<br>
#   2- Cerro De Las Rosas<br>
#   3- Córdoba Centro<br>

### 18) La ganancia neta por sucursal es las ventas menos los gastos (Ganancia = Venta - Gasto) ¿Cuál es la sucursal con mayor ganancia neta en 2020 en la provincia de Córdoba si además quitamos los pagos por comisiones? 
#### Elige la opción correcta:
--   1- Córdoba Quiroz<br>
--   2- Cerro De Las Rosas<br>
--   3- Córdoba Centro<br>

