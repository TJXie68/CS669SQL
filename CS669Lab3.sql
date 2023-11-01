CREATE TABLE Genre(
genre_id DECIMAL(12) NOT NULL PRIMARY KEY,
genre_name VARCHAR(64) NOT NULL);
CREATE TABLE Creator(
creator_id DECIMAL(12) NOT NULL PRIMARY KEY,
first_name VARCHAR(64) NOT NULL,
last_name VARCHAR(64) NOT NULL);
CREATE TABLE Movie_series(
movie_series_id DECIMAL(12) NOT NULL PRIMARY KEY,
genre_id DECIMAL(12) NOT NULL,
creator_id DECIMAL(12) NOT NULL,
series_name VARCHAR(255) NOT NULL,
suggested_price DECIMAL(8,2) NULL,
FOREIGN KEY (genre_id) REFERENCES Genre(genre_id),
FOREIGN KEY (creator_id) REFERENCES Creator(creator_id));
CREATE TABLE Movie(
movie_id DECIMAL(12) NOT NULL PRIMARY KEY,
movie_series_id DECIMAL(12) NOT NULL,
movie_name VARCHAR(64) NOT NULL,
length_in_minutes DECIMAL(4),
FOREIGN KEY (movie_series_id) REFERENCES Movie_series(movie_series_id));

INSERT INTO Genre(genre_id, genre_name)
VALUES(1, 'Fantasy');
INSERT INTO Genre(genre_id, genre_name)
VALUES(2, 'Family Film');
INSERT INTO Genre(genre_id, genre_name)
VALUES(3, 'Action');

INSERT INTO  Creator(creator_id, first_name, last_name)
VALUES(101, 'George', 'Lucas');
INSERT INTO  Creator(creator_id, first_name, last_name)
VALUES(102, 'John', 'Lasseter');
INSERT INTO  Creator(creator_id, first_name, last_name)
VALUES(103, 'John', 'Tolkien');
INSERT INTO  Creator(creator_id, first_name, last_name)
VALUES(104, 'Steven', 'Spielberg');

INSERT INTO Movie_series(movie_series_id, genre_id, creator_id, series_name, suggested_price)
VALUES(1001, 1, 101, 'Star Wars', 129.99);
INSERT INTO Movie_series(movie_series_id, genre_id, creator_id, series_name, suggested_price)
VALUES(1002, 2, 102, 'Toy Story', 22.13);
INSERT INTO Movie_series(movie_series_id, genre_id, creator_id, series_name, suggested_price)
VALUES(1003, 1, 103, 'Lord of the Rings', NULL);
INSERT INTO Movie_series(movie_series_id, genre_id, creator_id, series_name, suggested_price)
VALUES(1004, 3, 104, 'Jurassic Park', 59.99);

INSERT INTO Movie(movie_id, movie_series_id, movie_name, length_in_minutes)
VALUES(10011, 1001, 'Episode I: The Phantom Menace', 136);
INSERT INTO Movie(movie_id, movie_series_id, movie_name, length_in_minutes)
VALUES(10012, 1001, 'Episode II: Attack of the Clones', 142);
INSERT INTO Movie(movie_id, movie_series_id, movie_name, length_in_minutes)
VALUES(10013, 1001, 'Episode III: Revenge of the Sith', 140);
INSERT INTO Movie(movie_id, movie_series_id, movie_name, length_in_minutes)
VALUES(10014, 1001, 'Episode IV: A New Hope', 121);
INSERT INTO Movie(movie_id, movie_series_id, movie_name, length_in_minutes)
VALUES(10021, 1002, 'Toy Story', 121);
INSERT INTO Movie(movie_id, movie_series_id, movie_name, length_in_minutes)
VALUES(10022, 1002, 'Toy Story 2', 135);
INSERT INTO Movie(movie_id, movie_series_id, movie_name, length_in_minutes)
VALUES(10023, 1002, 'Toy Story 3', 148);
INSERT INTO Movie(movie_id, movie_series_id, movie_name, length_in_minutes)
VALUES(10031, 1003, 'The Lord of the Rings: The Fellowship of the Ring', 228);
INSERT INTO Movie(movie_id, movie_series_id, movie_name, length_in_minutes)
VALUES(10032, 1003, 'The Lord of the Rings: The Two Towers', 235);
INSERT INTO Movie(movie_id, movie_series_id, movie_name, length_in_minutes)
VALUES(10033, 1003, 'The Lord of the Rings: The Return of the King', 200);
INSERT INTO Movie(movie_id, movie_series_id, movie_name, length_in_minutes)
VALUES(10041, 1004, 'Jurassic Park', 127);
INSERT INTO Movie(movie_id, movie_series_id, movie_name, length_in_minutes)
VALUES(10042, 1004, 'The Lost World: Jurassic Park', 129);
INSERT INTO Movie(movie_id, movie_series_id, movie_name, length_in_minutes)
VALUES(10043, 1004, 'Jurassic Park III', 92);

SELECT COUNT(*) AS num_Movie
FROM Movie;

SELECT CONCAT('$', MIN(suggested_price))
AS least_expensive
FROM Movie_series;
SELECT CONCAT('$', MAX(suggested_price))
AS least_expensive
FROM Movie_series;

SELECT movie_name, CONCAT('$', MIN(suggested_price)) AS least_expensive
FROM Movie_series 
JOIN Movie ON Movie.movie_series_id = Movie_series.movie_series_id
GROUP BY movie_series_id, movie_name;

SELECT series_name, CONCAT('$', MIN(suggested_price))    AS movie_series_price, 
COUNT(movie.movie_name) AS number_of_movies
FROM Movie
JOIN Movie_series ON Movie_series.movie_series_id = Movie.movie_series_id
GROUP BY movie_series.movie_series_id, series_name;

SELECT genre_name, COUNT(Movie.movie_id) AS number_of_movies
FROM Movie
JOIN Movie_series ON Movie_series.movie_series_id = Movie.movie_series_id
JOIN Genre ON Genre.genre_id = Movie_series.genre_id
GROUP BY Genre.genre_id, Genre.genre_name
HAVING COUNT(Movie.movie_id) >= 7;

SELECT series_name, SUM(length_in_minutes) AS total_length
FROM Movie
JOIN Movie_series ON Movie_series.movie_series_id = Movie.movie_series_id
GROUP BY Movie_series.movie_series_id, series_name
HAVING SUM(length_in_minutes) >= 600;

SELECT CONCAT_WS(' ', first_name, last_name) AS creator_name, 
COUNT(genre_name = 'Family Film') AS number_of_family_films
FROM Creator
JOIN Movie_series ON Movie_series.creator_id = Creator.creator_id
JOIN Genre ON Genre.genre_id = Movie_series.genre_id
GROUP BY creator_name
ORDER BY number_of_family_films;

select CONCAT_WS(' ', Creator.first_name, Creator.last_name) AS creator_name, 
count(genre_name) as nbr_of_family_films
from Movie_series
join Creator on Creator.creator_id=Movie_series.creator_id
left join Genre on Genre.genre_id=Movie_Series.genre_id and Genre.genre_name='Family Film'
join Movie on Movie.movie_series_id=Movie_series.movie_series_id
group by creator_name, Genre.genre_name
order by nbr_of_family_films desc;