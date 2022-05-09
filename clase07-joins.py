#?create database practica;
#?use practica;

#?select * from ciudadano;

#VER LA TABLA CON ATENCION
#TENEMOS CIUDADANOS QUE TIENEN ASIGNADAS CIUDADES QUE NO ESTAN EN LA LISTA --- 
#Y TENEMOS CIUDADES QUE DONDE NO HAY CIUDADANOS (0) EN LIMA

#JOIN
#?SELECT * FROM CIUDADANO AS CO
#?JOIN CIUDAD2 CD 
#?ON (CO.IDCIUDAD = CD.IDCIUDAD);
#?-- Me muestra solo los matches. es decir, ciudadanos que viven en ciudades que aparecen en esa tabla 
#?-- es una especie de interseccion



#NOTEMOS QUE EN ESTE CASO ME MUESTRA SOLO LOS CIUDADANOS QUE TIENEN 
# INNER JOIN
#?SELECT * FROM CIUDADANO AS CO
#?INNER JOIN CIUDAD2 CD 
#?ON (CO.IDCIUDAD = CD.IDCIUDAD);
#?-- es lo mismo que un join


#LEFT OUTER JOIN
#?SELECT * FROM CIUDADANO AS CO
#?LEFT OUTER JOIN CIUDAD2 CD 
#?ON (CO.IDCIUDAD = CD.IDCIUDAD);
#?-- me muestra todos los matches + los no matches de la tabla1 (ciudadano)
#?-- es decir que me muestra todos los ciudadanos y sus ciudades, y los ciudadanos con ciudades que no estan registradas




#right OUTER JOIN
#?SELECT * FROM CIUDADANO AS CO
#?right OUTER JOIN CIUDAD2 CD 
#?ON (CO.IDCIUDAD = CD.IDCIUDAD);
#?-- me muestra todos los matches + los no matches de la tabla (ciudad)
#?-- me muestra SOLO los ciudadanos con ciudades registradas, y las ciudades sin ciudadanos



#full OUTER JOIN
#?SELECT * FROM CIUDADANO AS CO
#?JOIN CIUDAD2 CD 
#?ON (CO.IDCIUDAD = CD.IDCIUDAD);
#?-- me muestra todos los matches + los no matches de la tabla1 (ciudadano) + no matches de la tabla2 (ciudad)
#?-- me muestra SOLO los ciudadanos con ciudades registradas, y las ciudades sin ciudadanos


#CONSEJOS DE OPTIMIZACION
#SIEMPRE ES MEJOR PONER EL FILTRO EN UN AND QUE EN UN WHERE
#?-- forma 1:
#?SELECT * FROM CIUDADANO AS CO
#?JOIN CIUDAD2 CD 
#?ON (CO.IDCIUDAD = CD.IDCIUDAD)
#?WHERE CD.NOMBRE = 'LONDRES';    
#?-- forma 1:
#?SELECT * FROM CIUDADANO AS CO
#?JOIN CIUDAD2 CD 
#?ON (CO.IDCIUDAD = CD.IDCIUDAD)
#?and CD.NOMBRE = 'LONDRES';