CREATE TABLE HECHOS (
    AGENTE_KEY             NUMBER(5, 0),
    REGIMEN_KEY            NUMBER(5, 0),
    ADUANA_KEY             NUMBER(5, 0),
    OPERACION_KEY          NUMBER(5, 0),
    PAIS_ORIGEN_KEY        NUMBER(5, 0),
    PAIS_VENDEDOR_KEY      NUMBER(5, 0),
    CLIENTE_KEY            NUMBER(5, 0),
    CODIGO_TRANSPORTE_KEY  NUMBER(5, 0),
    ALMACENADORA_KEY       NUMBER(5, 0),
    FECHA_VALIDACION_KEY   NUMBER(8, 0),
    FECHA_ADICION_KEY      NUMBER(8, 0),
    FECHA_PRESENTACION_KEY NUMBER(8, 0),
    PESO_TOTAL             NUMBER(10, 2),
    VALOR_DOLARES          NUMBER(10, 2),
    VALOR_QUETZALES        NUMBER(10, 2),
    VALOR_FLETES           NUMBER(10, 2),
    VALOR_SEGUROS          NUMBER(10, 2),
    VALOR_OTROS_GASTOS     NUMBER(10, 2)
);

CREATE TABLE NO_HECHOS (
    AGENTE_KEY             NUMBER(5, 0),
    CODIGO_AGENTE          VARCHAR2(4),
    REGIMEN_KEY            NUMBER(5, 0),
    CODIGO_REGIMEN         VARCHAR2(2),
    ADUANA_KEY             NUMBER(5, 0),
    CODIGO_ADUANA          VARCHAR2(2),
    OPERACION_KEY          NUMBER(5, 0),
    CODIGO_TIPO_OPERACION  NUMBER(1, 0),
    PAIS_ORIGEN_KEY        NUMBER(5, 0),
    CODIGO_PAIS_ORIGEN     VARCHAR2(2),
    PAIS_VENDEDOR_KEY      NUMBER(5, 0),
    CODIGO_PAIS_VENDEDOR   VARCHAR2(2),
    CLIENTE_KEY            NUMBER(5, 0),
    CLIENTE                VARCHAR2(15),
    CODIGO_TRANSPORTE_KEY  NUMBER(5, 0),
    CODIGO_TRANSPORTE      VARCHAR2(1),
    ALMACENADORA_KEY       NUMBER(5, 0),
    CODIGO_ALMACENADORA    VARCHAR2(3),
    FECHA_VALIDACION_KEY   NUMBER(8, 0),
    FECHA_VALIDACION       DATE,
    FECHA_ADICION_KEY      NUMBER(8, 0),
    FECHA_ADICION          DATE,
    FECHA_PRESENTACION_KEY NUMBER(8, 0),
    FECHA_PRESENTACION     DATE,
    TIPO_CAMBIO            NUMBER(8, 4),
    PESO_TOTAL             NUMBER(10, 2),
    VALOR_DOLARES          NUMBER(10, 2),
    VALOR_QUETZALES        NUMBER(10, 2),
    VALOR_FLETES           NUMBER(10, 2),
    VALOR_SEGUROS          NUMBER(10, 2),
    VALOR_OTROS_GASTOS     NUMBER(10, 2)
);

CREATE TABLE DIM_AGENTE (
    AGENTE_KEY    NUMBER(5, 0),
    CODIGO_AGENTE VARCHAR2(4),
    NOMBRE_AGENTE VARCHAR2(200)
);

CREATE TABLE DIM_REGIMEN (
    REGIMEN_KEY    NUMBER(5, 0),
    CODIGO_REGIMEN VARCHAR2(2),
    NOMBRE_REGIMEN VARCHAR2(200)
);

CREATE TABLE DIM_ADUANA (
    ADUANA_KEY    NUMBER(5, 0),
    CODIGO_ADUANA VARCHAR2(2),
    NOMBRE_ADUANA VARCHAR2(200),
    TIPO_ADUANA   VARCHAR2(20)
);

CREATE TABLE DIM_TIPO_OPERACION (
    TIPO_OPERACION_KEY    NUMBER(5, 0),
    CODIGO_TIPO_OPERACION VARCHAR2(2),
    NOMBRE_TIPO_OPERACION VARCHAR2(50)
);

CREATE TABLE DIM_PAIS (
    PAIS_KEY    NUMBER(5, 0),
    CODIGO_PAIS VARCHAR2(2),
    NOMBRE_PAIS VARCHAR2(200)
);

CREATE TABLE DIM_CLIENTE (
    CLIENTE_KEY      NUMBER(5, 0),
    CODIGO_CLIENTE   VARCHAR2(15),
    NOMBRE_CLIENTE   VARCHAR2(200),
    STATUS           VARCHAR2(20),
    GENERO           VARCHAR2(20),
    ESTADO_CIVIL     VARCHAR2(20),
    REGION           VARCHAR2(20),
    DEPARTAMENTO     VARCHAR2(50),
    MUNICIPIO        VARCHAR2(75),
    CLASIFICACION    VARCHAR2(20),
    SECTOR_ECONOMICO VARCHAR2(200)
);

CREATE TABLE DIM_MEDIOS_TRANSPORTE (
    MEDIOS_TRANSPORTE_KEY    NUMBER(5, 0),
    CODIGO_MEDIOS_TRANSPORTE VARCHAR2(2),
    NOMBRE_MEDIOS_TRANSPORTE VARCHAR2(200)
);

CREATE TABLE DIM_ALMACENADORA (
    ALMACENADORA_KEY    NUMBER(5, 0),
    CODIGO_ALMACENADORA VARCHAR2(5),
    NOMBRE_ALMACENADORA VARCHAR2(200)
);

CREATE TABLE VALORES_DEFAULT (
    NOMBRE_METRICA VARCHAR2(50),
    VALOR          NUMBER(8, 0)
);

CREATE TABLE REPROCESA_DIMENSIONES_QA (
    NOMBRE_DIMENSION VARCHAR2(50),
    FECHA            DATE,
    PARAMETRO        NUMBER(8, 0)
);

CREATE TABLE CONTROL_NUMERACION (
    NOMBRE_DIMENSION VARCHAR2(50),
    VALOR            NUMBER(4, 0)
);

CREATE TABLE DIM_TIEMPO (
    FECHA_KEY           NUMERIC(8, 0) NOT NULL,
    FECHA               DATE NOT NULL,
    ANIO                NUMERIC(4, 0) NOT NULL,
    MES                 NUMERIC(2, 0) NOT NULL,
    NOMBRE_MES          VARCHAR2(15) NOT NULL,
    DIA                 NUMERIC(2, 0) NOT NULL,
    DIA_SEMANA          NUMERIC(1, 0) NOT NULL,
    NOMBRE_DIA          VARCHAR2(10) NOT NULL,
    SEMANA              NUMERIC(2, 0) NOT NULL,
    SEMESTRE            NUMERIC(1, 0) NOT NULL,
    NOMBRE_SEMESTRE     VARCHAR2(25) NOT NULL,
    CUATRIMESTRE        NUMERIC(1, 0) NOT NULL,
    NOMBRE_CUATRIMESTRE VARCHAR2(25) NOT NULL,
    TRIMESTRE           NUMERIC(1, 0) NOT NULL,
    NOMBRE_TRIMESTRE    VARCHAR2(25) NOT NULL,
    FECHA_SEMANA        VARCHAR2(25) NULL
)