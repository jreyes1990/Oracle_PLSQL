LOAD DATA 
INFILE 'C:\Users\jarl1\OneDrive\Documentos\ProyectoBBDD2_DanyReyes\FASE_1\4_CargaDatos\TIPO_OPERACION_1.csv' "str '\r\n'"
TRUNCATE
INTO TABLE TIPO_OPERACION
FIELDS TERMINATED BY ","
OPTIONALLY ENCLOSED BY '"' AND '"'
TRAILING NULLCOLS
(
CODIGO_TIPO_OPERACION CHAR(2),
NOMBRE_TIPO_OPERACION CHAR(50)
)