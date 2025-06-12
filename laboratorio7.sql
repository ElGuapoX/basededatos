-- Tabla Profesion
CREATE TABLE Profesion (
ID_Profesion INT PRIMARY KEY,
Profesion VARCHAR2(100) NOT NULL
);

-- Tabla Cliente
CREATE TABLE Cliente (
ID_Cliente INT PRIMARY KEY,
Cedula VARCHAR2(20) NOT NULL,
Nombre VARCHAR2(20) NOT NULL,
NombreA VARCHAR2(20),
Apellido VARCHAR2(20) NOT NULL,
ApellidoA VARCHAR2(20),
Sexo CHAR(1) NOT NULL,
Fecha_Nacimiento DATE NOT NULL,
ID_Profesion INT,
FOREIGN KEY (ID_Profesion) REFERENCES Profesion(ID_Profesion)
);

-- Tabla Tipo_Email
CREATE TABLE Tipo_Email (
ID_Email INT PRIMARY KEY,
Tipo_Email VARCHAR2(50) NOT NULL
);

-- Tabla Email_Cliente
CREATE TABLE Email_Cliente (
ID_Cliente INT,
ID_Email INT,
Email VARCHAR2(100) NOT NULL,
PRIMARY KEY (ID_Cliente, ID_Email),
FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente),
FOREIGN KEY (ID_Email) REFERENCES Tipo_Email(ID_Email)
);

-- Tabla Tipo_Tel
CREATE TABLE Tipo_Tel (
ID_Telefono INT PRIMARY KEY,
Tipo_Telefono VARCHAR2(50) NOT NULL
);

-- Tabla Tel_Cliente
CREATE TABLE Tel_Cliente (
ID_Cliente INT,
ID_Telefono INT,
Telefono VARCHAR2(20) NOT NULL,
PRIMARY KEY (ID_Cliente, ID_Telefono),
FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente),
FOREIGN KEY (ID_Telefono) REFERENCES Tipo_Tel(ID_Telefono)
);

-- Tabla Tipo_Prestamo
CREATE TABLE Tipo_Prestamo (
ID_Prestamo INT PRIMARY KEY,
Tipo_Prestamo VARCHAR2(50) NOT NULL,
Tasa_Interes_Prom NUMBER(5, 2) NOT NULL
);

-- Tabla Prestamo
CREATE TABLE Prestamo (
ID_Cliente INT,
ID_Prestamo INT,
Numero_Prestamo INT,
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