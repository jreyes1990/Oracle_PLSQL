/******************************************************************************/
/***** ATRIBUTOS IMPLICITOS DE PL/SQL *****/
SET SERVEROUTPUT ON;

BEGIN 
  UPDATE TEST SET C2='PPPPPPP' WHERE C1=100;
  DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);
  
  IF SQL%FOUND THEN
    DBMS_OUTPUT.PUT_LINE('ENCONTRADO');
  END IF;
  
  IF SQL%NOTFOUND THEN
    DBMS_OUTPUT.PUT_LINE('NO ENCONTRADO');
  END IF;
END;

/******************************************************************************/
/***** CREAR UN CURSOR DE PL/SQL *****/
SET SERVEROUTPUT ON;

DECLARE
  CURSOR C1 IS 
    SELECT * FROM REGIONS;
  V1 REGIONS%ROWTYPE;
BEGIN
  OPEN C1; -- ABRIMOS EL CURSOR
  FETCH C1 INTO V1; -- LEE EL CURSOR
    DBMS_OUTPUT.PUT_LINE(V1.REGION_NAME);
  CLOSE C1; -- CIERRA EL CURSOR
END;

/******************************************************************************/
/***** RECORRER UN CURSOR CON UN BUCLE LOOP DE PL/SQL *****/
SET SERVEROUTPUT ON;

DECLARE
  CURSOR C1 IS 
    SELECT * FROM REGIONS;
  V1 REGIONS%ROWTYPE;
BEGIN
  OPEN C1;
    LOOP
      FETCH C1 INTO V1;
      EXIT WHEN C1%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(V1.REGION_NAME);
    END LOOP;
  CLOSE C1;
END;

/******************************************************************************/
/***** RECORRER UN CURSOR CON UN BUCLE FOR DE PL/SQL *****/
SET SERVEROUTPUT ON;

DECLARE
  CURSOR C1 IS 
    SELECT * FROM REGIONS;
  V1 REGIONS%ROWTYPE;
BEGIN
  FOR I IN C1 LOOP
    DBMS_OUTPUT.PUT_LINE(I.REGION_NAME);
  END LOOP;
END;



