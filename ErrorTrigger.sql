CREATE SEQUENCE error_log_seq
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 999999
  NOCYCLE
  NOCACHE;
DROP TABLE error_log CASCADE CONSTRAINTS;
CREATE TABLE error_log (
  error_id number(6) PRIMARY KEY,
  error_message VARCHAR(255),
  error_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE TRIGGER MM_Movies_TRG
BEFORE INSERT OR UPDATE OR DELETE ON MM_Movies
FOR EACH ROW
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  IF inserting OR updating THEN
    IF :NEW.movie_id <= 0 OR :NEW.release_year <= 0 OR :NEW.average_rating < 0 OR :NEW.average_rating > 10 THEN
      INSERT INTO error_log (error_id, error_message) VALUES (error_log_seq.NEXTVAL, 'Invalid movie data: ' || :NEW.movie_id || ', ' || :NEW.release_year || ', ' || :NEW.average_rating);
      COMMIT;
      RAISE_APPLICATION_ERROR(-20001, 'Invalid movie data');
    END IF;
  END IF;
  IF deleting THEN
    IF :OLD.average_rating >= 8 THEN
      INSERT INTO error_log (error_id, error_message) VALUES (error_log_seq.NEXTVAL, 'Cannot delete movie with high rating: ' || :OLD.movie_id);
      COMMIT;
      RAISE_APPLICATION_ERROR(-20002, 'Cannot delete movie with high rating');
    END IF;
  END IF;
END;
/


INSERT INTO MM_Movies (movie_id, movie_title, release_year, directorName, average_rating, description) VALUES (2, 'Terminator: Dark Fate', 2019, 'Tim Miller', 11, 'Sarah Connor and a hybrid cyborg human must protect a young girl from a newly modified liquid Terminator from the future.');

UPDATE MM_Movies SET movie_id = -2 WHERE movie_id = 1;

SELECT * FROM error_log;
