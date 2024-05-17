-- Creando un JOB
BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    JOB_NAME 					=> 'JOB_EJEC_CIERRE_DIARIO_COOPE',
    JOB_TYPE 					=> 'PLSQL_BLOCK',
    JOB_ACTION 				=> 'BEGIN PR_CIERRE_DIARIO(SYSDATE); COMMIT; END;',
    START_DATE 				=> SYSDATE,
    REPEAT_INTERVAL 	=> 'FREQ=DAILY;INTERVAL=1;BYHOUR=23;BYMINUTE=50;BYSECOND=00',
    ENABLED 					=> TRUE,
    AUTO_DROP 				=> FALSE,
    COMMENTS 					=> 'EJECUTA EL PROCEDIMIENTO PR_CIERRE_DIARIO PARA CERRAR LAS OPERACIONES DIARIAS DE LA COOPERATIVA MADRE TIERRA R.L.'
  );
END;

-- Detener JOB
BEGIN
 DBMS_SCHEDULER.DISABLE ('JOB_EJEC_CIERRE_DIARIO_COOPE');
END;
/

-- Alternando JOB
BEGIN
	ALTER_JOB (
	  JOB_NAME => 'JOB_EJEC_CIERRE_DIARIO_COOPE',
	  ENABLED => TRUE,
	  START_TIME => TO_TIMESTAMP('14:00:00', 'HH24:MI:SS'),
	  REPEAT_INTERVAL => 'FREQ=MONTHLY;INTERVAL=1'
	);
END;

-- Habilitar JOB
BEGIN
  DBMS_SCHEDULER.ENABLE ('JOB_EJEC_CIERRE_DIARIO_COOPE');
END;
/

/* Para eliminar un trabajo en Oracle Scheduler, puede usar el DROP_JOBcomando. Aquí está la sintaxis:
 * Explicación:

 * DROP_JOB: este comando se utiliza para eliminar un trabajo del repositorio de trabajos de Oracle Scheduler.
 * JOB_NAME: Este es el nombre del trabajo que desea eliminar. */
BEGIN
  DBMS_SCHEDULER.DROP_JOB (
    JOB_NAME => 'JOB_EJEC_CIERRE_DIARIO_COOPE'
  );
END;

-- Consultando el JOB
SELECT * FROM dba_scheduler_jobs WHERE owner='POS';
