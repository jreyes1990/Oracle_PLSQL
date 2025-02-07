/*=======================================================================================================*/
/* 1. CREACION TRIGGER TABLA 'DATOS' A TABLA WATERMARK */
CREATE OR REPLACE TRIGGER TRG_DATOS_SINC
AFTER INSERT OR UPDATE
ON DATOS
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    EVENTO_TABLA        WATERMARK.TABLA%TYPE;
    EVENTO_EXISTE_PK	WATERMARK.PK%TYPE;
    EVENTO_OPERACION 	WATERMARK.OPERACION%TYPE;
    EVENTO_MIGRO 		WATERMARK.MIGRO%TYPE := 'N';
    EVENTO_FECHA_INSERT WATERMARK.FECHA_INSERT%TYPE := SYSDATE;
    --
    MIGRACION_DATOS EXCEPTION;
BEGIN
    BEGIN
        SELECT OBJECT_NAME 
            INTO EVENTO_TABLA
        FROM ALL_OBJECTS
        WHERE OBJECT_TYPE = 'TABLE'
        AND OBJECT_NAME = 'DATOS';
    EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'TRG_DATOS_SINC => ALL_OBJECTS: Ocurrio un error al realizar la busqueda del objet_name DATOS ['||SQLERRM||']');
    END;
    BEGIN
        IF INSERTING THEN
            EVENTO_OPERACION := 'I';
        ELSIF UPDATING THEN
            EVENTO_OPERACION := 'U';
        END IF;
        BEGIN
            SELECT COUNT(DISTINCT PK) 
                INTO EVENTO_EXISTE_PK
            FROM WATERMARK 
            WHERE TABLA=EVENTO_TABLA AND PK=(:NEW.CODIGO_AGENTE||'-'||:NEW.NUMERO_DECLARACION) AND OPERACION=EVENTO_OPERACION AND MIGRO=EVENTO_MIGRO;
            
            IF (EVENTO_EXISTE_PK = 0) THEN
                INSERT INTO WATERMARK 
                    (TABLA, PK, OPERACION, FECHA_INSERT, MIGRO, FECHA_OPERADO)
                    VALUES(EVENTO_TABLA, :NEW.CODIGO_AGENTE||'-'||:NEW.NUMERO_DECLARACION, EVENTO_OPERACION, EVENTO_FECHA_INSERT, EVENTO_MIGRO, NULL);
            ELSE
                RAISE MIGRACION_DATOS;
            END IF;
        EXCEPTION WHEN MIGRACION_DATOS THEN
            RAISE_APPLICATION_ERROR(-20001, 'TRG_DATOS_SINC => WATERMARK: Aun esta pendiente de migrar el PK ['||:NEW.CODIGO_AGENTE||'-'||:NEW.NUMERO_DECLARACION||'] de la tabla DATOS');
            ROLLBACK;
        END;
    END;
END TRG_DATOS_SINC;
/


/*=======================================================================================================*/
/* 2. CREACION TRIGGER TABLA 'AGENTE' A TABLA WATERMARK */
CREATE OR REPLACE TRIGGER TRG_AGENTE_SINC
AFTER INSERT OR UPDATE
ON AGENTE
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    EVENTO_TABLA        WATERMARK.TABLA%TYPE;
    EVENTO_EXISTE_PK	WATERMARK.PK%TYPE;
    EVENTO_OPERACION 	WATERMARK.OPERACION%TYPE;
    EVENTO_MIGRO 		WATERMARK.MIGRO%TYPE := 'N';
    EVENTO_FECHA_INSERT WATERMARK.FECHA_INSERT%TYPE := SYSDATE;
    --
    MIGRACION_DATOS EXCEPTION;
BEGIN
    BEGIN
        SELECT OBJECT_NAME 
            INTO EVENTO_TABLA
        FROM ALL_OBJECTS
        WHERE OBJECT_TYPE = 'TABLE'
        AND OBJECT_NAME = 'AGENTE';
    EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'TRG_AGENTE_SINC => ALL_OBJECTS: Ocurrio un error al realizar la busqueda del objet_name AGENTE ['||SQLERRM||']');
    END;
    BEGIN
        IF INSERTING THEN
            EVENTO_OPERACION := 'I';
        ELSIF UPDATING THEN
            EVENTO_OPERACION := 'U';
        END IF;
        BEGIN
            SELECT COUNT(DISTINCT PK) 
                INTO EVENTO_EXISTE_PK
            FROM WATERMARK 
            WHERE TABLA=EVENTO_TABLA AND PK=:NEW.CODIGO_AGENTE AND OPERACION=EVENTO_OPERACION AND MIGRO=EVENTO_MIGRO;
            
            IF (EVENTO_EXISTE_PK = 0) THEN
                INSERT INTO WATERMARK 
                    (TABLA, PK, OPERACION, FECHA_INSERT, MIGRO, FECHA_OPERADO)
                    VALUES(EVENTO_TABLA, :NEW.CODIGO_AGENTE, EVENTO_OPERACION, EVENTO_FECHA_INSERT, EVENTO_MIGRO, NULL);
            ELSE
                RAISE MIGRACION_DATOS;
            END IF;
        EXCEPTION WHEN MIGRACION_DATOS THEN
            RAISE_APPLICATION_ERROR(-20001, 'TRG_AGENTE_SINC => WATERMARK: Aun esta pendiente de migrar el PK ['||:NEW.CODIGO_AGENTE||'] de la tabla AGENTE');
            ROLLBACK;
        END;
    END;
END TRG_AGENTE_SINC;
/


/*=======================================================================================================*/
/* 3. CREACION TRIGGER TABLA 'REGIMEN' A TABLA WATERMARK */
CREATE OR REPLACE TRIGGER TRG_REGIMEN_SINC
AFTER INSERT OR UPDATE
ON REGIMEN
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    EVENTO_TABLA        WATERMARK.TABLA%TYPE;
    EVENTO_EXISTE_PK	WATERMARK.PK%TYPE;
    EVENTO_OPERACION 	WATERMARK.OPERACION%TYPE;
    EVENTO_MIGRO 		WATERMARK.MIGRO%TYPE := 'N';
    EVENTO_FECHA_INSERT WATERMARK.FECHA_INSERT%TYPE := SYSDATE;
    --
    MIGRACION_DATOS EXCEPTION;
BEGIN
    BEGIN
        SELECT OBJECT_NAME 
            INTO EVENTO_TABLA
        FROM ALL_OBJECTS
        WHERE OBJECT_TYPE = 'TABLE'
        AND OBJECT_NAME = 'REGIMEN';
    EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'TRG_REGIMEN_SINC => ALL_OBJECTS: Ocurrio un error al realizar la busqueda del objet_name REGIMEN ['||SQLERRM||']');
    END;
    BEGIN
        IF INSERTING THEN
            EVENTO_OPERACION := 'I';
        ELSIF UPDATING THEN
            EVENTO_OPERACION := 'U';
        END IF;
        BEGIN
            SELECT COUNT(DISTINCT PK) 
                INTO EVENTO_EXISTE_PK
            FROM WATERMARK 
            WHERE TABLA=EVENTO_TABLA AND PK=:NEW.CODIGO_REGIMEN AND OPERACION=EVENTO_OPERACION AND MIGRO=EVENTO_MIGRO;
            
            IF (EVENTO_EXISTE_PK = 0) THEN
                INSERT INTO WATERMARK 
                    (TABLA, PK, OPERACION, FECHA_INSERT, MIGRO, FECHA_OPERADO)
                    VALUES(EVENTO_TABLA, :NEW.CODIGO_REGIMEN, EVENTO_OPERACION, EVENTO_FECHA_INSERT, EVENTO_MIGRO, NULL);
            ELSE
                RAISE MIGRACION_DATOS;
            END IF;
        EXCEPTION WHEN MIGRACION_DATOS THEN
            RAISE_APPLICATION_ERROR(-20001, 'TRG_REGIMEN_SINC => WATERMARK: Aun esta pendiente de migrar el PK ['||:NEW.CODIGO_REGIMEN||'] de la tabla REGIMEN');
            ROLLBACK;
        END;
    END;
END TRG_REGIMEN_SINC;
/


/*=======================================================================================================*/
/* 4. CREACION TRIGGER TABLA 'ADUANA' A TABLA WATERMARK */
CREATE OR REPLACE TRIGGER TRG_ADUANA_SINC
AFTER INSERT OR UPDATE
ON ADUANA
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    EVENTO_TABLA        WATERMARK.TABLA%TYPE;
    EVENTO_EXISTE_PK	WATERMARK.PK%TYPE;
    EVENTO_OPERACION 	WATERMARK.OPERACION%TYPE;
    EVENTO_MIGRO 		WATERMARK.MIGRO%TYPE := 'N';
    EVENTO_FECHA_INSERT WATERMARK.FECHA_INSERT%TYPE := SYSDATE;
    --
    MIGRACION_DATOS EXCEPTION;
BEGIN
    BEGIN
        SELECT OBJECT_NAME 
            INTO EVENTO_TABLA
        FROM ALL_OBJECTS
        WHERE OBJECT_TYPE = 'TABLE'
        AND OBJECT_NAME = 'ADUANA';
    EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'TRG_ADUANA_SINC => ALL_OBJECTS: Ocurrio un error al realizar la busqueda del objet_name ADUANA ['||SQLERRM||']');
    END;
    BEGIN
        IF INSERTING THEN
            EVENTO_OPERACION := 'I';
        ELSIF UPDATING THEN
            EVENTO_OPERACION := 'U';
        END IF;
        BEGIN
            SELECT COUNT(DISTINCT PK) 
                INTO EVENTO_EXISTE_PK
            FROM WATERMARK 
            WHERE TABLA=EVENTO_TABLA AND PK=:NEW.CODIGO_ADUANA AND OPERACION=EVENTO_OPERACION AND MIGRO=EVENTO_MIGRO;
            
            IF (EVENTO_EXISTE_PK = 0) THEN
                INSERT INTO WATERMARK 
                    (TABLA, PK, OPERACION, FECHA_INSERT, MIGRO, FECHA_OPERADO)
                    VALUES(EVENTO_TABLA, :NEW.CODIGO_ADUANA, EVENTO_OPERACION, EVENTO_FECHA_INSERT, EVENTO_MIGRO, NULL);
            ELSE
                RAISE MIGRACION_DATOS;
            END IF;
        EXCEPTION WHEN MIGRACION_DATOS THEN
            RAISE_APPLICATION_ERROR(-20001, 'TRG_ADUANA_SINC => WATERMARK: Aun esta pendiente de migrar el PK ['||:NEW.CODIGO_ADUANA||'] de la tabla ADUANA');
            ROLLBACK;
        END;
    END;
END TRG_ADUANA_SINC;
/


/*=======================================================================================================*/
/* 5. CREACION TRIGGER TABLA 'TIPO_OPERACION' A TABLA WATERMARK */
CREATE OR REPLACE TRIGGER TRG_TIPO_OPERACION_SINC
AFTER INSERT OR UPDATE
ON TIPO_OPERACION
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    EVENTO_TABLA        WATERMARK.TABLA%TYPE;
    EVENTO_EXISTE_PK	WATERMARK.PK%TYPE;
    EVENTO_OPERACION 	WATERMARK.OPERACION%TYPE;
    EVENTO_MIGRO 		WATERMARK.MIGRO%TYPE := 'N';
    EVENTO_FECHA_INSERT WATERMARK.FECHA_INSERT%TYPE := SYSDATE;
    --
    MIGRACION_DATOS EXCEPTION;
BEGIN
    BEGIN
        SELECT OBJECT_NAME 
            INTO EVENTO_TABLA
        FROM ALL_OBJECTS
        WHERE OBJECT_TYPE = 'TABLE'
        AND OBJECT_NAME = 'TIPO_OPERACION';
    EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'TRG_TIPO_OPERACION_SINC => ALL_OBJECTS: Ocurrio un error al realizar la busqueda del objet_name TIPO_OPERACION ['||SQLERRM||']');
    END;
    BEGIN
        IF INSERTING THEN
            EVENTO_OPERACION := 'I';
        ELSIF UPDATING THEN
            EVENTO_OPERACION := 'U';
        END IF;
        BEGIN
            SELECT COUNT(DISTINCT PK) 
                INTO EVENTO_EXISTE_PK
            FROM WATERMARK 
            WHERE TABLA=EVENTO_TABLA AND PK=:NEW.CODIGO_TIPO_OPERACION AND OPERACION=EVENTO_OPERACION AND MIGRO=EVENTO_MIGRO;
            
            IF (EVENTO_EXISTE_PK = 0) THEN
                INSERT INTO WATERMARK 
                    (TABLA, PK, OPERACION, FECHA_INSERT, MIGRO, FECHA_OPERADO)
                    VALUES(EVENTO_TABLA, :NEW.CODIGO_TIPO_OPERACION, EVENTO_OPERACION, EVENTO_FECHA_INSERT, EVENTO_MIGRO, NULL);
            ELSE
                RAISE MIGRACION_DATOS;
            END IF;
        EXCEPTION WHEN MIGRACION_DATOS THEN
            RAISE_APPLICATION_ERROR(-20001, 'TRG_TIPO_OPERACION_SINC => WATERMARK: Aun esta pendiente de migrar el PK ['||:NEW.CODIGO_TIPO_OPERACION||'] de la tabla TIPO_OPERACION');
            ROLLBACK;
        END;
    END;
END TRG_TIPO_OPERACION_SINC;
/


/*=======================================================================================================*/
/* 6. CREACION TRIGGER TABLA 'PAIS' A TABLA WATERMARK */
CREATE OR REPLACE TRIGGER TRG_PAIS_SINC
AFTER INSERT OR UPDATE
ON PAIS
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    EVENTO_TABLA        WATERMARK.TABLA%TYPE;
    EVENTO_EXISTE_PK	WATERMARK.PK%TYPE;
    EVENTO_OPERACION 	WATERMARK.OPERACION%TYPE;
    EVENTO_MIGRO 		WATERMARK.MIGRO%TYPE := 'N';
    EVENTO_FECHA_INSERT WATERMARK.FECHA_INSERT%TYPE := SYSDATE;
    --
    MIGRACION_DATOS EXCEPTION;
BEGIN
    BEGIN
        SELECT OBJECT_NAME 
            INTO EVENTO_TABLA
        FROM ALL_OBJECTS
        WHERE OBJECT_TYPE = 'TABLE'
        AND OBJECT_NAME = 'PAIS';
    EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'TRG_PAIS_SINC => ALL_OBJECTS: Ocurrio un error al realizar la busqueda del objet_name PAIS ['||SQLERRM||']');
    END;
    BEGIN
        IF INSERTING THEN
            EVENTO_OPERACION := 'I';
        ELSIF UPDATING THEN
            EVENTO_OPERACION := 'U';
        END IF;
        BEGIN
            SELECT COUNT(DISTINCT PK) 
                INTO EVENTO_EXISTE_PK
            FROM WATERMARK 
            WHERE TABLA=EVENTO_TABLA AND PK=:NEW.CODIGO_PAIS AND OPERACION=EVENTO_OPERACION AND MIGRO=EVENTO_MIGRO;
            
            IF (EVENTO_EXISTE_PK = 0) THEN
                INSERT INTO WATERMARK 
                    (TABLA, PK, OPERACION, FECHA_INSERT, MIGRO, FECHA_OPERADO)
                    VALUES(EVENTO_TABLA, :NEW.CODIGO_PAIS, EVENTO_OPERACION, EVENTO_FECHA_INSERT, EVENTO_MIGRO, NULL);
            ELSE
                RAISE MIGRACION_DATOS;
            END IF;
        EXCEPTION WHEN MIGRACION_DATOS THEN
            RAISE_APPLICATION_ERROR(-20001, 'TRG_PAIS_SINC => WATERMARK: Aun esta pendiente de migrar el PK ['||:NEW.CODIGO_PAIS||'] de la tabla PAIS');
            ROLLBACK;
        END;
    END;
END TRG_PAIS_SINC;
/


/*=======================================================================================================*/
/* 7. CREACION TRIGGER TABLA 'CLIENTE' A TABLA WATERMARK */
CREATE OR REPLACE TRIGGER TRG_CLIENTE_SINC
AFTER INSERT OR UPDATE
ON CLIENTE
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    EVENTO_TABLA        WATERMARK.TABLA%TYPE;
    EVENTO_EXISTE_PK	WATERMARK.PK%TYPE;
    EVENTO_OPERACION 	WATERMARK.OPERACION%TYPE;
    EVENTO_MIGRO 		WATERMARK.MIGRO%TYPE := 'N';
    EVENTO_FECHA_INSERT WATERMARK.FECHA_INSERT%TYPE := SYSDATE;
    --
    MIGRACION_DATOS EXCEPTION;
BEGIN
    BEGIN
        SELECT OBJECT_NAME 
            INTO EVENTO_TABLA
        FROM ALL_OBJECTS
        WHERE OBJECT_TYPE = 'TABLE'
        AND OBJECT_NAME = 'CLIENTE';
    EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'TRG_CLIENTE_SINC => ALL_OBJECTS: Ocurrio un error al realizar la busqueda del objet_name CLIENTE ['||SQLERRM||']');
    END;
    BEGIN
        IF INSERTING THEN
            EVENTO_OPERACION := 'I';
        ELSIF UPDATING THEN
            EVENTO_OPERACION := 'U';
        END IF;
        BEGIN
            SELECT COUNT(DISTINCT PK) 
                INTO EVENTO_EXISTE_PK
            FROM WATERMARK 
            WHERE TABLA=EVENTO_TABLA AND PK=:NEW.CODIGO_CLIENTE AND OPERACION=EVENTO_OPERACION AND MIGRO=EVENTO_MIGRO;
            
            IF (EVENTO_EXISTE_PK = 0) THEN
                INSERT INTO WATERMARK 
                    (TABLA, PK, OPERACION, FECHA_INSERT, MIGRO, FECHA_OPERADO)
                    VALUES(EVENTO_TABLA, :NEW.CODIGO_CLIENTE, EVENTO_OPERACION, EVENTO_FECHA_INSERT, EVENTO_MIGRO, NULL);
            ELSE
                RAISE MIGRACION_DATOS;
            END IF;
        EXCEPTION WHEN MIGRACION_DATOS THEN
            RAISE_APPLICATION_ERROR(-20001, 'TRG_CLIENTE_SINC => WATERMARK: Aun esta pendiente de migrar el PK ['||:NEW.CODIGO_CLIENTE||'] de la tabla CLIENTE');
            ROLLBACK;
        END;
    END;
END TRG_CLIENTE_SINC;
/


/*=======================================================================================================*/
/* 8. CREACION TRIGGER TABLA 'MEDIOS_TRANSPORTE' A TABLA WATERMARK */
CREATE OR REPLACE TRIGGER TRG_MEDIOS_TRANSPORTE_SINC
AFTER INSERT OR UPDATE
ON MEDIOS_TRANSPORTE
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    EVENTO_TABLA        WATERMARK.TABLA%TYPE;
    EVENTO_EXISTE_PK	WATERMARK.PK%TYPE;
    EVENTO_OPERACION 	WATERMARK.OPERACION%TYPE;
    EVENTO_MIGRO 		WATERMARK.MIGRO%TYPE := 'N';
    EVENTO_FECHA_INSERT WATERMARK.FECHA_INSERT%TYPE := SYSDATE;
    --
    MIGRACION_DATOS EXCEPTION;
BEGIN
    BEGIN
        SELECT OBJECT_NAME 
            INTO EVENTO_TABLA
        FROM ALL_OBJECTS
        WHERE OBJECT_TYPE = 'TABLE'
        AND OBJECT_NAME = 'MEDIOS_TRANSPORTE';
    EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'TRG_MEDIOS_TRANSPORTE_SINC => ALL_OBJECTS: Ocurrio un error al realizar la busqueda del objet_name MEDIOS_TRANSPORTE ['||SQLERRM||']');
    END;
    BEGIN
        IF INSERTING THEN
            EVENTO_OPERACION := 'I';
        ELSIF UPDATING THEN
            EVENTO_OPERACION := 'U';
        END IF;
        BEGIN
            SELECT COUNT(DISTINCT PK) 
                INTO EVENTO_EXISTE_PK
            FROM WATERMARK 
            WHERE TABLA=EVENTO_TABLA AND PK=:NEW.CODIGO_TRANSPORTE AND OPERACION=EVENTO_OPERACION AND MIGRO=EVENTO_MIGRO;
            
            IF (EVENTO_EXISTE_PK = 0) THEN
                INSERT INTO WATERMARK 
                    (TABLA, PK, OPERACION, FECHA_INSERT, MIGRO, FECHA_OPERADO)
                    VALUES(EVENTO_TABLA, :NEW.CODIGO_TRANSPORTE, EVENTO_OPERACION, EVENTO_FECHA_INSERT, EVENTO_MIGRO, NULL);
            ELSE
                RAISE MIGRACION_DATOS;
            END IF;
        EXCEPTION WHEN MIGRACION_DATOS THEN
            RAISE_APPLICATION_ERROR(-20001, 'TRG_MEDIOS_TRANSPORTE_SINC => WATERMARK: Aun esta pendiente de migrar el PK ['||:NEW.CODIGO_TRANSPORTE||'] de la tabla MEDIOS_TRANSPORTE');
            ROLLBACK;
        END;
    END;
END TRG_MEDIOS_TRANSPORTE_SINC;
/


/*=======================================================================================================*/
/* 9. CREACION TRIGGER TABLA 'ALMACENADORA' A TABLA WATERMARK */
CREATE OR REPLACE TRIGGER TRG_ALMACENADORA_SINC
AFTER INSERT OR UPDATE
ON ALMACENADORA
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    EVENTO_TABLA        WATERMARK.TABLA%TYPE;
    EVENTO_EXISTE_PK	WATERMARK.PK%TYPE;
    EVENTO_OPERACION 	WATERMARK.OPERACION%TYPE;
    EVENTO_MIGRO 		WATERMARK.MIGRO%TYPE := 'N';
    EVENTO_FECHA_INSERT WATERMARK.FECHA_INSERT%TYPE := SYSDATE;
    --
    MIGRACION_DATOS EXCEPTION;
BEGIN
    BEGIN
        SELECT OBJECT_NAME 
            INTO EVENTO_TABLA
        FROM ALL_OBJECTS
        WHERE OBJECT_TYPE = 'TABLE'
        AND OBJECT_NAME = 'ALMACENADORA';
    EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'TRG_ALMACENADORA_SINC => ALL_OBJECTS: Ocurrio un error al realizar la busqueda del objet_name ALMACENADORA ['||SQLERRM||']');
    END;
    BEGIN
        IF INSERTING THEN
            EVENTO_OPERACION := 'I';
        ELSIF UPDATING THEN
            EVENTO_OPERACION := 'U';
        END IF;
        BEGIN
            SELECT COUNT(DISTINCT PK)
                INTO EVENTO_EXISTE_PK
            FROM WATERMARK 
            WHERE TABLA=EVENTO_TABLA AND PK=:NEW.CODIGO_ALMACENADORA AND OPERACION=EVENTO_OPERACION AND MIGRO=EVENTO_MIGRO;
           
            IF (EVENTO_EXISTE_PK = 0) THEN
                INSERT INTO WATERMARK 
                    (TABLA, PK, OPERACION, FECHA_INSERT, MIGRO, FECHA_OPERADO)
                    VALUES(EVENTO_TABLA, :NEW.CODIGO_ALMACENADORA, EVENTO_OPERACION, EVENTO_FECHA_INSERT, EVENTO_MIGRO, NULL);
            ELSE
                RAISE MIGRACION_DATOS;
            END IF;
        EXCEPTION WHEN MIGRACION_DATOS THEN
            RAISE_APPLICATION_ERROR(-20001, 'TRG_ALMACENADORA_SINC => WATERMARK: Aun esta pendiente de migrar el PK ['||:NEW.CODIGO_ALMACENADORA||'] de la tabla ALMACENADORA');
            ROLLBACK;
        END;
    END;
END TRG_ALMACENADORA_SINC;
/