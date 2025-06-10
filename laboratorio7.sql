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