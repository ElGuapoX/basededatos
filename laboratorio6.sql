CREATE TABLE colaboradores (
    id_colaborador NUMBER PRIMARY KEY,
    nombre VARCHAR2(25),
    apellido VARCHAR2(25),
    cedula VARCHAR2(12),
    sexo CHAR(1),
    fecha_nacimiento DATE,
    fecha_ingreso DATE,
    status CHAR(1),
    salario_mensual NUMBER(15,2)
);

CREATE TABLE salario_quincenal (
    id_salario NUMBER PRIMARY KEY,
    id_codcolaborador NUMBER, 
    fecha_pago DATE, 
    salario_quincenal NUMBER(15,2),
    seguro_social NUMBER(15,2),
    seguro_educativo NUMBER(15,2),
    salario_neto NUMBER(15,2),
    CONSTRAINT fk_colaborador FOREIGN KEY (id_codcolaborador) REFERENCES colaboradores(id_colaborador)
);

--La fecha de pago son los 15 y 30 de cada mes
--Los colaboradores que cuentan con un status (A=Activo, R=Retirado, V=Vacaciones) 
--Las quincenas solo son pagadas a los colaboradres activos (con status A)

--INSERCION DE DATOS

-- Secuencia para autoincrementar el id_colaborador

CREATE SEQUENCE seq_colaborador
    START WITH 1
    INCREMENT BY 1
    NOCACHE;


CREATE SEQUENCE salario_quincenal_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

--Funcion para insertar un colaborador

CREATE OR REPLACE PROCEDURE insertar_colaborador (
    p_nombre           colaboradores.nombre%TYPE,
    p_apellido         colaboradores.apellido%TYPE,
    p_cedula           colaboradores.cedula%TYPE,
    p_sexo             colaboradores.sexo%TYPE,
    p_fecha_nacimiento colaboradores.fecha_nacimiento%TYPE,
    p_fecha_ingreso    colaboradores.fecha_ingreso%TYPE,
    p_status           colaboradores.status%TYPE,
    p_salario_mensual  colaboradores.salario_mensual%TYPE
) AS
BEGIN
    INSERT INTO colaboradores (
        id_colaborador, nombre, apellido, cedula, sexo, fecha_nacimiento, fecha_ingreso, status, salario_mensual
    ) VALUES (
        seq_colaborador.NEXTVAL, p_nombre, p_apellido, p_cedula, p_sexo, p_fecha_nacimiento, p_fecha_ingreso, p_status, p_salario_mensual
    );

    COMMIT;

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'Error al insertar colaborador: ' || SQLERRM);
END insertar_colaborador;
/

--Funcion para calculo de 


--insercion de colaboradores
--Activos 

EXEC insertar_colaborador('Ana', 'Martinez', '2233445566', 'F', TO_DATE('1995-04-04', 'YYYY-MM-DD'), TO_DATE('2022-04-01', 'YYYY-MM-DD'),'A', 4000);
EXEC insertar_colaborador('Luis', 'Gomez', '1122334455', 'M', TO_DATE('1988-08-15', 'YYYY-MM-DD'), TO_DATE('2020-01-10', 'YYYY-MM-DD'),'A', 5000);
EXEC insertar_colaborador('Maria', 'Lopez', '9988776655', 'F', TO_DATE('1990-12-20', 'YYYY-MM-DD'), TO_DATE('2021-06-15', 'YYYY-MM-DD'),'A', 4500);
EXEC insertar_colaborador('Pedro', 'Ramirez', '4455667788', 'M', TO_DATE('1993-01-25', 'YYYY-MM-DD'), TO_DATE('2023-02-20', 'YYYY-MM-DD'),'A', 4200);
EXEC insertar_colaborador('Laura', 'Diaz', '3322110099', 'F', TO_DATE('1998-07-11', 'YYYY-MM-DD'), TO_DATE('2023-09-01', 'YYYY-MM-DD'),'A', 3800);
EXEC insertar_colaborador('Jorge', 'Sanchez', '7788990011', 'M', TO_DATE('1987-05-09', 'YYYY-MM-DD'), TO_DATE('2019-03-18', 'YYYY-MM-DD'),'A', 5200);
EXEC insertar_colaborador('Sofia', 'Ruiz', '6655443322', 'F', TO_DATE('1996-02-28', 'YYYY-MM-DD'), TO_DATE('2022-11-10', 'YYYY-MM-DD'),'A', 4100);

--Retirados

EXEC insertar_colaborador('Carlos', 'Perez', '5566778899', 'M', TO_DATE('1985-03-30', 'YYYY-MM-DD'), TO_DATE('2019-11-05', 'YYYY-MM-DD'),'R', 6000);
EXEC insertar_colaborador('Elena', 'Torres', '1234567890', 'F', TO_DATE('1979-09-10', 'YYYY-MM-DD'), TO_DATE('2015-07-22', 'YYYY-MM-DD'),'R', 5500);

--Vacaciones 

EXEC insertar_colaborador('Roberto', 'Flores', '0011223344', 'M', TO_DATE('1991-11-01', 'YYYY-MM-DD'), TO_DATE('2021-05-01', 'YYYY-MM-DD'),'V', 4700);



--Funciones de calculo

CREATE OR REPLACE FUNCTION cal_salario_quincenal (
    p_salario_mensual NUMBER
) RETURN NUMBER IS 
BEGIN
    RETURN p_salario_mensual / 2;
END;
/

CREATE OR REPLACE FUNCTION cal_seguro_social (
    p_salario_quincenal NUMBER
) RETURN NUMBER IS
BEGIN
    RETURN p_salario_quincenal * 0.0975; -- 9.75% del salario quincenal
END;
/

CREATE OR REPLACE FUNCTION cal_seguro_educativo (
    p_salario_quincenal NUMBER
) RETURN NUMBER IS
BEGIN
    RETURN p_salario_quincenal * 0.125; -- 12.5% del salario quincenal
END;
/

CREATE OR REPLACE FUNCTION cal_salario_neto (
    p_salario_quincenal NUMBER,
    p_seguro_social NUMBER,
    p_seguro_educativo NUMBER
) RETURN NUMBER IS
BEGIN
    RETURN p_salario_quincenal - (p_seguro_social + p_seguro_educativo);
END;
/


--Paga del salario

CREATE OR REPLACE PROCEDURE pagar_salario_quincenal(p_status IN CHAR)
IS
    CURSOR c_colaboradores IS
        SELECT id_colaborador, salario_mensual
        FROM colaboradores
        WHERE status = p_status;

    v_id_colaborador     colaboradores.id_colaborador%TYPE;
    v_salario_mensual    colaboradores.salario_mensual%TYPE;
    v_salario_quincenal  salario_quincenal.salario_quincenal%TYPE;
    v_seguro_social      salario_quincenal.seguro_social%TYPE;
    v_seguro_educativo   salario_quincenal.seguro_educativo%TYPE;
    v_salario_neto       salario_quincenal.salario_neto%TYPE;
    v_fecha_pago         DATE;
BEGIN
    OPEN c_colaboradores;
    LOOP
        FETCH c_colaboradores INTO v_id_colaborador, v_salario_mensual;
        EXIT WHEN c_colaboradores%NOTFOUND;

        v_salario_quincenal := cal_salario_quincenal(v_salario_mensual);
        v_seguro_social     := cal_seguro_social(v_salario_quincenal);
        v_seguro_educativo  := cal_seguro_educativo(v_salario_quincenal);
        v_salario_neto      := cal_salario_neto(v_salario_quincenal, v_seguro_social, v_seguro_educativo);

        IF TO_CHAR(SYSDATE, 'DD') <= 15 THEN
            v_fecha_pago := TO_DATE('15' || TO_CHAR(SYSDATE, '/MM/YYYY'), 'DD/MM/YYYY');
        ELSE
            v_fecha_pago := LAST_DAY(SYSDATE); 
        END IF;

        BEGIN
            INSERT INTO salario_quincenal (
                id_salario,
                id_codcolaborador,
                fecha_pago,
                salario_quincenal,
                seguro_social,
                seguro_educativo,
                salario_neto
            ) VALUES (
                salario_quincenal_seq.NEXTVAL,
                v_id_colaborador,
                v_fecha_pago,
                v_salario_quincenal,
                v_seguro_social,
                v_seguro_educativo,
                v_salario_neto
            );
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                DBMS_OUTPUT.PUT_LINE('**Error**: Llave duplicada para el colaborador ' || v_id_colaborador || '. Salario para esta quincena ya registrado.');
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error al procesar colaborador ' || v_id_colaborador || ': ' || SQLERRM);
        END;
    END LOOP;
    CLOSE c_colaboradores;
    COMMIT;
END;
/

--Pagar salarios quincenales a colaboradores activos, retirados y en vacaciones (Con el codigo corregido WHERE status = p_status)
--EXEC pagar_salario_quincenal;

--Pagar salarios quincenales a colaboradores activos
EXEC pagar_salario_quincenal('A');


--Creacion de la vista

 CREATE OR REPLACE VIEW Vista_Salario AS
 SELECT
 c.id_colaborador AS ID,
 c.nombre AS Nombre,
 c.apellido AS Apellido,
 c.salario_mensual AS Salario_Mensual,
 s.salario_quincenal AS Salario_Quincenal,
 s.seguro_social AS Seguro_Social,
 s.seguro_educativo AS Seguro_Educativo,
 s.salario_neto AS Salario_Neto
 FROM
 colaboradores c
 JOIN
 salario_quincenal s ON c.id_colaborador = s.id_codcolaborador;