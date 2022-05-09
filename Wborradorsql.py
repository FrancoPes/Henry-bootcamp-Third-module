# que dia de la demana ha generado mayot cantidad de ingresos totales historicamente
#select sum(precio * cantidad) as ingreso_total, dayname(fecha) as dia
#from venta
#group by dia
#order by ingreso_total desc
#limit 1

# que dia de la demana ha generado mayot cantidad de ingresos totales en promedio
#select avg(precio * cantidad) as ingreso_total, dayname(fecha) as dia
#from venta
#group by dia
#order by ingreso_total desc
#limit 1

##sucursal con mayor ingreso

#select sum(precio * cantidad) as ingreso_total, idsucursal
#from venta
#group by idsucursal
#order by ingreso_total desc
#limit 1

## venta estrella de cada tipo
#select  max(v.precio * v.idproducto) as ingreso_total, p.tipo as tipo, p.idproducto, p.concepto
#from venta v
#join producto p
#on (v.idproducto = p.idproducto)
#group by p.tipo 

## producto  estrella de cada tipo 
#select ingreso_total, tipo, producto, concepto
#from (select  sum(v.precio * v.idproducto) as ingreso_total, p.tipo as tipo, p.idproducto as producto, p.concepto as concepto
#from venta v
#join producto p
#on (v.idproducto = p.idproducto)
#group by p.concepto) as T 
#group by tipo
#order by ingreso_total desc



#select sum(precio * cantidad) as ingreso_total, idsucursal
#from venta
#group by idsucursal
#order by ingreso_total desc
#limit 1


#¿Cuál es el canal de ventas con menos venta (Venta = Precio * Cantidad)?
#   1- OnLine<br>
#   2- Telefónica<br>
#   3- Presencial<br>


#select  sum((v.precio * v.cantidad)) as ventas_pesos, c.canal
#from venta v
#join canal_venta c
#on (c.idcanal = v.idcanal)
#group by canal                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             order by ventas_pesos asc
# respuesta 3 presencial




### 7) ¿Cuál es el canal de ventas con menor cantidad de ventas registradas?
#   1- OnLine<br>
#   2- Telefónica<br>
#   3- Presencial<br>

#select count(v.idventa) as venta_registrada, c.canal
#from venta v
#join canal_venta c
#on (c.idcanal = v.idcanal)
#group by c.canal
#order by venta_registrada asc
#respuesta 2 telefonica

### 8) ¿Cuál es el año con la mayor cantidad de productos vendidos?

#select count(*) as totalventasregistradas, year(fecha) as anio_venta
#from producto p
#join venta v
#on (p.idproducto = v.idproducto)
#                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   group by anio_venta
#primer forma, resultado 2020

#select sum(v.cantidad) as total_unidades_vendidas, year(fecha) as anio_venta
#from producto p
#join venta v
#on (p.idproducto = v.idproducto)
#group by anio_venta
#order by total_unidades_vendidas 
#forma 2, tambien la respuesta es 2020


### 9) Se define el tiempo de entrega como el tiempo en días transcurrido entre que se realiza la compra y se efectua la entrega. 
#Par analizar mejoras en el servicio, la dirección desea saber: cuál es el año con el promedio más alto de este tiempo de entrega. 
#(Fecha = Fecha de venta; Fecha_Entrega = Fecha de entrega)

#select avg(timestampdiff(day, fecha, fecha_entrega)) diferencia_dias_entrega, year(fecha) anio_ref
#from venta
#group by anio_ref
#order by diferencia_dias_entrega desc
# respuesta 2020


### 10) La dirección desea saber que tipo de producto tiene la mayor venta en 2020 (Tabla 'producto', campo Tipo = Tipo de producto)
#   1- INFORMATICA<br>
#   2- ESTUCHERIA<br>
#   3- AUDIO<br>
#   4- IMPRESIÓN<br>
#   5- GABINETES<br>
#   6- GRABACION<br>
#   7- BASES<br>
#   8- GAMING<br>

#select max(v.cantidad * v.precio) as ventas, p.tipo as tipo, 
#from producto p
#join venta v
#on (p.idproducto = v.idproducto)
#group by p.tipo
#order by ventas desc
# respuesta 1 informatica? 
