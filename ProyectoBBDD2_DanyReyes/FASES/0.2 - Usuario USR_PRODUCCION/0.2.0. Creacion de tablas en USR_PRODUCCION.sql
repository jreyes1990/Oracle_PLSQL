CREATE TABLE DATOS (
    CODIGO_AGENTE         VARCHAR2(4),
    NUMERO_DECLARACION    VARCHAR2(12),
    CODIGO_REGIMEN        VARCHAR2(2),
    CODIGO_ADUANA         VARCHAR2(2),
    CODIGO_TIPO_OPERACION NUMBER(1, 0),
    CODIGO_PAIS_ORIGEN    VARCHAR2(2),
    CODIGO_PAIS_VENDEDOR  VARCHAR2(2),
    CLIENTE               VARCHAR2(15),
    CODIGO_TRANSPORTE     VARCHAR2(1),
    TIPO_CAMBIO           NUMBER(8, 4),
    FECHA_VALIDACION      DATE,
    FECHA_ADICION         DATE,
    FECHA_PRESENTACION    DATE,
    PESO_TOTAL            NUMBER(10, 2),
    VALOR_DOLARES         NUMBER(10, 2),
    VALOR_QUETZALES       NUMBER(10, 2),
    CODIGO_ALMACENADORA   VARCHAR2(3),
    VALOR_FLETES          NUMBER(10, 2),
    VALOR_SEGUROS         NUMBER(10, 2),
    VALOR_OTROS_GASTOS    NUMBER(10, 2)
);

CREATE TABLE AGENTE (
    CODIGO_AGENTE VARCHAR2(4),
    NOMBRE_AGENTE VARCHAR2(200)
);

CREATE TABLE REGIMEN (
    CODIGO_REGIMEN VARCHAR2(2),
    NOMBRE_REGIMEN VARCHAR2(200),
    PAGO_BANCO     VARCHAR2(1)
);

CREATE TABLE ADUANA (
    CODIGO_ADUANA VARCHAR2(2),
    NOMBRE_ADUANA VARCHAR2(200),
    TIPO_ADUANA   VARCHAR2(1)
);

CREATE TABLE TIPO_OPERACION (
    CODIGO_TIPO_OPERACION VARCHAR2(2),
    NOMBRE_TIPO_OPERACION VARCHAR2(50)
);

CREATE TABLE PAIS (
    CODIGO_PAIS VARCHAR2(2),
    NOMBRE_PAIS VARCHAR2(200)
);

CREATE TABLE CLIENTE (
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

CREATE TABLE MEDIOS_TRANSPORTE (
    CODIGO_TRANSPORTE      VARCHAR2(2),
    DESCRIPCION_TRANSPORTE VARCHAR2(200)
);

CREATE TABLE ALMACENADORA (
    CODIGO_ALMACENADORA VARCHAR2(5),
    NOMBRE_ALMACENADORA VARCHAR2(200)
);

CREATE TABLE WATERMARK (
    TABLA         VARCHAR2(30),
    PK            VARCHAR2(20),
    OPERACION     VARCHAR2(1),
    FECHA_INSERT  DATE,
    MIGRO         VARCHAR2(1) DEFAULT 'N',
    FECHA_OPERADO DATE
);