BEGIN
   -- Borrar vistas
   FOR v IN (SELECT view_name FROM user_views) LOOP
      EXECUTE IMMEDIATE 'DROP VIEW ' || v.view_name;
   END LOOP;

   -- Borrar tablas (con constraints en cascada)
   FOR t IN (SELECT table_name FROM user_tables) LOOP
      EXECUTE IMMEDIATE 'DROP TABLE ' || t.table_name || ' CASCADE CONSTRAINTS';
   END LOOP;

   -- Borrar secuencias
   FOR s IN (SELECT sequence_name FROM user_sequences) LOOP
      EXECUTE IMMEDIATE 'DROP SEQUENCE ' || s.sequence_name;
   END LOOP;

   -- Borrar procedimientos
   FOR p IN (SELECT object_name FROM user_objects WHERE object_type = 'PROCEDURE') LOOP
      EXECUTE IMMEDIATE 'DROP PROCEDURE ' || p.object_name;
   END LOOP;
END;
/

