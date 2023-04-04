/*
----------------------
It doesn't work now
----------------------
Create new table

name: MM_CINEMA
Cols: cinema_name,..., location(uptown, midtown, downtown)

insert new col (preferred_location) into mm_users

*/

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
   
   -- Declare variables for exception handling
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

/*
-------------
insert 'genre' coloum into 'mm_movies'
??? mm_moviegenre table
-------------
*/
CREATE OR REPLACE PROCEDURE add_movie(
    p_mv_id         IN mm_movies.movie_id%TYPE,
    p_mv_title      IN mm_movies.movie_title%TYPE,
    --p_genre         IN mm_movies.genre&TYPE,
    p_release_yr    IN mm_movies.release_year%TYPE,
    p_dr_name       IN mm_movies.directorname%TYPE,
    p_avg_rating    IN mm_movies.average_rating%TYPE,
    p_description   IN mm_movies.description%TYPE
    
)IS

    v_genre_name   mm_genres.genre_name%TYPE;
    CURSOR cur_genre IS
       SELECT genre_name FROM mm_genres
       WHERE genre_name = p_genre;
   
    invalid_genre EXCEPTION;
    
BEGIN
    OPEN cur_genre;
    FETCH cur_genre INTO v_genre_name;
    IF cur_genre%NOTFOUND THEN
       RAISE invalid_genre;
    END IF;
    CLOSE cur_genre;
   
    -- Insert the new movie record
    INSERT INTO mm_movies (
      movie_id,
      movie_title,
      --genre,
      release_year,
      directorname,
      average_rating,
      description
    ) VALUES (
      p_mv_id,
      p_mv_title,
      --p_genre
      p_release_yr,
      p_dr_name,
      p_avg_rating,
      p_description
      
    );
   
    -- Exception handling
    EXCEPTION
        WHEN invalid_genre THEN
            DBMS_OUTPUT.PUT_LINE('Error: Invalid Genre');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;