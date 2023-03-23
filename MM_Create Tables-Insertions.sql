DROP TABLE MM_Recommendations;
DROP TABLE MM_MovieActors;
DROP TABLE MM_Ratings;
DROP TABLE MM_Movies;
DROP TABLE MM_Directors;
DROP TABLE MM_Genres;
DROP TABLE MM_Actors;
DROP TABLE MM_Users;
DROP SEQUENCE user_id_seq;
DROP SEQUENCE actor_id_seq;


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
CREATE TABLE MM_Actors (
    actor_id Number(6) DEFAULT actor_id_seq.NEXTVAL PRIMARY KEY,
    actor_name VARCHAR(100)
);

CREATE TABLE MM_Users (
    user_id Number(6) DEFAULT user_id_seq.NEXTVAL PRIMARY KEY,
    username VARCHAR(50),
    password VARCHAR(25),
    email VARCHAR(100)
);

CREATE TABLE MM_Directors (
    director_id number(6) PRIMARY KEY,
    director_name VARCHAR(255)
);

CREATE TABLE MM_Genres (
    genre_id number(6) PRIMARY KEY,
    genre_name VARCHAR(30)
);

CREATE TABLE MM_Movies (
    movie_id number(6) PRIMARY KEY,
    movie_title VARCHAR(255),
    release_year number(6),
    genre_id number(6),
    director_id number(6),
    average_rating FLOAT,
    FOREIGN KEY (genre_id) REFERENCES MM_Genres(genre_id),
    FOREIGN KEY (director_id) REFERENCES MM_Directors(director_id)
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

CREATE TABLE MM_Recommendations (
    recommendation_id number(6) PRIMARY KEY,
    user_id number(6),
    movie_id number(6),
    FOREIGN KEY (user_id) REFERENCES MM_Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES MM_Movies(movie_id)
);

UPDATE MM_Movies 
SET average_rating = (
    SELECT AVG(rating_value) 
    FROM MM_Ratings 
    WHERE MM_Ratings.movie_id = MM_Movies.movie_id
);









-- Actors
INSERT INTO MM_Actors (actor_name) VALUES ('Tom Hanks');
INSERT INTO MM_Actors (actor_name) VALUES ('Meryl Streep');
INSERT INTO MM_Actors (actor_name) VALUES ('Denzel Washington');
INSERT INTO MM_Actors (actor_name) VALUES ('Viola Davis');
INSERT INTO MM_Actors (actor_name) VALUES ('Leonardo DiCaprio');

-- Users
INSERT INTO MM_Users (username, password, email) VALUES ('jdoe', 'password123', 'jdoe@example.com');
INSERT INTO MM_Users (username, password, email) VALUES ('jsmith', 'password456', 'jsmith@example.com');
INSERT INTO MM_Users (username, password, email) VALUES ('janedoe', 'password789', 'janedoe@example.com');
INSERT INTO MM_Users (username, password, email) VALUES ('bobsmith', 'passwordabc', 'bobsmith@example.com');
INSERT INTO MM_Users (username, password, email) VALUES ('katejones', 'passworddef', 'katejones@example.com');

-- Directors
INSERT INTO MM_Directors (director_id, director_name) VALUES (1, 'Frank Darabont');
INSERT INTO MM_Directors (director_id, director_name) VALUES (2, 'Francis Ford Coppola');
INSERT INTO MM_Directors (director_id, director_name) VALUES (3, 'Christopher Nolan');
INSERT INTO MM_Directors (director_id, director_name) VALUES (4, 'Quentin Tarantino');
INSERT INTO MM_Directors (director_id, director_name) VALUES (5, 'Peter Jackson');

-- Genres
INSERT INTO MM_Genres (genre_id, genre_name) VALUES (1, 'Drama');
INSERT INTO MM_Genres (genre_id, genre_name) VALUES (2, 'Adventure');
INSERT INTO MM_Genres (genre_id, genre_name) VALUES (3, 'Action');
INSERT INTO MM_Genres (genre_id, genre_name) VALUES (4, 'Crime');
INSERT INTO MM_Genres (genre_id, genre_name) VALUES (5, 'Comedy');

-- Movies
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating)
    VALUES (1, 'The Shawshank Redemption', 1994, 1, 1, 9.3);
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating)
    VALUES (2, 'The Godfather', 1972, 1, 2, 9.2);
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating)
    VALUES (3, 'The Dark Knight', 2008, 3, 3, 9.0);
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating)
    VALUES (4, 'Pulp Fiction', 1994, 4, 4, 8.9);
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating)
    VALUES (5, 'The Lord of the Rings: The Return of the King', 2003, 2, 5, 8.9);
---Ratings
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (1, 1, 1, 8.5);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (2, 2, 2, 8.8);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (3, 3, 3, 7.6);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (4, 4, 4, 9.0);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (5, 5, 5, 8.9);

---Recommandations
INSERT INTO MM_Recommendations (recommendation_id, user_id, movie_id) VALUES (1, 1, 3);
INSERT INTO MM_Recommendations (recommendation_id, user_id, movie_id) VALUES (2, 2, 1);
INSERT INTO MM_Recommendations (recommendation_id, user_id, movie_id) VALUES (3, 3, 2);
INSERT INTO MM_Recommendations (recommendation_id, user_id, movie_id) VALUES (4, 4, 5);
INSERT INTO MM_Recommendations (recommendation_id, user_id, movie_id) VALUES (5, 5, 4);


-- MovieActors
INSERT INTO MM_MovieActors (movie_id, actor_id) VALUES (1, 5);
INSERT INTO MM_MovieActors (movie_id, actor_id) VALUES (1, 1);
INSERT INTO MM_MovieActors (movie_id, actor_id) VALUES (2, 2);
INSERT INTO MM_MovieActors (movie_id, actor_id) VALUES (2, 3);
INSERT INTO MM_MovieActors (movie_id, actor_id) VALUES (3, 1);