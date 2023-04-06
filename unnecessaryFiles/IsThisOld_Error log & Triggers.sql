--Error id sequence
CREATE SEQUENCE error_id_seq START WITH 1 INCREMENT BY 1;
--Error log table
CREATE TABLE error_log (
  error_id NUMBER PRIMARY KEY,
  table_name VARCHAR2(50),
  sequence_name VARCHAR2(50),
  operation VARCHAR2(10),
  error_msg CLOB,
  error_time TIMESTAMP
);
CREATE OR REPLACE TRIGGER log_mm_movieactors_error_trigger
AFTER INSERT OR UPDATE OR DELETE ON MM_MovieActors
FOR EACH ROW
DECLARE
  v_operation VARCHAR2(10);
  v_error_msg VARCHAR2(4000);
  v_error_id NUMBER;
BEGIN
  IF INSERTING THEN
    v_operation := 'INSERT';
  ELSIF UPDATING THEN
    v_operation := 'UPDATE';
  ELSIF DELETING THEN
    v_operation := 'DELETE';
  END IF;
  
  -- Get the next error id from the sequence
  v_error_id := error_id_seq.NEXTVAL;
  
  -- Log the error to the error_log table
  v_error_msg := SUBSTR(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE(), 1, 4000);
  INSERT INTO error_log (error_id, table_name, operation, error_msg, error_time)
  VALUES (v_error_id, 'MM_MovieActors', v_operation, v_error_msg, SYSTIMESTAMP);
  
  -- Raise the error to prevent the transaction from committing
  RAISE_APPLICATION_ERROR(-20001, v_error_msg);
END;
/


INSERT INTO MM_MovieActors (movie_id, actor_id) VALUES (1, 1);

SELECT * FROM error_log;