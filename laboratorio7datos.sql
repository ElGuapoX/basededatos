-- Insertar profesiones
INSERT INTO Profesion (ID_Profesion, Profesion) VALUES (1, 'Ingeniero');
INSERT INTO Profesion (ID_Profesion, Profesion) VALUES (2, 'Doctor');
INSERT INTO Profesion (ID_Profesion, Profesion) VALUES (3, 'Abogado');

-- Insertar clientes
INSERT INTO Cliente (ID_Cliente, Cedula, Nombre, NombreA, Apellido, ApellidoA, Sexo, Fecha_Nacimiento, ID_Profesion)
VALUES (1, '001-0000001-1', 'Juan', 'Carlos', 'Pérez', 'Gómez', 'M', TO_DATE('1990-01-01','YYYY-MM-DD'), 1);
INSERT INTO Cliente (ID_Cliente, Cedula, Nombre, NombreA, Apellido, ApellidoA, Sexo, Fecha_Nacimiento, ID_Profesion)
VALUES (2, '001-0000002-2', 'Ana', NULL, 'Martínez', NULL, 'F', TO_DATE('1985-05-15','YYYY-MM-DD'), 2);

-- Insertar tipos de email
INSERT INTO Tipo_Email (ID_Email, Tipo_Email) VALUES (1, 'Personal');
INSERT INTO Tipo_Email (ID_Email, Tipo_Email) VALUES (2, 'Laboral');

-- Insertar emails de clientes
INSERT INTO Email_Cliente (ID_Cliente, ID_Email, Email) VALUES (1, 1, 'juan.perez@gmail.com');
INSERT INTO Email_Cliente (ID_Cliente, ID_Email, Email) VALUES (2, 2, 'ana.martinez@hospital.com');

-- Insertar tipos de teléfono
INSERT INTO Tipo_Tel (ID_Telefono, Tipo_Telefono) VALUES (1, 'Celular');
INSERT INTO Tipo_Tel (ID_Telefono, Tipo_Telefono) VALUES (2, 'Residencial');

-- Insertar teléfonos de clientes
INSERT INTO Tel_Cliente (ID_Cliente, ID_Telefono, Telefono) VALUES (1, 1, '8091234567');
INSERT INTO Tel_Cliente (ID_Cliente, ID_Telefono, Telefono) VALUES (2, 2, '8097654321');

-- Insertar tipos de préstamo
INSERT INTO Tipo_Prestamo (ID_Prestamo, Tipo_Prestamo, Tasa_Interes_Prom) VALUES (1, 'Personal', 8.5);
INSERT INTO Tipo_Prestamo (ID_Prestamo, Tipo_Prestamo, Tasa_Interes_Prom) VALUES (2, 'Auto', 7.5);

-- Insertar préstamos
INSERT INTO Prestamo (ID_Cliente, ID_Prestamo, Numero_Prestamo, Fecha_Aprobado, Monto_Aprobado, Tasa_Interes, Letra_Mensual, Monto_Pagado, Fecha_Pago)
VALUES (1, 1, 1001, TO_DATE('2024-01-10','YYYY-MM-DD'), 50000, 8.5, 1200, 12000, TO_DATE('2024-06-01','YYYY-MM-DD'));
INSERT INTO Prestamo (ID_Cliente, ID_Prestamo, Numero_Prestamo, Fecha_Aprobado, Monto_Aprobado, Tasa_Interes, Letra_Mensual, Monto_Pagado, Fecha_Pago)
VALUES (2, 2, 1002, TO_DATE('2024-02-15','YYYY-MM-DD'), 150000, 7.5, 3500, 35000, TO_DATE('2024-06-10','YYYY-MM-DD'));


-- =========================
-- 1. MERCADEO - PARAMETRIZACION DEL SISTEMA
-- =========================

-- CARGAR DATOS DE SUCURSALES
EXEC insertar_sucursal('Sucursal Central', 'Personal', 0);
EXEC insertar_sucursal('Sucursal Norte', 'Hipotecario', 0);

-- CARGAR DATOS DE TIPOS DE PRESTAMOS
EXEC insertar_tipo_prestamo('Personal', 12);
EXEC insertar_tipo_prestamo('Hipotecario', 8);

-- CARGAR DATOS TIPOS DE EMAIL
EXEC insertar_tipo_email('Personal');
EXEC insertar_tipo_email('Trabajo');

-- CARGAR DATOS TIPOS DE TELEFONOS
EXEC insertar_tipo_telefono('Celular');
EXEC insertar_tipo_telefono('Casa');

-- CARGAR DATOS DE CLASES DE PROFESIONES
EXEC insertar_profesion('Ingeniero');
EXEC insertar_profesion('Doctor');

-- =========================
-- 2. APROBACION DEL CLIENTE
-- =========================

-- CLIENTE 1
EXEC insertar_cliente('001-0000001-1', 'Juan', NULL, 'Perez', NULL, 'M', TO_DATE('1990-01-01','YYYY-MM-DD'), 1, 1,1, 'juan.perez@gmail.com', 1, '8091111111');

-- CLIENTE 2
EXEC insertar_cliente('001-0000002-2','Maria',NULL,'Gomez',NULL,'F',TO_DATE('1985-05-10','YYYY-MM-DD'),2,2,2,'maria.gomez@hotmail.com',2,'8092222222');

-- CLIENTE 3
EXEC insertar_cliente('001-0000003-3', 'Carlos', NULL, 'Lopez', NULL, 'M', TO_DATE('1978-11-23','YYYY-MM-DD'), 1, 1,1, 'carlos.lopez@empresa.com',2, '8093333333');

-----------------------------
--Llegue hasta aqui
-----------------------------

-- =========================
-- 3. APROBACION DEL PRODUCTO POR EL BANCO (PRESTAMOS)
-- =========================

-- PRESTAMO CLIENTE 1
EXEC insertar_prestamo(1, 1, 10001, TO_DATE('2024-06-01','YYYY-MM-DD'), 100000, 12, 2500, 1, 'admin');

-- PRESTAMO CLIENTE 2
EXEC insertar_prestamo(2, 2, 20001, TO_DATE('2024-06-02','YYYY-MM-DD'), 150000, 10, 3500, 2, 'admin');

-- PRESTAMO CLIENTE 3
EXEC insertar_prestamo(3, 3, 30001, TO_DATE('2024-06-03','YYYY-MM-DD'), 200000, 11, 4500, 1, 'admin');

-- =========================
-- 4. RECUPERACION DE LA CARTERA DE PRESTAMOS
-- =========================

-- a. CARGAR DATOS DE LOS PRESTAMOS PROPORCIONADOS POR EMPRESAS (TRANSACCIONES)
EXEC insertar_pago(1, 1, 1, TO_DATE('2024-06-10','YYYY-MM-DD'), 5000, 'admin');
EXEC insertar_pago(2, 2, 2, TO_DATE('2024-06-11','YYYY-MM-DD'), 7000, 'admin');
EXEC insertar_pago(1, 3, 3, TO_DATE('2024-06-12','YYYY-MM-DD'), 9000, 'admin');

-- b. VALIDAR LA SUBIDA DE ESTOS DATOS A LA TABLA DE TRANSACCIONES
-- (Consulta, no inserción)
SELECT * FROM transaccion;

-- c. APLICAR LOS PAGOS A LOS PRESTAMOS DESDE TRANSACCIONES
EXEC actualizar_pagos;

-- =========================
-- 5. VISTAS
-- =========================

-- Vista de clientes y sus préstamos
CREATE OR REPLACE VIEW v_clientes_prestamos AS
SELECT c.id_cliente, c.nombre, c.apellido, p.id_prestamo, p.monto_aprobado, p.saldo_actual
FROM cliente c
JOIN prestamo p ON c.id_cliente = p.id_cliente;

-- Vista de préstamos por sucursal
CREATE OR REPLACE VIEW v_prestamos_sucursal AS
SELECT s.nombresurcursal, COUNT(p.id_prestamo) AS cantidad_prestamos, SUM(p.monto_aprobado) AS total_prestado
FROM sucursal s
JOIN prestamo p ON s.cod_sucursal = p.cod_sucursal
GROUP BY s.nombresurcursal;

-- Vista de acumulado de préstamos por sucursal y tipo de préstamo
CREATE OR REPLACE VIEW v_sucursal_tipo_prestamo AS
SELECT s.cod_sucursal, s.nombresurcursal, s.tipo_prestamo, SUM(p.monto_aprobado) AS total_prestamos
FROM sucursal s
JOIN prestamo p ON s.cod_sucursal = p.cod_sucursal
GROUP BY s.cod_sucursal, s.nombresurcursal, s.tipo_prestamo;

-- Vista de pagos realizados por sucursal y tipo de préstamo
CREATE OR REPLACE VIEW v_pagos_sucursal_tipo AS
SELECT s.cod_sucursal, s.nombresurcursal, s.tipo_prestamo, SUM(t.monto_pago) AS total_pagado
FROM sucursal s
JOIN transaccion t ON s.cod_sucursal = t.cod_sucursal
GROUP BY s.cod_sucursal, s.nombresurcursal, s.tipo_prestamo;