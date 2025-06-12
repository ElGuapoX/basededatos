CREATE TABLE Cliente (
    id_cliente NUMBER PRIMARY KEY, 
    cedula VARCHAR2(12) NOT NULL,
    nombrea VARCHAR2(25) NOT NULL,
    nombreb VARCHAR2(25),
    apellidoa VARCHAR2(25) NOT NULL,
    apellidob VARCHAR2(25),
    sexo CHAR(1) CHECK (sexo IN ('M', 'F')),
    fecha_nacimiento DATE NOT NULL
);

CREATE TABLE tipo_prestamos_cliente (
    id_tipo_prestamo NUMBER PRIMARY KEY,
    id_cliente NUMBER NOT NULL,
    fecha_aprobado DATE NOT NULL,
    fecha_pago DATE NOT NULL,
    num_prestamos NUMBER NOT NULL,
    monto_aprobado NUMBER(15,2) NOT NULL,
    letra_mensual NUMBER(15,2) NOT NULL,
    saldo_actual NUMBER(15,2) NOT NULL,
    monto_pagado NUMBER(15,2) NOT NULL,
    tasa_interest_r NUMBER(5,2) NOT NULL,
    CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE tipo_prestamos (
    id_tipo_prestamo NUMBER PRIMARY KEY, 
    nombre_prestamo VARCHAR2(50) NOT NULL,
    tasa_interest_b NUMBER(5,2) NOT NULL
);

CREATE TABLE telefono (
    id_telefono NUMBER PRIMARY KEY, 
    numero VARCHAR2(15) NOT NULL
);

CREATE TABLE tipo_telefono (
    id_tipo_telefono NUMBER PRIMARY KEY, 
    tipo VARCHAR2(20) NOT NULL
);

CREATE TABLE telefono_cliente (
    id_cliente NUMBER NOT NULL,
    id_telefono NUMBER NOT NULL,
    id_tipo_telefono NUMBER NOT NULL,
    CONSTRAINT pk_telefono_cliente PRIMARY KEY (id_cliente, id_telefono),
    CONSTRAINT fk_cliente_telefono FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_telefono FOREIGN KEY (id_telefono) REFERENCES telefono(id_telefono),
    CONSTRAINT fk_tipo_telefono FOREIGN KEY (id_tipo_telefono) REFERENCES tipo_telefono(id_tipo_telefono)
);

CREATE TABLE profesion (
    id_profesion NUMBER PRIMARY KEY, 
    nombre_profesion VARCHAR2(50) NOT NULL
);

CREATE TABLE profesion_cliente (
    id_cliente NUMBER NOT NULL,
    id_profesion NUMBER NOT NULL,
    CONSTRAINT pk_profesion_cliente PRIMARY KEY (id_cliente, id_profesion),
    CONSTRAINT fk_cliente_profesion FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_profesion FOREIGN KEY (id_profesion) REFERENCES profesion(id_profesion)
);

CREATE TABLE email (
    id_email NUMBER PRIMARY KEY, 
    email VARCHAR2(100) NOT NULL
);

CREATE TABLE tipo_email (
    id_tipo_email NUMBER PRIMARY KEY, 
    tipo VARCHAR2(20) NOT NULL
);

CREATE TABLE email_cliente (
    id_cliente NUMBER NOT NULL,
    id_email NUMBER NOT NULL,
    id_tipo_email NUMBER NOT NULL,
    CONSTRAINT pk_email_cliente PRIMARY KEY (id_cliente, id_email),
    CONSTRAINT fk_cliente_email FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_email FOREIGN KEY (id_email) REFERENCES email(id_email),
    CONSTRAINT fk_tipo_email FOREIGN KEY (id_tipo_email) REFERENCES tipo_email(id_tipo_email)
);