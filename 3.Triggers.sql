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
AFTER INSERT ON mm_ratings
FOR EACH ROW
BEGIN
  UPDATE mm_movies
  SET average_rating = (SELECT AVG(rating_value) FROM mm_ratings WHERE movie_id = :new.movie_id)
  WHERE movie_id = :new.movie_id;
END;


