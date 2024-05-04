set NLS_LANG=.UTF8

sqlldr userid= USR_PRODUCCION/PRODUCCION    control='C:\Users\jarl1\OneDrive\Documentos\ProyectoBBDD2_DanyReyes\FASE_1\4_CargaDatos\codigo_fuente_datos.ctl'
echo "Carga de informacion a la tabla DATOS

sqlldr userid= USR_PRODUCCION/PRODUCCION    control='C:\Users\jarl1\OneDrive\Documentos\ProyectoBBDD2_DanyReyes\FASE_1\4_CargaDatos\codigo_fuente_agente.ctl'
echo "Carga de informacion a la tabla AGENTE

sqlldr userid= USR_PRODUCCION/PRODUCCION    control='C:\Users\jarl1\OneDrive\Documentos\ProyectoBBDD2_DanyReyes\FASE_1\4_CargaDatos\codigo_fuente_regimen.ctl'
echo "Carga de informacion a la tabla REGIMEN

pause