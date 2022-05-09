#Creacion de la database
Create database Empresa1;
use empresa1;

#creacion de sus tablas 
CREATE TABLE IF NOT EXISTS venta (
  IdVenta				INTEGER,
  Fecha 				DATE NOT NULL,
  Fecha_Entrega 		DATE NOT NULL,
  IdCanal				INTEGER, 
  IdCliente			INTEGER, 
  IdSucursal			INTEGER,
  IdEmpleado			INTEGER,
  IdProducto			INTEGER,
  Precio				VARCHAR(30),
  Cantidad			VARCHAR(30)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE empleado (
	IDEmpleado					INTEGER,
	Apellido					VARCHAR(100),
	Nombre						VARCHAR(100),
	Sucursal					VARCHAR(50),
	Sector						VARCHAR(50),
	Cargo						VARCHAR(50),
	Salario2					VARCHAR(30)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE  cliente (
	ID					INTEGER,
	Provincia			VARCHAR(50),
	Nombre_y_Apellido	VARCHAR(80),
	Domicilio			VARCHAR(150),
	Telefono			VARCHAR(30),
	Edad				VARCHAR(5),
	Localidad			VARCHAR(80),
	X					VARCHAR(30),
	Y					VARCHAR(30),
	col10				VARCHAR(1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE  tipo_gasto (
  IdTipoGasto int(11) NOT NULL AUTO_INCREMENT,
  Descripcion varchar(100) NOT NULL,
  Monto_Aproximado DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (IdTipoGasto)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE canal_venta (
  IdCanal				INTEGER,
  Canal 				VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE compra (
  IdCompra			INTEGER,
  Fecha 				DATE,
  IdProducto			INTEGER,
  Cantidad			INTEGER,
  Precio				DECIMAL(10,2),
  IdProveedor			INTEGER
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE  gasto (
  	IdGasto 		INTEGER,
  	IdSucursal 	INTEGER,
  	IdTipoGasto 	INTEGER,
    Fecha			DATE,
  	Monto 		DECIMAL(10,2)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;


CREATE TABLE  proveedor (
	IDProveedor		INTEGER,
	Nombre			VARCHAR(80),
	Domicilio		VARCHAR(150),
	Ciudad			VARCHAR(80),
	Provincia		VARCHAR(50),
	Pais			VARCHAR(20),
	Departamento	VARCHAR(80)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;


CREATE TABLE producto (
	IDProducto					INTEGER,
	Concepto					VARCHAR(100),
	Tipo						VARCHAR(50),
	Precio2						VARCHAR(30)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;


CREATE TABLE calendario (
        id                      INTEGER PRIMARY KEY,  
        fecha                 	DATE NOT NULL,
        anio                    INTEGER NOT NULL,
        mes                   	INTEGER NOT NULL, 
        dia                     INTEGER NOT NULL, 
        trimestre               INTEGER NOT NULL,
        semana                  INTEGER NOT NULL, 
        dia_nombre              VARCHAR(9) NOT NULL,
        mes_nombre              VARCHAR(9) NOT NULL 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE sucursal (
	ID			INTEGER,
	Sucursal	VARCHAR(40),
	Domicilio	VARCHAR(150),
	Localidad	VARCHAR(80),
	Provincia	VARCHAR(50),
	Latitud2	VARCHAR(30),
	Longitud2	VARCHAR(30)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
# Importacion de datos apartir de csv
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\gasto.csv' 
INTO TABLE `gasto` 
FIELDS TERMINATED BY ',' ENCLOSED BY '' ESCAPED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\compra.csv' 
INTO TABLE `compra` 
FIELDS TERMINATED BY ',' ENCLOSED BY '' ESCAPED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\venta.csv' 
INTO TABLE `venta` 
FIELDS TERMINATED BY ',' ENCLOSED BY '' ESCAPED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\CanalDeVenta.csv' 
INTO TABLE `canal_venta` 
FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY '\"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\TiposDeGasto.csv' 
INTO TABLE `tipo_gasto` 
FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY '\"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Cliente.csv'
INTO TABLE cliente
FIELDS TERMINATED BY ';' ENCLOSED BY '\"' ESCAPED BY '\"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Proveedor.csv' 
INTO TABLE proveedor
FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY '\"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Producto.csv' 
INTO TABLE `producto` 
FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY '\"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Empleado.csv' 
INTO TABLE empleado
FIELDS TERMINATED BY ';' ENCLOSED BY '\"' ESCAPED BY '\"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Sucursal.csv' 
INTO TABLE sucursal
FIELDS TERMINATED BY ';' ENCLOSED BY '\"' ESCAPED BY '\"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

#---------------------------------------------------------------------------------------------------------------------------------------
# LIMPIEZA DE LOS DATOS Y NORMALIZACION
#PASO 1) NORMALIZAMOS LOS NOMBRES DE LOS CAMPOS. EN OTRAS PALABRAS, TRATAMOS DE MANTENER UNA CONSISTENCIA ENTRE LOS CAMPOS DE TODAS LAS TABLAS
# POR EJEMPLO, VAMOS A LLAMAR 'Id' SEGUIDO DEL NOMBRE DE LA TABLA, A TODAS LAS PK DE TODAS LAS TABLAS
# ADEMAS, PONDREMOS UN NOMBRE ACORDE A TODAS LAS COLUMNAS

ALTER TABLE calendario CHANGE id IdFecha INT(11) NOT NULL;

ALTER TABLE sucursal CHANGE ï»¿ID IdSucursal INT(11) NULL DEFAULT NULL;

ALTER TABLE `tipo_gasto` CHANGE `Descripcion` `Tipo_Gasto` VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL;

ALTER TABLE `producto` CHANGE `IDProducto` `IdProducto` INT(11) NULL DEFAULT NULL;

ALTER TABLE `producto` CHANGE `Concepto` `Producto` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NULL DEFAULT NULL;

ALTER TABLE `empresa1`.`empleado` 
CHANGE COLUMN `ID_empleado` `Idempleado` INT NULL DEFAULT NULL ;

aLTER TABLE `empresa1`.`proveedor` 
CHANGE COLUMN `Departamento` `Localidad` VARCHAR(80) NULL DEFAULT NULL ;
#---------------------------------------------------------------------------------------------------------------------------------------
# LIMPIEZA DE LOS DATOS Y NORMALIZACION
#PASO 2) DESCARTAR COLUMNAS QUE NO TENGAS RELEVANCIA

ALTER TABLE `empresa1`.`empleado` 
DROP COLUMN `MyUnknownColumn`;

ALTER TABLE `cliente` DROP `col10`;

#---------------------------------------------------------------------------------------------------------------------------------------
# LIMPIEZA DE LOS DATOS Y NORMALIZACION
#PASO 3) VERIFICAR Y CAMBIAR LOS TIPOS DE DATOS NUMERICOS. SI LOS MISMOS ESTASN ESCRITOS CORRECTAMENTE
#EN LATITUD Y LONGITUD DE LA TABLA CLIENTES, DEBEMOS CAMBIAR PUNTOS POR COMA
#ESTO SE HACE CON LA FUNCION REPLACE

#PRIMERO CAMBIAMOS EL NOMBRE, EN VEZ DE LLAMARLOS X Y, LOS LAMMAMOS LATITUD Y LONGITUD
ALTER TABLE `cliente` 	ADD `Latitud` DECIMAL(13,10) NOT NULL DEFAULT '0' AFTER `Y`, 
						ADD `Longitud` DECIMAL(13,10) NOT NULL DEFAULT '0' AFTER `Latitud`;
                        
#CUANDO HAY UN VALOR EN BLANCO(BLANK), VAMOS A PONER UN CERO
UPDATE cliente SET Y = 0 WHERE Y = '';
UPDATE cliente SET X = 0 WHERE X = '';

# EN LAS COLUMNAS LATITUD Y LONGITUD
UPDATE `cliente` SET Latitud = REPLACE(Y,',','.');      #EL PRIMERO ARGUMENTO EN LA COLUMNA QUE QUIERO MODIFICA, EL SEGUNDO ES QUE QUIERO Y EL TERCERO POR CUAL
UPDATE `cliente` SET Longitud = REPLACE(X,',','.');      #ESTO TAMBIEN SE PODRIA HABER HECHON DIRECTAMENTE EN LAS MISMAS COLUMNAS XY (ES LO MISMO)

#ahora borramos x e y:
alter table cliente
drop column x;

alter table cliente
drop column y;

#hacemos lo mismo pero con sucursal
UPDATE sucursal SET Latitud = 0 WHERE Latitud = '';
UPDATE sucursal SET longitud = 0 WHERE longitud = '';

UPDATE `sucursal` SET Latitud = REPLACE(Latitud,',','.');      
UPDATE `sucursal` SET Longitud = REPLACE(longitud,',','.');

#lo mismo con la tabla empleado
 UPDATE empleado SET salario = 0 WHERE salario = '';
 
#---------------------------------------------------------------------------------------------------------------------------------------
# LIMPIEZA DE LOS DATOS Y NORMALIZACION
#PASO 4) NORMALIZAR LAS COLUMNAS Y COLOVAR UN VALOR A LAS QUE NO TIENEN DATO ('SIN DATO').

#de momento, colocamos 'sin datos' a los valores faltantes
UPDATE `cliente` SET Domicilio = 'Sin Dato' WHERE TRIM(Domicilio) = "" OR ISNULL(Domicilio);  #USAMOS TRIM PARA CORTAR VALORES VACIOS
UPDATE `cliente` SET Localidad = 'Sin Dato' WHERE TRIM(Localidad) = "" OR ISNULL(Localidad);
UPDATE `cliente` SET Nombre_y_Apellido = 'Sin Dato' WHERE TRIM(Nombre_y_Apellido) = "" OR ISNULL(Nombre_y_Apellido);
UPDATE `cliente` SET Provincia = 'Sin Dato' WHERE TRIM(Provincia) = "" OR ISNULL(Provincia);

UPDATE `empleado` SET Apellido = 'Sin Dato' WHERE TRIM(Apellido) = "" OR ISNULL(Apellido);
UPDATE `empleado` SET Nombre = 'Sin Dato' WHERE TRIM(Nombre) = "" OR ISNULL(Nombre);
UPDATE `empleado` SET Sucursal = 'Sin Dato' WHERE TRIM(Sucursal) = "" OR ISNULL(Sucursal);
UPDATE `empleado` SET Sector = 'Sin Dato' WHERE TRIM(Sector) = "" OR ISNULL(Sector);
UPDATE `empleado` SET Cargo = 'Sin Dato' WHERE TRIM(Cargo) = "" OR ISNULL(Cargo);

UPDATE `producto` SET Producto = 'Sin Dato' WHERE TRIM(Producto) = "" OR ISNULL(Producto);
UPDATE `producto` SET Tipo = 'Sin Dato' WHERE TRIM(Tipo) = "" OR ISNULL(Tipo);

UPDATE `proveedor` SET Nombre = 'Sin Dato' WHERE TRIM(Nombre) = "" OR ISNULL(Nombre);
UPDATE `proveedor` SET Domicilio = 'Sin Dato' WHERE TRIM(Domicilio) = "" OR ISNULL(Domicilio);
UPDATE `proveedor` SET Ciudad = 'Sin Dato' WHERE TRIM(Ciudad) = "" OR ISNULL(Ciudad);
UPDATE `proveedor` SET Provincia = 'Sin Dato' WHERE TRIM(Provincia) = "" OR ISNULL(Provincia);
UPDATE `proveedor` SET Pais = 'Sin Dato' WHERE TRIM(Pais) = "" OR ISNULL(Pais);
UPDATE `proveedor` SET localidad = 'Sin Dato' WHERE TRIM(localidad) = "" OR ISNULL(localidad);

UPDATE `sucursal` SET Direccion = 'Sin Dato' WHERE TRIM(Direccion) = "" OR ISNULL(Direccion);
UPDATE `sucursal` SET Sucursal = 'Sin Dato' WHERE TRIM(Sucursal) = "" OR ISNULL(Sucursal);
UPDATE `sucursal` SET Provincia = 'Sin Dato' WHERE TRIM(Provincia) = "" OR ISNULL(Provincia);
UPDATE `sucursal` SET Localidad = 'Sin Dato' WHERE TRIM(Localidad) = "" OR ISNULL(Localidad);





# A LA TABLA VENTAS, TENEMOS QUE DARLE ESPECIAL ATENCION, YA QUE LOS VALORES FALTANTES DE PRECIO Y CANTIDAD SON PREOCUPANTES
#CON LO CUAL, LO OPTIMO SERIA COPIAR ESOS VALORES FALTANTES (PRECIO O CANTIDAD) A UNA tabla auxiliar para un estudio minusioso posteriormente

CREATE TABLE   `aux_venta` (
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

UPDATE venta SET Cantidad = REPLACE(Cantidad, '\r', '');


#insertamos en la tabla creada UNA CONSULTA
#INSERTAMOS LOS VALORES 

INSERT INTO aux_venta (IdVenta, Fecha, Fecha_Entrega, IdCliente, IdSucursal, IdEmpleado, IdProducto, Precio, Cantidad, Motivo)
SELECT IdVenta, Fecha, Fecha_Entrega, IdCliente, IdSucursal, IdEmpleado, IdProducto, Precio, 0, 1
FROM venta WHERE Cantidad = '' or Cantidad is null;  #------------>> ver por que no se ejecuta


UPDATE venta SET Cantidad = '1' WHERE Cantidad = '' or Cantidad is null;
ALTER TABLE `venta` CHANGE `Cantidad` `Cantidad` INTEGER NOT NULL DEFAULT '0';



#---------------------------------------------------------------------------------------------------------------------------------------
# Normalizacion de los datos
# paso 6) usamos una funcion para que los datos empiecen con una letra capital, seguido de minusculas
#para ello se crea la funcion
SET GLOBAL log_bin_trust_function_creators = 1;
DROP FUNCTION IF EXISTS `UC_Words`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `UC_Words`( str VARCHAR(255) ) RETURNS varchar(255) CHARSET utf8
BEGIN  
  DECLARE c CHAR(1);  
  DECLARE s VARCHAR(255);  
  DECLARE i INT DEFAULT 1;  
  DECLARE bool INT DEFAULT 1;  
  DECLARE punct CHAR(17) DEFAULT ' ()[]{},.-_!@;:?/';  
  SET s = LCASE( str );  
  WHILE i < LENGTH( str ) DO  
     BEGIN  
       SET c = SUBSTRING( s, i, 1 );  
       IF LOCATE( c, punct ) > 0 THEN  
        SET bool = 1;  
      ELSEIF bool=1 THEN  
        BEGIN  
          IF c >= 'a' AND c <= 'z' THEN  
             BEGIN  
               SET s = CONCAT(LEFT(s,i-1),UCASE(c),SUBSTRING(s,i+1));  
               SET bool = 0;  
             END;  
           ELSEIF c >= '0' AND c <= '9' THEN  
            SET bool = 0;  
          END IF;  
        END;  
      END IF;  
      SET i = i+1;  
    END;  
  END WHILE;  
  RETURN s;  
END$$
DELIMITER ;


#aplicamos esa funciona  todos los campos que sean texto
UPDATE cliente SET 	Provincia = UC_Words(TRIM(Provincia)),
					Localidad = UC_Words(TRIM(Localidad)),
                    Domicilio = UC_Words(TRIM(Domicilio)),
                    Nombre_y_Apellido = UC_Words(TRIM(Nombre_y_Apellido));
                    
UPDATE sucursal SET Provincia = UC_Words(TRIM(Provincia)),
					Localidad = UC_Words(TRIM(Localidad)),
                    direccion = UC_Words(TRIM(direccion)),
                    Sucursal = UC_Words(TRIM(Sucursal));
					
UPDATE proveedor SET Provincia = UC_Words(TRIM(Provincia)),
					Ciudad = UC_Words(TRIM(Ciudad)),
                    localidad = UC_Words(TRIM(localidad)),
                    Pais = UC_Words(TRIM(Pais)),
                    Nombre = UC_Words(TRIM(Nombre)),
                    Domicilio = UC_Words(TRIM(Domicilio));

UPDATE producto SET Producto = UC_Words(TRIM(Producto)),
					Tipo = UC_Words(TRIM(Tipo));
					
UPDATE empleado SET Sucursal = UC_Words(TRIM(Sucursal)),
                    Sector = UC_Words(TRIM(Sector)),
                    Cargo = UC_Words(TRIM(Cargo)),
                    Nombre = UC_Words(TRIM(Nombre)),
                    Apellido = UC_Words(TRIM(Apellido));

#---------------------------------------------------------------------------------------------------------------------------------------
# CHEQUEO DE LOS DATOS DE ID
# paso 7) chequeamos si los id de las distintas tablas no estan duplicados

SELECT IdCliente, COUNT(*) FROM cliente GROUP BY IdCliente HAVING COUNT(*) > 1;
SELECT IdSucursal, COUNT(*) FROM sucursal GROUP BY IdSucursal HAVING COUNT(*) > 1;
SELECT IdEmpleado, COUNT(*) FROM empleado GROUP BY IdEmpleado HAVING COUNT(*) > 1;
SELECT IdProveedor, COUNT(*) FROM proveedor GROUP BY IdProveedor HAVING COUNT(*) > 1;
SELECT IdProducto, COUNT(*) FROM producto GROUP BY IdProducto HAVING COUNT(*) > 1;


#cuantas repetidad tiene la columna empleados?

select count(*) from (SELECT IdEmpleado, COUNT(*) FROM empleado GROUP BY IdEmpleado  HAVING COUNT(*) > 1 ) as t;  #17 

#para arreglar la id de los empleados, hacemos una combinacion entre la clave empleado y la id sucursal
#primero traemos idsucursal a empleados
ALTER TABLE `empleado` ADD `IdSucursal` INT NULL DEFAULT '0' AFTER `Sucursal`;

#llenamos esa tabla, para ello usamos un join
UPDATE empleado e JOIN sucursal s
	ON (e.Sucursal = s.Sucursal)
SET e.IdSucursal = s.IdSucursal;

ALTER TABLE `empleado` DROP `Sucursal`;  #---> respetando la 3ra ley de la normalizacion

#anado una nueva columna llamada codigo emplreado
ALTER TABLE `empleado` ADD `CodigoEmpleado` INT NULL DEFAULT '0' AFTER `IdEmpleado`;

UPDATE empleado SET CodigoEmpleado = IdEmpleado;

#el id es igual al id anterior mas idsucursal por un escalar
UPDATE empleado SET IdEmpleado = (IdSucursal * 1000000) + CodigoEmpleado;


SELECT * FROM `empleado`;
SELECT IdEmpleado, COUNT(*) FROM empleado GROUP BY IdEmpleado HAVING COUNT(*) > 1;



#para no perder la correlacion entre tablas, modificamos la claveforanea en ventas
UPDATE venta SET IdEmpleado = (IdSucursal * 1000000) + IdEmpleado;


#---------------------------------------------------------------------------------------------------------------------------------------
# NORMALIZACION DE TABLAS
# paso 8) Normalizamos la tabla de empleados. vamos a usar dos nuevas tablas, cargo y sector
#hacemos lo mismo con productos
CREATE TABLE cargo (
  IdCargo int(11) NOT NULL AUTO_INCREMENT,
  Cargo varchar(50) NOT NULL,
  PRIMARY KEY (`IdCargo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE sector (
  `IdSector` int(11) NOT NULL AUTO_INCREMENT,
  `Sector` varchar(50) NOT NULL,
  PRIMARY KEY (`IdSector`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

#insertamos los valores en sectores y cargo
INSERT INTO cargo (Cargo) SELECT DISTINCT Cargo FROM empleado ORDER BY 1;
INSERT INTO sector (Sector) SELECT DISTINCT Sector FROM empleado ORDER BY 1;

#agregamos a empleado las tablas idsector e idcargo
ALTER TABLE `empleado` 	ADD `IdSector` INT NOT NULL DEFAULT '0' AFTER `IdSucursal`, 
						ADD `IdCargo` INT NOT NULL DEFAULT '0' AFTER `IdSector`;
                        
# llenamos las columnos idcargo e idsector en empleado
#hacemos ese update apartir de un join
UPDATE empleado e JOIN cargo c ON (c.Cargo = e.Cargo) SET e.IdCargo = c.IdCargo; ver el err
UPDATE empleado e JOIN sector s ON (s.Sector = e.Sector) SET e.IdSector = s.IdSector;
# -----> ver el error
#ALTER TABLE `empleado` DROP `Cargo`;
#ALTER TABLE `empleado` DROP `Sector`;

# normalizamos la tabla producto
ALTER TABLE `producto` ADD `IdTipoProducto` INT NOT NULL DEFAULT '0' AFTER `Precio2`;
DROP TABLE IF EXISTS `tipo_producto`;
CREATE TABLE IF NOT EXISTS `tipo_producto` (
  `IdTipoProducto` int(11) NOT NULL AUTO_INCREMENT,
  `TipoProducto` varchar(50) NOT NULL,
  PRIMARY KEY (`IdTipoProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tipo_producto (TipoProducto) SELECT DISTINCT Tipo FROM producto ORDER BY 1;

INSERT INTO tipo_producto (TipoProducto) SELECT DISTINCT Tipo FROM producto ORDER BY 1;

SELECT * FROM `producto`;

ALTER TABLE `producto`
  DROP `Tipo`;
  
  # normalizamos los nombres de las provincias y localidad
  #para ello, reeamplazamos los valores distintos y los transformamos en un unico dato, 
  #y eso lo hacemos de forma IGUAL, tanto en cliente, como proveedor y sucursal
UPDATE `cliente` SET provincia = 'Buenos Aires'
WHERE Provincia IN ('B. Aires',
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

UPDATE `proveedor` SET provincia = 'Buenos Aires'
WHERE Provincia IN ('B. Aires',
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


UPDATE `sucursal` SET provincia = 'Buenos Aires'
WHERE Provincia IN ('B. Aires',
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
                            
UPDATE `proveedor` SET Localidad = 'Capital Federal'
WHERE Localidad IN ('Boca De Atencion Monte Castro',
                            'Caba',
                            'Cap.   Federal',
                            'Cap. Fed.',
                            'Capfed',
                            'Capital',
                            'Capital Federal',
                            'Cdad De Buenos Aires',
                            'Ciudad De Buenos Aires')
AND Localidad = 'Buenos Aires';

UPDATE `cliente` SET Localidad = 'Capital Federal'
WHERE Localidad IN ('Boca De Atencion Monte Castro',
                            'Caba',
                            'Cap.   Federal',
                            'Cap. Fed.',
                            'Capfed',
                            'Capital',
                            'Capital Federal',
                            'Cdad De Buenos Aires',
                            'Ciudad De Buenos Aires')
AND Localidad = 'Buenos Aires';

UPDATE `sucursal` SET Localidad = 'Capital Federal'
WHERE Localidad IN ('Boca De Atencion Monte Castro',
                            'Caba',
                            'Cap.   Federal',
                            'Cap. Fed.',
                            'Capfed',
                            'Capital',
                            'Capital Federal',
                            'Cdad De Buenos Aires',
                            'Ciudad De Buenos Aires')
AND Localidad = 'Buenos Aires';

#CREAMOS LAS TABLAS DE LOCALIDAD Y PROVINCIA A MODO DE NORMALIZAR 

CREATE TABLE IF NOT EXISTS `localidad` (
  `IdLocalidad` int(11) NOT NULL AUTO_INCREMENT,
  `Localidad` varchar(80) NOT NULL,
  `Provincia` varchar(80) NOT NULL,
  `IdProvincia` int(11) NOT NULL,
  PRIMARY KEY (`IdLocalidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE IF NOT EXISTS `provincia` (
  `IdProvincia` int(11) NOT NULL AUTO_INCREMENT,
  `Provincia` varchar(50) NOT NULL,
  PRIMARY KEY (`IdProvincia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;


#introduzco los dastos de provincia y localidad de las 3 tablas
#id provincia lo dejo en cero de modemto
INSERT INTO Localidad (Localidad, Provincia, IdProvincia)
SELECT	DISTINCT localidad, provincia, 0
FROM proveedor;

INSERT INTO Localidad (Localidad, Provincia, IdProvincia)
SELECT	DISTINCT localidad, provincia, 0
FROM cliente;

INSERT INTO Localidad (Localidad, Provincia, IdProvincia)
SELECT	DISTINCT localidad, provincia, 0
FROM sucursal;


select * from localidad group by localidad;

#debo tener un distint de cada localidad en la tabla. con lo cual creo una nueva tabla de localidad
# pero esta vez con distint


CREATE TABLE localidad1 as
(select * from localidad group by localidad);

#hacemos lo mismo pero con provincia

#metemos los datos de las 3 tablas (proveedor, cliente, sucursal) en provincia
INSERT INTO provincia (Provincia)
SELECT DISTINCT provincia
FROM proveedor;

INSERT INTO provincia (Provincia)
SELECT DISTINCT provincia
FROM cliente;

INSERT INTO provincia (Provincia)
SELECT DISTINCT provincia
FROM sucursal;

#creamos una tabla con solo distints de provincia
select * from provincia group by provincia;

CREATE TABLE provincia1 as
(select * from provincia group by provincia);

drop table provincia;
drop table localidad;

#ahora las tablas auxiliares con lod distintos son las que vamos a usar

ALTER TABLE `empresa1`.`provincia1` 
RENAME TO  `empresa1`.`provincia` ;

ALTER TABLE `empresa1`.`localidad1` 
RENAME TO  `empresa1`.`localidad` ;

#hago las uniones de provincia con localidad primero

select * from provincia;
select * from localidad;

select * from localidad l
join provincia p
on (p.provincia = l.provincia);

# lleno los idprovincia de localidad coon un join

update localidad l
join provincia p
on (p.provincia = l.provincia)
set l.idprovincia = p.idprovincia;
# estan conectadas estas dos tablas 
# juntar localidad con proveedor, cliente y sucursal de la misma manera y listo
#pero primero tengo que agregar id localidad en cada tabla

ALTER TABLE `empresa1`.`proveedor` 
ADD COLUMN `idlocalidad` INT NULL AFTER `Localidad`;

ALTER TABLE `empresa1`.`cliente` 
ADD COLUMN `idlocalidad` INT NULL AFTER `Localidad`;

ALTER TABLE `empresa1`.`sucursal` 
ADD COLUMN `idlocalidad` INT NULL AFTER `Localidad`;

#hacemos los joins de localidad con cada tabla

update cliente c 
join localidad l
on (l.localidad = c.localidad)
set c.idlocalidad = l.idlocalidad;

update proveedor p
join localidad l
on (l.localidad = p.localidad)
set p.idlocalidad = l.idlocalidad;

update sucursal s  #----> no funciona, ver como arreglar luego
join localidad l
on (l.localidad = s.localidad)
set s.idlocalidad = l.idlocalidad;



# luego queda eliminar columnas redundantes
#--------------------------------------------------------------------------------------------------------------------------------
#creamos un rango etario
ALTER TABLE `cliente` ADD `Rango_Etario` VARCHAR(20) NOT NULL DEFAULT '-' AFTER `Edad`;

UPDATE cliente SET Rango_Etario = '1_Hasta 30 años' WHERE Edad <= 30;
UPDATE cliente SET Rango_Etario = '2_De 31 a 40 años' WHERE Edad <= 40 AND Rango_Etario = '-';
UPDATE cliente SET Rango_Etario = '3_De 41 a 50 años' WHERE Edad <= 50 AND Rango_Etario = '-';
UPDATE cliente SET Rango_Etario = '4_De 51 a 60 años' WHERE Edad <= 60 AND Rango_Etario = '-';
UPDATE cliente SET Rango_Etario = '5_Desde 60 años' WHERE Edad > 60 AND Rango_Etario = '-';



#---------------------------------------------------------------------------------------------------------------------------------------
# BUSQUEDA DE OUTLIERS Y VALORES INCORRECTOS
#PASO 10) BUSCAMOS OUTLIERS EN PRECIO, YA QUE PUEDEN HABER ERRORES DE TIPEO,
# PARA ELLO, SACAMOS EL PROMEDIO DE CADA PRODUCTO Y EL DESVIO. SI ALGUN PRODUCTO SE DESVIA MUY EVIDENTEMENTE, QUIZAS HAY QUE OBSERVARLO


#sacamos media, desvio, precio minimo y precio maximo de cada producto y lo dejamos en una nueva tablas
#CREAMOS UNA TABLA QUE SAQUE EL PROMEDIO DE VENTA DE CADA PRODUCTO, SU DESVIEO Y UN RANGO DE 'NORMALIDAD'
USE EMPRESA1;
CREATE TABLE aux_venta_outliers as
SELECT P.PRODUCTO as producto, 
P.IDPRODUCTO as idproducto, 
AVG(V.PRECIO) AS PRECIO_PROMEDIO, 
STD(V.PRECIO) as desvio_precio, 
AVG(V.PRECIO) + std(v.precio)*4 as limite_derecho, 
AVG(V.PRECIO) - std(v.precio)*2 as limite_izquierdo  
FROM VENTA V 
JOIN PRODUCTO P ON (V.IDPRODUCTO = P.IDPRODUCTO) 
group by P.PRODUCTO;

SELECT * FROM aux_venta_outliers;
select count(*) from aux_venta_outliers;


#hCEMOS UN JOIN CON VENTAS Y TESTEAMOS VENTAS POR VENTAS. CUANDO UNA VENTA ESTA FUERA DE LOS UMBRALES, TOMA EL VALOR CERO EN UNA VARIABLE LLAMADA BINARIA
#SI NO ES ASI, TOMA EL VALOR 1
#PARA ELLO ANADIMOS NUEVAS COLUMNAS A VENTAS
ALTER TABLE `empresa1`.`venta` 
ADD COLUMN `limite_izquierdo` INT NULL AFTER `Cantidad`,
ADD COLUMN `limite_derecho` INT NULL AFTER `limite_izquierdo`,
ADD COLUMN `binaria` INT NULL AFTER `limite_derecho`;
ALTER TABLE `empresa1`.`venta` 
CHANGE COLUMN `binaria` `binaria` INT NULL DEFAULT 0 ;

#INSERTAMOS EN VENTAS LOS VALORES QUE SACAMOS EN LA OTRA TABLA Y LOS INSERTAMOS
update venta v join aux_venta_outliers a on (a.idproducto = v.idproducto) set v.limite_izquierdo = a.limite_izquierdo;
update venta v join aux_venta_outliers a on (a.idproducto = v.idproducto) set v.limite_derecho = a.limite_derecho;
update venta set binaria = 1 where precio < limite_derecho and precio > limite_izquierdo;
update venta set binaria = 0 where binaria is null;


################################################################################################################################################
#RESOLUCION DEL PROFE, NO EJECUTAR
################################################################################################################################################
#use henry_m3;
/*Deteccion y corrección de Outliers sobre ventas*/
/*Motivos:
2-Outlier de Cantidad
3-Outlier de Precio
*/
USE CHECKPOINT_M2;
SELECT v.*, o.promedio, o.maximo                                               
FROM venta v JOIN (SELECT 	IdProducto,
							AVG(Precio) as promedio,
							AVG(Precio) + (3 * STDDEV(Precio)) AS maximo
					FROM venta
					GROUP BY IdProducto) o
			ON (v.IdProducto = o.IdProducto)
WHERE v.Precio > o.maximo;
select * from venta where IdProducto = 42890 order by PRECIO DESC;

SELECT v.*, o.promedio, o.maximo
FROM venta v JOIN (SELECT 	IdProducto,
							AVG(Cantidad) as promedio,
							AVG(Cantidad) + (3 * STDDEV(Cantidad)) AS maximo
					FROM venta
					GROUP BY IdProducto) o
			ON (v.IdProducto = o.IdProducto)
WHERE v.Cantidad > o.maximo;
select * from venta where IdProducto = 42992 ;
select Cantidad, count(*) from venta group by Cantidad order by 1;

INSERT INTO aux_venta (IdVenta, Fecha, Fecha_Entrega, IdCliente, IdSucursal, IdEmpleado, IdProducto, Precio, Cantidad, Motivo)
SELECT v.IdVenta, v.Fecha, v.Fecha_Entrega, v.IdCliente, v.IdSucursal, v.IdEmpleado, v.IdProducto, v.Precio, v.Cantidad, 2
FROM venta v 
JOIN (SELECT IdProducto, AVG(Cantidad) As Promedio, STDDEV(Cantidad) as Desv FROM venta GROUP BY IdProducto) v2
	on (v.IdProducto = v2.IdProducto)
WHERE v.Cantidad > (v2.Promedio + (3 * v2.Desv)) OR v.Cantidad < 0;

INSERT INTO aux_venta (IdVenta, Fecha, Fecha_Entrega, IdCliente, IdSucursal, IdEmpleado, IdProducto, Precio, Cantidad, Motivo)
SELECT v.IdVenta, v.Fecha, v.Fecha_Entrega, v.IdCliente, v.IdSucursal, v.IdEmpleado, v.IdProducto, v.Precio, v.Cantidad, 3
FROM venta v 
JOIN (SELECT IdProducto, AVG(Precio) As Promedio, STDDEV(Precio) as Desv FROM venta GROUP BY IdProducto) v2
	on (v.IdProducto = v2.IdProducto)
WHERE v.Precio > (v2.Promedio + (3 * v2.Desv)) OR v.Precio < 0;

select * from aux_venta where Motivo = 2; -- outliers de cantidad
select * from aux_venta where Motivo = 3; -- outliers de precio

ALTER TABLE `venta` ADD `Outlier` TINYINT NOT NULL DEFAULT '1' AFTER `Cantidad`;

UPDATE venta v JOIN aux_venta a
	ON (v.IdVenta = a.IdVenta AND a.Motivo IN (2,3))
SET v.Outlier = 0;

SELECT 	co.TipoProducto,
		co.PromedioVentaConOutliers,
        so.PromedioVentaSinOutliers
FROM
	(SELECT 	tp.TipoProducto,
			AVG(v.Precio * v.Cantidad) as PromedioVentaConOutliers
	FROM 	venta v JOIN producto p
		ON (v.IdProducto = p.IdProducto)
			JOIN tipo_producto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto)
	GROUP BY tp.TipoProducto) co
JOIN
	(SELECT 	tp.TipoProducto,
			AVG(v.Precio * v.Cantidad) as PromedioVentaSinOutliers
	FROM 	venta v JOIN producto p
		ON (v.IdProducto = p.IdProducto and v.Outlier = 1)
			JOIN tipo_producto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto)
	GROUP BY tp.TipoProducto) so
ON co.TipoProducto = so.TipoProducto;
#####################################################################################################################################################################
####################################################################################################################################################################
#KPI: SACAMOS EL MARGEN DE GANANCIA POR CADA VENTA

#ver luego

#---------------------------------------------------------------------------------------------------------------------------------------
# INDICES Y CLAVES
#PASO 11) CREAMOS LAS PK Y FK DE CADA TABLA

# DEFINIMOS LAS PK PARA LAS TABLAS QUE FALTAN

ALTER TABLE `empresa1`.`sucursal` 
CHANGE COLUMN `IdSucursal` `IdSucursal` INT NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`IdSucursal`);

ALTER TABLE `empresa1`.`proveedor` 
CHANGE COLUMN `IDProveedor` `IDProveedor` INT NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`IDProveedor`);
;

ALTER TABLE `empresa1`.`producto` 
CHANGE COLUMN `IdProducto` `IdProducto` INT NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`IdProducto`);
;

ALTER TABLE `empresa1`.`gasto` 
CHANGE COLUMN `IdGasto` `IdGasto` INT NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`IdGasto`);
;

ALTER TABLE `empresa1`.`cliente` 
CHANGE COLUMN `ID` `ID` INT NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`ID`);
;

ALTER TABLE `empresa1`.`empleado` 
CHANGE COLUMN `Idempleado` `Idempleado` INT NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`Idempleado`);
;


ALTER TABLE `empresa1`.`canal_venta` 
CHANGE COLUMN `IdCanal` `IdCanal` INT NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`IdCanal`);
;

ALTER TABLE `empresa1`.`aux_venta_outliers` 
CHANGE COLUMN `producto` `producto` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_spanish_ci' NOT NULL ,
ADD PRIMARY KEY (`producto`);
;

ALTER TABLE `empresa1`.`aux_venta` 
CHANGE COLUMN `IdVenta` `IdVenta` INT NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`IdVenta`);
;




# DEFINIMOS LAS PK PARA LAS TABLAS QUE FALTAN
#para ello anadimos un indice para cada fk
#VENTA
ALTER TABLE `venta` ADD INDEX(`IdProducto`);
ALTER TABLE `venta` ADD INDEX(`IdEmpleado`);
ALTER TABLE `venta` ADD INDEX(`Fecha`);
ALTER TABLE `venta` ADD INDEX(`Fecha_Entrega`);
ALTER TABLE `venta` ADD INDEX(`IdCliente`);
ALTER TABLE `venta` ADD INDEX(`IdSucursal`);
ALTER TABLE `venta` ADD INDEX(`IdCanal`);

#FK DEFINIDAS
ALTER TABLE venta ADD CONSTRAINT `venta_fk_fecha` FOREIGN KEY (fecha) REFERENCES calendario (fecha) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE venta ADD CONSTRAINT `venta_fk_cliente` FOREIGN KEY (IdCliente) REFERENCES cliente (IdCliente) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE venta ADD CONSTRAINT `venta_fk_sucursal` FOREIGN KEY (IdSucursal) REFERENCES sucursal (IdSucursal) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE venta ADD CONSTRAINT `venta_fk_producto` FOREIGN KEY (IdProducto) REFERENCES producto (IdProducto) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE venta ADD CONSTRAINT `venta_fk_empleado` FOREIGN KEY (IdEmpleado) REFERENCES empleado (IdEmpleado) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE venta ADD CONSTRAINT `venta_fk_canal` FOREIGN KEY (IdCanal) REFERENCES canal_venta (IdCanal) ON DELETE RESTRICT ON UPDATE RESTRICT;

SELECT * FROM VENTA;

SHOW VARIABLES;


#-------------------------------------------------------------------------------------------------------------------------------------------
#procedures
use checkpoint_m2;

#1) procedimiento que indique todas las ventas que se realizaron en una fecha determinada
delimiter //
create procedure procedimiento_VENTA_FECHA1(in fecha_par date)
begin
select idventa, fecha_entrega, idcanal, idcliente,idsucursal, idempleado, idproducto, precio, cantidad from venta where fecha = fecha_par; 
end//

#call procedimiento_VENTA_FECHA1(2016-08-05);

#2) creacion de un procedure que liste los productos que efectivamente se ahn vendido por tipo (parametro)
delimiter //
create procedure procedimiento_productos_tipo_21(in parametro varchar(50))
begin

select distinct( p.producto), p.idproducto  from venta v
join producto p
on (p.idproducto = v.idproducto)
join tipo_producto t
on (p.idtipoproducto = t.idtipoproducto) where t.tipoproducto = parametro;
end //

#call procedimiento_productos_tipo_21('estucheria');

#procedure para insertar en ventas
delimiter //
create procedure procedimiento_insertion_v(in fecha_par date, in fecha_entrega_par date, in idcanal_par int, in idcliente_par int, in idsucursal_par int, in idempleado_par int, in idproducto_par int, in precio decimal(10,2), in cantidad_par int)
begin
if exists(select idcanal = idcanal_par from canal_venta) then
insert into venta (fecha, fecha_entrega, idcanal, idcliente, idsucursal, idempleado, idproducto, precio, cantidad) values (fecha_par, fecha_entrega_par, idcanal_par ,  idcliente_par , idsucursal_par, idempleado_par, idproducto_par , precio, cantidad_par );
select @mensaje2;
end if;
end//

# call procedimiento_insertion_v(2016-05-18, 2016-06-02, 10, 884, 12, 13001674, 42825, 813.12, 1); 


# procedure que recibe como parametro un grupo etario y devuelve el total de las compras de ese grupo
use checkpoint_m2;

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
