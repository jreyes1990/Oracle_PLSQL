set NLS_LANG=.UTF8

sqlldr userid= USR_PRODUCCION/PRODUCCION    control='C:\Users\jarl1\OneDrive\Documentos\ProyectoBBDD2_DanyReyes\FASE_1\4_CargaDatos\codigo_fuente_datos.ctl'
echo "Carga de informacion a la tabla DATOS"

sqlldr userid= USR_PRODUCCION/PRODUCCION    control='C:\Users\jarl1\OneDrive\Documentos\ProyectoBBDD2_DanyReyes\FASE_1\4_CargaDatos\codigo_fuente_agente.ctl'
echo "Carga de informacion a la tabla AGENTE"

sqlldr userid= USR_PRODUCCION/PRODUCCION    control='C:\Users\jarl1\OneDrive\Documentos\ProyectoBBDD2_DanyReyes\FASE_1\4_CargaDatos\codigo_fuente_regimen.ctl'
echo "Carga de informacion a la tabla REGIMEN"

sqlldr userid= USR_PRODUCCION/PRODUCCION    control='C:\Users\jarl1\OneDrive\Documentos\ProyectoBBDD2_DanyReyes\FASE_1\4_CargaDatos\codigo_fuente_aduana.ctl'
echo "Carga de informacion a la tabla ADUANA"

sqlldr userid= USR_PRODUCCION/PRODUCCION    control='C:\Users\jarl1\OneDrive\Documentos\ProyectoBBDD2_DanyReyes\FASE_1\4_CargaDatos\codigo_fuente_tipo_operacion.ctl'
echo "Carga de informacion a la tabla TIPO_OPERACION"

sqlldr userid= USR_PRODUCCION/PRODUCCION    control='C:\Users\jarl1\OneDrive\Documentos\ProyectoBBDD2_DanyReyes\FASE_1\4_CargaDatos\codigo_fuente_pais.ctl'
echo "Carga de informacion a la tabla PAIS"

sqlldr userid= USR_PRODUCCION/PRODUCCION    control='C:\Users\jarl1\OneDrive\Documentos\ProyectoBBDD2_DanyReyes\FASE_1\4_CargaDatos\codigo_fuente_cliente.ctl'
echo "Carga de informacion a la tabla CLIENTE"

sqlldr userid= USR_PRODUCCION/PRODUCCION    control='C:\Users\jarl1\OneDrive\Documentos\ProyectoBBDD2_DanyReyes\FASE_1\4_CargaDatos\codigo_fuente_medios_transporte.ctl'
echo "Carga de informacion a la tabla MEDIOS_TRANSPORTE"

sqlldr userid= USR_PRODUCCION/PRODUCCION    control='C:\Users\jarl1\OneDrive\Documentos\ProyectoBBDD2_DanyReyes\FASE_1\4_CargaDatos\codigo_fuente_almacenadora.ctl'
echo "Carga de informacion a la tabla ALMACENADORA"

pause