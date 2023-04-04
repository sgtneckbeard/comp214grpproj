-- Trigger to update mm_moviegenre table when a new movie is added
CREATE OR REPLACE TRIGGER TR_MM_MOVIES_INSERT
AFTER INSERT ON MM_MOVIES
FOR EACH ROW
BEGIN
  INSERT INTO MM_MOVIEGENRE (movie_id, genre_id)
  VALUES (:NEW.movie_id, :NEW.genre_id);
END;



-- Trigger to update average_rating column in mm_movies table when mm_ratings table is updated
CREATE OR REPLACE TRIGGER TR_MM_RATINGS_UPDATE
AFTER UPDATE ON MM_RATINGS
FOR EACH ROW
BEGIN
  UPDATE MM_MOVIES
  SET average_rating = (SELECT AVG(rating) FROM MM_RATINGS WHERE movie_id = :NEW.movie_id)
  WHERE movie_id = :NEW.movie_id;
END;
