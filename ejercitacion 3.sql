
#DETERMINO SI HAY OUTLAYERS EN PRECIO Y CANTIDAD DE VENTAS
#BUSQUEDA DE OUTLAYERS EN PRECIO


#DECVIACION ESTANDAR
select STD(precio) as Std_precio from venta;
#PROMEDIO
select AVG(precio) as Promedio_Precio from venta;
#MINIMO
select min(precio) as minimo_precio, idventa from venta;
#MAXIMO
select max(precio) as maximo_precio, idventa from venta;
select * from  venta where idventa = 2014;
#MEDIANA
select count(*) as cant, cantidad from venta group by cantidad order by count(*) desc;  #-----> mediana
#DADO QUE NO SIGUE UNA DISTRIBUCION NORMAL, usamos el sentido comun
select idventa, precio from  venta where precio > 100000 or precio < 80;



# lo mismo pero con las cantidades
select AVG(cantidad) as Promedio_cantidad from venta; #2
select STD(cantidad) as Std_cantidad from venta;  -- 0,7
select count(*) as cant, cantidad from venta group by precio order by count(*) desc;  #-----> mediana
select idventa, cantidad from  venta where cantidad >= 5 or cantidad <=  0 or cantidad = "";


#lo mismo pero con precio de la tabla compra 

select AVG(precio) as Promedio_cantidad from compra; #1171
select STD(precio) as Std_cantidad from compra;  -- 2439
select count(*) as cant, precio from compra group by precio order by count(*) desc;  #-----> mediana


# posibles outlayers

select count(*) from(
select idcompra, precio from  compra where precio >= 100000 or precio <=  70 or cantidad = "") as t;


#lo mismo pero con sueldos de los empleados
SELECT avg(salario)  from empleado; #29460.6742
select STD(salario)  from empleado;  -- 13403.425840605565
select count(*) as cant, salario from empleado group by salario order by count(*) desc;  #-----> mediana 32000
select idempleado, salario from  empleado where salario >= 100000 or salario <=  10000 or salario = "";  #--> no hay outlayers con certeza

# DEFINIMOS CIERTOS KPIS


