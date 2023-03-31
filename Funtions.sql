------Function for getting movies from a certain Actor----------
CREATE OR REPLACE FUNCTION get_movies_by_actor(p_actor_name IN MM_Actors.actor_name%TYPE)
   RETURN SYS_REFCURSOR
IS
   v_cursor SYS_REFCURSOR;
BEGIN
   OPEN v_cursor FOR
      SELECT m.movie_title
      FROM MM_Movies m
      JOIN MM_MovieActors ma ON m.movie_id = ma.movie_id
      JOIN MM_Actors a ON ma.actor_id = a.actor_id
      WHERE a.actor_name = p_actor_name;
   RETURN v_cursor;
END;


DECLARE
   v_cursor SYS_REFCURSOR;
   v_movie_title MM_Movies.movie_title%TYPE;
BEGIN
   v_cursor := get_movies_by_actor('Tom Hanks');
   LOOP
      FETCH v_cursor INTO v_movie_title;
      EXIT WHEN v_cursor%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(v_movie_title);
   END LOOP;
   CLOSE v_cursor;
END;


------Function for getting movies from a certain Genre----------

CREATE OR REPLACE FUNCTION get_movies_by_genre(p_genre_name IN MM_Genres.genre_name%TYPE)
   RETURN SYS_REFCURSOR
IS
   v_cursor SYS_REFCURSOR;
BEGIN
   OPEN v_cursor FOR
      SELECT m.movie_title
      FROM MM_Movies m
      JOIN MM_MovieGenre mg ON m.movie_id = mg.movie_id
      JOIN MM_Genres g ON mg.genre_id = g.genre_id
      WHERE g.genre_name = p_genre_name;
   RETURN v_cursor;
END;
/


DECLARE
   v_cursor SYS_REFCURSOR;
   v_movie_title MM_Movies.movie_title%TYPE;
BEGIN
   v_cursor := get_movies_by_genre('Action');
   LOOP
      FETCH v_cursor INTO v_movie_title;
      EXIT WHEN v_cursor%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(v_movie_title);
   END LOOP;
   CLOSE v_cursor;
END;
/

------Function for getting movies from a certain Genre(WITH AN EXCEPTION HANDLER FOR INVALID GENRE )----------

CREATE OR REPLACE FUNCTION get_movies_by_genre(p_genre_name IN MM_Genres.genre_name%TYPE)
   RETURN SYS_REFCURSOR
IS
   v_cursor SYS_REFCURSOR;
   v_count NUMBER;
BEGIN
   SELECT COUNT(*)
   INTO v_count
   FROM MM_Genres
   WHERE genre_name = p_genre_name;

   IF v_count = 0 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Genre not found: ' || p_genre_name);
   ELSE
      OPEN v_cursor FOR
         SELECT m.movie_title
         FROM MM_Movies m
         JOIN MM_MovieGenre mg ON m.movie_id = mg.movie_id
         JOIN MM_Genres g ON mg.genre_id = g.genre_id
         WHERE g.genre_name = p_genre_name;
      RETURN v_cursor;
   END IF;
EXCEPTION
   WHEN OTHERS THEN
      IF v_cursor%ISOPEN THEN
         CLOSE v_cursor;
      END IF;
      RAISE;
END;
/

DECLARE
   v_cursor SYS_REFCURSOR;
   v_movie_title MM_Movies.movie_title%TYPE;
BEGIN
   -- Test case 1: Valid genre
   v_cursor := get_movies_by_genre('Action');
   LOOP
      FETCH v_cursor INTO v_movie_title;
      EXIT WHEN v_cursor%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(v_movie_title);
   END LOOP;
   CLOSE v_cursor;
   
   -- Test case 2: Invalid genre
   BEGIN
      v_cursor := get_movies_by_genre('omedy');
   EXCEPTION
      WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(SQLERRM);
   END;
END;
/




