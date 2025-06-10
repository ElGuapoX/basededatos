--Problema Pag 3

CREATE TABLE students (
	id NUMBER PRIMARY KEY,
	first_name VARCHAR2(20),
	last_name VARCHAR2(20),
	major VARCHAR2(20),
	current_credits NUMBER
);


CREATE SEQUENCE student_sequence
START WITH 1
INCREMENT BY 1
NOCACHE 
NOCYCLE;


CREATE OR REPLACE PROCEDURE AddNewStudent (
  p_FirstName students.first_name%TYPE,
  p_LastName students.last_name%TYPE,
  p_Major students.major%TYPE ) AS
BEGIN
  -- Inserta una nueva fila en la tabla students. Usa
  -- student_sequence para generar el nuevo ID del estudiante y
  -- asigna el valor 0 a current_credits.
  INSERT INTO students (ID, first_name, last_name , major, current_credits)
  VALUES ( student_sequence.NEXTVAL, p_FirstName, p_LastName, p_Major, 0 );
  COMMIT;
END AddNewStudent;
/

EXEC AddNewStudent('Adrian', 'Wong', 'Base de datos 2');

--EL student_sequence.next esta mal escrito, la forma correcta es student_sequence.nextval.
--Se agrego la creacion de la secuencia student_sequence para que el codigo compile sin error.
--


--Ejemplo Pag 4

CREATE TABLE students (
  id NUMBER PRIMARY KEY,
  first_name VARCHAR2(20),
  last_name VARCHAR2(20),
  major VARCHAR2(20),
  current_credits NUMBER
);

CREATE SEQUENCE student_sequence
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

CREATE OR REPLACE PROCEDURE AddNewStudent (
  p_FirstName students.first_name%TYPE,
  p_LastName students.last_name%TYPE,
  p_Major students.major%TYPE
) AS
BEGIN
  INSERT INTO students (id, first_name, last_name, major, current_credits)
  VALUES (student_sequence.NEXTVAL, p_FirstName, p_LastName, p_Major, 0);
  COMMIT;
END AddNewStudent;
/

EXEC AddNewStudent('Maria', 'Lopez', 'Matematicas');
EXEC AddNewStudent('Juan', 'Perez', 'Fisica');

--Se elimino p_StudentID ya que no se estaba utilizando en el procedimiento AddNewStudent.
--Se usa student_sequence.NEXTVAL en lugar de student_sequence.next para obtener el siguiente valor de la secuencia.


--Ejemplo Pag 6 se crea apartir del ejemplo pag 4

-- Crear la tabla students
CREATE TABLE students (
  id NUMBER PRIMARY KEY,
  first_name VARCHAR2(20),
  last_name VARCHAR2(20),
  major VARCHAR2(20),
  current_credits NUMBER
);

-- Crear la secuencia para los IDs de los estudiantes
CREATE SEQUENCE student_sequence
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

DECLARE
 -- Variables que describen al nuevo estudiante
v_NewFirstName students.first_name%TYPE := 'Margaret';
v_NewLastName students.last_name%TYPE := 'Mason';
v_NewMajor students.major%TYPE := 'History';
BEGIN
 -- Añade Margaret Mason a la Base de Datos
AddNewStudent (v_NewFirstName, v_NewLastName, v_NewMajor );
END;
/

--Se cambiaron las comillas ''

--Ejemplo Pag 10


CREATE OR REPLACE PROCEDURE ModeTest (
  p_InParameter     IN     NUMBER,
  p_OutParameter    OUT    NUMBER,
  p_InOutParameter  IN OUT NUMBER
) IS
  v_LocalVariable NUMBER;
BEGIN
  v_LocalVariable := p_InParameter;
  -- p_InParameter := 7; -- No tiene efecto, los parámetros IN no pueden ser modificados
  p_OutParameter := 7;
  v_LocalVariable := p_OutParameter;
  v_LocalVariable := p_InOutParameter;
  p_InOutParameter := 7;
END ModeTest;
/

DECLARE
  v_in     NUMBER := 5;    
  v_out    NUMBER;         
  v_inout  NUMBER;   
BEGIN
  ModeTest(v_in, v_out, v_inout);

  -- Imprime los valores después de la ejecución del procedimiento
  DBMS_OUTPUT.PUT_LINE('Valor final de v_in: ' || v_in);
  DBMS_OUTPUT.PUT_LINE('Valor final de v_out: ' || v_out);
  DBMS_OUTPUT.PUT_LINE('Valor final de v_inout: ' || v_inout);
END;
/


--Ejemplo Pag 9

-- Creación o reemplazo del procedimiento ModeTest
CREATE OR REPLACE PROCEDURE ModeTest (
    p_InParameter     IN     NUMBER,  -- Parámetro de solo entrada
    p_OutParameter    OUT    NUMBER,  -- Parámetro de solo salida
    p_InOutParameter  IN OUT NUMBER   -- Parámetro de entrada y salida
) IS
    -- Variable local para operaciones internas
    v_LocalValue NUMBER := 0;
BEGIN
    -- Asignación desde el parámetro de entrada (válido)
    v_LocalValue := p_InParameter;

    -- Asignar valor al parámetro de salida
    p_OutParameter := 7;

    -- Asignar y actualizar el parámetro de entrada/salida
    v_LocalValue := p_InOutParameter;
    p_InOutParameter := 7;
END ModeTest;
/

SET SERVEROUTPUT ON;

DECLARE
  v_in     NUMBER := 5;    
  v_out    NUMBER;         
  v_inout  NUMBER;   
BEGIN
  ModeTest(v_in, v_out, v_inout);

  -- Imprime los valores después de la ejecución del procedimiento
  DBMS_OUTPUT.PUT_LINE('Valor final de v_in: ' || v_in);
  DBMS_OUTPUT.PUT_LINE('Valor final de v_out: ' || v_out);
  DBMS_OUTPUT.PUT_LINE('Valor final de v_inout: ' || v_inout);
END;
/

SET SERVEROUTPUT ON;

DECLARE
  v_in     NUMBER := 5;   -- Valor inicial para el parámetro IN
  v_out    NUMBER;        -- Variable para el parámetro OUT
  v_inout  NUMBER := 10;  -- Valor inicial para el parámetro IN OUT
BEGIN
  ModeTest(v_in, v_out, v_inout);
END;
/


--Problema Pag 12

CREATE OR REPLACE PROCEDURE ParameterLength (
p_Parameter1 IN OUT VARCHAR2,
p_Parameter2 IN OUT NUMBER) AS
BEGIN
p_Parameter1 := 'abcdefghijklm';
p_Parameter2 := 12.3;
END ParameterLength;
/

SET SERVEROUTPUT ON;

--Prueba de la funcionalidad del codigo

DECLARE
  v_text VARCHAR2(50);
  v_num  NUMBER := 0;
BEGIN
  -- Llamada al procedimiento
  ParameterLength(v_text, v_num);

  -- Mostrar los nuevos valores de los parámetros
  DBMS_OUTPUT.PUT_LINE('Nuevo valor de v_text: ' || v_text);
  DBMS_OUTPUT.PUT_LINE('Nuevo valor de v_num : ' || v_num);
END;
/

--No se hicieron correcciones en el codigo

--Problema Pag 14

CREATE TABLE students (
	id NUMBER PRIMARY KEY,
	first_name VARCHAR2(20),
	last_name VARCHAR2(20),
	major VARCHAR2(20),
	current_credits NUMBER
);

--Tabla student_sequence, es lo que hace que el id suba 1.
CREATE SEQUENCE student_sequence START WITH 1 INCREMENT BY 1;


CREATE OR REPLACE PROCEDURE AddNewStudent (
p_FirstName students.first_name%TYPE ,
p_LastName students.last_name%TYPE ,
p_Major students.major%TYPE DEFAULT 'Economic') AS
BEGIN
-- Inserta una nueva fila en la tabla students. Usa student_sequence
-- para generar el nuevo valor ID del estudiante y asigna el valor 0
-- a current_credits
INSERT INTO students VALUES (student_sequence.nextval, p_FirstName, p_LastName, p_Major, 0);
END AddNewStudent ;
/
--Se agrego p_major al insert ya que no estaba, y esto causaba error al compilar.

EXEC AddNewStudent('Adrian', 'Wong');

--Ejemplo Pag 13

CREATE OR REPLACE PROCEDURE ParameterLength (
p_Parameter1 IN OUT VARCHAR2,
p_Parameter2 IN OUT NUMBER) AS
BEGIN
p_Parameter1 := 'abcdefghijklm';
p_Parameter2 := 12.3;
END ParameterLength;
/

--Insercion de datos 1
DECLARE
v_Variable1 VARCHAR2(40);
v_Variable2 NUMBER(5,2);
BEGIN
ParameterLength(v_Variable1, v_variable2);
  DBMS_OUTPUT.PUT_LINE('Nuevo valor Variable 1: ' || v_Variable1);
  DBMS_OUTPUT.PUT_LINE('Nuevo valor Variable 2 : ' || v_Variable2);
END;
/

--Insercion de datos 2

DECLARE
 v_Variable1 VARCHAR2(30);
 v_Variable2 NUMBER(5,2);
BEGIN
 ParameterLength(v_Variable1, v_variable2);
  DBMS_OUTPUT.PUT_LINE('Nuevo valor Variable 1: ' || v_Variable1);
  DBMS_OUTPUT.PUT_LINE('Nuevo valor Variable 2 : ' || v_Variable2);
END;
/


--Cuando se declara el v_Variable2 NUMBER(3,4) se esta pidiendo mas decimales de lo que le permite tener al numero.

--Ejemplo Pag 14 Invocacion 1

CREATE TABLE students (
	id NUMBER PRIMARY KEY,
	first_name VARCHAR2(20),
	last_name VARCHAR2(20),
	major VARCHAR2(20),
	current_credits NUMBER
);

--Tabla student_sequence, es lo que hace que el id suba 1.
CREATE SEQUENCE student_sequence START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE PROCEDURE AddNewStudent (
p_FirstName students.first_name%TYPE ,
p_LastName students.last_name%TYPE ,
p_Major students.major%TYPE DEFAULT 'Economic') AS
BEGIN
-- Inserta una nueva fila en la tabla students. Usa student_sequence
-- para generar el nuevo valor ID del estudiante y asigna el valor 0
-- a current_credits
INSERT INTO students VALUES (student_sequence.nextval, p_FirstName, p_LastName, p_Major, 0);
END AddNewStudent ;
/

--Invocacion 1
BEGIN
  AddNewStudent('Barbara', 'Blues');
END;
/

--Invocacion 2

BEGIN
 AddNewStudent( p_Firstname => 'Adrian', p_LastName => 'Wong');
END;
/


--4.4 Funciones
--Ejemplo Pag 4

CREATE TABLE classes (
  department VARCHAR2(50),
  course VARCHAR2(50),
  current_students NUMBER,
  max_students NUMBER
);


INSERT INTO classes (department, course, current_students, max_students)
VALUES ('Sistemas', 'Base', 45, 50);

INSERT INTO classes (department, course, current_students, max_students)
VALUES ('Sistemas', 'Ecuaciones', 48, 50);

COMMIT;


CREATE OR REPLACE FUNCTION AlmostFull (
  p_Department classes.department%TYPE,
  p_Course classes.course%TYPE
) RETURN BOOLEAN IS
  v_CurrentStudents NUMBER;
  v_MaxStudents NUMBER;
  v_ReturnValue BOOLEAN;
  v_FullPercent CONSTANT NUMBER := 90;
BEGIN
  SELECT current_students, max_students
  INTO v_CurrentStudents, v_MaxStudents
  FROM classes
  WHERE department = p_Department
    AND course = p_Course;

  IF (v_CurrentStudents / v_MaxStudents * 100) > v_FullPercent THEN
    v_ReturnValue := TRUE;
  ELSE
    v_ReturnValue := FALSE;
  END IF;

  RETURN v_ReturnValue;
END AlmostFull;
/

--Prueba para la ejecucion de la funcion
DECLARE
  v_Result BOOLEAN;
BEGIN
  v_Result := AlmostFull('Sistemas', 'Base'); --Se cambia 'ecuaciones' por 'base' para hacer la prueba

  IF v_Result THEN
    DBMS_OUTPUT.PUT_LINE('Resultado: La clase está casi llena.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Resultado: La clase NO está casi llena.');
  END IF;
END;
/


--Se borro un parentesis que estaba de mas en la funcion CREATE OR REPLACE FUNCTION

--Ejemplo Pag 5 

CREATE TABLE classes (
  department VARCHAR2(50),
  course VARCHAR2(50),
  current_students NUMBER,
  max_students NUMBER
);


INSERT INTO classes (department, course, current_students, max_students)
VALUES ('Sistemas', 'Base', 30, 50);
INSERT INTO classes (department, course, current_students, max_students)
VALUES ('Sistemas', 'Ecuaciones', 48, 50);
INSERT INTO classes (department, course, current_students, max_students)
VALUES ('Sistemas', 'Matematicas', 49, 50);

CREATE TABLE temp_table (
  char_col VARCHAR2(50)
);


--Este problema depende del problema anterior ya que en este se llama la funcion AlmostFull
DECLARE
CURSOR c_Classes IS
SELECT department, course
FROM classes;
BEGIN
FOR v_ClassRecord IN c_Classes LOOP --No entiendo de donde sale v_ClassRecord ni c_Classes.
-- Registra todos los cursos que no tienen mucho espacio vacio en temp_table
IF AlmostFull( v_ClassRecord.department, v_ClassRecord.course ) THEN
INSERT INTO temp_table (char_col) VALUES
(v_ClassRecord.department || ' ' || v_Classrecord.course || ' is almost full! ' );
END IF;
END LOOP;
  -- Imprimir resultados de temp_table
  FOR msg IN (SELECT char_col FROM temp_table) LOOP
    DBMS_OUTPUT.PUT_LINE(msg.char_col);
  END LOOP;
END AlmostFull;
/

--Se escribio de manera correcta el SELECT, antes estaba escrito como SELEC T
--Se agrego una bloque del codigo para poder visualizar de manera clara los datos introducidos en la tabla temp_table


--Ejemplo Pag 8

CREATE TABLE classes (
  department VARCHAR2(50),
  course VARCHAR2(50),
  current_students NUMBER,
  max_students NUMBER
);


INSERT INTO classes (department, course, current_students, max_students)
VALUES ('Sistemas', 'Base', 30, 50);
INSERT INTO classes (department, course, current_students, max_students)
VALUES ('Sistemas', 'Ecuaciones', 50, 50);
INSERT INTO classes (department, course, current_students, max_students)
VALUES ('Sistemas', 'Matematicas', 49, 50);


CREATE OR REPLACE FUNCTION ClassInfo (
p_Department classes.department%TYPE,
p_Course classes.course%TYPE)
RETURN VARCHAR2 IS
v_CurrentStudents NUMBER;
v_MaxStudents NUMBER;
v_PercentFull NUMBER;
BEGIN
-- Obtiene la cantidad actual y máxima de estudiantes para el curso solicitado
SELECT current_students, max_students
INTO v_CurrentStudents, v_MaxStudents
FROM classes
WHERE department = p_Department
AND course = p_Course;
-- Calcula el porcentaje actual
v_PercentFull := v_CurrentStudents / v_MaxStudents * 100;
IF v_PercentFull = 100 THEN
RETURN 'Full';
ELSIF v_PercentFull > 80 THEN
RETURN 'Some Room';
ELSIF v_PercentFull > 60 THEN
RETURN 'More Room';
ELSIF v_PercentFull > 0 THEN
RETURN 'Lots of Room';
ELSE
RETURN 'Empty';
END IF;
END ClassInfo;
/


--Sentencia para ejecutar la funcion
DECLARE
  v_resultado VARCHAR2(100);
BEGIN
  v_resultado := ClassInfo('Sistemas', 'Base');
  DBMS_OUTPUT.PUT_LINE('Estado del curso: ' || v_resultado);
END;
/


--Se cambiaron las comillas de los RETURN
--Se corrigio v_studens por v_students


--Ejemplo Pag 13

CREATE TABLE temp_table(
  char_col VARCHAR2(50)
);

CREATE TABLE students (
	id NUMBER PRIMARY KEY,
	first_name VARCHAR2(20),
	last_name VARCHAR2(20),
	major VARCHAR2(20),
	current_credits NUMBER
);

INSERT INTO students (id, first_name, last_name, major, current_credits)
VALUES (1, 'Adrian', 'Wong', 'Matematicas', 0);

INSERT INTO students (id, first_name, last_name, major, current_credits)
VALUES (2, 'Isaac', 'Bernal', 'Fisica', 0);

COMMIT;

DECLARE
CURSOR c_AllStudents IS
SELECT first_name, last_name
FROM students;
v_FormattedName VARCHAR2(50);
--Función que devolverá el nombre y apellido concatenado y separado por un espacio
FUNCTION FormatName (p_FirstName IN VARCHAR2,
p_LastName IN VARCHAR2)
RETURN VARCHAR2 IS
BEGIN
RETURN p_FirstName || ' ' || p_LastName;
END FormatName;

-- Inicia el programa principal
BEGIN
FOR v_StudentRecord IN c_AllStudents LOOP
v_FormattedName := FormatName (v_StudentRecord.first_name,
v_StudentRecord.last_name);
INSERT INTO temp_table (char_col) VALUES (v_FormattedName);
END LOOP;

-- Imprimir resultados de temp_table
FOR msg IN (SELECT char_col FROM temp_table) LOOP
  DBMS_OUTPUT.PUT_LINE(msg.char_col);
END LOOP;

END;
/

--Se corrigieron las comillas de los RETURN
--Se agrego la impresion de los resultados de la tabla temp_table para visualizar los datos introducidos


--Ejemplo Pag 14

CREATE TABLE students (
	id NUMBER PRIMARY KEY,
	first_name VARCHAR2(20),
	last_name VARCHAR2(20),
	major VARCHAR2(20),
	current_credits NUMBER
);

INSERT INTO students (id, first_name, last_name, major, current_credits)
VALUES (1, 'Adrian', 'Wong', 'Matematicas', 0);

INSERT INTO students (id, first_name, last_name, major, current_credits)
VALUES (2, 'Isaac', 'Bernal', 'Fisica', 0);


DECLARE
  v_FormattedName VARCHAR2(50);
  -- Primero la función
  FUNCTION FormatName(p_FirstName IN VARCHAR2, p_LastName IN VARCHAR2)
    RETURN VARCHAR2 IS
  BEGIN
    RETURN p_FirstName || ' ' || p_LastName;
  END FormatName;

BEGIN
  -- Uso de cursor implícito en el FOR
  FOR v_StudentRecord IN (SELECT first_name, last_name FROM students) LOOP
    v_FormattedName := FormatName(v_StudentRecord.first_name, v_StudentRecord.last_name);
    DBMS_OUTPUT.PUT_LINE('Nombre completo: ' || v_FormattedName);
  END LOOP;
END;
/


--Se corrigieron las comillas de los RETURN
--Se declaro correctamente la variable V_FormattedName antes de usarla
--Se agrego la impresion de los resultados de la tabla temp_table para visualizar los datos introducidos
--El cursor esta declarado de manera incorrecta, se agrego el cursor implícito en el FOR para que funcione correctamente.

--EJemplo Pag 15

CREATE TABLE salarioquincenal (
  id NUMBER PRIMARY KEY,
  salario NUMBER
);

INSERT INTO salarioquincenal (id, salario)
VALUES (1, 1000);

CREATE OR REPLACE FUNCTION seguro_social(
p_salarioq IN salarioquincenal.salario%TYPE
)
RETURN NUMBER AS
v_result NUMBER;
BEGIN
v_result := p_salarioq * (9.75/100);
DBMS_OUTPUT.PUT_LINE('Seguro social calculado: ' || v_result);
RETURN v_result;
END seguro_social;
/

--Se corrigió el nombre de la tabla y la columna en la función seguro_social para que coincidan con los nombres de la tabla salarioquincenal y su columna salario.
--Se agregó una inserción de datos en la tabla salarioquincenal para que la función pueda ser probada.


DECLARE
  v_salario salarioquincenal.salario%TYPE;
  v_resultado NUMBER;
BEGIN
  -- Obtén el salario de la tabla (por ejemplo, el id=1)
  SELECT salario INTO v_salario FROM salarioquincenal WHERE id = 1;
  -- Llama a la función (esto también imprimirá desde dentro de la función)
  v_resultado := seguro_social(v_salario);
END;
/