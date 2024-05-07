CREATE OR REPLACE PROCEDURE PRC_SINCRONIZACION
IS
    CURSOR CR_PRODUCCION_WATERMARK IS
        SELECT * 
        FROM USR_PRODUCCION.WATERMARK;
    --
    CURSOR CR_PRODUCCION_DATOS(P_PK USR_PRODUCCION.WATERMARK.PK%TYPE) IS
        SELECT * 
        FROM USR_PRODUCCION.DATOS 
        WHERE (CODIGO_AGENTE||'-'||NUMERO_DECLARACION)=P_PK;
    --
    CURSOR CR_PRODUCCION_AGENTE(P_PK USR_PRODUCCION.WATERMARK.PK%TYPE) IS
        SELECT * 
        FROM USR_PRODUCCION.AGENTE
        WHERE CODIGO_AGENTE=P_PK;
    --
    CURSOR CR_PRODUCCION_REGIMEN(P_PK USR_PRODUCCION.WATERMARK.PK%TYPE) IS
        SELECT * 
        FROM USR_PRODUCCION.REGIMEN
        WHERE CODIGO_REGIMEN=P_PK;
    --
    CURSOR CR_PRODUCCION_ADUANA(P_PK USR_PRODUCCION.WATERMARK.PK%TYPE) IS
        SELECT * 
        FROM USR_PRODUCCION.ADUANA
        WHERE CODIGO_ADUANA=P_PK;
    --
    CURSOR CR_PRODUCCION_TIPO_OPERACION(P_PK USR_PRODUCCION.WATERMARK.PK%TYPE) IS
        SELECT * 
        FROM USR_PRODUCCION.TIPO_OPERACION
        WHERE CODIGO_TIPO_OPERACION=P_PK;
    --
    CURSOR CR_PRODUCCION_PAIS(P_PK USR_PRODUCCION.WATERMARK.PK%TYPE) IS
        SELECT * 
        FROM USR_PRODUCCION.PAIS
        WHERE CODIGO_PAIS=P_PK;
    --
    CURSOR CR_PRODUCCION_CLIENTE(P_PK USR_PRODUCCION.WATERMARK.PK%TYPE) IS
        SELECT * 
        FROM USR_PRODUCCION.CLIENTE
        WHERE CODIGO_CLIENTE=P_PK;
    --
    CURSOR CR_PRODUCCION_TRANSPORTE(P_PK USR_PRODUCCION.WATERMARK.PK%TYPE) IS
        SELECT * 
        FROM USR_PRODUCCION.MEDIOS_TRANSPORTE
        WHERE CODIGO_TRANSPORTE=P_PK;
    --
    CURSOR CR_PRODUCCION_ALMACENADORA(P_PK USR_PRODUCCION.WATERMARK.PK%TYPE) IS
        SELECT * 
        FROM USR_PRODUCCION.ALMACENADORA
        WHERE CODIGO_ALMACENADORA=P_PK;
    --
    EVENTO_MIGRO 		        USR_PRODUCCION.WATERMARK.MIGRO%TYPE := 'S';
    EVENTO_FECHA_OPERADO        USR_PRODUCCION.WATERMARK.FECHA_OPERADO%TYPE := SYSDATE;
BEGIN
    FOR i IN CR_PRODUCCION_WATERMARK LOOP
        -- SINCRONIZACION DE LA TABLA DATOS
        IF (UPPER(i.TABLA)=UPPER('DATOS') AND UPPER(i.MIGRO)=UPPER('N') AND UPPER(i.OPERACION) IN(UPPER('I'),UPPER('U'))) THEN
            FOR d IN CR_PRODUCCION_DATOS(i.PK) LOOP
                --
                IF (UPPER(i.OPERACION)=UPPER('U')) THEN
                    BEGIN
                        DELETE FROM STG_DATOS WHERE CODIGO_AGENTE=d.CODIGO_AGENTE AND NUMERO_DECLARACION=d.NUMERO_DECLARACION;
                    EXCEPTION WHEN OTHERS THEN
                        RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => STG_DATOS: Ocurrio un error al realizar delete en la tabla STG_DATOS ['||SQLERRM||']');
                        ROLLBACK;
                    END;
                END IF;
                --
                BEGIN
                    INSERT INTO STG_DATOS
                        (CODIGO_AGENTE, NUMERO_DECLARACION, CODIGO_REGIMEN, CODIGO_ADUANA, CODIGO_TIPO_OPERACION, CODIGO_PAIS_ORIGEN, CODIGO_PAIS_VENDEDOR,
                         CLIENTE, CODIGO_TRANSPORTE, TIPO_CAMBIO, FECHA_VALIDACION, FECHA_ADICION, FECHA_PRESENTACION, PESO_TOTAL, VALOR_DOLARES, VALOR_QUETZALES,
                         CODIGO_ALMACENADORA, VALOR_FLETES, VALOR_SEGUROS, VALOR_OTROS_GASTOS)
                    VALUES(d.CODIGO_AGENTE, d.NUMERO_DECLARACION, d.CODIGO_REGIMEN, d.CODIGO_ADUANA, d.CODIGO_TIPO_OPERACION, d.CODIGO_PAIS_ORIGEN, d.CODIGO_PAIS_VENDEDOR,
                         d.CLIENTE, d.CODIGO_TRANSPORTE, d.TIPO_CAMBIO, d.FECHA_VALIDACION, d.FECHA_ADICION, d.FECHA_PRESENTACION, d.PESO_TOTAL, d.VALOR_DOLARES, d.VALOR_QUETZALES,
                         d.CODIGO_ALMACENADORA, d.VALOR_FLETES, d.VALOR_SEGUROS, d.VALOR_OTROS_GASTOS);
                EXCEPTION WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => STG_DATOS: Ocurrio un error al realizar insert en la tabla STG_DATOS ['||SQLERRM||']');
                    ROLLBACK;
                END;
                --
                BEGIN
                    UPDATE USR_PRODUCCION.WATERMARK 
                        SET MIGRO=EVENTO_MIGRO, FECHA_OPERADO=EVENTO_FECHA_OPERADO
                    WHERE UPPER(TABLA)=UPPER(i.TABLA) AND UPPER(OPERACION)=UPPER(i.OPERACION) AND PK=i.PK;
                EXCEPTION WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => WATERMARK: Ocurrio un error al realizar update en la tabla WATERMARK => '||UPPER(i.TABLA)||' ['||SQLERRM||']');
                    ROLLBACK;
                END;
            END LOOP;
        END IF;
        -- SINCRONIZACION DE LA TABLA AGENTE
        IF (UPPER(i.TABLA)=UPPER('AGENTE') AND UPPER(i.MIGRO)=UPPER('N') AND UPPER(i.OPERACION) IN(UPPER('I'),UPPER('U'))) THEN
            FOR a IN CR_PRODUCCION_AGENTE(i.PK) LOOP
                --
                IF (UPPER(i.OPERACION)=UPPER('U')) THEN
                    BEGIN
                        DELETE FROM STG_AGENTE WHERE CODIGO_AGENTE=a.CODIGO_AGENTE;
                    EXCEPTION WHEN OTHERS THEN
                        RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => STG_AGENTE: Ocurrio un error al realizar delete en la tabla STG_AGENTE ['||SQLERRM||']');
                        ROLLBACK;
                    END;
                END IF;
                --
                BEGIN
                    INSERT INTO STG_AGENTE
                        (CODIGO_AGENTE, NOMBRE_AGENTE)
                    VALUES(a.CODIGO_AGENTE, a.NOMBRE_AGENTE);
                EXCEPTION WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => STG_AGENTE: Ocurrio un error al realizar insert en la tabla STG_AGENTE ['||SQLERRM||']');
                    ROLLBACK;
                END;
                --
                BEGIN
                    UPDATE USR_PRODUCCION.WATERMARK 
                        SET MIGRO=EVENTO_MIGRO, FECHA_OPERADO=EVENTO_FECHA_OPERADO
                    WHERE UPPER(TABLA)=UPPER(i.TABLA) AND UPPER(OPERACION)=UPPER(i.OPERACION) AND PK=i.PK;
                EXCEPTION WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => WATERMARK: Ocurrio un error al realizar update en la tabla WATERMARK => '||UPPER(i.TABLA)||' ['||SQLERRM||']');
                    ROLLBACK;
                END;
            END LOOP;
        END IF;
        -- SINCRONIZACION DE LA TABLA REGIMEN
        IF (UPPER(i.TABLA)=UPPER('REGIMEN') AND UPPER(i.MIGRO)=UPPER('N') AND UPPER(i.OPERACION) IN(UPPER('I'),UPPER('U'))) THEN
            FOR r IN CR_PRODUCCION_REGIMEN(i.PK) LOOP
                --
                IF (UPPER(i.OPERACION)=UPPER('U')) THEN
                    BEGIN
                        DELETE FROM STG_REGIMEN WHERE CODIGO_REGIMEN=r.CODIGO_REGIMEN;
                    EXCEPTION WHEN OTHERS THEN
                        RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => STG_REGIMEN: Ocurrio un error al realizar delete en la tabla STG_REGIMEN ['||SQLERRM||']');
                        ROLLBACK;
                    END;
                END IF;
                --
                BEGIN
                    INSERT INTO STG_REGIMEN
                        (CODIGO_REGIMEN, NOMBRE_REGIMEN)
                    VALUES(r.CODIGO_REGIMEN, r.NOMBRE_REGIMEN);
                EXCEPTION WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => STG_REGIMEN: Ocurrio un error al realizar insert en la tabla STG_REGIMEN ['||SQLERRM||']');
                    ROLLBACK;
                END;
                --
                BEGIN
                    UPDATE USR_PRODUCCION.WATERMARK 
                        SET MIGRO=EVENTO_MIGRO, FECHA_OPERADO=EVENTO_FECHA_OPERADO
                    WHERE UPPER(TABLA)=UPPER(i.TABLA) AND UPPER(OPERACION)=UPPER(i.OPERACION) AND PK=i.PK;
                EXCEPTION WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => WATERMARK: Ocurrio un error al realizar update en la tabla WATERMARK => '||UPPER(i.TABLA)||' ['||SQLERRM||']');
                    ROLLBACK;
                END;
            END LOOP;
        END IF;
        -- SINCRONIZACION DE LA TABLA ADUANA
        IF (UPPER(i.TABLA)=UPPER('ADUANA') AND UPPER(i.MIGRO)=UPPER('N') AND UPPER(i.OPERACION) IN(UPPER('I'),UPPER('U'))) THEN
            FOR ad IN CR_PRODUCCION_ADUANA(i.PK) LOOP
                --
                IF (UPPER(i.OPERACION)=UPPER('U')) THEN
                    BEGIN
                        DELETE FROM STG_ADUANA WHERE CODIGO_ADUANA=ad.CODIGO_ADUANA;
                    EXCEPTION WHEN OTHERS THEN
                        RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => STG_ADUANA: Ocurrio un error al realizar delete en la tabla STG_ADUANA ['||SQLERRM||']');
                        ROLLBACK;
                    END;
                END IF;
                --
                BEGIN
                    INSERT INTO STG_ADUANA
                        (CODIGO_ADUANA, NOMBRE_ADUANA, TIPO_ADUANA)
                    VALUES(ad.CODIGO_ADUANA, ad.NOMBRE_ADUANA, ad.TIPO_ADUANA);
                EXCEPTION WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => STG_ADUANA: Ocurrio un error al realizar insert en la tabla STG_ADUANA ['||SQLERRM||']');
                    ROLLBACK;
                END;
                --
                BEGIN
                    UPDATE USR_PRODUCCION.WATERMARK 
                        SET MIGRO=EVENTO_MIGRO, FECHA_OPERADO=EVENTO_FECHA_OPERADO
                    WHERE UPPER(TABLA)=UPPER(i.TABLA) AND UPPER(OPERACION)=UPPER(i.OPERACION) AND PK=i.PK;
                EXCEPTION WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => WATERMARK: Ocurrio un error al realizar update en la tabla WATERMARK => '||UPPER(i.TABLA)||' ['||SQLERRM||']');
                    ROLLBACK;
                END;
            END LOOP;
        END IF;
        -- SINCRONIZACION DE LA TABLA TIPO_OPERACION
        IF (UPPER(i.TABLA)=UPPER('TIPO_OPERACION') AND UPPER(i.MIGRO)=UPPER('N') AND UPPER(i.OPERACION) IN(UPPER('I'),UPPER('U'))) THEN
            FOR tn IN CR_PRODUCCION_TIPO_OPERACION(i.PK) LOOP
                --
                IF (UPPER(i.OPERACION)=UPPER('U')) THEN
                    BEGIN
                        DELETE FROM STG_TIPO_OPERACION WHERE CODIGO_TIPO_OPERACION=tn.CODIGO_TIPO_OPERACION;
                    EXCEPTION WHEN OTHERS THEN
                        RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => STG_TIPO_OPERACION: Ocurrio un error al realizar delete en la tabla STG_TIPO_OPERACION ['||SQLERRM||']');
                        ROLLBACK;
                    END;
                END IF;
                --
                BEGIN
                    INSERT INTO STG_TIPO_OPERACION
                        (CODIGO_TIPO_OPERACION, NOMBRE_TIPO_OPERACION)
                    VALUES(tn.CODIGO_TIPO_OPERACION, tn.NOMBRE_TIPO_OPERACION);
                EXCEPTION WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => STG_TIPO_OPERACION: Ocurrio un error al realizar insert en la tabla STG_TIPO_OPERACION ['||SQLERRM||']');
                    ROLLBACK;
                END;
                --
                BEGIN
                    UPDATE USR_PRODUCCION.WATERMARK 
                        SET MIGRO=EVENTO_MIGRO, FECHA_OPERADO=EVENTO_FECHA_OPERADO
                    WHERE UPPER(TABLA)=UPPER(i.TABLA) AND UPPER(OPERACION)=UPPER(i.OPERACION) AND PK=i.PK;
                EXCEPTION WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => WATERMARK: Ocurrio un error al realizar update en la tabla WATERMARK => '||UPPER(i.TABLA)||' ['||SQLERRM||']');
                    ROLLBACK;
                END;
            END LOOP;
        END IF;
        -- SINCRONIZACION DE LA TABLA PAIS
        IF (UPPER(i.TABLA)=UPPER('PAIS') AND UPPER(i.MIGRO)=UPPER('N') AND UPPER(i.OPERACION) IN(UPPER('I'),UPPER('U'))) THEN
            FOR p IN CR_PRODUCCION_PAIS(i.PK) LOOP
                --
                IF (UPPER(i.OPERACION)=UPPER('U')) THEN
                    BEGIN
                        DELETE FROM STG_PAIS WHERE CODIGO_PAIS=p.CODIGO_PAIS;
                    EXCEPTION WHEN OTHERS THEN
                        RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => STG_PAIS: Ocurrio un error al realizar delete en la tabla STG_PAIS ['||SQLERRM||']');
                        ROLLBACK;
                    END;
                END IF;
                --
                BEGIN
                    INSERT INTO STG_PAIS
                        (CODIGO_PAIS, NOMBRE_PAIS)
                    VALUES(p.CODIGO_PAIS, p.NOMBRE_PAIS);
                EXCEPTION WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => STG_PAIS: Ocurrio un error al realizar insert en la tabla STG_PAIS ['||SQLERRM||']');
                    ROLLBACK;
                END;
                --
                BEGIN
                    UPDATE USR_PRODUCCION.WATERMARK 
                        SET MIGRO=EVENTO_MIGRO, FECHA_OPERADO=EVENTO_FECHA_OPERADO
                    WHERE UPPER(TABLA)=UPPER(i.TABLA) AND UPPER(OPERACION)=UPPER(i.OPERACION) AND PK=i.PK;
                EXCEPTION WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => WATERMARK: Ocurrio un error al realizar update en la tabla WATERMARK => '||UPPER(i.TABLA)||' ['||SQLERRM||']');
                    ROLLBACK;
                END;
            END LOOP;
        END IF;
        -- SINCRONIZACION DE LA TABLA CLIENTE
        IF (UPPER(i.TABLA)=UPPER('CLIENTE') AND UPPER(i.MIGRO)=UPPER('N') AND UPPER(i.OPERACION) IN(UPPER('I'),UPPER('U'))) THEN
            FOR c IN CR_PRODUCCION_CLIENTE(i.PK) LOOP
                --
                IF (UPPER(i.OPERACION)=UPPER('U')) THEN
                    BEGIN
                        DELETE FROM STG_CLIENTE WHERE CODIGO_CLIENTE=c.CODIGO_CLIENTE;
                    EXCEPTION WHEN OTHERS THEN
                        RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => STG_CLIENTE: Ocurrio un error al realizar delete en la tabla STG_CLIENTE ['||SQLERRM||']');
                        ROLLBACK;
                    END;
                END IF;
                --
                BEGIN
                    INSERT INTO STG_CLIENTE
                        (CODIGO_CLIENTE, NOMBRE_CLIENTE, STATUS, GENERO, ESTADO_CIVIL, REGION, DEPARTAMENTO, MUNICIPIO, CLASIFICACION, SECTOR_ECONOMICO)
                    VALUES(c.CODIGO_CLIENTE, c.NOMBRE_CLIENTE, c.STATUS, c.GENERO, c.ESTADO_CIVIL, c.REGION, c.DEPARTAMENTO, c.MUNICIPIO, c.CLASIFICACION, c.SECTOR_ECONOMICO);
                EXCEPTION WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => STG_CLIENTE: Ocurrio un error al realizar insert en la tabla STG_CLIENTE ['||SQLERRM||']');
                    ROLLBACK;
                END;
                --
                BEGIN
                    UPDATE USR_PRODUCCION.WATERMARK 
                        SET MIGRO=EVENTO_MIGRO, FECHA_OPERADO=EVENTO_FECHA_OPERADO
                    WHERE UPPER(TABLA)=UPPER(i.TABLA) AND UPPER(OPERACION)=UPPER(i.OPERACION) AND PK=i.PK;
                EXCEPTION WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => WATERMARK: Ocurrio un error al realizar update en la tabla WATERMARK => '||UPPER(i.TABLA)||' ['||SQLERRM||']');
                    ROLLBACK;
                END;
            END LOOP;
        END IF;
        -- SINCRONIZACION DE LA TABLA MEDIOS_TRANSPORTE
        IF (UPPER(i.TABLA)=UPPER('MEDIOS_TRANSPORTE') AND UPPER(i.MIGRO)=UPPER('N') AND UPPER(i.OPERACION) IN(UPPER('I'),UPPER('U'))) THEN
            FOR mt IN CR_PRODUCCION_TRANSPORTE(i.PK) LOOP
                --
                IF (UPPER(i.OPERACION)=UPPER('U')) THEN
                    BEGIN
                        DELETE FROM STG_MEDIOS_TRANSPORTE WHERE CODIGO_TRANSPORTE=mt.CODIGO_TRANSPORTE;
                    EXCEPTION WHEN OTHERS THEN
                        RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => STG_MEDIOS_TRANSPORTE: Ocurrio un error al realizar delete en la tabla STG_MEDIOS_TRANSPORTE ['||SQLERRM||']');
                        ROLLBACK;
                    END;
                END IF;
                --
                BEGIN
                    INSERT INTO STG_MEDIOS_TRANSPORTE
                        (CODIGO_TRANSPORTE, DESCRIPCION_TRANSPORTE)
                    VALUES(mt.CODIGO_TRANSPORTE, mt.DESCRIPCION_TRANSPORTE);
                EXCEPTION WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => STG_MEDIOS_TRANSPORTE: Ocurrio un error al realizar insert en la tabla STG_MEDIOS_TRANSPORTE ['||SQLERRM||']');
                    ROLLBACK;
                END;
                --
                BEGIN
                    UPDATE USR_PRODUCCION.WATERMARK 
                        SET MIGRO=EVENTO_MIGRO, FECHA_OPERADO=EVENTO_FECHA_OPERADO
                    WHERE UPPER(TABLA)=UPPER(i.TABLA) AND UPPER(OPERACION)=UPPER(i.OPERACION) AND PK=i.PK;
                EXCEPTION WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => WATERMARK: Ocurrio un error al realizar update en la tabla WATERMARK => '||UPPER(i.TABLA)||' ['||SQLERRM||']');
                    ROLLBACK;
                END;
            END LOOP;
        END IF;
        -- SINCRONIZACION DE LA TABLA ALMACENADORA
        IF (UPPER(i.TABLA)=UPPER('ALMACENADORA') AND UPPER(i.MIGRO)=UPPER('N') AND UPPER(i.OPERACION) IN(UPPER('I'),UPPER('U'))) THEN
            FOR ac IN CR_PRODUCCION_ALMACENADORA(i.PK) LOOP
                --
                IF (UPPER(i.OPERACION)=UPPER('U')) THEN
                    BEGIN
                        DELETE FROM STG_ALMACENADORA WHERE CODIGO_ALMACENADORA=ac.CODIGO_ALMACENADORA;
                    EXCEPTION WHEN OTHERS THEN
                        RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => STG_ALMACENADORA: Ocurrio un error al realizar delete en la tabla STG_ALMACENADORA ['||SQLERRM||']');
                        ROLLBACK;
                    END;
                END IF;
                --
                BEGIN
                    INSERT INTO STG_ALMACENADORA
                        (CODIGO_ALMACENADORA, NOMBRE_ALMACENADORA)
                    VALUES(ac.CODIGO_ALMACENADORA, ac.NOMBRE_ALMACENADORA);
                EXCEPTION WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => STG_ALMACENADORA: Ocurrio un error al realizar insert en la tabla STG_ALMACENADORA ['||SQLERRM||']');
                    ROLLBACK;
                END;
                --
                BEGIN
                    UPDATE USR_PRODUCCION.WATERMARK 
                        SET MIGRO=EVENTO_MIGRO, FECHA_OPERADO=EVENTO_FECHA_OPERADO
                    WHERE UPPER(TABLA)=UPPER(i.TABLA) AND UPPER(OPERACION)=UPPER(i.OPERACION) AND PK=i.PK;
                EXCEPTION WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001, 'PRC_SINCRONIZACION => WATERMARK: Ocurrio un error al realizar update en la tabla WATERMARK => '||UPPER(i.TABLA)||' ['||SQLERRM||']');
                    ROLLBACK;
                END;
            END LOOP;
        END IF;
    END LOOP;
END PRC_SINCRONIZACION;