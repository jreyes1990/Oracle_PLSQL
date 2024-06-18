/*  CREAR 1 PROCEDIMIENTOS POR CADA DIMENSIÓN, PARA LLENAR TABLAS DE DIMENSIONES.
    (PROCEDIMIENTOS, PARÁMETRO 1 – UTILICE MERGE), AMBIENTE DW. 
    PERMISOS DE SELECT A LAS TABLAS DE STAGE */
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
            ELSIF P_OPCION = 2 THEN
                MERGE INTO DIM_AGENTE d
                USING (SELECT DISTINCT 
                       a.CODIGO_AGENTE, b.NOMBRE_AGENTE
                       FROM NO_HECHOS a
                       LEFT JOIN USR_STAGE.STG_AGENTE b on(a.CODIGO_AGENTE=b.CODIGO_AGENTE)
                       WHERE a.AGENTE_KEY IS NOT NULL AND a.CODIGO_AGENTE IS NOT NULL
                       ) nh
                ON (d.CODIGO_AGENTE=nh.CODIGO_AGENTE)
                WHEN MATCHED THEN
                    UPDATE 
                        SET d.NOMBRE_AGENTE = nh.NOMBRE_AGENTE
                WHEN NOT MATCHED THEN
                    INSERT (AGENTE_KEY, CODIGO_AGENTE, NOMBRE_AGENTE)
                    VALUES (0, nh.CODIGO_AGENTE, nh.NOMBRE_AGENTE);
                PRC_REPROCESA_DIMENSIONES_QA('DIM_AGENTE', P_OPCION);
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
            ELSIF P_OPCION = 2 THEN
                MERGE INTO DIM_REGIMEN d
                USING (SELECT DISTINCT 
                       a.CODIGO_REGIMEN, b.NOMBRE_REGIMEN
                       FROM NO_HECHOS a
                       LEFT JOIN USR_STAGE.STG_REGIMEN b on(a.CODIGO_REGIMEN=b.CODIGO_REGIMEN)
                       WHERE a.REGIMEN_KEY IS NOT NULL AND a.CODIGO_REGIMEN IS NOT NULL
                       ) nh
                ON
                  (d.CODIGO_REGIMEN=nh.CODIGO_REGIMEN)
                WHEN MATCHED THEN
                    UPDATE SET
                      d.NOMBRE_REGIMEN = nh.NOMBRE_REGIMEN
                WHEN NOT MATCHED THEN
                    INSERT (REGIMEN_KEY, CODIGO_REGIMEN, NOMBRE_REGIMEN)
                    VALUES (0, nh.CODIGO_REGIMEN, nh.NOMBRE_REGIMEN);
                PRC_REPROCESA_DIMENSIONES_QA('DIM_REGIMEN', P_OPCION);
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
            ELSIF P_OPCION = 2 THEN
                MERGE INTO DIM_ADUANA d
                USING (SELECT DISTINCT 
                       a.CODIGO_ADUANA, b.NOMBRE_ADUANA, b.TIPO_ADUANA
                       FROM NO_HECHOS a
                       LEFT JOIN USR_STAGE.STG_ADUANA b on(a.CODIGO_ADUANA=b.CODIGO_ADUANA)
                       WHERE a.ADUANA_KEY IS NOT NULL AND a.CODIGO_ADUANA IS NOT NULL
                       ) nh
                ON
                  (d.CODIGO_ADUANA=nh.CODIGO_ADUANA)
                WHEN MATCHED THEN
                    UPDATE SET
                      d.NOMBRE_ADUANA = nh.NOMBRE_ADUANA,
                      d.TIPO_ADUANA = nh.TIPO_ADUANA
                WHEN NOT MATCHED THEN
                    INSERT (ADUANA_KEY, CODIGO_ADUANA, NOMBRE_ADUANA, TIPO_ADUANA)
                    VALUES (0, nh.CODIGO_ADUANA, nh.NOMBRE_ADUANA, nh.TIPO_ADUANA);
                PRC_REPROCESA_DIMENSIONES_QA('DIM_ADUANA', P_OPCION);
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
            ELSIF P_OPCION = 2 THEN
                MERGE INTO DIM_TIPO_OPERACION d
                USING (SELECT DISTINCT 
                       a.CODIGO_TIPO_OPERACION, b.NOMBRE_TIPO_OPERACION
                       FROM NO_HECHOS a
                       LEFT JOIN USR_STAGE.STG_TIPO_OPERACION b on(a.CODIGO_TIPO_OPERACION=b.CODIGO_TIPO_OPERACION)
                       WHERE a.OPERACION_KEY IS NOT NULL AND a.CODIGO_TIPO_OPERACION IS NOT NULL
                       ) nh
                ON
                  (d.CODIGO_TIPO_OPERACION=nh.CODIGO_TIPO_OPERACION)
                WHEN MATCHED THEN
                    UPDATE SET
                      d.NOMBRE_TIPO_OPERACION = nh.NOMBRE_TIPO_OPERACION
                WHEN NOT MATCHED THEN
                    INSERT (TIPO_OPERACION_KEY, CODIGO_TIPO_OPERACION, NOMBRE_TIPO_OPERACION)
                    VALUES (0, nh.CODIGO_TIPO_OPERACION, nh.NOMBRE_TIPO_OPERACION);
                PRC_REPROCESA_DIMENSIONES_QA('DIM_TIPO_OPERACION', P_OPCION);
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
                USING (SELECT DISTINCT CODIGO_PAIS, NOMBRE_PAIS FROM USR_STAGE.STG_PAIS) s
                ON
                  (d.CODIGO_PAIS=s.CODIGO_PAIS)
                WHEN MATCHED THEN
                    UPDATE SET
                      d.NOMBRE_PAIS = s.NOMBRE_PAIS
                WHEN NOT MATCHED THEN
                    INSERT (PAIS_KEY, CODIGO_PAIS, NOMBRE_PAIS)
                    VALUES (0, s.CODIGO_PAIS, s.NOMBRE_PAIS);
            ELSIF P_OPCION = 2 THEN
                MERGE INTO DIM_PAIS d
                USING (SELECT DISTINCT
                       a.CODIGO_PAIS, b.NOMBRE_PAIS
                       FROM (
                        SELECT DISTINCT CODIGO_PAIS_ORIGEN AS CODIGO_PAIS, PAIS_ORIGEN_KEY FROM NO_HECHOS
                        UNION ALL
                        SELECT DISTINCT CODIGO_PAIS_VENDEDOR AS CODIGO_PAIS, PAIS_VENDEDOR_KEY AS PAIS_ORIGEN_KEY FROM NO_HECHOS
                       ) a
                       LEFT JOIN USR_STAGE.STG_PAIS b on(a.CODIGO_PAIS=b.CODIGO_PAIS)
                       WHERE a.PAIS_ORIGEN_KEY IS NOT NULL AND a.CODIGO_PAIS IS NOT NULL
                       ) nh
                ON
                  (d.CODIGO_PAIS=nh.CODIGO_PAIS)
                WHEN MATCHED THEN
                    UPDATE SET
                      d.NOMBRE_PAIS = nh.NOMBRE_PAIS
                WHEN NOT MATCHED THEN
                    INSERT (PAIS_KEY, CODIGO_PAIS, NOMBRE_PAIS)
                    VALUES (0, nh.CODIGO_PAIS, nh.NOMBRE_PAIS);
                PRC_REPROCESA_DIMENSIONES_QA('DIM_PAIS', P_OPCION);
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
            ELSIF P_OPCION = 2 THEN
                MERGE INTO DIM_CLIENTE d
                USING (SELECT DISTINCT 
                       a.CLIENTE AS CODIGO_CLIENTE, b.NOMBRE_CLIENTE, b.STATUS, b.GENERO, b.ESTADO_CIVIL, b.REGION, b.DEPARTAMENTO, b.MUNICIPIO, b.CLASIFICACION, b.SECTOR_ECONOMICO 
                       FROM NO_HECHOS a
                       LEFT JOIN USR_STAGE.STG_CLIENTE b on(a.CLIENTE=b.CODIGO_CLIENTE) 
                       WHERE a.CLIENTE_KEY IS NOT NULL AND a.CLIENTE IS NOT NULL
                       ) nh
                ON
                  (d.CODIGO_CLIENTE=nh.CODIGO_CLIENTE)
                WHEN MATCHED THEN
                    UPDATE SET
                      d.NOMBRE_CLIENTE = nh.NOMBRE_CLIENTE,
                      d.STATUS = nh.STATUS,
                      d.GENERO = nh.GENERO,
                      d.ESTADO_CIVIL = nh.ESTADO_CIVIL,
                      d.REGION = nh.REGION,
                      d.DEPARTAMENTO = nh.DEPARTAMENTO,
                      d.MUNICIPIO = nh.MUNICIPIO,
                      d.CLASIFICACION = nh.CLASIFICACION,
                      d.SECTOR_ECONOMICO = nh.SECTOR_ECONOMICO
                WHEN NOT MATCHED THEN
                    INSERT (CLIENTE_KEY, CODIGO_CLIENTE, NOMBRE_CLIENTE, STATUS, GENERO, ESTADO_CIVIL, REGION, DEPARTAMENTO, MUNICIPIO, CLASIFICACION, SECTOR_ECONOMICO)
                    VALUES (0, nh.CODIGO_CLIENTE, nh.NOMBRE_CLIENTE, nh.STATUS, nh.GENERO, nh.ESTADO_CIVIL, nh.REGION, nh.DEPARTAMENTO, nh.MUNICIPIO, nh.CLASIFICACION, nh.SECTOR_ECONOMICO);
                PRC_REPROCESA_DIMENSIONES_QA('DIM_CLIENTE', P_OPCION);
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
            ELSIF P_OPCION = 2 THEN
                MERGE INTO DIM_MEDIOS_TRANSPORTE d
                USING (SELECT DISTINCT 
                       a.CODIGO_TRANSPORTE, b.DESCRIPCION_TRANSPORTE 
                       FROM NO_HECHOS a
                       LEFT JOIN USR_STAGE.STG_MEDIOS_TRANSPORTE b on(a.CODIGO_TRANSPORTE=b.CODIGO_TRANSPORTE)
                       WHERE a.CODIGO_TRANSPORTE_KEY IS NOT NULL AND a.CODIGO_TRANSPORTE IS NOT NULL
                       ) nh
                ON
                  (d.CODIGO_MEDIOS_TRANSPORTE=nh.CODIGO_TRANSPORTE)
                WHEN MATCHED THEN
                    UPDATE SET
                      d.NOMBRE_MEDIOS_TRANSPORTE = nh.DESCRIPCION_TRANSPORTE
                WHEN NOT MATCHED THEN
                    INSERT (MEDIOS_TRANSPORTE_KEY, CODIGO_MEDIOS_TRANSPORTE, NOMBRE_MEDIOS_TRANSPORTE)
                    VALUES (0, nh.CODIGO_TRANSPORTE, nh.DESCRIPCION_TRANSPORTE);
                PRC_REPROCESA_DIMENSIONES_QA('DIM_MEDIOS_TRANSPORTE', P_OPCION);
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
            ELSIF P_OPCION = 2 THEN
                MERGE INTO DIM_ALMACENADORA d
                USING (SELECT DISTINCT 
                       a.CODIGO_ALMACENADORA, b.NOMBRE_ALMACENADORA 
                       FROM NO_HECHOS a
                       LEFT JOIN USR_STAGE.STG_ALMACENADORA b ON(a.CODIGO_ALMACENADORA=b.CODIGO_ALMACENADORA) 
                       WHERE a.CODIGO_ALMACENADORA IS NOT NULL AND a.CODIGO_ALMACENADORA IS NOT NULL
                       ) nh
                ON
                  (d.CODIGO_ALMACENADORA=nh.CODIGO_ALMACENADORA)
                WHEN MATCHED THEN
                    UPDATE SET
                      d.NOMBRE_ALMACENADORA = nh.NOMBRE_ALMACENADORA
                WHEN NOT MATCHED THEN
                    INSERT (ALMACENADORA_KEY, CODIGO_ALMACENADORA, NOMBRE_ALMACENADORA)
                    VALUES (0, nh.CODIGO_ALMACENADORA, nh.NOMBRE_ALMACENADORA);
                PRC_REPROCESA_DIMENSIONES_QA('DIM_ALMACENADORA', P_OPCION);
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