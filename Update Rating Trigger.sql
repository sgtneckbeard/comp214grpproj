CREATE OR REPLACE TRIGGER update_movie_rating
AFTER INSERT OR UPDATE ON MM_Ratings
FOR EACH ROW
BEGIN
    UPDATE MM_Movies
    SET average_rating = (
        SELECT AVG(rating_value) 
        FROM MM_Ratings 
        WHERE MM_Ratings.movie_id = :new.movie_id
    )
    WHERE MM_Movies.movie_id = :new.movie_id;
END;
/
