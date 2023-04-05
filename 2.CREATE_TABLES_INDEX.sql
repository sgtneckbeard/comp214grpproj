-- Sequences Start --
    CREATE SEQUENCE user_id_seq
        START WITH 1
        INCREMENT BY 1
        NOCACHE
        NOCYCLE;

    CREATE SEQUENCE actor_id_seq
        START WITH 1
        INCREMENT BY 1
        NOCACHE
        NOCYCLE;

    CREATE SEQUENCE error_id_seq 
        START WITH 1 
        INCREMENT BY 1;

-- Sequences End -- 

-------------------

-- Tables Start --
    CREATE TABLE MM_Actors (
        actor_id Number(6)  PRIMARY KEY,
        actor_name VARCHAR(100)
    );

    CREATE TABLE MM_Users (
        user_id Number(6)  PRIMARY KEY,
        username VARCHAR(50),
        password VARCHAR(25),
        email VARCHAR(100)
    );


    CREATE TABLE MM_Genres (
        genre_id number(6) PRIMARY KEY,
        genre_name VARCHAR(30)
    );

    CREATE TABLE MM_Movies (
        movie_id number(6) PRIMARY KEY,
        genre_id number(6),
        movie_title VARCHAR(255),
        release_year number(6),
        directorName VARCHAR(50),
        average_rating FLOAT,
        description VARCHAR(280),
        FOREIGN KEY (genre_id) REFERENCES MM_Genres(genre_id)
    );

    CREATE TABLE MM_Ratings (
        rating_id number(6) PRIMARY KEY,
        movie_id number(6),
        user_id number(6),
        rating_value INT,
        FOREIGN KEY (movie_id) REFERENCES MM_Movies(movie_id),
        FOREIGN KEY (user_id) REFERENCES MM_Users(user_id)
    );


    CREATE TABLE MM_MovieActors (
        movie_id number(6),
        actor_id number(6),
        PRIMARY KEY (movie_id, actor_id),
        FOREIGN KEY (movie_id) REFERENCES MM_Movies(movie_id),
        FOREIGN KEY (actor_id) REFERENCES MM_Actors(actor_id)
    );

    CREATE TABLE MM_MovieGenre (
        movie_id number(6),
        genre_id number(6),
        PRIMARY KEY (movie_id, genre_id),
        FOREIGN KEY (movie_id) REFERENCES MM_Movies(movie_id),
        FOREIGN KEY (genre_id) REFERENCES MM_Genres(genre_id)
    );

    -- UPDATE MM_Movies 
    -- SET average_rating = (
    --     SELECT AVG(rating_value) 
    --     FROM MM_Ratings 
    --     WHERE MM_Ratings.movie_id = MM_Movies.movie_id
    -- );

    CREATE TABLE error_log (
        error_id NUMBER PRIMARY KEY,
        table_name VARCHAR2(50),
        sequence_name VARCHAR2(50),
        operation VARCHAR2(10),
        error_msg CLOB,
        error_time TIMESTAMP
);
-- Tables End --

-------------------

-- Indexes Start -- 

-- Indexes End--
