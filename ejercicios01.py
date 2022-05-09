# solucional error 1290
# https://www.youtube.com/watch?v=lWJuWD6SwDg
# Es un problema de seguridad, simplemente hay que modificar el archivo my (linea 142) --->buscar con la salida del error 1290
# #secure-file-priv="C:/ProgramData/MySQL/MySQL Server 8.0/Uploads" ------>comentar
# secure-file-priv=""  ------>dejar
# luego reiniciar el workbrench -----> services ---> mysql80 ---> resetear
#? AGREGAR LOS ARCHIVOS EN ESTA CARPETA: C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\empleado.csv

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
















