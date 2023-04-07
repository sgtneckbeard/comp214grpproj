CREATE OR REPLACE PACKAGE MM_MANAGER_PKG IS
-- declare global variables
g_movie_id MM_Movies.movie_id%TYPE;
g_genre_id MM_Genres.genre_id%TYPE;
g_movie_title MM_Movies.movie_title%TYPE;
g_release_year MM_Movies.release_year%TYPE;
g_directorName MM_Movies.directorName%TYPE;
g_description MM_Movies.description%TYPE;

FUNCTION GetMovieGenre(p_movie_id IN NUMBER)
RETURN VARCHAR2;

PROCEDURE AddMovie(
p_movie_id IN MM_Movies.movie_id%TYPE,
p_genre_id IN MM_Genres.genre_id%TYPE,
p_movie_title IN MM_Movies.movie_title%TYPE,
p_release_year IN MM_Movies.release_year%TYPE,
p_directorName IN MM_Movies.directorName%TYPE,
p_description IN MM_Movies.description%TYPE
);

PROCEDURE UpdateMovie(
p_movie_id IN MM_Movies.movie_id%TYPE,
p_genre_id IN MM_Genres.genre_id%TYPE,
p_movie_title IN MM_Movies.movie_title%TYPE,
p_release_year IN MM_Movies.release_year%TYPE,
p_directorName IN MM_Movies.directorName%TYPE,
p_description IN MM_Movies.description%TYPE
);

PROCEDURE DeleteMovie(
p_movie_id IN MM_Movies.movie_id%TYPE
);
END MM_MANAGER_PKG;
/

CREATE OR REPLACE PACKAGE BODY MM_MANAGER_PKG IS
 
  FUNCTION GetMovieGenre(p_movie_id IN NUMBER) 
    RETURN VARCHAR2 
  IS 
    v_genre_name VARCHAR2(30); 
  BEGIN 
    SELECT g.genre_name INTO v_genre_name 
    FROM MM_Genres g 
    JOIN MM_MovieGenre mg ON g.genre_id = mg.genre_id 
    WHERE mg.movie_id = p_movie_id; 
    RETURN v_genre_name; 
  EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
      RETURN NULL; 
  END GetMovieGenre; 
 
  PROCEDURE AddMovie( 
    p_movie_id IN MM_Movies.movie_id%TYPE,
    p_genre_id IN MM_Genres.genre_id%TYPE, 
    p_movie_title IN MM_Movies.movie_title%TYPE, 
    p_release_year IN MM_Movies.release_year%TYPE, 
    p_directorName IN MM_Movies.directorName%TYPE, 
    p_description IN MM_Movies.description%TYPE 
  ) 
  IS
  BEGIN 
    INSERT INTO MM_Movies(movie_id, genre_id, movie_title, release_year, directorName, description) 
    VALUES(p_movie_id, p_genre_id, p_movie_title, p_release_year, p_directorName, p_description); 
    DBMS_OUTPUT.PUT_LINE('Added movie:');
    DBMS_OUTPUT.PUT_LINE(p_movie_id || ', ' || p_genre_id || ', ' || p_movie_title || ', ' || p_release_year || ', ' || p_directorName || ', ' || p_description);
  END AddMovie;
 
  PROCEDURE UpdateMovie( 
    p_movie_id IN MM_Movies.movie_id%TYPE, 
    p_genre_id IN MM_Genres.genre_id%TYPE, 
    p_movie_title IN MM_Movies.movie_title%TYPE, 
    p_release_year IN MM_Movies.release_year%TYPE, 
    p_directorName IN MM_Movies.directorName%TYPE, 
    p_description IN MM_Movies.description%TYPE 
  ) 
  IS 
  BEGIN 
    UPDATE MM_Movies 
    SET genre_id = p_genre_id, movie_title = p_movie_title, release_year = p_release_year, 
        directorName = p_directorName, description = p_description 
    WHERE movie_id = p_movie_id; 
	DBMS_OUTPUT.PUT_LINE('Updated movie:'); 
	DBMS_OUTPUT.PUT_LINE( p_movie_id || ', ' || p_genre_id || ', ' || p_movie_title || ', ' || p_release_year || ', ' || p_directorName || ', ' || p_description); 
  END UpdateMovie; 
 
  PROCEDURE DeleteMovie(p_movie_id IN MM_Movies.movie_id%TYPE) 
  	IS 
       v_genre_id MM_Genres.genre_id%TYPE; 
       v_movie_title MM_Movies.movie_title%TYPE; 
       v_release_year MM_Movies.release_year%TYPE; 
       v_directorName MM_Movies.directorName%TYPE; 
       v_description MM_Movies.description%TYPE; 
    BEGIN 
    SELECT genre_id, movie_title, release_year, directorName, description 
    INTO v_genre_id, v_movie_title, v_release_year, v_directorName, v_description 
    FROM MM_Movies 
    WHERE movie_id = p_movie_id; 
 
    DBMS_OUTPUT.PUT_LINE('Deleted movie:'); 
    DBMS_OUTPUT.PUT_LINE(p_movie_id || ', ' || v_genre_id || ', ' || v_movie_title || ', ' || v_release_year || ', ' || v_directorName || ', ' || v_description); 
 
    DELETE FROM MM_Ratings WHERE movie_id = p_movie_id; 
    DELETE FROM MM_MovieActors WHERE movie_id = p_movie_id; 
    DELETE FROM MM_MovieGenre WHERE movie_id = p_movie_id; 
    DELETE FROM MM_Movies WHERE movie_id = p_movie_id; 
  END DeleteMovie; 
 
END MM_MANAGER_PKG;
/



DECLARE
  -- Declare the variables to hold the movie information
  l_movie_id MM_Movies.movie_id%TYPE := 100;
  l_genre_id MM_Genres.genre_id%TYPE := 1;
  l_movie_title MM_Movies.movie_title%TYPE := 'The Matrix';
  l_release_year MM_Movies.release_year%TYPE := 1999;
  l_directorName MM_Movies.directorName%TYPE := 'Lana Wachowski, Lilly Wachowski';
  l_description MM_Movies.description%TYPE := 'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.';

BEGIN
  -- Add the movie
  MM_MANAGER_PKG.AddMovie(l_movie_id, l_genre_id, l_movie_title, l_release_year, l_directorName, l_description);

  -- Update the movie
  l_directorName := 'Lana Wachowski, Lilly Wachowski, Keanu Reeves';
  l_description := 'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers. Starring Keanu Reeves as Neo.';
  MM_MANAGER_PKG.UpdateMovie(l_movie_id, l_genre_id, l_movie_title, l_release_year, l_directorName, l_description);

  -- Delete the movie
  MM_MANAGER_PKG.DeleteMovie(l_movie_id);

END;
/