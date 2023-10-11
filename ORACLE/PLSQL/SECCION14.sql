/******************************************************************************/
/***** CREAR OBJETOS DECLARACION EN PL/SQL *****/
-- CREAR CABECERA DEL OBJETO
CREATE OR REPLACE TYPE PRODUCTO AS OBJECT(
  -- ATRIBUTOS
  CODIGO NUMBER,
  NOMBRE VARCHAR2(100),
  PRECIO NUMBER,
  
  -- METODOS
  MEMBER FUNCTION VER_PRODUCTO RETURN VARCHAR2,
  MEMBER FUNCTION VER_PRECIO RETURN NUMBER,
  MEMBER PROCEDURE CAMBIAR_PRECIO(PVP NUMBER),
  MEMBER PROCEDURE MAYUS
);
/

--PARA BORRAR OBJETO
DROP TYPE PRODUCTO;

-- CREAR CUERPO DEL OBJETO
CREATE OR REPLACE TYPE BODY PRODUCTO 
AS
  MEMBER FUNCTION VER_PRODUCTO
  RETURN VARCHAR2 AS
  BEGIN
    RETURN 'CODIGO-->'||CODIGO||' NOMBRE-->'||NOMBRE||' PRECIO-->'||PRECIO;
  END VER_PRODUCTO;
  
  MEMBER FUNCTION VER_PRECIO
  RETURN NUMBER AS
  BEGIN
    RETURN PRECIO;
  END VER_PRECIO;
  
  MEMBER PROCEDURE CAMBIAR_PRECIO(PVP NUMBER) AS
  BEGIN
    PRECIO := PVP;
  END CAMBIAR_PRECIO;
  
  MEMBER PROCEDURE MAYUS AS
  BEGIN
    NOMBRE := UPPER(NOMBRE);
  END;
  
END;
/

-- EJECUTAR EL OBJETO EN PL/SQL
SET SERVEROUTPUT ON FORMAT WRAPPED LINE 1000;

DECLARE
  V1 PRODUCTO;
BEGIN
  V1 := PRODUCTO(100,'Manzanas',10);
  DBMS_OUTPUT.PUT_LINE(V1.VER_PRECIO());
  DBMS_OUTPUT.PUT_LINE(V1.VER_PRODUCTO());
  
  V1.CAMBIAR_PRECIO(20);
  DBMS_OUTPUT.PUT_LINE(V1.VER_PRECIO());
  
  V1.MAYUS();
  DBMS_OUTPUT.PUT_LINE(V1.VER_PRODUCTO());
  
  V1.NOMBRE := 'Pera';
  DBMS_OUTPUT.PUT_LINE(V1.VER_PRODUCTO());
END;

/***** ARGUMENTO SELF EN PL/SQL *****/
-- CREAR CABECERA DEL OBJETO
CREATE OR REPLACE TYPE PRODUCTO AS OBJECT(
  -- ATRIBUTOS
  CODIGO NUMBER,
  NOMBRE VARCHAR2(100),
  PRECIO NUMBER,
  
  -- METODOS
  MEMBER FUNCTION VER_PRODUCTO RETURN VARCHAR2,
  MEMBER FUNCTION VER_PRECIO RETURN NUMBER,
  MEMBER PROCEDURE CAMBIAR_PRECIO(PRECIO NUMBER),
  MEMBER PROCEDURE MAYUS
);
/

-- CREAR CUERPO DEL OBJETO
CREATE OR REPLACE TYPE BODY PRODUCTO 
AS
  MEMBER FUNCTION VER_PRODUCTO
  RETURN VARCHAR2 AS
  BEGIN
    RETURN 'CODIGO-->'||CODIGO||' NOMBRE-->'||NOMBRE||' PRECIO-->'||PRECIO;
  END VER_PRODUCTO;
  
  MEMBER FUNCTION VER_PRECIO
  RETURN NUMBER AS
  BEGIN
    RETURN PRECIO;
  END VER_PRECIO;
  
  MEMBER PROCEDURE CAMBIAR_PRECIO(PRECIO NUMBER) AS
  BEGIN
    self.PRECIO := PRECIO; --Uso de self
  END CAMBIAR_PRECIO;
  
  MEMBER PROCEDURE MAYUS AS
  BEGIN
    NOMBRE := UPPER(NOMBRE);
  END;
  
END;
/

-- EJECUTAR EL OBJETO EN PL/SQL
SET SERVEROUTPUT ON FORMAT WRAPPED LINE 1000;

DECLARE
  V1 PRODUCTO;
BEGIN
  V1 := PRODUCTO(100,'Manzanas',10);
  DBMS_OUTPUT.PUT_LINE(V1.VER_PRECIO());
  DBMS_OUTPUT.PUT_LINE(V1.VER_PRODUCTO());
  
  V1.CAMBIAR_PRECIO(20);
  DBMS_OUTPUT.PUT_LINE(V1.VER_PRECIO());
  
  V1.MAYUS();
  DBMS_OUTPUT.PUT_LINE(V1.VER_PRODUCTO());
  
  V1.NOMBRE := 'Pera';
  DBMS_OUTPUT.PUT_LINE(V1.VER_PRODUCTO());
END;

/***** METODOS ESTATICOS EN PL/SQL *****/
-- CREAR TABLA AUDITORIA
DROP TABLE AUDITORIA;

CREATE TABLE AUDITORIA(
  USUARIO VARCHAR2(100),
  FECHA DATE
);

SELECT * FROM AUDITORIA;

-- CREAR CABECERA DEL OBJETO
CREATE OR REPLACE TYPE PRODUCTO AS OBJECT(
  -- ATRIBUTOS
  CODIGO NUMBER,
  NOMBRE VARCHAR2(100),
  PRECIO NUMBER,
  
  -- METODOS
  MEMBER FUNCTION VER_PRODUCTO RETURN VARCHAR2,
  MEMBER FUNCTION VER_PRECIO RETURN NUMBER,
  MEMBER PROCEDURE CAMBIAR_PRECIO(PRECIO NUMBER),
  MEMBER PROCEDURE MAYUS,
  STATIC PROCEDURE AUDITORIA
);
/

-- CREAR CUERPO DEL OBJETO
CREATE OR REPLACE TYPE BODY PRODUCTO 
AS
  MEMBER FUNCTION VER_PRODUCTO
  RETURN VARCHAR2 AS
  BEGIN
    RETURN 'CODIGO-->'||CODIGO||' NOMBRE-->'||NOMBRE||' PRECIO-->'||PRECIO;
  END VER_PRODUCTO;
  
  MEMBER FUNCTION VER_PRECIO
  RETURN NUMBER AS
  BEGIN
    RETURN PRECIO;
  END VER_PRECIO;
  
  MEMBER PROCEDURE CAMBIAR_PRECIO(PRECIO NUMBER) AS
  BEGIN
    self.PRECIO := PRECIO; --Uso de self
  END CAMBIAR_PRECIO;
  
  MEMBER PROCEDURE MAYUS AS
  BEGIN
    NOMBRE := UPPER(NOMBRE);
  END;
  
  STATIC PROCEDURE AUDITORIA AS
  BEGIN
    INSERT INTO AUDITORIA VALUES(USER, SYSDATE);
  END;
  
END;
/

-- EJECUTAR EL OBJETO EN PL/SQL
SET SERVEROUTPUT ON FORMAT WRAPPED LINE 1000;

DECLARE
  V1 PRODUCTO;
BEGIN
  V1 := PRODUCTO(100,'Manzanas',10);
  DBMS_OUTPUT.PUT_LINE(V1.VER_PRECIO());
  DBMS_OUTPUT.PUT_LINE(V1.VER_PRODUCTO());
  
  V1.CAMBIAR_PRECIO(20);
  DBMS_OUTPUT.PUT_LINE(V1.VER_PRECIO());
  
  V1.MAYUS();
  DBMS_OUTPUT.PUT_LINE(V1.VER_PRODUCTO());
  
  V1.NOMBRE := 'Pera';
  DBMS_OUTPUT.PUT_LINE(V1.VER_PRODUCTO());
  
  PRODUCTO.AUDITORIA();
END;

SELECT * FROM AUDITORIA;

/***** METODOS CONSTRUCTORES EN PL/SQL *****/
-- CREAR SECUENCIA
DROP SEQUENCE SEQ1;

CREATE SEQUENCE SEQ1;

-- CREAR CABECERA DEL OBJETO
CREATE OR REPLACE TYPE PRODUCTO AS OBJECT(
  -- ATRIBUTOS
  CODIGO NUMBER,
  NOMBRE VARCHAR2(100),
  PRECIO NUMBER,
  
  -- METODOS
  MEMBER FUNCTION VER_PRODUCTO RETURN VARCHAR2,
  MEMBER FUNCTION VER_PRECIO RETURN NUMBER,
  MEMBER PROCEDURE CAMBIAR_PRECIO(PRECIO NUMBER),
  MEMBER PROCEDURE MAYUS,
  STATIC PROCEDURE AUDITORIA,
  CONSTRUCTOR FUNCTION PRODUCTO(N1 VARCHAR2) RETURN SELF AS RESULT
);
/

-- CREAR CUERPO DEL OBJETO
CREATE OR REPLACE TYPE BODY PRODUCTO 
AS
  MEMBER FUNCTION VER_PRODUCTO
  RETURN VARCHAR2 AS
  BEGIN
    RETURN 'CODIGO-->'||CODIGO||' NOMBRE-->'||NOMBRE||' PRECIO-->'||PRECIO;
  END VER_PRODUCTO;
  
  MEMBER FUNCTION VER_PRECIO
  RETURN NUMBER AS
  BEGIN
    RETURN PRECIO;
  END VER_PRECIO;
  
  MEMBER PROCEDURE CAMBIAR_PRECIO(PRECIO NUMBER) AS
  BEGIN
    self.PRECIO := PRECIO; --Uso de self
  END CAMBIAR_PRECIO;
  
  MEMBER PROCEDURE MAYUS AS
  BEGIN
    NOMBRE := UPPER(NOMBRE);
  END;
  
  STATIC PROCEDURE AUDITORIA AS
  BEGIN
    INSERT INTO AUDITORIA VALUES(USER, SYSDATE);
  END;
  
  CONSTRUCTOR FUNCTION PRODUCTO(N1 VARCHAR2) RETURN SELF AS RESULT
  IS
  BEGIN
    SELF.NOMBRE := N1;
    SELF.PRECIO := NULL;
    SELF.CODIGO := SEQ1.NEXTVAL;
    
    RETURN;
  END;
  
END;
/

-- EJECUTAR EL OBJETO EN PL/SQL
SET SERVEROUTPUT ON FORMAT WRAPPED LINE 1000;

DECLARE
  V1 PRODUCTO;
BEGIN
  V1 := PRODUCTO('Manzanas');
  DBMS_OUTPUT.PUT_LINE(V1.VER_PRECIO());
  DBMS_OUTPUT.PUT_LINE(V1.VER_PRODUCTO());
  
  V1.CAMBIAR_PRECIO(20);
  DBMS_OUTPUT.PUT_LINE(V1.VER_PRECIO());
  
  V1.MAYUS();
  DBMS_OUTPUT.PUT_LINE(V1.VER_PRODUCTO());
  
  V1.NOMBRE := 'Pera';
  DBMS_OUTPUT.PUT_LINE(V1.VER_PRODUCTO());
  
  PRODUCTO.AUDITORIA();
END;

/***** COMO VER NUESTROS OBJETOS EN PL/SQL *****/
DESC PRODUCTO;
SELECT * FROM USER_TYPES;
SELECT * FROM USER_SOURCE WHERE NAME='PRODUCTO';
