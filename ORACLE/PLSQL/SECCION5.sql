/* HABILITAR LA SALIDA A LA PANTALL */
SET SERVEROUTPUT ON;

BEGIN
  DBMS_OUTPUT.PUT_LINE(100);
  DBMS_OUTPUT.PUT_LINE('AAAAAA' || 'XXXXX');
END;