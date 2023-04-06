DROP TABLE MM_MovieActors CASCADE CONSTRAINTS;
DROP TABLE MM_MovieGenre CASCADE CONSTRAINTS;
DROP TABLE MM_Ratings CASCADE CONSTRAINTS;
DROP TABLE MM_Movies CASCADE CONSTRAINTS;
DROP TABLE MM_Genres CASCADE CONSTRAINTS;
DROP TABLE MM_Actors CASCADE CONSTRAINTS;
DROP TABLE MM_Users CASCADE CONSTRAINTS;
DROP TABLE error_log CASCADE CONSTRAINTS;
DROP SEQUENCE user_id_seq;
DROP SEQUENCE actor_id_seq;
DROP SEQUENCE error_log_seq
DROP TRIGGER TR_MM_MOVIES_INSERT;
DROP TRIGGER TR_update_avg_rating;
DROP TRIGGER TR_MM_Movies;
DROP PROCEDURE add_movie;
--DROP PROCEDURE get_top_rated_movie;
DROP PROCEDURE get_top_5;
DROP FUNCTION get_movies_by_actor;
DROP FUNCTION get_movies_by_genre;
