-- Create the database
CREATE DATABASE sqlproject;

-- Use the database
USE sqlproject;

-- Create the artist table
CREATE TABLE artist (
  artist_id INT PRIMARY KEY,
  artist_name VARCHAR(255),
  artist_gender VARCHAR(255)
);

-- Insert data into the artist table
INSERT INTO artist VALUES (10, 'yash', 'male');
INSERT INTO artist VALUES (20, 'radhika', 'female');
INSERT INTO artist VALUES (30, 'ranveer', 'male');
INSERT INTO artist VALUES (40, 'rakshitha', 'female');
INSERT INTO artist VALUES (50, 'punith', 'male');

-- Select all records from the artist table
SELECT * FROM artist;

-- Create the director table
CREATE TABLE director (
  director_id INT PRIMARY KEY,
  director_name VARCHAR(255),
  director_place VARCHAR(255)
);

-- Insert data into the director table
INSERT INTO director VALUES (101, 'prashanth', 'benglore');
INSERT INTO director VALUES (102, 'mouli', 'Andrapradesh');
INSERT INTO director VALUES (103, 'YOGRAJ', 'mysore');
INSERT INTO director VALUES (104, 'chandru', 'mandaya');
INSERT INTO director VALUES (105, 'rishabshetty', 'manglore');

-- Select all records from the director table
SELECT * FROM director;

-- Create the movie table
CREATE TABLE movie (
  film_id INT PRIMARY KEY,
  film_name VARCHAR(255),
  film_year INT,
  film_language VARCHAR(255),
  director_id INT
);

-- Insert data into the movie table
INSERT INTO movie VALUES (201, 'kantara', 2021, 'kannada', 105);
INSERT INTO movie VALUES (202, 'padhmavathi', 2016, 'hindi', 101);
INSERT INTO movie VALUES (203, 'jamesbond', 2015, 'english', 103);
INSERT INTO movie VALUES (204, 'avengers', 2018, 'english', 102);
INSERT INTO movie VALUES (205, 'kantara', 2021, 'kannada', 104);

-- Select all records from the movie table
SELECT * FROM movie;

-- Create the casting table
CREATE TABLE casting (
  artist_id INT,
  film_id INT,
  character_name VARCHAR(255)
);

-- Add foreign key constraints to the casting table
ALTER TABLE casting ADD CONSTRAINT fk_artist_id FOREIGN KEY (artist_id) REFERENCES artist (artist_id);
ALTER TABLE casting ADD CONSTRAINT fk_film_id FOREIGN KEY (film_id) REFERENCES movie (film_id);

-- Insert data into the casting table
INSERT INTO casting VALUES (20, 201, 'hero');
INSERT INTO casting VALUES (50, 203, 'heroin');
INSERT INTO casting VALUES (10, 202, 'mother');
INSERT INTO casting VALUES (40, 204, 'father');
INSERT INTO casting VALUES (30, 202, 'sister');

-- Select all records from the casting table
SELECT * FROM casting;

-- Create the review table
CREATE TABLE review (
  film_id INT,
  stars INT
);

-- Add foreign key constraint to the review table
ALTER TABLE review ADD CONSTRAINT fk_film_id FOREIGN KEY (film_id) REFERENCES movie (film_id);

-- Insert data into the review table
INSERT INTO review VALUES (205, 4);
INSERT INTO review VALUES (202, 3);
INSERT INTO review VALUES (204, 1);
INSERT INTO review VALUES (201, 5);
INSERT INTO review VALUES (202, 2);

-- Select all records from the review table
SELECT * FROM review;

-- Display the movies releasing on a particular release date
SELECT film_name
FROM movie
WHERE film_year = 2015;

-- Display all the artists who acted in a film between 2015 and 2019
SELECT a.artist_name, m.film_name, m.film_year
FROM artist a
JOIN casting c ON a.artist_id = c.artist_id
JOIN movie m ON c.film_id = m.film_id
WHERE m.film_year BETWEEN 2015 AND 2019;

-- Display the names of all the films whose director is "YOGRAJ"
SELECT film_name
FROM movie
WHERE director_id = (SELECT director_id FROM director WHERE director_name = 'YOGRAJ');

-- Display the names of films with the stars received and sort the results based on stars
SELECT m.film_name, r.stars
FROM movie m
JOIN review r ON m.film_id = r.film_id
ORDER BY r.stars;

-- Update the stars of all films whose director's name is "YOGRAJ" to 5
UPDATE review
SET stars = 5
WHERE film_id IN (SELECT film_id
                  FROM movie
                  WHERE director_id IN (SELECT director_id
                                       FROM director
                                       WHERE director_name = 'YOGRAJ'));

-- Display the full join for movie and casting
SELECT *
FROM movie
LEFT JOIN casting ON movie.film_id = casting.film_id
UNION ALL
SELECT *
FROM casting
RIGHT JOIN movie ON movie.film_id = casting.film_id;
