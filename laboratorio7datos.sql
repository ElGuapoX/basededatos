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