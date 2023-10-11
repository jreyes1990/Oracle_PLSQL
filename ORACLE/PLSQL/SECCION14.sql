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