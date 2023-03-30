DROP TABLE MM_MovieActors CASCADE CONSTRAINTS;
DROP TABLE MM_MovieGenre CASCADE CONSTRAINTS;
DROP TABLE MM_Ratings CASCADE CONSTRAINTS;
DROP TABLE MM_Movies CASCADE CONSTRAINTS;
DROP TABLE MM_Directors CASCADE CONSTRAINTS;
DROP TABLE MM_Genres CASCADE CONSTRAINTS;
DROP TABLE MM_Actors CASCADE CONSTRAINTS;
DROP TABLE MM_Users CASCADE CONSTRAINTS;
DROP SEQUENCE user_id_seq ;
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
    actor_id Number(6) PRIMARY KEY,
    actor_name VARCHAR(100)
);

CREATE TABLE MM_Users (
    user_id Number(6) PRIMARY KEY,
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
    description VARCHAR(280),
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
INSERT INTO MM_Actors (actor_id, actor_name) VALUES (actor_id_seq.NEXTVAL, 'Tom Hanks');
INSERT INTO MM_Actors (actor_id, actor_name) VALUES (actor_id_seq.NEXTVAL, 'Meryl Streep');
INSERT INTO MM_Actors (actor_id, actor_name) VALUES (actor_id_seq.NEXTVAL, 'Denzel Washington');
INSERT INTO MM_Actors (actor_id, actor_name) VALUES (actor_id_seq.NEXTVAL, 'Viola Davis');
INSERT INTO MM_Actors (actor_id, actor_name) VALUES (actor_id_seq.NEXTVAL, 'Leonardo DiCaprio');
INSERT INTO MM_Actors (actor_id, actor_name) VALUES (actor_id_seq.NEXTVAL, 'Angelina Jolie');
INSERT INTO MM_Actors (actor_id, actor_name) VALUES (actor_id_seq.NEXTVAL, 'Brad Pitt');
INSERT INTO MM_Actors (actor_id, actor_name) VALUES (actor_id_seq.NEXTVAL, 'Scarlett Johansson');
INSERT INTO MM_Actors (actor_id, actor_name) VALUES (actor_id_seq.NEXTVAL, 'Robert De Niro');
INSERT INTO MM_Actors (actor_id, actor_name) VALUES (actor_id_seq.NEXTVAL, 'Emma Stone');
INSERT INTO MM_Actors (actor_id, actor_name) VALUES (actor_id_seq.NEXTVAL, 'Chris Hemsworth');
INSERT INTO MM_Actors (actor_id, actor_name) VALUES (actor_id_seq.NEXTVAL, 'Charlize Theron');
INSERT INTO MM_Actors (actor_id, actor_name) VALUES (actor_id_seq.NEXTVAL, 'Samuel L. Jackson');
INSERT INTO MM_Actors (actor_id, actor_name) VALUES (actor_id_seq.NEXTVAL, 'Kate Winslet');
INSERT INTO MM_Actors (actor_id, actor_name) VALUES (actor_id_seq.NEXTVAL, 'Ryan Gosling');

-- Users
INSERT INTO MM_Users (user_id, username, password, email) VALUES (user_id_seq.NEXTVAL, 'jdoe', 'password123', 'jdoe@example.com');
INSERT INTO MM_Users (user_id, username, password, email) VALUES (user_id_seq.NEXTVAL, 'jsmith', 'password456', 'jsmith@example.com');
INSERT INTO MM_Users (user_id, username, password, email) VALUES (user_id_seq.NEXTVAL, 'janedoe', 'password789', 'janedoe@example.com');
INSERT INTO MM_Users (user_id, username, password, email) VALUES (user_id_seq.NEXTVAL, 'bobsmith', 'passwordabc', 'bobsmith@example.com');
INSERT INTO MM_Users (user_id, username, password, email) VALUES (user_id_seq.NEXTVAL, 'katejones', 'passworddef', 'katejones@example.com');
INSERT INTO MM_Users (user_id, username, password, email) VALUES (user_id_seq.NEXTVAL, 'johnsmith', 'p@ssw0rd', 'johnsmith@example.com');
INSERT INTO MM_Users (user_id, username, password, email) VALUES (user_id_seq.NEXTVAL, 'lucycarter', 'qwerty123', 'lucycarter@example.com');
INSERT INTO MM_Users (user_id, username, password, email) VALUES (user_id_seq.NEXTVAL, 'mikebrown', 'letmein123', 'mikebrown@example.com');
INSERT INTO MM_Users (user_id, username, password, email) VALUES (user_id_seq.NEXTVAL, 'sarahwilson', 'hello123', 'sarahwilson@example.com');
INSERT INTO MM_Users (user_id, username, password, email) VALUES (user_id_seq.NEXTVAL, 'jenniferlee', 'iloveyou123', 'jenniferlee@example.com');
INSERT INTO MM_Users (user_id, username, password, email) VALUES (user_id_seq.NEXTVAL, 'davidsmith', 'welcome123', 'davidsmith@example.com');
INSERT INTO MM_Users (user_id, username, password, email) VALUES (user_id_seq.NEXTVAL, 'amandajones', 'abc123', 'amandajones@example.com');
INSERT INTO MM_Users (user_id, username, password, email) VALUES (user_id_seq.NEXTVAL, 'peterparker', 'spiderman123', 'peterparker@example.com');
INSERT INTO MM_Users (user_id, username, password, email) VALUES (user_id_seq.NEXTVAL, 'lisawalker', 'password1234', 'lisawalker@example.com');
INSERT INTO MM_Users (user_id, username, password, email) VALUES (user_id_seq.NEXTVAL, 'samuelbrown', 'qazwsxedc123', 'samuelbrown@example.com');

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
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating, description)
VALUES (1, 'The Shawshank Redemption', 1994, 1, 1, 9.3, 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.');
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating, description)
VALUES (2, 'The Godfather', 1972, 1, 2, 9.2, 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.');
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating, description)
VALUES (3, 'The Dark Knight', 2008, 3, 3, 9.0, 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.');
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating, description)
VALUES (4, 'Pulp Fiction', 1994, 4, 4, 8.9, 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.');
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating, description)
VALUES (5, 'The Lord of the Rings The Fellowship of the Ring', 2001, 2, 5, 8.8, 'A young hobbit, Frodo, who has found the One Ring that belongs to the Dark Lord Sauron, begins his journey with eight companions to Mount Doom, the only place where it can be destroyed.');
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating, description)
VALUES (6, 'Schindler''s List', 1993, 1, 6, 8.9, 'In Poland during World War II, Oskar Schindler gradually becomes concerned for his Jewish workforce after witnessing their persecution by the Nazis.');
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating, description)
VALUES (7, 'Goodfellas', 1990, 4, 7, 8.7, 'The story of Henry Hill and his life in the mob, covering his relationship with his wife Karen Hill and his mob partners Jimmy Conway and Tommy DeVito in the Italian-American crime syndicate.');
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating, description)
VALUES (8, 'Titanic', 1997, 1, 8, 7.8, 'A seventeen-year-old aristocrat falls in love with a kind but poor artist aboard the luxurious, ill-fated R.M.S. Titanic.');
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating, description)
VALUES (9, 'Psycho', 1960, 1, 9, 8.5, 'A Phoenix secretary embezzles $40,000 from her employer''s client, goes on the run, and checks into a remote motel run by a young man under the domination of his mother.');
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating, description)
VALUES (10, 'The Shining', 1980, 1, 10, 8.4, 'A family heads to an isolated hotel for the winter where a sinister presence influences the father into violence, while his psychic son sees horrific forebodings from both past and future.');
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating, description)
VALUES (11, 'Edward Scissorhands', 1990, 5, 11, 7.9, 'A gentle man with scissors for hands is brought into a new community after living in isolation.');
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating, description)
VALUES (12, 'Fight Club', 1999, 1, 12, 8.8, 'An insomniac office worker and a devil-may-care soapmaker form an underground fight club that evolves into something much, much more.');
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating, description)
VALUES (13, 'Gladiator', 2000, 3, 13, 8.5, 'A former Roman General sets out to exact vengeance against the corrupt emperor who murdered his family and sent him into slavery.');
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating, description)
VALUES (14, 'Little Women', 2019, 1, 14, 7.9, 'Jo March reflects back and forth on her life, telling the beloved story of the March sisters - four young women each determined to live life on her own terms.');
INSERT INTO MM_Movies (movie_id, movie_title, release_year, genre_id, director_id, average_rating, description)
VALUES (15, 'Lost in Translation', 2003, 1, 15, 7.7, 'A faded movie star and a neglected young woman form an unlikely bond after crossing paths in Tokyo.');

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