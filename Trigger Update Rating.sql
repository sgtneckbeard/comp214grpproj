-------------------------------Trigger for Rating.---------------
CREATE OR REPLACE TRIGGER update_movie_rating
AFTER INSERT ON MM_Ratings
FOR EACH ROW
BEGIN
    UPDATE MM_Movies 
    SET average_rating = (
        SELECT AVG(rating_value) 
        FROM MM_Ratings 
        WHERE MM_Ratings.movie_id = :new.movie_id
    )
    WHERE movie_id = :new.movie_id;
END;

