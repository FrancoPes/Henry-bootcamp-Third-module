

#chequeando si hay id repetidas
SELECT COUNT(ID_EMPLEADO), ID_EMPLEADO
FROM EMPLEADO
GROUP BY ID_EMPLEADO
having COUNT(ID_EMPLEADO) > 1;

select idproveedor
from proveedor
where  (nombre is null or nombre = '');

SELECT COUNT(IDPROVEEDOR) 
FROM PROVEEDOR
WHERE (IDPROVEEDOR IS NULL OR IDPROVEEDOR = '');

#cambiando el nombre de las columnas
select * 
from tipodegasto;
alter table sucursal
RENAME COLUMN ID TO Idsucursal;

alter table cliente
RENAME COLUMN ID TO Idcliente;

alter table tipodegasto
RENAME COLUMN descripcion TO tipodegasto;

alter table producto
RENAME COLUMN concepto TO producto;

alter table proveedor
RENAME COLUMN Address TO Direccion;

alter table proveedor
RENAME COLUMN City TO Ciudad;

alter table proveedor
RENAME COLUMN State TO Provincia;

alter table proveedor
RENAME COLUMN departamen TO Localidad;

alter table proveedor
RENAME COLUMN Country TO Pais;

alter table empleado
RENAME COLUMN ID_empleado TO Idempleado;

#eliminando columnas que no son relevantes
alter table empleado
drop COLUMN MyUnknownColumn;

alter table cliente
drop COLUMN X;

alter table cliente
drop COLUMN Y;

ALTER TABLE `cliente` DROP `col10`;

/*Imputar Valores Faltantes*/
UPDATE `cliente`
SET Domicilio = 'Sin Dato' 
WHERE TRIM(Domicilio) = "" OR ISNULL(Domicilio);

UPDATE `cliente` 
SET Localidad = 'Sin Dato' 
WHERE TRIM(Localidad) = "" OR ISNULL(Localidad);

UPDATE `cliente` 
SET Nombre_y_Apellido = 'Sin Dato' 
WHERE TRIM(Nombre_y_Apellido) = "" OR ISNULL(Nombre_y_Apellido);

UPDATE `cliente` 
SET Provincia = 'Sin Dato' 
WHERE TRIM(Provincia) = "" OR ISNULL(Provincia);

UPDATE `empleado`
SET Apellido = 'Sin Dato' 
WHERE TRIM(Apellido) = "" OR ISNULL(Apellido);

UPDATE `empleado`
SET Nombre = 'Sin Dato' 
WHERE TRIM(Nombre) = "" OR ISNULL(Nombre);

UPDATE `empleado` 
SET Sucursal = 'Sin Dato' 
WHERE TRIM(Sucursal) = "" OR ISNULL(Sucursal);

UPDATE `empleado` 
SET Sector = 'Sin Dato' 
WHERE TRIM(Sector) = "" OR ISNULL(Sector);

UPDATE `empleado` 
SET Cargo = 'Sin Dato' 
WHERE TRIM(Cargo) = "" OR ISNULL(Cargo);

UPDATE `producto` 
SET Producto = 'Sin Dato' 
WHERE TRIM(Producto) = "" OR ISNULL(Producto);

UPDATE `producto` 
SET Tipo = 'Sin Dato' 
WHERE TRIM(Tipo) = "" OR ISNULL(Tipo);

UPDATE `proveedor` 
SET Nombre = 'Sin Dato' 
WHERE TRIM(Nombre) = "" OR ISNULL(Nombre);

UPDATE `proveedor` 
SET direccion = 'Sin Dato' 
WHERE TRIM(direccion) = "" OR ISNULL(direccion);

UPDATE `proveedor` 
SET Ciudad = 'Sin Dato' 
WHERE TRIM(Ciudad) = "" OR ISNULL(Ciudad);

UPDATE `proveedor` 
SET Provincia = 'Sin Dato' 
WHERE TRIM(Provincia) = "" OR ISNULL(Provincia);

UPDATE `proveedor` 
SET Pais = 'Sin Dato' 
WHERE TRIM(Pais) = "" OR ISNULL(Pais);

UPDATE `proveedor` 
SET localidad = 'Sin Dato' 
WHERE TRIM(localidad) = "" OR ISNULL(localidad);

UPDATE `sucursal` 
SET direccion = 'Sin Dato' 
WHERE TRIM(direccion) = "" OR ISNULL(direccion);

UPDATE `sucursal` 
SET Sucursal = 'Sin Dato' 
WHERE TRIM(Sucursal) = "" OR ISNULL(Sucursal);

UPDATE `sucursal` 
SET Provincia = 'Sin Dato' 
WHERE TRIM(Provincia) = "" OR ISNULL(Provincia);

UPDATE `sucursal` 
SET Localidad = 'Sin Dato' 
WHERE TRIM(Localidad) = "" OR ISNULL(Localidad);

/*Tabla ventas limpieza y normalizacion*/
UPDATE venta v JOIN producto p ON (v.IdProducto = p.IdProducto) 
SET v.Precio = p.Precio
WHERE v.Precio = 0;


#TABLA AUXILIAR DE VENTA
# cuando tenemos problemas con una tabla en particular que no los sabemos resolver
# entonces copiamos esos datos y los metemos en una auxiliar
/*Tabla auxiliar donde se guardarán registros con problemas:
1-Cantidad en Cero
*/
DROP TABLE IF EXISTS `aux_venta`;
CREATE TABLE IF NOT EXISTS `aux_venta` (
  `IdVenta`				INTEGER,
  `Fecha` 				DATE NOT NULL,
  `Fecha_Entrega` 		DATE NOT NULL,
  `IdCliente`			INTEGER, 
  `IdSucursal`			INTEGER,
  `IdEmpleado`			INTEGER,
  `IdProducto`			INTEGER,
  `Precio`				FLOAT,
  `Cantidad`			INTEGER,
  `Motivo`				INTEGER
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

# paso a la auxiliar las cantidades cero o nulas
#
INSERT INTO aux_venta (IdVenta, Fecha, Fecha_Entrega, IdCliente, IdSucursal, IdEmpleado, IdProducto, Precio, Cantidad, Motivo)
SELECT IdVenta, Fecha, Fecha_Entrega, IdCliente, IdSucursal, IdEmpleado, IdProducto, Precio, 0, 1
FROM venta WHERE Cantidad = 0 or Cantidad is null;

UPDATE venta SET Cantidad = 1 WHERE Cantidad = 0 or Cantidad is null;

/*Normalizacion a Letra Capital*/

#creacion de la funcoion correspondiente en otro query

#aplicamos la funcion UC_Words
UPDATE cliente SET 	Provincia = UC_Words(TRIM(Provincia)),
					Localidad = UC_Words(TRIM(Localidad)),
                    Domicilio = UC_Words(TRIM(Domicilio)),
                    Nombre_y_Apellido = UC_Words(TRIM(Nombre_y_Apellido));

UPDATE sucursal SET Provincia = UC_Words(TRIM(Provincia)),
					Localidad = UC_Words(TRIM(Localidad)),
                    Direccion = UC_Words(TRIM(Direccion)),
                    Sucursal = UC_Words(TRIM(Sucursal));
                    
UPDATE proveedor SET Provincia = UC_Words(TRIM(Provincia)),
					Ciudad = UC_Words(TRIM(Ciudad)),
                    Localidad = UC_Words(TRIM(Localidad)),
                    Pais = UC_Words(TRIM(Pais)),
                    Nombre = UC_Words(TRIM(Nombre)),
                    Direccion = UC_Words(TRIM(Direccion));

UPDATE producto SET Producto = UC_Words(TRIM(Producto)),
					Tipo = UC_Words(TRIM(Tipo));
                    
UPDATE empleado SET Sucursal = UC_Words(TRIM(Sucursal)),
                    Sector = UC_Words(TRIM(Sector)),
                    Cargo = UC_Words(TRIM(Cargo)),
                    Nombre = UC_Words(TRIM(Nombre)),
                    Apellido = UC_Words(TRIM(Apellido));
                    
                    
# VERIFICO SI HAY ID DUPLICADOS

SELECT COUNT(Idempleado), Idempleado
FROM EMPLEADO
GROUP BY Idempleado
having COUNT(Idempleado) > 1;

SELECT COUNT(idcompra), idcompra
FROM compra
GROUP BY idcompra
having COUNT(idcompra) > 1;

SELECT COUNT(idventa), idventa
FROM venta
GROUP BY idventa
having COUNT(idventa) > 1;

SELECT COUNT(idventa), idventa
FROM venta
GROUP BY idventa
having COUNT(idventa) > 1;

SELECT COUNT(idgasto), idgasto
FROM gasto
GROUP BY idgasto
having COUNT(idgasto) > 1;

SELECT COUNT(idproveedor), idproveedor
FROM proveedor
GROUP BY idproveedor
having COUNT(idproveedor) > 1;

SELECT COUNT(idproducto), idproducto
FROM producto
GROUP BY idproducto
having COUNT(idproducto) > 1;

SELECT COUNT(idsucursal), idsucursal
FROM sucursal
GROUP BY idsucursal
having COUNT(idsucursal) > 1;

SELECT COUNT(idcliente), idcliente
FROM cliente
GROUP BY idcliente
having COUNT(idcliente) > 1;

#SOLUCION A LOS DUPLICADOS DE LA TABLA EMPLEADOS
SELECT * 
FROM EMPLEADO
WHERE IDEMPLEADO = 3032;

## EN REALIDAD HAY EMPLEADO DUPLICADOS, PERO DE DISTINTAS SUCURSALES
##SI BIEN HAY VARIAS SOLUCIONES, UNA SOLUCION ELEGANTE SERIA COMBINAR LA ID DE LA SUCURSAL CON LA DE EMPLEADO
#EN LA TABLA VENTAS TENGO LAS DOS COLUMNAS, ENTONCES CAMBIO LA CLAVE FORANEA AHI Y LUEGO ME LA TRAIGO A LA TABLA DE EMPLEADO

UPDATE VENTA SET IdEmpleado = (IdSucursal * 1000000) + IdEmpleado;


#CREAR UNA NUEVA TABLA QUE SE LLAME CARGO Y OTRA QUE SE LLAME SECTOR (NORMALIZACIOND DE LA TABLA EMPLEADOS)
DROP TABLE `cargo`;
CREATE TABLE cargo (
  IdCargo int(11) NOT NULL AUTO_INCREMENT,
  Cargo varchar(50) NOT NULL,
  PRIMARY KEY (IdCargo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

DROP TABLE IF EXISTS `sector`;
CREATE TABLE IF NOT EXISTS `sector` (
  `IdSector` int(11) NOT NULL AUTO_INCREMENT,
  `Sector` varchar(50) NOT NULL,
  PRIMARY KEY (`IdSector`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;


#INSERTAMOS LOS CARGOS DE EMPLEADOS EN LA TABLA CARGO
INSERT INTO cargo (Cargo) SELECT DISTINCT Cargo FROM empleado ORDER BY 1;
INSERT INTO SECTOR (SECTOR) SELECT DISTINCT SECTOR FROM empleado ORDER BY 1;

#MODIFICAMOS LA TABLA EMPLEADO, ANADO las nuevas columnas idcargo e idsector
ALTER TABLE EMPLEADO
add `IdSector` INT NOT NULL DEFAULT '0', 
ADD `IdCargo` INT NOT NULL DEFAULT '0' AFTER `IdSector`; #el after me dice donde lo pongo


#traigo los datos. lo hago con un join
UPDATE empleado e 
JOIN cargo c 
ON (c.Cargo = e.Cargo) 
SET e.IdCargo = c.IdCargo;

# ACTUALIZO TABLA EMPELADO CON TABLA SECTOR

UPDATE empleado e 
JOIN sector s 
ON (s.Sector = e.Sector) 
SET e.IdSector = s.IdSector;

#VER EL ERROR

# NBORMALIZO LA TABLA PRODUCTO.A LOS TIPOS DE PRODUCTOS LES VAMOS A PONER UN ID
ALTER TABLE `producto` ADD `IdTipoProducto` INT NOT NULL DEFAULT '0' AFTER `Precio`;

CREATE TABLE IF NOT EXISTS `tipo_producto` (
  `IdTipoProducto` int(11) NOT NULL AUTO_INCREMENT,
  `TipoProducto` varchar(50) NOT NULL,
  PRIMARY KEY (`IdTipoProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tipo_producto (TipoProducto) 
SELECT DISTINCT Tipo 
FROM producto 
ORDER BY 1;

UPDATE producto p 
JOIN tipo_producto t 
ON (p.Tipo = t.TipoProducto) 
SET p.IdTipoProducto = t.IdTipoProducto;

ALTER TABLE `producto`
DROP `Tipo`;

# Es necesario contar con una tabla de localidades del país con el fin de evaluar la apertura de una nueva sucursal y mejorar nuestros datos. 
#A partir de los datos en las tablas cliente, sucursal y proveedor hay que generar una tabla definitiva de Localidades y Provincias.
#Utilizando la nueva tabla de Localidades controlar y corregir (Normalizar) los campos Localidad 
#y Provincia de las tablas cliente, sucursal y proveedor.

DROP TABLE IF EXISTS aux_Localidad;
CREATE TABLE IF NOT EXISTS aux_Localidad (
	Localidad_Original	VARCHAR(80),
	Provincia_Original	VARCHAR(50),
	Localidad_Normalizada	VARCHAR(80),
	Provincia_Normalizada	VARCHAR(50),
	IdLocalidad			INTEGER
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;


#INSERTAMOS LAS LOCALIDADES DE LOS CLIENTES, PROVEEDORES, ETC. LAS ESTAQUEAMOS
INSERT INTO aux_localidad (Localidad_Original, Provincia_Original, Localidad_Normalizada, Provincia_Normalizada, IdLocalidad)
SELECT DISTINCT Localidad, Provincia, Localidad, Provincia, 0 FROM cliente
UNION
SELECT DISTINCT Localidad, Provincia, Localidad, Provincia, 0 FROM sucursal
UNION
SELECT DISTINCT Ciudad, Provincia, Ciudad, Provincia, 0 FROM proveedor
ORDER BY 2, 1;

#NORMALIZAMOS MANUALMENTE BUENOS AIRES
UPDATE `aux_localidad` SET Provincia_Normalizada = 'Buenos Aires'
WHERE Provincia_Original IN ('B. Aires',
                            'B.Aires',
                            'Bs As',
                            'Bs.As.',
                            'Buenos Aires',
                            'C Debuenos Aires',
                            'Caba',
                            'Ciudad De Buenos Aires',
                            'Pcia Bs As',
                            'Prov De Bs As.',
                            'Provincia De Buenos Aires');

#NORMALIZAMOS MANUALMENTE CORDOBA
UPDATE `aux_localidad` SET Provincia_Normalizada = 'Córdoba'
WHERE provincia_Original IN ('Coroba',
                            'Cordoba',
                            'Cã³rdoba'
							'Cã³rdoba');


#CAPITAL FEDERAL
UPDATE `aux_localidad` SET Localidad_Normalizada = 'Capital Federal'
WHERE Localidad_Original IN ('Boca De Atencion Monte Castro',
                            'Caba',
                            'Cap.   Federal',
                            'Cap. Fed.',
                            'Capfed',
                            'Capital',
                            'Capital Federal',
                            'Cdad De Buenos Aires',
                            'Ciudad De Buenos Aires')
AND Provincia_Normalizada = 'Buenos Aires';

#rio negro
UPDATE `aux_localidad` SET Provincia_Normalizada = 'Rio Negro'
WHERE Provincia_original IN ('Rã­o Negro');

#tucuman

UPDATE `aux_localidad` SET Provincia_Normalizada = 'Tucuman'
WHERE Provincia_original IN ('Tucumã¡n');

#ciudad de cordoba

UPDATE `aux_localidad` SET localidad_Normalizada = 'Córdoba'
WHERE localidad_Original IN ('Coroba',
                            'Cordoba',
                            'Cã³rdoba'
							'Cã³rdoba');
                            
#Martã­nez
UPDATE `aux_localidad` SET localidad_Normalizada = 'Martinez'
WHERE localidad_Original IN ('Martã­nez');

#San Miguel De Tucumã¡n
UPDATE `aux_localidad` SET localidad_Normalizada = 'San Miguel De Tucuman'
WHERE localidad_Original IN ('San Miguel De Tucumã¡n');

#Vicente Lã³pez
UPDATE `aux_localidad` SET localidad_Normalizada = 'Vicente Lopez'
WHERE localidad_Original IN ('Vicente Lã³pez');

UPDATE `aux_localidad` SET Localidad_Normalizada = 'Córdoba'
WHERE Localidad_Original IN ('Coroba',
                            'Cordoba',
							'Cã³rdoba')
AND Provincia_Normalizada = 'Córdoba';


#una vex normalizadas, creo dos nuevas tablas, una con localidad y otra con provincia

DROP TABLE IF EXISTS `localidad`;
CREATE TABLE IF NOT EXISTS `localidad` (
  `IdLocalidad` int(11) NOT NULL AUTO_INCREMENT,
  `Localidad` varchar(80) NOT NULL,
  `Provincia` varchar(80) NOT NULL,
  `IdProvincia` int(11) NOT NULL,
  PRIMARY KEY (`IdLocalidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

DROP TABLE IF EXISTS `provincia`;
CREATE TABLE IF NOT EXISTS `provincia` (
  `IdProvincia` int(11) NOT NULL AUTO_INCREMENT,
  `Provincia` varchar(50) NOT NULL,
  PRIMARY KEY (`IdProvincia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;


#inserto un distint de las localidades normalizadas
INSERT INTO Localidad (Localidad, Provincia, IdProvincia)
SELECT	DISTINCT Localidad_Normalizada, Provincia_Normalizada, 0
FROM aux_localidad
ORDER BY Provincia_Normalizada, Localidad_Normalizada;

INSERT INTO provincia (Provincia)
SELECT DISTINCT Provincia_Normalizada
FROM aux_localidad
ORDER BY Provincia_Normalizada;

UPDATE localidad l JOIN provincia p
	ON (l.Provincia = p.Provincia)
SET l.IdProvincia = p.IdProvincia;

UPDATE aux_localidad a JOIN localidad l 
			ON (l.Localidad = a.Localidad_Normalizada
                AND a.Provincia_Normalizada = l.Provincia)
SET a.IdLocalidad = l.IdLocalidad;

ALTER TABLE `cliente` ADD `IdLocalidad` INT NOT NULL DEFAULT '0' AFTER `Localidad`;
ALTER TABLE `proveedor` ADD `IdLocalidad` INT NOT NULL DEFAULT '0' AFTER `Departamento`;
ALTER TABLE `sucursal` ADD `IdLocalidad` INT NOT NULL DEFAULT '0' AFTER `Provincia`;
#errorr
UPDATE cliente c JOIN aux_localidad a
	ON (c.Provincia = a.Provincia_Original AND c.Localidad = a.Localidad_Original)
SET c.IdLocalidad = a.IdLocalidad;

UPDATE sucursal s JOIN aux_localidad a
	ON (s.Provincia = a.Provincia_Original AND s.Localidad = a.Localidad_Original)
SET s.IdLocalidad = a.IdLocalidad;

UPDATE sucursal s JOIN aux_localidad a
	ON (s.Provincia = a.Provincia_Original AND s.Localidad = a.Localidad_Original)
SET s.IdLocalidad = a.IdLocalidad;






#discretizar

ALTER TABLE `cliente` ADD `Rango_Etario` VARCHAR(20) NOT NULL DEFAULT '-' AFTER `Edad`;

UPDATE cliente SET Rango_Etario = '1_Hasta 30 años' WHERE Edad <= 30;
UPDATE cliente SET Rango_Etario = '2_De 31 a 40 años' WHERE Edad <= 40 AND Rango_Etario = '-';
UPDATE cliente SET Rango_Etario = '3_De 41 a 50 años' WHERE Edad <= 50 AND Rango_Etario = '-';
UPDATE cliente SET Rango_Etario = '4_De 51 a 60 años' WHERE Edad <= 60 AND Rango_Etario = '-';
UPDATE cliente SET Rango_Etario = '5_Desde 60 años' WHERE Edad > 60 AND Rango_Etario = '-';

