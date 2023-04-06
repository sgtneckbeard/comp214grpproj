-----------------------------------------------------------------------------------------
-- 1. Procedure for adding new movies to the mm_movies table with exception handling
-----------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE add_movie(
    p_mv_id         IN mm_movies.movie_id%TYPE,
    p_genre_id      IN mm_movies.genre_id%TYPE,
    p_mv_title      IN mm_movies.movie_title%TYPE,
    p_release_yr    IN mm_movies.release_year%TYPE,
    p_dr_name       IN mm_movies.directorname%TYPE,
    p_avg_rating    IN mm_movies.average_rating%TYPE DEFAULT NULL,
    p_description   IN mm_movies.description%TYPE
    
)IS
    v_genre_id   mm_genres.genre_id%TYPE;
    
    CURSOR cur_genre IS
    SELECT genre_id FROM mm_genres
    WHERE genre_id = p_genre_id;
   
    invalid_genre EXCEPTION;
    
BEGIN
    OPEN cur_genre;
    FETCH cur_genre INTO v_genre_id;
    IF cur_genre%NOTFOUND THEN
       RAISE invalid_genre;
    END IF;
    CLOSE cur_genre;
   
    -- Insert the new movie record
    INSERT INTO mm_movies (
      movie_id, genre_id, movie_title, release_year,
      directorname, average_rating, description
    ) VALUES (
      p_mv_id, p_genre_id, p_mv_title, p_release_yr,
      p_dr_name, p_avg_rating, p_description   
    );
   
    -- Exception handling
    EXCEPTION
        WHEN invalid_genre THEN
            DBMS_OUTPUT.PUT_LINE('Error: Invalid Genre');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

-- Test code

BEGIN
    add_movie(17, 3, 'Iron Man', 2008, 'Jon Favreau', null,
              'A billionaire industrialist and genius inventor who creates a suit of armor to become a superhero known as Iron Man.');
END;


------------------------------------------------------------------------------------------------------------
-- 2. Procedure for getting top 5 movies by average rating from the mm_movies table with exception handling
------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE get_top_5
IS
    v_movie_id    mm_movies.movie_id%TYPE;
    v_movie_title mm_movies.movie_title%TYPE;
    v_avg_rating  mm_movies.average_rating%TYPE;
    
    CURSOR cur_rating IS
    SELECT movie_id, movie_title, average_rating
    FROM (
        SELECT movie_id, movie_title, average_rating
        FROM mm_movies
        WHERE average_rating IS NOT NULL
        ORDER BY average_rating DESC
    ) WHERE ROWNUM <= 5;
   
    no_rating_found EXCEPTION;
   
BEGIN
    OPEN cur_rating;
        DBMS_OUTPUT.PUT_LINE('Top 5 Movies');
    LOOP
        FETCH cur_rating INTO v_movie_id, v_movie_title, v_avg_rating;
        EXIT WHEN cur_rating%NOTFOUND;

        -- Display the movie information
        DBMS_OUTPUT.PUT_LINE('Movie ID: ' || LPAD(v_movie_id,3)
                            ||'  Movie Title: ' || RPAD(v_movie_title,20)
                            ||'  Average Rating: ' || v_avg_rating);
    END LOOP;

    CLOSE cur_rating;
    
-- Exception handling
EXCEPTION
    WHEN no_rating_found THEN
        DBMS_OUTPUT.PUT_LINE('Error: No rating found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

-- Test code

BEGIN
    get_top_5();
END;

