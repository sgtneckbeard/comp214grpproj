-- Trigger to update mm_moviegenre table when a new movie is added
CREATE OR REPLACE TRIGGER TR_MM_MOVIES_INSERT
AFTER INSERT ON MM_MOVIES
FOR EACH ROW
BEGIN
  INSERT INTO MM_MOVIEGENRE (movie_id, genre_id)
  VALUES (:NEW.movie_id, :NEW.genre_id);
END;
/


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
/


-- Trigger to log errors in table
CREATE OR REPLACE TRIGGER TR_MM_Movies
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

-- Test code for TR_MM_Movies
INSERT INTO MM_Movies (movie_id, movie_title, release_year, directorName, average_rating, description) VALUES (2, 'Terminator: Dark Fate', 2019, 'Tim Miller', 11, 'Sarah Connor and a hybrid cyborg human must protect a young girl from a newly modified liquid Terminator from the future.');

UPDATE MM_Movies SET movie_id = -2 WHERE movie_id = 1;

SELECT * FROM error_log;
/