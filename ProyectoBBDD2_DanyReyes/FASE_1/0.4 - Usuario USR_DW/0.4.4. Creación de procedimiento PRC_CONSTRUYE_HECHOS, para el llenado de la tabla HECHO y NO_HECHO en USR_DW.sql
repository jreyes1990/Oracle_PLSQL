/* ===========================================================================*/
/*  Procedimiento llenado de tabla de HECHOS (PRC_CONSTRUYE_HECHOS), 
    Parámetro 1. STG_TRANSACCION LEFT JOIN Todas las dimensiones por medio de 
    los COD. Ambiente DW. Lleno tabla de hechos (todos los key llenos) 
    y no hechos (key nulos). 
*/
CREATE OR REPLACE PROCEDURE PRC_CONSTRUYE_HECHOS(
    P_OPCION NUMBER
) 
IS
    CURSOR CR_CONSTRUYE_HECHOS IS
        SELECT 
            A.CODIGO_AGENTE, 
            A.NUMERO_DECLARACION, 
            A.CODIGO_REGIMEN, 
            A.CODIGO_ADUANA, 
            A.CODIGO_TIPO_OPERACION, 
            A.CODIGO_PAIS_ORIGEN, 
            A.CODIGO_PAIS_VENDEDOR, 
            A.CLIENTE, 
            A.CODIGO_TRANSPORTE, 
            A.TIPO_CAMBIO, 
            A.FECHA_VALIDACION, 
            A.FECHA_ADICION, 
            A.FECHA_PRESENTACION, 
            A.PESO_TOTAL, 
            A.VALOR_DOLARES, 
            A.VALOR_QUETZALES, 
            A.CODIGO_ALMACENADORA, 
            A.VALOR_FLETES, 
            A.VALOR_SEGUROS, 
            A.VALOR_OTROS_GASTOS,
            TO_NUMBER(TO_CHAR(TRUNC(A.FECHA_VALIDACION),'RRRRMMDD')) AS FECHA_VALIDACION_KEY,
            TO_NUMBER(TO_CHAR(TRUNC(A.FECHA_ADICION),'RRRRMMDD')) AS FECHA_ADICION_KEY,
            TO_NUMBER(TO_CHAR(TRUNC(A.FECHA_PRESENTACION),'RRRRMMDD')) AS FECHA_PRESENTACION_KEY,
            B.AGENTE_KEY,
            C.REGIMEN_KEY,
            D.ADUANA_KEY,
            E.TIPO_OPERACION_KEY AS OPERACION_KEY,
            F.PAIS_KEY AS PAIS_ORIGEN_KEY,
            FF.PAIS_KEY AS PAIS_VENDEDOR_KEY,
            G.CLIENTE_KEY,
            H.MEDIOS_TRANSPORTE_KEY AS CODIGO_TRANSPORTE_KEY,
            I.ALMACENADORA_KEY,
            (CASE WHEN (B.AGENTE_KEY IS NOT NULL AND C.REGIMEN_KEY IS NOT NULL AND D.ADUANA_KEY IS NOT NULL AND F.PAIS_KEY IS NOT NULL AND FF.PAIS_KEY IS NOT NULL AND G.CLIENTE_KEY IS NOT NULL AND H.MEDIOS_TRANSPORTE_KEY IS NOT NULL AND I.ALMACENADORA_KEY IS NOT NULL) THEN 1 ELSE 0 END) AS VALIDA_KEYS	
        FROM USR_STAGE.STG_DATOS A
        LEFT JOIN DIM_AGENTE B ON(A.CODIGO_AGENTE=B.CODIGO_AGENTE)
        LEFT JOIN DIM_REGIMEN C ON(A.CODIGO_REGIMEN=C.CODIGO_REGIMEN)
        LEFT JOIN DIM_ADUANA D ON(A.CODIGO_ADUANA=D.CODIGO_ADUANA)
        LEFT JOIN DIM_TIPO_OPERACION E ON(A.CODIGO_TIPO_OPERACION=E.CODIGO_TIPO_OPERACION)
        LEFT JOIN DIM_PAIS F ON(A.CODIGO_PAIS_ORIGEN=F.CODIGO_PAIS)
        LEFT JOIN DIM_PAIS FF ON(A.CODIGO_PAIS_VENDEDOR=FF.CODIGO_PAIS)
        LEFT JOIN DIM_CLIENTE G ON(A.CLIENTE=G.CODIGO_CLIENTE)
        LEFT JOIN DIM_MEDIOS_TRANSPORTE H ON(A.CODIGO_TRANSPORTE=H.CODIGO_MEDIOS_TRANSPORTE)
        LEFT JOIN DIM_ALMACENADORA I ON(A.CODIGO_ALMACENADORA=I.CODIGO_ALMACENADORA);
    --
    PARAMETRO_VACIO         EXCEPTION;
    PARAMETRO_NO_DEFINIDO   EXCEPTION;
    VALIDACION_NO_DEFINIDO  EXCEPTION;
BEGIN
    BEGIN
        IF P_OPCION IS NOT NULL THEN
            IF P_OPCION = 1 THEN
                FOR i IN CR_CONSTRUYE_HECHOS LOOP
                    BEGIN
                        IF i.VALIDA_KEYS IN(0, 1) THEN
                            IF i.VALIDA_KEYS = 1 THEN
                                -- INSERTANDO A LA TABLA DE HECHOS
                                BEGIN
                                    INSERT INTO HECHOS 
                                           (AGENTE_KEY, REGIMEN_KEY, ADUANA_KEY, OPERACION_KEY, PAIS_ORIGEN_KEY, PAIS_VENDEDOR_KEY, CLIENTE_KEY, 
                                            CODIGO_TRANSPORTE_KEY, ALMACENADORA_KEY, FECHA_VALIDACION_KEY, FECHA_ADICION_KEY, FECHA_PRESENTACION_KEY, 
                                            PESO_TOTAL, VALOR_DOLARES, VALOR_QUETZALES, VALOR_FLETES, VALOR_SEGUROS, VALOR_OTROS_GASTOS) 
                                    VALUES(i.AGENTE_KEY, i.REGIMEN_KEY, i.ADUANA_KEY, i.OPERACION_KEY, i.PAIS_ORIGEN_KEY, i.PAIS_VENDEDOR_KEY, i.CLIENTE_KEY,
                                           i.CODIGO_TRANSPORTE_KEY, i.ALMACENADORA_KEY, i.FECHA_VALIDACION_KEY, i.FECHA_ADICION_KEY, i.FECHA_PRESENTACION_KEY,
                                           i.PESO_TOTAL, i.VALOR_DOLARES, i.VALOR_QUETZALES, i.VALOR_FLETES, i.VALOR_SEGUROS, i.VALOR_OTROS_GASTOS);
                                EXCEPTION WHEN OTHERS THEN
                                    RAISE_APPLICATION_ERROR(-20001, 'PRC_CONSTRUYE_HECHOS => Error al insertar los datos a la tabla de HECHOS: ');
                                END;
                            ELSIF i.VALIDA_KEYS = 0 THEN
                                -- INSERTANDO A LA TABLA DE NO_HECHOS
                                BEGIN
                                    INSERT INTO NO_HECHOS 
                                           (AGENTE_KEY, CODIGO_AGENTE, REGIMEN_KEY, CODIGO_REGIMEN, ADUANA_KEY, CODIGO_ADUANA, OPERACION_KEY, 
                                            CODIGO_TIPO_OPERACION, PAIS_ORIGEN_KEY, CODIGO_PAIS_ORIGEN, PAIS_VENDEDOR_KEY, CODIGO_PAIS_VENDEDOR, 
                                            CLIENTE_KEY, CLIENTE, CODIGO_TRANSPORTE_KEY, CODIGO_TRANSPORTE, ALMACENADORA_KEY, CODIGO_ALMACENADORA, 
                                            FECHA_VALIDACION_KEY, FECHA_VALIDACION, FECHA_ADICION_KEY, FECHA_ADICION, FECHA_PRESENTACION_KEY, 
                                            FECHA_PRESENTACION, TIPO_CAMBIO, PESO_TOTAL, VALOR_DOLARES, VALOR_QUETZALES, VALOR_FLETES, VALOR_SEGUROS, 
                                            VALOR_OTROS_GASTOS) 
                                    VALUES (i.AGENTE_KEY, i.CODIGO_AGENTE, i.REGIMEN_KEY, i.CODIGO_REGIMEN, i.ADUANA_KEY, i.CODIGO_ADUANA, i.OPERACION_KEY,
                                            i.CODIGO_TIPO_OPERACION, i.PAIS_ORIGEN_KEY, i.CODIGO_PAIS_ORIGEN, i.PAIS_VENDEDOR_KEY, i.CODIGO_PAIS_VENDEDOR,
                                            i.CLIENTE_KEY, i.CLIENTE, i.CODIGO_TRANSPORTE_KEY, i.CODIGO_TRANSPORTE, i.ALMACENADORA_KEY, i.CODIGO_ALMACENADORA,
                                            i.FECHA_VALIDACION_KEY, i.FECHA_VALIDACION, i.FECHA_ADICION_KEY, i.FECHA_ADICION, i.FECHA_PRESENTACION_KEY,
                                            i.FECHA_PRESENTACION, i.TIPO_CAMBIO, i.PESO_TOTAL, i.VALOR_DOLARES, i.VALOR_QUETZALES, i.VALOR_FLETES, i.VALOR_SEGUROS,
                                            i.VALOR_OTROS_GASTOS);
                                EXCEPTION WHEN OTHERS THEN
                                    RAISE_APPLICATION_ERROR(-20001, 'PRC_CONSTRUYE_HECHOS => Error al insertar los datos a la tabla de NO_HECHOS: ');
                                END;
                            END IF;
                        ELSE 
                            RAISE VALIDACION_NO_DEFINIDO;
                            ROLLBACK;
                        END IF;
                    EXCEPTION
                        WHEN VALIDACION_NO_DEFINIDO THEN
                            RAISE_APPLICATION_ERROR(-20001, 'PRC_CONSTRUYE_HECHOS => La Validación ['||i.VALIDA_KEYS||'], No esta definido dentro del cursor CR_CONSTRUYE_HECHOS');
                    END;
                END LOOP;
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
            RAISE_APPLICATION_ERROR(-20001, 'PRC_CONSTRUYE_HECHOS => El procedimiento almacenado debe llevar un parametro: ['||P_OPCION||']');
        WHEN PARAMETRO_NO_DEFINIDO THEN
            RAISE_APPLICATION_ERROR(-20001, 'PRC_CONSTRUYE_HECHOS => El parametro ['||P_OPCION||'], No esta definido dentro del procedimiento almacenado');
    END;
END PRC_CONSTRUYE_HECHOS;
