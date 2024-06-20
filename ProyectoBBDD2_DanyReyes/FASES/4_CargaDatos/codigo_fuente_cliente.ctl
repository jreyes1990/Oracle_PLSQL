LOAD DATA 
INFILE 'C:\Users\jarl1\OneDrive\Documentos\ProyectoBBDD2_DanyReyes\FASE_1\4_CargaDatos\CLIENTE_1.csv' "str '\r\n'"
TRUNCATE
INTO TABLE CLIENTE
FIELDS TERMINATED BY ","
OPTIONALLY ENCLOSED BY '"' AND '"'
TRAILING NULLCOLS
(
CODIGO_CLIENTE CHAR(15),
NOMBRE_CLIENTE CHAR(200),
STATUS CHAR(20),
GENERO CHAR(20),
ESTADO_CIVIL CHAR(20),
REGION CHAR(20),
DEPARTAMENTO CHAR(50),
MUNICIPIO CHAR(75),
CLASIFICACION CHAR(20),
SECTOR_ECONOMICO CHAR(200)
)