/* HABILITAR LA SALIDA A LA PANTALL */
SET SERVEROUTPUT ON;

BEGIN
  DBMS_OUTPUT.PUT_LINE(100);
  DBMS_OUTPUT.PUT_LINE('AAAAAA' || 'XXXXX');
END;

/******************************************************************************/
/* PONER TU NOMBRE Y APELLIDOS EN PANTALLA */
SET SERVEROUTPUT ON;

BEGIN
  DBMS_OUTPUT.PUT_LINE('NOMBRE(S):'||'JOLBERTH ALBERTO');
  DBMS_OUTPUT.PUT_LINE('APELLIDO(S):'||'REYES LOPEZ');
END;

/******************************************************************************/
/***** VARIABLES *****/
/* PONER TU NOMBRE Y APELLIDOS EN PANTALLA */
SET SERVEROUTPUT ON;

DECLARE
  NAME     VARCHAR2(100);
  LASTNAME VARCHAR2(100);
BEGIN
  NAME := 'JOLBERTH ALBERTO';
  LASTNAME := 'REYES LOPEZ';
  DBMS_OUTPUT.PUT_LINE('VARIABLE NOMBRE(S):'||NAME);
  DBMS_OUTPUT.PUT_LINE('VARIABLE APELLIDO(S):'||LASTNAME);
END;




