CREATE TRIGGER update_mm_moviegenre AFTER UPDATE ON mm_movie
FOR EACH ROW
BEGIN
    UPDATE mm_moviegenre
    SET genre = NEW.genre
    WHERE movie_id = NEW.movie_id;
END;