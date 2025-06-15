--Primer PARTE

--Creacion de secuecias

CREATE SEQUENCE seq_id_tipo_email
START WITH 1
INCREMENT BY 1
NOMAXVALUE
MINVALUE 1
NOCYCLE;

CREATE SEQUENCE seq_id_tipo_telefono
START WITH 1
INCREMENT BY 1
NOMAXVALUE
MINVALUE 1
NOCYCLE;

CREATE SEQUENCE seq_id_cliente
START WITH 1
INCREMENT BY 1
NOMAXVALUE
MINVALUE 1
NOCYCLE;

CREATE SEQUENCE seq_id_profesion
START WITH 1
INCREMENT BY 1
NOMAXVALUE
MINVALUE 1
NOCYCLE;

CREATE SEQUENCE seq_id_email
START WITH 1
INCREMENT BY 1
NOMAXVALUE
MINVALUE 1
NOCYCLE;

CREATE SEQUENCE seq_id_telefono
START WITH 1
INCREMENT BY 1
NOMAXVALUE
MINVALUE 1
NOCYCLE;

CREATE SEQUENCE seq_id_prestamo
START WITH 1
INCREMENT BY 1
NOMAXVALUE
MINVALUE 1
NOCYCLE;

CREATE SEQUENCE seq_id_prestamo_p
START WITH 1
INCREMENT BY 1
NOMAXVALUE
MINVALUE 1
NOCYCLE;

CREATE SEQUENCE seq_id_transaccion
START WITH 1
INCREMENT BY 1
NOMAXVALUE
MINVALUE 1
NOCYCLE;

CREATE SEQUENCE seq_cod_sucursal
START WITH 1
INCREMENT BY 1
NOMAXVALUE
MINVALUE 1
NOCYCLE;

-- Tabla Profesion
CREATE TABLE Profesion (
ID_Profesion NUMBER PRIMARY KEY,
Profesion VARCHAR2(20) NOT NULL
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

-- Tabla Tipo_Telefono
CREATE TABLE Tipo_Telefono (
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
FOREIGN KEY (ID_Telefono) REFERENCES Tipo_Telefono(ID_Telefono)
);

-- Tabla Tipo_Prestamo
CREATE TABLE Tipo_Prestamo (
ID_Prestamo NUMBER PRIMARY KEY,
Tipo_Prestamo VARCHAR2(50) NOT NULL,
Tasa_Interes_Prom NUMBER(5, 2) NOT NULL
);

-- Tabla Prestamo
CREATE TABLE Prestamo (
ID_prestamo_p NUMBER PRIMARY KEY,
ID_Cliente NUMBER,
ID_Prestamo NUMBER,
Numero_Prestamo NUMBER,
Fecha_Aprobado DATE NOT NULL,
Monto_Aprobado NUMBER(12, 2) NOT NULL,
Tasa_Interes NUMBER(5, 2) NOT NULL,
Letra_Mensual NUMBER(12, 2) NOT NULL,
Monto_Pagado NUMBER(12, 2),
Fecha_Pago DATE,
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
    id_transaccion NUMBER (10) PRIMARY KEY,
    cod_sucursal NUMBER (3) NOT NULL,
    id_cliente NUMBER (10) NOT NULL,
    ID_Prestamo NUMBER NOT NULL,
    fecha_transaccion DATE NOT NULL,
    monto_pago NUMBER(12, 2) NOT NULL,
    fechainsercion DATE NOT NULL,
    usuario VARCHAR2(20) NOT NULL,
    FOREIGN KEY (cod_sucursal) REFERENCES SUCURSAL(cod_sucursal),
    FOREIGN KEY (ID_Prestamo) REFERENCES  Tipo_Prestamo(ID_Prestamo),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(ID_Cliente)
);

-- Procedimientos

CREATE OR REPLACE PROCEDURE insertar_tipo_telefono ( p_tipo_telefono IN VARCHAR2) AS
    v_id_telefono NUMBER;
BEGIN
    v_id_telefono := seq_id_tipo_telefono.NEXTVAL;
    INSERT INTO Tipo_Telefono (ID_Telefono, Tipo_Telefono) VALUES (v_id_telefono, p_tipo_telefono);
END insertar_tipo_telefono;
/

CREATE OR REPLACE PROCEDURE insertar_tipo_email ( p_tipo_email IN VARCHAR2) AS
    v_id_email NUMBER;
BEGIN
    v_id_email := seq_id_email.NEXTVAL;
    INSERT INTO Tipo_Email (ID_Email, Tipo_Email) VALUES (v_id_email, p_tipo_email);
END insertar_tipo_email;
/

CREATE OR REPLACE PROCEDURE insertar_profesion (p_profesion IN VARCHAR2) AS
    v_id_profesion NUMBER;
BEGIN
    v_id_profesion := seq_id_profesion.NEXTVAL;
    INSERT INTO Profesion (ID_Profesion, Profesion) VALUES (v_id_profesion, p_profesion);
END insertar_profesion;
/

CREATE OR REPLACE PROCEDURE insertar_sucursal (
    p_nombresucursal IN VARCHAR2,
    p_tipo_prestamo IN VARCHAR2,
    p_monto_prestamos IN NUMBER
) AS
    v_cod_sucursal NUMBER;
BEGIN
    v_cod_sucursal := seq_cod_sucursal.NEXTVAL; 
    INSERT INTO SUCURSAL (cod_sucursal, nombresurcursal, Tipo_Prestamo, monto_prestamos)
    VALUES (v_cod_sucursal, p_nombresucursal, p_tipo_prestamo, p_monto_prestamos);
END insertar_sucursal;
/

CREATE OR REPLACE PROCEDURE insertar_tipo_prestamo (
    p_tipo_prestamo IN VARCHAR2,
    p_tasa_interes_prom IN NUMBER
) AS
    v_id_prestamo NUMBER;
BEGIN
    v_id_prestamo := seq_id_prestamo.NEXTVAL;
    INSERT INTO Tipo_Prestamo (ID_Prestamo, Tipo_Prestamo, Tasa_Interes_Prom)
    VALUES (v_id_prestamo, p_tipo_prestamo, p_tasa_interes_prom);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error en insertar_tipo_prestamo: ' || SQLERRM);
END insertar_tipo_prestamo;
/

--Funcion para calcular la edad
CREATE OR REPLACE FUNCTION calcular_edad (p_fecha_nacimiento IN DATE) RETURN NUMBER AS
    v_edad NUMBER;
BEGIN
    v_edad := TRUNC(MONTHS_BETWEEN(SYSDATE, p_fecha_nacimiento) / 12);
    RETURN v_edad;
END calcular_edad;
/

---------------------------------------------------------------------------

--Procedimiento para insertar cliente
CREATE OR REPLACE PROCEDURE insertar_cliente (
    p_cedula IN VARCHAR2,
    p_nombre IN VARCHAR2,
    p_nombreA IN VARCHAR2,
    p_apellido IN VARCHAR2,
    p_apellidoA IN VARCHAR2,
    p_sexo IN CHAR,
    p_fecha_nacimiento IN DATE,
    p_id_profesion IN NUMBER,
    p_cod_sucursal IN NUMBER,
    p_id_email IN NUMBER,
    p_email IN VARCHAR2,
    p_id_telefono IN NUMBER,
    p_telefono IN VARCHAR2
) AS
    v_id_cliente NUMBER;
    v_edad NUMBER;
BEGIN
    v_id_cliente := seq_id_cliente.NEXTVAL;
    v_edad := calcular_edad(p_fecha_nacimiento);

    INSERT INTO Cliente (
        ID_Cliente, Cedula, Nombre, NombreA, Apellido, ApellidoA, Sexo, Fecha_Nacimiento, ID_Profesion, Edad, COD_SUCURSAL
    ) VALUES (
        v_id_cliente, p_cedula, p_nombre, p_nombreA, p_apellido, p_apellidoA, p_sexo, p_fecha_nacimiento, p_id_profesion, v_edad, p_cod_sucursal
    );

    INSERT INTO Email_Cliente (ID_Cliente, ID_Email, Email)
    VALUES (v_id_cliente, p_id_email, p_email);

    INSERT INTO Tel_Cliente (ID_Cliente, ID_Telefono, Telefono)
    VALUES (v_id_cliente, p_id_telefono, p_telefono);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error en insertar_cliente: ' || SQLERRM);
END insertar_cliente;
/

--Proceimiento para insertar prestamos
CREATE OR REPLACE PROCEDURE insertar_prestamo (
    p_id_cliente      IN NUMBER,
    p_id_prestamo    IN NUMBER,
    p_numero_prestamo IN NUMBER,
    p_fecha_aprobado  IN DATE,
    p_monto_aprobado  IN NUMBER,
    p_tasa_interes    IN NUMBER,
    p_letra_mensual   IN NUMBER,
    p_cod_sucursal    IN NUMBER,
    p_usuario         IN VARCHAR2
) AS
    v_id_prestamo_p NUMBER;
BEGIN
    v_id_prestamo_p := seq_id_prestamo_p.NEXTVAL;

    INSERT INTO Prestamo (
        ID_PRESTAMO_P, ID_CLIENTE, ID_PRESTAMO, NUMERO_PRESTAMO, FECHA_APROBADO, MONTO_APROBADO,
        TASA_INTERES, LETRA_MENSUAL, MONTO_PAGADO, FECHA_PAGO, COD_SUCURSAL,
        INTERES_PAGADO, SALDO_ACTUAL, FECHA_MODIFICACION, USUARIO
    ) VALUES (
        v_id_prestamo_p, p_id_cliente, p_id_prestamo, p_numero_prestamo, p_fecha_aprobado, p_monto_aprobado,
        p_tasa_interes, p_letra_mensual, 0, NULL, p_cod_sucursal,
        0, p_monto_aprobado, SYSDATE, p_usuario
    );

    UPDATE SUCURSAL
       SET MONTO_PRESTAMOS = MONTO_PRESTAMOS + p_monto_aprobado
     WHERE COD_SUCURSAL = p_cod_sucursal;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error en insertar_prestamo: ' || SQLERRM);
END insertar_prestamo;
/

--Procedimiento para insertar pagos
CREATE OR REPLACE PROCEDURE insertar_pago (
    p_cod_sucursal IN NUMBER,
    p_id_cliente IN NUMBER,
    p_id_prestamo IN NUMBER,
    p_fecha_transaccion IN DATE,
    p_monto_pago IN NUMBER,
    p_usuario IN VARCHAR2
)  AS
    v_id_transaccion NUMBER;
BEGIN
    v_id_transaccion := seq_id_transaccion.NEXTVAL;
    INSERT INTO transaccion (
        cod_sucursal, id_transaccion, id_cliente, ID_Prestamo, fecha_transaccion, monto_pago, fechainsercion, usuario
    ) VALUES (
        p_cod_sucursal, v_id_transaccion, p_id_cliente, p_id_prestamo, p_fecha_transaccion, p_monto_pago, SYSDATE, p_usuario
    );
END insertar_pago;
/

--Funcion para calcular los intereses
CREATE OR REPLACE FUNCTION calcular_interes(
    saldo_actual IN NUMBER,
    tasa_interes IN NUMBER
) RETURN NUMBER AS
    v_interes NUMBER;
BEGIN
    v_interes := saldo_actual * (tasa_interes / 100);
    RETURN v_interes;
END calcular_interes;
/

--Procedimiento para actualizar prestamos con pagos 
CREATE OR REPLACE PROCEDURE actualizar_pagos IS
    CURSOR c_pagos IS
        SELECT cod_sucursal, id_cliente, id_prestamo, monto_pago, usuario
        FROM transaccion
        WHERE fechainsercion > (
            SELECT NVL(MAX(fecha_modificacion), TO_DATE('01/01/1900','DD/MM/YYYY'))
            FROM prestamo
            WHERE id_cliente = transaccion.id_cliente
              AND id_prestamo = transaccion.id_prestamo
        );
    v_saldo_actual   NUMBER;
    v_tasa_interes   NUMBER;
    v_interes        NUMBER;
    v_monto_pagado   NUMBER;
BEGIN
    FOR r_pago IN c_pagos LOOP
        -- Obtener el saldo actual y la tasa de interés del préstamo
        SELECT SALDO_ACTUAL, TASA_INTERES, MONTO_PAGADO INTO v_saldo_actual, v_tasa_interes, v_monto_pagado
        FROM prestamo
        WHERE ID_CLIENTE = r_pago.ID_CLIENTE
          AND ID_PRESTAMO = r_pago.ID_PRESTAMO;

        -- Validar que el pago no sea mayor al saldo
        IF r_pago.MONTO_PAGO > v_saldo_actual THEN
            -- Opcional: puedes lanzar un error o ajustar el pago al saldo
            CONTINUE;
        END IF;

        -- Calcular el interés
        v_interes := calcular_interes(v_saldo_actual, v_tasa_interes);

        -- Actualizar el préstamo
        UPDATE prestamo
           SET SALDO_ACTUAL = SALDO_ACTUAL - (r_pago.MONTO_PAGO - v_interes),
               INTERES_PAGADO = INTERES_PAGADO + v_interes,
               MONTO_PAGADO = MONTO_PAGADO + r_pago.MONTO_PAGO,
               FECHA_PAGO = SYSDATE,
               FECHA_MODIFICACION = SYSDATE,
               USUARIO = r_pago.USUARIO
         WHERE ID_CLIENTE = r_pago.ID_CLIENTE
           AND ID_PRESTAMO = r_pago.ID_PRESTAMO;

        -- Actualizar la sucursal
        UPDATE sucursal
           SET MONTO_PRESTAMOS = MONTO_PRESTAMOS - (r_pago.MONTO_PAGO - v_interes)
         WHERE COD_SUCURSAL = r_pago.COD_SUCURSAL;
    END LOOP;
END;
/
