'''
### Datos

Los Datos son un conjunto de hechos almacenados:

<img src="../_src/assets/datos.jpg"  height="250">

### Información

Es el conjunto de datos procesados en tiempo y en forma, que constituyen un mensaje relevante y reduce la incertidumbre.

<img src="../_src/assets/informacion.jpg"  height="250">

### Conocimiento

Se adquiere con la práctica y la experiencia. Dota a las personas con la capacidad de tomar decisiones. 

<img src="../_src/assets/conocimiento.jpg"  height="250">

## Inteligencia de Negocios (BI)

* Con la experiencia nos hacemos expertos
* Adquirimos el conocimiento sobre el dominio del negocio.
* Somos capaces de describir su comportamiento y comprender sus aspectos y variables más importantes.
* ¿Está esa experiencia e información, de donde se obtuvo el conocimiento, plasmada en los datos?
* ¿Cuánto valor se le puede dar entonces a los datos que el negocio genera?
* ¿Cómo podemos hacer para generar información a partir de los datos?
* Ese es el objetivo principal de la Inteligencia de Negocios, convertir los datos en información oportuna y relevante por medio de diferentes técnicas de transformación, análisis y visualización.

### Soporte a la Decisión

* En una organización se toman decisiones
* Es importante mitigar la incertidumbre
* Lograr respaldo y seguridad
* La Inteligencia de Negocios, enfocada en la calidad del dato, procura procesarlo, desde su origen para su análisis
* Soporte a la toma de decisiones
'''
#-------------------------------------------------------------------------------------------------------------------------------------------------
# COMO IMPORTAR UN ARCHIVO CSV A UNA TABLA 
#? https://www.mysqltutorial.org/import-csv-file-mysql-table/
#? https://devtut.github.io/mysql/load-data-infile.html#using-load-data-infile-to-load-large-amount-of-data-to-database
#? https://www.youtube.com/watch?v=w4N5osKxp7Q



#C:\Users\54261\OneDrive\Escritorio\Henry\Modulo3\Compra.csv
# TIPOS DE DATOS sql 
#? https://dev.mysql.com/doc/refman/5.7/en/data-types.html



#csv y excel
#? https://www.youtube.com/watch?v=d3JYtvnhYFM




#IMPORTAR UN CSV CON CODIGO
''' 
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\empleado.csv'
into table empleado
fields terminated by ';'
optionally enclosed by '"'
escaped by '"'
lines terminated by '\n'
ignore 1 lines; -- skip the header row

'''

# IMPORTAR CON LA INTERFAZ
#? Salida de cualquier tabla ---> import
























