#############################################################################################################################################
### 1) Un índice SQL es una tabla de búsqueda rápida para poder encontrar los registros que los usuarios necesitan buscar con mayor frecuencia.

#----> RESPUESTA >> VERDADERO; 'Un índice SQL es una tabla de búsqueda rápida para poder encontrar los registros que los usuarios necesitan buscar con mayor frecuencia.'
--
--
#############################################################################################################################################
### 2) La regla de las 3 sigmas para detección de Outliers está basada en la Mediana.
#------> RESPUESTA >> FALSO: ESTA BASADA EN LA MEDIA


#############################################################################################################################################
### 3) Las tablas Maestros registran las operaciones ocurridas, todo tipo de transacciones donde intervienen las diferentes entidades del modelo.
#------> RESPUESTA >> FALSO: ''ablas Maestros: Registran los atributos particulares de las entidades, representando cada registro a una única instancia, por medio de una clave primaria.''

#############################################################################################################################################
## Elegir la opción correcta en base a la observación del siguiente DER:

### 4) ¿Cuál de las siguientes no es una tabla que representa una dimensión?
   -- 1- cliente<br>
   -- 2- calendario<br>
   -- 3- venta<br>
   -- 4- provincia<br>
  
  # RESPUESTA >> VENTA : PORQUE VENTA ES UNA TABLA DE HECHOS
  
  #############################################################################################################################################
  ### 5) El DER presentado...
   -- 1- es un Modelo Estrella, porque tiene una sóla tabla de hechos.<br>    NO
   -- 2- no es un Modelo Estrella, ya que contiene referencias circulares.<br>
   -- 3- es un Modelo Copo de Nieve.<br>
   
   
   #############################################################################################################################################
   -- PREGUNTAS PRACTICAS
   #############################################################################################################################################
   
   ## Resuelve los siguientes ejercicios:

### 6) La ganancia neta por sucursal es las ventas menos los gastos (Ganancia = ;0[ - Gasto) ¿Cuál es la sucursal con mayor ganancia neta en 2020? 
#### Elige la opción correcta:
 --  1- Alberdi<br>
 --  2- Flores<br>             RESPUESTA ##### FLORES
 --  3- Corrientes<br>

#############################################################################################################################################
### 7) La ganancia neta por producto es las ventas menos las compras (Ganancia = Venta - Compra) ¿Cuál es el tipo de producto con mayor ganancia neta en 2020?
#### Elige la opción correcta:
 --  1- Informática<br>    ##RESOUESTA INFORMATICA
 --  2- Impresión<br>
 --  3- Grabacion<br>
 
 #############################################################################################################################################
  ### 8) Del total de clientes que realizaron compras en 2020 ¿Qué porcentaje lo hizo sólo en una única sucursal?
  
  #814/2415
  #############################################################################################################################################
  ### 9) Del total de clientes que realizaron compras en 2020 ¿Qué porcentaje no había realizado compras en 2019?
  #985/2415
  
  #############################################################################################################################################
  ### 10) Del total de clientes que realizaron compras en 2019 ¿Qué porcentaje lo hizo también en 2020?
  #1430/1674
  
  #############################################################################################################################################
  ### 11) ¿Qué cantidad de clientes realizó compras sólo por el canal OnLine entre 2019 y 2020?
  #564
  #############################################################################################################################################
  ### 12) ¿Cuál es la sucursal que más Venta (Precio * Cantidad) hizo en 2020 a clientes que viven fuera de su provincia?
#### Elige la opción correcta:
  -- 1- flores<br>   ##FLORES
  -- 2- cordoba quiroz<br>
  -- 3- cordoba centro <br>
  
  ### 13) ¿Cuál fué el mes del año 2020, de mayor crecimiento con respecto al mismo mes del año 2019 si se toman en cuenta a nivel general Ventas (Precio * Cantidad) - Compras (Precio * Cantidad) - Gastos? 
#### Responder el Número del Mes:

# MES 9
### 14) Considerando que se requiere consultar las ventas por Rangos Etarios de Productos que corresponden a los tipos 'Estucheria', 'Informatica', 'Impresión' y 'Audio', hechas por Sucursales ubicadas en la Provincia de Buenos Aires durante la segunda mitad del año 2020 y a travéz del Canal de Venta OnLine.
#### Elegir la opción correcta en términos de desempeño o performance:
#1)     #opcion 2
```sql
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
		Venta Desc;
```
2)
```sql
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
			And pr.Provincia = 'Buenos Aires')
Group by cl.Rango_Etario,
		tp.TipoProducto
Order by cl.Rango_Etario,
		Venta Desc;
```
3)
```sql
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
		Venta Desc;
```
### 15) El negocio suele requerir con gran frecuencia consultas a nivel trimestral tanto sobre las ventas, como las compras y los gastos...
#### Elige la opción correcta:
   -- 1- Con los índices creados existentes, sólo sobre las claves primarias y foráneas, sería suficiente para cubrir cualquier necesidad de consulta.<br>
   -- 2- Sería aduecuado colocar un índice sobre el campo trimestre de la tabla calendario aunque este no sea una clave foránea.<br>   (2) correcta
   -- 3- No se puede crear índices sobre campos que no son clave.<br>  ffff