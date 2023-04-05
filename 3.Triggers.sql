-- Trigger to update mm_moviegenre table when a new movie is added
CREATE OR REPLACE TRIGGER TR_MM_MOVIES_INSERT
AFTER INSERT ON MM_MOVIES
FOR EACH ROW
BEGIN
  INSERT INTO MM_MOVIEGENRE (movie_id, genre_id)
  VALUES (:NEW.movie_id, :NEW.genre_id);
END;



-- Trigger to update average_rating column in mm_movies table when mm_ratings table is updated
CREATE OR REPLACE TRIGGER TR_update_avg_rating
FOR INSERT OR UPDATE OR DELETE ON MM_Ratings
COMPOUND TRIGGER
    g_movie_id MM_Ratings.movie_id%TYPE;
    g_rating_count NUMBER := 0;
    g_rating_sum NUMBER := 0;

    AFTER EACH ROW IS
    BEGIN
        IF INSERTING THEN
            g_rating_count := g_rating_count + 1;
            g_rating_sum := g_rating_sum + :NEW.rating_value;
            g_movie_id := :NEW.movie_id;
        ELSIF UPDATING THEN
            g_rating_sum := g_rating_sum - :OLD.rating_value + :NEW.rating_value;
            g_movie_id := :NEW.movie_id;
        ELSIF DELETING THEN
            g_rating_count := g_rating_count - 1;
            g_rating_sum := g_rating_sum - :OLD.rating_value;
            g_movie_id := :OLD.movie_id;
        END IF;
    END AFTER EACH ROW;

    AFTER STATEMENT IS
    BEGIN
        IF g_rating_count > 0 THEN
            UPDATE MM_Movies
            SET average_rating = g_rating_sum / g_rating_count
            WHERE movie_id = g_movie_id;
        END IF;
        g_movie_id := NULL;
        g_rating_count := 0;
        g_rating_sum := 0;
    END AFTER STATEMENT;
END TR_update_avg_rating;



-- Trigger to log errors in table
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

