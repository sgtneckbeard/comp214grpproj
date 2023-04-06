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


DELETE FROM MM_MovieActors;
DELETE FROM MM_MovieGenre;
DELETE FROM MM_Ratings;
DELETE FROM MM_Movies;
DELETE FROM MM_Actors;
DELETE FROM MM_Genres;
DELETE FROM MM_Users;

-- Insert a new movie with 0 rating
INSERT INTO MM_Movies (movie_id, movie_title, release_year, directorName, average_rating, description)
VALUES (1, 'The Shawshank Redemption', 1994, 'Frank Darabont', 0.0, 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.');

-- Insert a new user
INSERT INTO MM_Users (user_id, username, password, email)
VALUES (1, 'johndoe', 'password', 'johndoe@example.com');

-- Insert a new rating for the movie by the user
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value)
VALUES (1, 1, 1, 9);

-- Verify that the trigger has updated the average_rating column in MM_Movies
SELECT * FROM MM_Movies WHERE movie_id = 1; --Expected output for the rating: 9
