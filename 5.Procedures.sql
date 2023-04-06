/*
----------------------
It doesn't work now
----------------------
Create new table

name: MM_CINEMA
Cols: cinema_name, location(uptown, midtown, downtown)

insert new col (preferred_location) into mm_users



CREATE OR REPLACE PROCEDURE add_user(
    p_user_id     IN mm_users.user_id%TYPE,
    p_user_name   IN mm_users.username%TYPE,
    p_user_pw     IN mm_users.password%TYPE,
    p_email       IN mm_users.email%TYPE
    --p_pref_location IN mm_users.preferred_location%TYPE
)IS

    v_user_id   mm_users.user_id%TYPE;
    CURSOR cur_location IS
       SELECT user_id FROM mm_users
       WHERE preferred_location = 'uptown';
   
    invalid_location EXCEPTION;
    
BEGIN
    OPEN cur_location;
    FETCH cur_location INTO v_user_id;
    IF cur_location%NOTFOUND THEN
       RAISE invalid_location;
    END IF;
    CLOSE cur_location;
   
    -- Insert the new user record
    INSERT INTO mm_users (
      user_id,
      username,
      password,
      email,
      --preferred_location
    ) VALUES (
      p_user_id,
      p_user_name,
      p_user_pw,
      p_email,
      --p_pref_location
    );
   
    -- Exception handling
    EXCEPTION
        WHEN invalid_location THEN
            DBMS_OUTPUT.PUT_LINE('Error: Invalid Location');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
*/

/*
-------------
doesn't work with parameters.
-------------
*/
CREATE OR REPLACE PROCEDURE add_movie(
    p_mv_id         IN mm_movies.movie_id%TYPE,
    p_mv_title      IN mm_movies.movie_title%TYPE,
    p_genre_id      IN mm_movies.genre_id%TYPE,
    p_release_yr    IN mm_movies.release_year%TYPE,
    p_dr_name       IN mm_movies.directorname%TYPE,
    p_avg_rating    IN mm_movies.average_rating%TYPE,
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
      movie_id, movie_title, genre_id, release_year,
      directorname, average_rating, description
    ) VALUES (
      p_mv_id, p_mv_title, p_genre_id, p_release_yr,
      p_dr_name, p_avg_rating, p_description   
    );
   
    -- Exception handling
    EXCEPTION
        WHEN invalid_genre THEN
            DBMS_OUTPUT.PUT_LINE('Error: Invalid Genre');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

BEGIN
    add_movie(17, 3, 'Iron Man', 2008, 'Jon Favreau', null,
              'A billionaire industrialist and genius inventor who creates a suit of armor to become a superhero known as Iron Man.');
END;

------------------------------------------------------

------------------------------------------


CREATE OR REPLACE PROCEDURE get_top_rated_movie
IS
    v_movie_id    mm_movies.movie_id%TYPE;
    v_movie_title mm_movies.movie_title%TYPE;
    v_avg_rating  mm_movies.average_rating%TYPE;
    
    CURSOR cur_rating IS
    SELECT RPAD(movie_id,4), RPAD(movie_title,50), average_rating
    FROM mm_movies
    ORDER BY average_rating
    DESC FETCH FIRST 5 ROW ONLY;
   
    no_rating_found EXCEPTION;
   
BEGIN
    OPEN cur_rating;
        DBMS_OUTPUT.PUT_LINE('Top 5 Movies');
    LOOP
        FETCH cur_rating INTO v_movie_id, v_movie_title, v_avg_rating;
        EXIT WHEN cur_rating%NOTFOUND;
        
        -- Display the movie information
        DBMS_OUTPUT.PUT_LINE('Movie ID: ' || v_movie_id || '  Movie Title: ' || v_movie_title ||'  Average Rating: ' || v_avg_rating);
    END LOOP;

    CLOSE cur_rating;
    
-- Exception handling
EXCEPTION
    WHEN no_rating_found THEN
        DBMS_OUTPUT.PUT_LINE('Error: No rating found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

BEGIN
    get_top_rated_movie();
END;