--Primer PARTE

-- Tabla Profesion
CREATE TABLE Profesion (
ID_Profesion NUMBER PRIMARY KEY,
Profesion VARCHAR2(100) NOT NULL
);

-- Tabla Cliente
CREATE TABLE Cliente (
ID_Cliente NUMBER PRIMARY KEY,
Cedula VARCHAR2(20) NOT NULL,
Nombre VARCHAR2(20) NOT NULL,
NombreA VARCHAR2(20),
Apellido VARCHAR2(20) NOT NULL,
ApellidoA VARCHAR2(20),
Sexo CHAR(1) NOT NULL,
Fecha_Nacimiento DATE NOT NULL,
ID_Profesion NUMBER,
FOREIGN KEY (ID_Profesion) REFERENCES Profesion(ID_Profesion)
);

-- Tabla Tipo_Email
CREATE TABLE Tipo_Email (
ID_Email NUMBER PRIMARY KEY,
Tipo_Email VARCHAR2(50) NOT NULL
);

-- Tabla Email_Cliente
CREATE TABLE Email_Cliente (
ID_Cliente NUMBER,
ID_Email NUMBER,
Email VARCHAR2(100) NOT NULL,
PRIMARY KEY (ID_Cliente, ID_Email),
FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente),
FOREIGN KEY (ID_Email) REFERENCES Tipo_Email(ID_Email)
);

-- Tabla Tipo_Tel
CREATE TABLE Tipo_Tel (
ID_Telefono NUMBER PRIMARY KEY,
Tipo_Telefono VARCHAR2(50) NOT NULL
);

-- Tabla Tel_Cliente
CREATE TABLE Tel_Cliente (
ID_Cliente NUMBER,
ID_Telefono NUMBER,
Telefono VARCHAR2(20) NOT NULL,
PRIMARY KEY (ID_Cliente, ID_Telefono),
FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente),
FOREIGN KEY (ID_Telefono) REFERENCES Tipo_Tel(ID_Telefono)
);

-- Tabla Tipo_Prestamo
CREATE TABLE Tipo_Prestamo (
ID_Prestamo NUMBER PRIMARY KEY,
Tipo_Prestamo VARCHAR2(50) NOT NULL,
Tasa_Interes_Prom NUMBER(5, 2) NOT NULL
);

-- Tabla Prestamo
CREATE TABLE Prestamo (
ID_Cliente NUMBER,
ID_Prestamo NUMBER,
Numero_Prestamo NUMBER,
Fecha_Aprobado DATE NOT NULL,
Monto_Aprobado NUMBER(12, 2) NOT NULL,
Tasa_Interes NUMBER(5, 2) NOT NULL,
Letra_Mensual NUMBER(12, 2) NOT NULL,
Monto_Pagado NUMBER(12, 2),
Fecha_Pago DATE,
PRIMARY KEY (ID_Cliente, ID_Prestamo),
FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente),
FOREIGN KEY (ID_Prestamo) REFERENCES Tipo_Prestamo(ID_Prestamo)
);

--Segunda PARTE

CREATE TABLE SUCURSAL (
    cod_sucursal NUMBER (3) PRIMARY KEY,
    nombresurcursal VARCHAR2(20) NOT NULL,
    Tipo_Prestamo VARCHAR2(20) NOT NULL,
    monto_prestamos NUMBER(12, 2) NOT NULL
);

ALTER TABLE Cliente ADD (
    edad NUMBER(3) NOT NULL,
    cod_sucursal NUMBER (3) NOT NULL,
    CONSTRAINT fk_cliente_cod_sucursal FOREIGN KEY (cod_sucursal) REFERENCES SUCURSAL(cod_sucursal)
);

ALTER TABLE Prestamo ADD (
    cod_sucursal NUMBER (3) NOT NULL,
    interes_pagado NUMBER(12, 2) NOT NULL,
    saldo_actual NUMBER(12, 2) NOT NULL,
    fecha_modificacion DATE NOT NULL,
    usuario VARCHAR2(20) NOT NULL,
    CONSTRAINT fk_prestamo_cod_sucursal FOREIGN KEY (cod_sucursal) REFERENCES SUCURSAL(cod_sucursal)
);

CREATE TABLE transaccion (
    cod_sucursal NUMBER (3) NOT NULL,
    id_transaccion NUMBER (10) PRIMARY KEY,
    id_cliente NUMBER (10) NOT NULL,
    Tipo_Prestamo VARCHAR2(20) NOT NULL,
    fecha_transaccion DATE NOT NULL,
    monto_pago NUMBER(12, 2) NOT NULL,
    fechainsercion DATE NOT NULL,
    usuario VARCHAR2(20) NOT NULL,
    FOREIGN KEY (cod_sucursal) REFERENCES SUCURSAL(cod_sucursal),
    FOREIGN KEY (Tipo_Prestamo) REFERENCES Tipo_Prestamo(Tipo_Prestamo)
    FOREIGN KEY (id_cliente) REFERENCES Cliente(ID_Cliente)
);

--Creacion de secuecias

CREATE SEQUENCE 