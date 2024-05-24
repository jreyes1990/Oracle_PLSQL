/*=======================================================================================================*/
/* 2. CREACION PROCEDURE PARA EL LLENADO DE LA DIMENSION 'DIM_AGENTE', UTILIZANDO LA INSTRUCCION MERGE */
CREATE OR REPLACE PROCEDURE PRC_DIM_AGENTE(
    P_OPCION NUMBER
)
IS
    PARAMETRO_VACIO         EXCEPTION;
    PARAMETRO_NO_DEFINIDO   EXCEPTION;
BEGIN
    BEGIN
        IF P_OPCION IS NOT NULL THEN
            IF P_OPCION = 1 THEN
                MERGE INTO DIM_AGENTE d
                USING (SELECT CODIGO_AGENTE, NOMBRE_AGENTE FROM USR_STAGE.STG_AGENTE) s
                ON (d.CODIGO_AGENTE=s.CODIGO_AGENTE)
                WHEN MATCHED THEN
                    UPDATE 
                        SET d.NOMBRE_AGENTE = s.NOMBRE_AGENTE
                WHEN NOT MATCHED THEN
                    INSERT (AGENTE_KEY, CODIGO_AGENTE, NOMBRE_AGENTE)
                    VALUES (0, s.CODIGO_AGENTE, s.NOMBRE_AGENTE);
            ELSE
                RAISE PARAMETRO_NO_DEFINIDO;
                ROLLBACK;
            END IF;
        ELSE
            RAISE PARAMETRO_VACIO;
            ROLLBACK;
        END IF;
        
    EXCEPTION 
        WHEN PARAMETRO_VACIO THEN
            RAISE_APPLICATION_ERROR(-20001, 'PRC_DIM_AGENTE => El procedimiento almacenado debe llevar un parametro: ['||P_OPCION||']');
        WHEN PARAMETRO_NO_DEFINIDO THEN
            RAISE_APPLICATION_ERROR(-20001, 'PRC_DIM_AGENTE => El parametro ['||P_OPCION||'], No esta definido dentro del procedimiento almacenado');
    END;
END PRC_DIM_AGENTE;


/*=======================================================================================================*/
/* 3. CREACION PROCEDURE PARA EL LLENADO DE LA DIMENSION 'DIM_REGIMEN', UTILIZANDO LA INSTRUCCION MERGE */
CREATE OR REPLACE PROCEDURE PRC_DIM_REGIMEN(
    P_OPCION NUMBER
)
IS
    PARAMETRO_VACIO         EXCEPTION;
    PARAMETRO_NO_DEFINIDO   EXCEPTION;
BEGIN
    BEGIN
        IF P_OPCION IS NOT NULL THEN
            IF P_OPCION = 1 THEN
                MERGE INTO DIM_REGIMEN d
                USING (SELECT CODIGO_REGIMEN, NOMBRE_REGIMEN FROM USR_STAGE.STG_REGIMEN) s
                ON
                  (d.CODIGO_REGIMEN=s.CODIGO_REGIMEN)
                WHEN MATCHED THEN
                    UPDATE SET
                      d.NOMBRE_REGIMEN = s.NOMBRE_REGIMEN
                WHEN NOT MATCHED THEN
                    INSERT (REGIMEN_KEY, CODIGO_REGIMEN, NOMBRE_REGIMEN)
                    VALUES (0, s.CODIGO_REGIMEN, s.NOMBRE_REGIMEN);
            ELSE
                RAISE PARAMETRO_NO_DEFINIDO;
                ROLLBACK;
            END IF;
        ELSE
            RAISE PARAMETRO_VACIO;
            ROLLBACK;
        END IF;
        
    EXCEPTION 
        WHEN PARAMETRO_VACIO THEN
            RAISE_APPLICATION_ERROR(-20001, 'PRC_DIM_REGIMEN => El procedimiento almacenado debe llevar un parametro: ['||P_OPCION||']');
        WHEN PARAMETRO_NO_DEFINIDO THEN
            RAISE_APPLICATION_ERROR(-20001, 'PRC_DIM_REGIMEN => El parametro ['||P_OPCION||'], No esta definido dentro del procedimiento almacenado');
    END;
END PRC_DIM_REGIMEN;


/*=======================================================================================================*/
/* 4. CREACION PROCEDURE PARA EL LLENADO DE LA DIMENSION 'DIM_ADUANA', UTILIZANDO LA INSTRUCCION MERGE */
CREATE OR REPLACE PROCEDURE PRC_DIM_ADUANA(
    P_OPCION NUMBER
)
IS
    PARAMETRO_VACIO         EXCEPTION;
    PARAMETRO_NO_DEFINIDO   EXCEPTION;
BEGIN
    BEGIN
        IF P_OPCION IS NOT NULL THEN
            IF P_OPCION = 1 THEN
                MERGE INTO DIM_ADUANA d
                USING (SELECT CODIGO_ADUANA, NOMBRE_ADUANA, TIPO_ADUANA FROM USR_STAGE.STG_ADUANA) s
                ON
                  (d.CODIGO_ADUANA=s.CODIGO_ADUANA)
                WHEN MATCHED THEN
                    UPDATE SET
                      d.NOMBRE_ADUANA = s.NOMBRE_ADUANA,
                      d.TIPO_ADUANA = s.TIPO_ADUANA
                WHEN NOT MATCHED THEN
                    INSERT (ADUANA_KEY, CODIGO_ADUANA, NOMBRE_ADUANA, TIPO_ADUANA)
                    VALUES (0, s.CODIGO_ADUANA, s.NOMBRE_ADUANA, s.TIPO_ADUANA);
            ELSE
                RAISE PARAMETRO_NO_DEFINIDO;
                ROLLBACK;
            END IF;
        ELSE
            RAISE PARAMETRO_VACIO;
            ROLLBACK;
        END IF;
        
    EXCEPTION 
        WHEN PARAMETRO_VACIO THEN
            RAISE_APPLICATION_ERROR(-20001, 'PRC_DIM_ADUANA => El procedimiento almacenado debe llevar un parametro: ['||P_OPCION||']');
        WHEN PARAMETRO_NO_DEFINIDO THEN
            RAISE_APPLICATION_ERROR(-20001, 'PRC_DIM_ADUANA => El parametro ['||P_OPCION||'], No esta definido dentro del procedimiento almacenado');
    END;
END PRC_DIM_ADUANA;


/*=======================================================================================================*/
/* 5. CREACION PROCEDURE PARA EL LLENADO DE LA DIMENSION 'DIM_TIPO_OPERACION', UTILIZANDO LA INSTRUCCION MERGE */
CREATE OR REPLACE PROCEDURE PRC_DIM_TIPO_OPERACION(
    P_OPCION NUMBER
)
IS
    PARAMETRO_VACIO         EXCEPTION;
    PARAMETRO_NO_DEFINIDO   EXCEPTION;
BEGIN
    BEGIN
        IF P_OPCION IS NOT NULL THEN
            IF P_OPCION = 1 THEN
                MERGE INTO DIM_TIPO_OPERACION d
                USING (SELECT CODIGO_TIPO_OPERACION, NOMBRE_TIPO_OPERACION FROM USR_STAGE.STG_TIPO_OPERACION) s
                ON
                  (d.CODIGO_TIPO_OPERACION=s.CODIGO_TIPO_OPERACION)
                WHEN MATCHED THEN
                    UPDATE SET
                      d.NOMBRE_TIPO_OPERACION = s.NOMBRE_TIPO_OPERACION
                WHEN NOT MATCHED THEN
                    INSERT (TIPO_OPERACION_KEY, CODIGO_TIPO_OPERACION, NOMBRE_TIPO_OPERACION)
                    VALUES (0, s.CODIGO_TIPO_OPERACION, s.NOMBRE_TIPO_OPERACION);
            ELSE
                RAISE PARAMETRO_NO_DEFINIDO;
                ROLLBACK;
            END IF;
        ELSE
            RAISE PARAMETRO_VACIO;
            ROLLBACK;
        END IF;
        
    EXCEPTION 
        WHEN PARAMETRO_VACIO THEN
            RAISE_APPLICATION_ERROR(-20001, 'PRC_DIM_TIPO_OPERACION => El procedimiento almacenado debe llevar un parametro: ['||P_OPCION||']');
        WHEN PARAMETRO_NO_DEFINIDO THEN
            RAISE_APPLICATION_ERROR(-20001, 'PRC_DIM_TIPO_OPERACION => El parametro ['||P_OPCION||'], No esta definido dentro del procedimiento almacenado');
    END;
END PRC_DIM_TIPO_OPERACION;


/*=======================================================================================================*/
/* 6. CREACION PROCEDURE PARA EL LLENADO DE LA DIMENSION 'DIM_PAIS', UTILIZANDO LA INSTRUCCION MERGE */
CREATE OR REPLACE PROCEDURE PRC_DIM_PAIS(
    P_OPCION NUMBER
)
IS
    PARAMETRO_VACIO         EXCEPTION;
    PARAMETRO_NO_DEFINIDO   EXCEPTION;
BEGIN
    BEGIN
        IF P_OPCION IS NOT NULL THEN
            IF P_OPCION = 1 THEN
                MERGE INTO DIM_PAIS d
                USING (SELECT CODIGO_PAIS, NOMBRE_PAIS FROM USR_STAGE.STG_PAIS) s
                ON
                  (d.CODIGO_PAIS=s.CODIGO_PAIS)
                WHEN MATCHED THEN
                    UPDATE SET
                      d.NOMBRE_PAIS = s.NOMBRE_PAIS
                WHEN NOT MATCHED THEN
                    INSERT (PAIS_KEY, CODIGO_PAIS, NOMBRE_PAIS)
                    VALUES (0, s.CODIGO_PAIS, s.NOMBRE_PAIS);
            ELSE
                RAISE PARAMETRO_NO_DEFINIDO;
                ROLLBACK;
            END IF;
        ELSE
            RAISE PARAMETRO_VACIO;
            ROLLBACK;
        END IF;
        
    EXCEPTION 
        WHEN PARAMETRO_VACIO THEN
            RAISE_APPLICATION_ERROR(-20001, 'PRC_DIM_PAIS => El procedimiento almacenado debe llevar un parametro: ['||P_OPCION||']');
        WHEN PARAMETRO_NO_DEFINIDO THEN
            RAISE_APPLICATION_ERROR(-20001, 'PRC_DIM_PAIS => El parametro ['||P_OPCION||'], No esta definido dentro del procedimiento almacenado');
    END;
END PRC_DIM_PAIS;


/*=======================================================================================================*/
/* 7. CREACION PROCEDURE PARA EL LLENADO DE LA DIMENSION 'DIM_CLIENTE', UTILIZANDO LA INSTRUCCION MERGE */
CREATE OR REPLACE PROCEDURE PRC_DIM_CLIENTE(
    P_OPCION NUMBER
)
IS
    PARAMETRO_VACIO         EXCEPTION;
    PARAMETRO_NO_DEFINIDO   EXCEPTION;
BEGIN
    BEGIN
        IF P_OPCION IS NOT NULL THEN
            IF P_OPCION = 1 THEN
                MERGE INTO DIM_CLIENTE d
                USING (SELECT CODIGO_CLIENTE, NOMBRE_CLIENTE, STATUS, GENERO, ESTADO_CIVIL, REGION, DEPARTAMENTO, MUNICIPIO, CLASIFICACION, SECTOR_ECONOMICO FROM USR_STAGE.STG_CLIENTE) s
                ON
                  (d.CODIGO_CLIENTE=s.CODIGO_CLIENTE)
                WHEN MATCHED THEN
                    UPDATE SET
                      d.NOMBRE_CLIENTE = s.NOMBRE_CLIENTE,
                      d.STATUS = s.STATUS,
                      d.GENERO = s.GENERO,
                      d.ESTADO_CIVIL = s.ESTADO_CIVIL,
                      d.REGION = s.REGION,
                      d.DEPARTAMENTO = s.DEPARTAMENTO,
                      d.MUNICIPIO = s.MUNICIPIO,
                      d.CLASIFICACION = s.CLASIFICACION,
                      d.SECTOR_ECONOMICO = s.SECTOR_ECONOMICO
                WHEN NOT MATCHED THEN
                    INSERT (CLIENTE_KEY, CODIGO_CLIENTE, NOMBRE_CLIENTE, STATUS, GENERO, ESTADO_CIVIL, REGION, DEPARTAMENTO, MUNICIPIO, CLASIFICACION, SECTOR_ECONOMICO)
                    VALUES (0, s.CODIGO_CLIENTE, s.NOMBRE_CLIENTE, s.STATUS, s.GENERO, s.ESTADO_CIVIL, s.REGION, s.DEPARTAMENTO, s.MUNICIPIO, s.CLASIFICACION, s.SECTOR_ECONOMICO);
            ELSE
                RAISE PARAMETRO_NO_DEFINIDO;
                ROLLBACK;
            END IF;
        ELSE
            RAISE PARAMETRO_VACIO;
            ROLLBACK;
        END IF;
        
    EXCEPTION 
        WHEN PARAMETRO_VACIO THEN
            RAISE_APPLICATION_ERROR(-20001, 'PRC_DIM_CLIENTE => El procedimiento almacenado debe llevar un parametro: ['||P_OPCION||']');
        WHEN PARAMETRO_NO_DEFINIDO THEN
            RAISE_APPLICATION_ERROR(-20001, 'PRC_DIM_CLIENTE => El parametro ['||P_OPCION||'], No esta definido dentro del procedimiento almacenado');
    END;
END PRC_DIM_CLIENTE;


/*=======================================================================================================*/
/* 8. CREACION PROCEDURE PARA EL LLENADO DE LA DIMENSION 'DIM_MEDIOS_TRANSPORTE', UTILIZANDO LA INSTRUCCION MERGE */
CREATE OR REPLACE PROCEDURE PRC_DIM_MEDIOS_TRANSPORTE(
    P_OPCION NUMBER
)
IS
    PARAMETRO_VACIO         EXCEPTION;
    PARAMETRO_NO_DEFINIDO   EXCEPTION;
BEGIN
    BEGIN
        IF P_OPCION IS NOT NULL THEN
            IF P_OPCION = 1 THEN
                MERGE INTO DIM_MEDIOS_TRANSPORTE d
                USING (SELECT CODIGO_TRANSPORTE, DESCRIPCION_TRANSPORTE FROM USR_STAGE.STG_MEDIOS_TRANSPORTE) s
                ON
                  (d.CODIGO_MEDIOS_TRANSPORTE=s.CODIGO_TRANSPORTE)
                WHEN MATCHED THEN
                    UPDATE SET
                      d.NOMBRE_MEDIOS_TRANSPORTE = s.DESCRIPCION_TRANSPORTE
                WHEN NOT MATCHED THEN
                    INSERT (MEDIOS_TRANSPORTE_KEY, CODIGO_MEDIOS_TRANSPORTE, NOMBRE_MEDIOS_TRANSPORTE)
                    VALUES (0, s.CODIGO_TRANSPORTE, s.DESCRIPCION_TRANSPORTE);
            ELSE
                RAISE PARAMETRO_NO_DEFINIDO;
                ROLLBACK;
            END IF;
        ELSE
            RAISE PARAMETRO_VACIO;
            ROLLBACK;
        END IF;
        
    EXCEPTION 
        WHEN PARAMETRO_VACIO THEN
            RAISE_APPLICATION_ERROR(-20001, 'PRC_DIM_MEDIOS_TRANSPORTE => El procedimiento almacenado debe llevar un parametro: ['||P_OPCION||']');
        WHEN PARAMETRO_NO_DEFINIDO THEN
            RAISE_APPLICATION_ERROR(-20001, 'PRC_DIM_MEDIOS_TRANSPORTE => El parametro ['||P_OPCION||'], No esta definido dentro del procedimiento almacenado');
    END;
END PRC_DIM_MEDIOS_TRANSPORTE;


/*=======================================================================================================*/
/* 9. CREACION PROCEDURE PARA EL LLENADO DE LA DIMENSION 'DIM_ALMACENADORA', UTILIZANDO LA INSTRUCCION MERGE */
CREATE OR REPLACE PROCEDURE PRC_DIM_ALMACENADORA(
    P_OPCION NUMBER
)
IS
    PARAMETRO_VACIO         EXCEPTION;
    PARAMETRO_NO_DEFINIDO   EXCEPTION;
BEGIN
    BEGIN
        IF P_OPCION IS NOT NULL THEN
            IF P_OPCION = 1 THEN
                MERGE INTO DIM_ALMACENADORA d
                USING (SELECT CODIGO_ALMACENADORA, NOMBRE_ALMACENADORA FROM USR_STAGE.STG_ALMACENADORA) s
                ON
                  (d.CODIGO_ALMACENADORA=s.CODIGO_ALMACENADORA)
                WHEN MATCHED THEN
                    UPDATE SET
                      d.NOMBRE_ALMACENADORA = s.NOMBRE_ALMACENADORA
                WHEN NOT MATCHED THEN
                    INSERT (ALMACENADORA_KEY, CODIGO_ALMACENADORA, NOMBRE_ALMACENADORA)
                    VALUES (0, s.CODIGO_ALMACENADORA, s.NOMBRE_ALMACENADORA);
            ELSE
                RAISE PARAMETRO_NO_DEFINIDO;
                ROLLBACK;
            END IF;
        ELSE
            RAISE PARAMETRO_VACIO;
            ROLLBACK;
        END IF;
        
    EXCEPTION 
        WHEN PARAMETRO_VACIO THEN
            RAISE_APPLICATION_ERROR(-20001, 'PRC_DIM_ALMACENADORA => El procedimiento almacenado debe llevar un parametro: ['||P_OPCION||']');
        WHEN PARAMETRO_NO_DEFINIDO THEN
            RAISE_APPLICATION_ERROR(-20001, 'PRC_DIM_ALMACENADORA => El parametro ['||P_OPCION||'], No esta definido dentro del procedimiento almacenado');
    END;
END PRC_DIM_ALMACENADORA;