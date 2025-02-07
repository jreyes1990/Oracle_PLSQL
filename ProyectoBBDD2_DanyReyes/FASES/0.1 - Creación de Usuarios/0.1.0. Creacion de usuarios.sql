-- SYSTEM.
alter session set "_oracle_script"=true;

DROP USER USR_DW CASCADE;
DROP USER USR_PRODUCCION CASCADE;
DROP USER USR_STAGE CASCADE;

CREATE USER USR_PRODUCCION IDENTIFIED BY PRODUCCION DEFAULT TABLESPACE SYSTEM;
CREATE USER USR_STAGE IDENTIFIED BY STAGE DEFAULT TABLESPACE SYSTEM;
CREATE USER USR_DW IDENTIFIED BY DW2024 DEFAULT TABLESPACE SYSTEM;

-- PERMISO PARA CONECTARSE
GRANT CONNECT, RESOURCE TO USR_PRODUCCION;
GRANT CONNECT, RESOURCE TO USR_STAGE;
GRANT CONNECT, RESOURCE TO USR_DW;

ALTER USER USR_DW QUOTA UNLIMITED ON USERS;
ALTER USER USR_PRODUCCION QUOTA UNLIMITED ON USERS;
ALTER USER USR_STAGE QUOTA UNLIMITED ON USERS;