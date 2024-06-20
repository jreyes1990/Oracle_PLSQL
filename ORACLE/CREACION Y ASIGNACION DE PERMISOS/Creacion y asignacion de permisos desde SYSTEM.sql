/*  1. Conéctate a la base de datos como un usuario con privilegios administrativos. 
       Usualmente, esto se hace con el usuario sys o system. */
-- sqlplus sys as sysdba

/*  1. Eliminar Usuario */
DROP USER "SGI" CASCADE;

/*  2. Crea el usuario:
       Para crear un nuevo usuario, usa el comando CREATE USER. 
       Debes especificar el nombre del usuario y una contraseña. */
CREATE USER "SGI" IDENTIFIED BY "Adm1n5g1*2024" DEFAULT TABLESPACE SYSTEM;

/*  3. Asigna cuotas en las tablaspaces. 
       Esto es opcional, pero recomendable para especificar cuánto espacio puede usar el 
       nuevo usuario en una tablaspace específica. */
ALTER USER "SGI" QUOTA UNLIMITED ON USERS;

/*  4. Concede privilegios al usuario. 
       Necesitarás asignar los privilegios necesarios para que el usuario pueda 
       realizar sus tareas. Algunos de los privilegios comunes son:

       CREATE SESSION: Permite al usuario conectarse a la base de datos.
       CREATE TABLE: Permite al usuario crear tablas.
       CREATE SEQUENCE: Permite al usuario crear secuencias.
       CREATE VIEW: Permite al usuario crear vistas. 
       CREATE PROCEDURE: Permite al usuario crear procedimientos almacenados y funciones.
       CREATE TRIGGER: Permite al usuario crear disparadores (triggers).
       CREATE SYNONYM: Permite al usuario crear sinónimos.
       CREATE DATABASE LINK: Permite al usuario crear enlaces de base de datos.
       CREATE MATERIALIZED VIEW: Permite al usuario crear vistas materializadas.
       CREATE ROLE: Permite al usuario crear roles.
       UNLIMITED TABLESPACE: Permite al usuario utilizar espacio ilimitado en las tablaspaces.
       EXECUTE ANY PROCEDURE: Permite al usuario ejecutar cualquier procedimiento almacenado.
       SELECT ANY TABLE: Permite al usuario seleccionar de cualquier tabla.
       INSERT ANY TABLE: Permite al usuario insertar en cualquier tabla.
       UPDATE ANY TABLE: Permite al usuario actualizar cualquier tabla.
       DELETE ANY TABLE: Permite al usuario eliminar de cualquier tabla. */
GRANT CREATE SESSION TO "SGI";
GRANT CREATE TABLE TO "SGI";
GRANT CREATE SEQUENCE TO "SGI";
GRANT CREATE VIEW TO "SGI";
GRANT CREATE PROCEDURE TO "SGI";
GRANT CREATE TRIGGER TO "SGI";
GRANT CREATE SYNONYM TO "SGI";
GRANT CREATE DATABASE LINK TO "SGI";
GRANT CREATE MATERIALIZED VIEW TO "SGI";
GRANT CREATE ROLE TO "SGI";
GRANT UNLIMITED TABLESPACE TO "SGI";
GRANT EXECUTE ANY PROCEDURE TO "SGI";
GRANT SELECT ANY TABLE TO "SGI";
GRANT INSERT ANY TABLE TO "SGI";
GRANT UPDATE ANY TABLE TO "SGI";
GRANT DELETE ANY TABLE TO "SGI";

/*  4.1. También puedes conceder todos los privilegios del sistema con: */
GRANT ALL PRIVILEGES TO "SGI";

/*  5. Concede permisos sobre objetos específicos. 
       Si el usuario necesita acceder a objetos específicos en la base de datos, 
       debes concederle permisos sobre esos objetos. Por ejemplo, para conceder 
       permisos de selección sobre una tabla: 
       
       SELECT: Permite al usuario seleccionar datos de una tabla o vista.
       INSERT: Permite al usuario insertar datos en una tabla.
       UPDATE: Permite al usuario actualizar datos en una tabla.
       DELETE: Permite al usuario eliminar datos de una tabla.
       EXECUTE: Permite al usuario ejecutar un procedimiento almacenado o una función.
       ALTER: Permite al usuario alterar la estructura de una tabla.
       INDEX: Permite al usuario crear un índice en una tabla. */
GRANT SELECT ON "ESQUEMA"."TABLA" TO "SGI";
GRANT INSERT ON "ESQUEMA"."TABLA" TO "SGI";
GRANT UPDATE ON "ESQUEMA"."TABLA" TO "SGI";
GRANT DELETE ON "ESQUEMA"."TABLA" TO "SGI";
GRANT EXECUTE ON "ESQUEMA"."TABLA" TO "SGI";
GRANT ALTER ON "ESQUEMA"."TABLA" TO "SGI";
GRANT INDEX ON "ESQUEMA"."TABLA" TO "SGI";


/*  6. Concede roles. 
       Además de los privilegios individuales, también puedes asignar roles, 
       que son grupos de privilegios. 
       
       CONNECT: Proporciona los privilegios básicos para conectarse a la base de datos. 
       RESOURCE: Proporciona privilegios adicionales para crear objetos como tablas y procedimientos. 
       DBA: Concede todos los privilegios administrativos. */
GRANT CONNECT TO "SGI";
GRANT RESOURCE TO "SGI";
GRANT DBA TO "SGI";

