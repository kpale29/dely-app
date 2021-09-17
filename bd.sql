-- Generado por Oracle SQL Developer Data Modeler 20.2.0.167.1538
--   en:        2021-09-16 11:40:16 CST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE categorias (
    id           INTEGER NOT NULL,
    nombre       NVARCHAR2(180) NOT NULL,
    descripcion  NVARCHAR2(255)
);

ALTER TABLE categorias ADD CONSTRAINT categorias_pk PRIMARY KEY ( id );

CREATE TABLE direccion (
    id          INTEGER NOT NULL,
    id_usuario  INTEGER NOT NULL,
    direccion   NVARCHAR2(255),
    sector      NVARCHAR2(255),
    lat         NUMBER(10),
    lng         NUMBER(10)
);

ALTER TABLE direccion ADD CONSTRAINT direccion_pk PRIMARY KEY ( id );

CREATE TABLE pedidos (
    id             INTEGER NOT NULL,
    id_cliente     INTEGER NOT NULL,
    id_repartidor  INTEGER NOT NULL,
    id_direccion   INTEGER,
    lat        NUMBER(10),
    lng            NUMBER(10),
    status         NVARCHAR2(90),
    timestamp      INTEGER
);

ALTER TABLE pedidos ADD CONSTRAINT pedido_pk PRIMARY KEY ( id );

CREATE TABLE pedidos_productos (
    id_pedido    INTEGER NOT NULL,
    id_producto  INTEGER NOT NULL,
    cantidad     INTEGER
);

CREATE TABLE productos (
    id            INTEGER NOT NULL,
    nombre        NVARCHAR2(180) NOT NULL,
    descripcion   NVARCHAR2(255),
    precio        NUMBER(10),
    imagen1       NVARCHAR2(255),
    imagen2       NVARCHAR2(255) NOT NULL,
    imagen3       NVARCHAR2(255),
    id_categoria  INTEGER NOT NULL
);

ALTER TABLE productos ADD CONSTRAINT productos_pk PRIMARY KEY ( id );

CREATE TABLE roles (
    id      INTEGER NOT NULL,
    nombre  NVARCHAR2(180) NOT NULL,
    imagen  NVARCHAR2(255),
    route   NVARCHAR2(255)
);

ALTER TABLE roles ADD CONSTRAINT roles_pk PRIMARY KEY ( id );

CREATE TABLE roles_usuarios (
    id_usuario  INTEGER NOT NULL,
    id_rol      INTEGER NOT NULL
);

ALTER TABLE roles_usuarios ADD CONSTRAINT roles_usuarios_pk PRIMARY KEY ( id_usuario, id_rol );

CREATE TABLE usuarios (
    id            INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    correo        VARCHAR(180) NOT NULL UNIQUE,
    password      VARCHAR(255) NOT NULL,
    telefono      VARCHAR(80) NOT NULL UNIQUE,
    nombre        VARCHAR(255) NOT NULL,
    imagen        VARCHAR(255),
    estado        BOOLEAN,
    apellido      VARCHAR(255) NOT NULL,
    token_sesion  VARCHAR(180),
    creado        DATETIME NOT NULL, 
    modificado    DATETIME NOT NULL
);

ALTER TABLE usuarios ADD CONSTRAINT usuarios_pk PRIMARY KEY ( id );

ALTER TABLE direccion
    ADD CONSTRAINT direccion_usuarios_fk FOREIGN KEY ( id_usuario )
        REFERENCES usuarios ( id );

ALTER TABLE pedidos
    ADD CONSTRAINT pedido_usuarios_fk FOREIGN KEY ( id_cliente )
        REFERENCES usuarios ( id );

ALTER TABLE pedidos
    ADD CONSTRAINT pedido_usuarios_fkv2 FOREIGN KEY ( id_repartidor )
        REFERENCES usuarios ( id );

ALTER TABLE pedidos_productos
    ADD CONSTRAINT pedidos_productos_pedido_fk FOREIGN KEY ( id_pedido )
        REFERENCES pedidos ( id );

ALTER TABLE pedidos_productos
    ADD CONSTRAINT pedidos_productos_productos_fk FOREIGN KEY ( id_producto )
        REFERENCES productos ( id );

ALTER TABLE productos
    ADD CONSTRAINT productos_categorias_fk FOREIGN KEY ( id_categoria )
        REFERENCES categorias ( id );

ALTER TABLE roles_usuarios
    ADD CONSTRAINT roles_usuarios_roles_fk FOREIGN KEY ( id_rol )
        REFERENCES roles ( id );

ALTER TABLE roles_usuarios
    ADD CONSTRAINT roles_usuarios_usuarios_fk FOREIGN KEY ( id_usuario )
        REFERENCES usuarios ( id );

CREATE SEQUENCE categorias_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER categorias_id_trg BEFORE
    INSERT ON categorias
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := categorias_id_seq.nextval;
END;
/

CREATE SEQUENCE direccion_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER direccion_id_trg BEFORE
    INSERT ON direccion
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := direccion_id_seq.nextval;
END;
/

CREATE SEQUENCE pedidos_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER pedidos_id_trg BEFORE
    INSERT ON pedidos
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := pedidos_id_seq.nextval;
END;
/

CREATE SEQUENCE productos_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER productos_id_trg BEFORE
    INSERT ON productos
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := productos_id_seq.nextval;
END;
/

CREATE SEQUENCE roles_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER roles_id_trg BEFORE
    INSERT ON roles
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := roles_id_seq.nextval;
END;
/

CREATE SEQUENCE usuarios_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER usuarios_id_trg BEFORE
    INSERT ON usuarios
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := usuarios_id_seq.nextval;
END;
/



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             8
-- CREATE INDEX                             0
-- ALTER TABLE                             15
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           6
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          6
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
