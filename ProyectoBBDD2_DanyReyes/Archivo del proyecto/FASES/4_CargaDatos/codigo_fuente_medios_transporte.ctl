LOAD DATA 
INFILE 'C:\Users\jarl1\OneDrive\Documentos\ProyectoBBDD2_DanyReyes\FASE_1\4_CargaDatos\MEDIOS_TRANSPORTE_1.csv' "str '\r\n'"
TRUNCATE
INTO TABLE MEDIOS_TRANSPORTE
FIELDS TERMINATED BY ","
OPTIONALLY ENCLOSED BY '"' AND '"'
TRAILING NULLCOLS
(
CODIGO_TRANSPORTE CHAR(2),
DESCRIPCION_TRANSPORTE CHAR(200)
)