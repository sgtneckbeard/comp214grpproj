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
INSERT INTO MM_Actors (actor_name) VALUES ('Angelina Jolie');
INSERT INTO MM_Actors (actor_name) VALUES ('Brad Pitt');
INSERT INTO MM_Actors (actor_name) VALUES ('Scarlett Johansson');
INSERT INTO MM_Actors (actor_name) VALUES ('Robert De Niro');
INSERT INTO MM_Actors (actor_name) VALUES ('Emma Stone');
INSERT INTO MM_Actors (actor_name) VALUES ('Chris Hemsworth');
INSERT INTO MM_Actors (actor_name) VALUES ('Charlize Theron');
INSERT INTO MM_Actors (actor_name) VALUES ('Samuel L. Jackson');
INSERT INTO MM_Actors (actor_name) VALUES ('Kate Winslet');
INSERT INTO MM_Actors (actor_name) VALUES ('Ryan Gosling');

-- Users
INSERT INTO MM_Users (username, password, email) VALUES ('jdoe', 'password123', 'jdoe@example.com');
INSERT INTO MM_Users (username, password, email) VALUES ('jsmith', 'password456', 'jsmith@example.com');
INSERT INTO MM_Users (username, password, email) VALUES ('janedoe', 'password789', 'janedoe@example.com');
INSERT INTO MM_Users (username, password, email) VALUES ('bobsmith', 'passwordabc', 'bobsmith@example.com');
INSERT INTO MM_Users (username, password, email) VALUES ('katejones', 'passworddef', 'katejones@example.com');
INSERT INTO MM_Users (username, password, email) VALUES ('johnsmith', 'p@ssw0rd', 'johnsmith@example.com');
INSERT INTO MM_Users (username, password, email) VALUES ('lucycarter', 'qwerty123', 'lucycarter@example.com');
INSERT INTO MM_Users (username, password, email) VALUES ('mikebrown', 'letmein123', 'mikebrown@example.com');
INSERT INTO MM_Users (username, password, email) VALUES ('sarahwilson', 'hello123', 'sarahwilson@example.com');
INSERT INTO MM_Users (username, password, email) VALUES ('jenniferlee', 'iloveyou123', 'jenniferlee@example.com');
INSERT INTO MM_Users (username, password, email) VALUES ('davidsmith', 'welcome123', 'davidsmith@example.com');
INSERT INTO MM_Users (username, password, email) VALUES ('amandajones', 'abc123', 'amandajones@example.com');
INSERT INTO MM_Users (username, password, email) VALUES ('peterparker', 'spiderman123', 'peterparker@example.com');
INSERT INTO MM_Users (username, password, email) VALUES ('lisawalker', 'password1234', 'lisawalker@example.com');
INSERT INTO MM_Users (username, password, email) VALUES ('samuelbrown', 'qazwsxedc123', 'samuelbrown@example.com');

-- Directors
INSERT INTO MM_Directors (director_id, director_name) VALUES (1, 'Frank Darabont');
INSERT INTO MM_Directors (director_id, director_name) VALUES (2, 'Francis Ford Coppola');
INSERT INTO MM_Directors (director_id, director_name) VALUES (3, 'Christopher Nolan');
INSERT INTO MM_Directors (director_id, director_name) VALUES (4, 'Quentin Tarantino');
INSERT INTO MM_Directors (director_id, director_name) VALUES (5, 'Peter Jackson');
INSERT INTO MM_Directors (director_id, director_name) VALUES (6, 'Steven Spielberg');
INSERT INTO MM_Directors (director_id, director_name) VALUES (7, 'Martin Scorsese');
INSERT INTO MM_Directors (director_id, director_name) VALUES (8, 'James Cameron');
INSERT INTO MM_Directors (director_id, director_name) VALUES (9, 'Alfred Hitchcock');
INSERT INTO MM_Directors (director_id, director_name) VALUES (10, 'Stanley Kubrick');
INSERT INTO MM_Directors (director_id, director_name) VALUES (11, 'Tim Burton');
INSERT INTO MM_Directors (director_id, director_name) VALUES (12, 'David Fincher');
INSERT INTO MM_Directors (director_id, director_name) VALUES (13, 'Ridley Scott');
INSERT INTO MM_Directors (director_id, director_name) VALUES (14, 'Greta Gerwig');
INSERT INTO MM_Directors (director_id, director_name) VALUES (15, 'Sofia Coppola');

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
 VALUES (5, 'The Lord of the Rings: The Fellowship of the Ring', 2001, 2, 5, 8.8);
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating) 
VALUES (6, 'Schindler''s List', 1993, 1, 6, 8.9);
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating) 
VALUES (7, 'Goodfellas', 1990, 4, 7, 8.7);
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating) 
VALUES (8, 'Titanic', 1997, 1, 8, 7.8);
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating) 
VALUES (9, 'Psycho', 1960, 1, 9, 8.5);
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating) 
VALUES (10, 'The Shining', 1980, 1, 10, 8.4);
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating) 
VALUES (11, 'Edward Scissorhands', 1990, 5, 11, 7.9);
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating) 
VALUES (12, 'Fight Club', 1999, 1, 12, 8.8);
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating) 
VALUES (13, 'Gladiator', 2000, 3, 13, 8.5);
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating) 
VALUES (14, 'Little Women', 2019, 1, 14, 7.9);
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating) 
VALUES (15, 'Lost in Translation', 2003, 1, 15, 7.7);

---Ratings
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (1, 1, 1, 8.5);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (2, 2, 2, 8.8);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (3, 3, 3, 7.6);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (4, 4, 4, 9.0);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (5, 5, 5, 8.9);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (6, 1, 2, 7.8);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (7, 2, 3, 8.2);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (8, 3, 4, 6.5);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (9, 4, 5, 7.9);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (10, 5, 1, 8.0);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (11, 1, 3, 8.1);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (12, 2, 4, 7.3);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (13, 3, 5, 8.6);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (14, 4, 1, 9.5);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (15, 5, 2, 8.4);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (16, 1, 4, 7.1);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (17, 2, 5, 8.7);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (18, 3, 1, 7.9);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (19, 4, 2, 9.1);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (20, 5, 3, 8.3);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (21, 1, 5, 6.9);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (22, 2, 1, 8.6);
INSERT INTO MM_Ratings (rating_id, movie_id, user_id, rating_value) VALUES (23, 3, 2, 7.8);



-- MovieActors
INSERT INTO MM_MovieActors (movie_id, actor_id) VALUES (1, 1);
INSERT INTO MM_MovieActors (movie_id, actor_id) VALUES (1, 2);
INSERT INTO MM_MovieActors (movie_id, actor_id) VALUES (2, 4);
INSERT INTO MM_MovieActors (movie_id, actor_id) VALUES (2, 8);
INSERT INTO MM_MovieActors (movie_id, actor_id) VALUES (3, 3);
INSERT INTO MM_MovieActors (movie_id, actor_id) VALUES (3, 13);
INSERT INTO MM_MovieActors (movie_id, actor_id) VALUES (4, 4);
INSERT INTO MM_MovieActors (movie_id, actor_id) VALUES (4, 9);
INSERT INTO MM_MovieActors (movie_id, actor_id) VALUES (5, 1);
INSERT INTO MM_MovieActors (movie_id, actor_id) VALUES (5, 13);
INSERT INTO MM_MovieActors (movie_id, actor_id) VALUES (6, 2);
INSERT INTO MM_MovieActors (movie_id, actor_id) VALUES (6, 9);
INSERT INTO MM_MovieActors (movie_id, actor_id) VALUES (7, 9);
INSERT INTO MM_MovieActors (movie_id, actor_id) VALUES (7, 4);
INSERT INTO MM_MovieActors (movie_id, actor_id) VALUES (8, 1);
INSERT INTO MM_MovieActors (movie_id, actor_id) VALUES (8, 14);