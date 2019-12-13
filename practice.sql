CREATE TABLE Reviewers(
id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(100),
last_name VARCHAR(100)
);

CREATE TABLE Series(
id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(100) NOT NULL,
released_year INT NOT NULL,
genre VARCHAR(100)
);

CREATE TABLE Reviews(
id INT AUTO_INCREMENT PRIMARY KEY,
rating DECIMAL(2,1) NOT NULL,
reviewer_id INT NOT NULL,
series_id INT NOT NULL,
FOREIGN KEY (series_id) REFERENCES Series(id),
FOREIGN KEY(reviewer_id) REFERENCES Reviewers(id)
);

INSERT INTO series (title, released_year, genre) VALUES
    ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ("Bob's Burgers", 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ("Breaking Bad", 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ("Fargo", 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');


INSERT INTO reviews(series_id, reviewer_id, rating) VALUES
    (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
    (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
    (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
    (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
    (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
    (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
    (7,2,9.1),(7,5,9.7),
    (8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
    (9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
    (10,5,9.9),
    (13,3,8.0),(13,4,7.2),
    (14,2,8.5),(14,3,8.9),(14,4,8.9);

SELECT Series.id, Series.genre, Series.released_year, Series.released_year, Reviews.rating
FROM Series
join Reviews
    ON Series.id = Reviews.series_id;

---- PRACTICE 2 -----
SELECT Series.id, Series.title, AVG(Reviews.rating) AS ave_rating FROM Series
    JOIN Reviews
    ON Series.id = Reviews.series_id
    GROUP BY Series.id
    ORDER BY ave_rating;

---- PRACTICE 3 -------
SELECT first_name, last_name, rating FROM Reviewers
JOIN Reviews ON Reviewers.id = Reviews.reviewer_id

---- PRACTICE 4 ------- UNREVIEWED SERIES
SELECT title
FROM Series
LEFT JOIN Reviews
    ON Series.id = Reviews.series_id
    WHERE rating is NULL;

----- PRACTICE 5 ----- genre average rating
SELECT Series.genre, AVG(Reviews.rating) as ave_rating
FROM Series
INNER JOIN Reviews
    ON series.id=Reviews.series_id
    GROUP BY genre;

---- PRACTICE 6 ----
SELECT first_name, last_name, COUNT(first_name) as COUNT, IFNULL(MIN(rating),0) AS MIN, IFNULL(MAX(rating),0) AS MAX, IFNULL(AVG(rating), 0) AS AVG,
CASE
    WHEN COUNT(rating) > 10 THEN 'super ACTIVE'
    WHEN COUNT(rating) > 0 THEN 'ACTIVE'
    ELSE 'INACTIVE'
END AS STATUS
FROM Reviewers
LEFT JOIN Reviews
    ON Reviewers.id = Reviews.reviewer_id
    GROUP BY first_name, last_name;
---- PRACTICE 6 or ----
SELECT first_name, last_name, COUNT(first_name) as COUNT, IFNULL(MIN(rating),0) AS MIN, IFNULL(MAX(rating),0) AS MAX, IFNULL(AVG(rating), 0) AS AVG,
IF(COUNT(rating)>0, 'ACTIVE', 'INACTIVE')
FROM Reviewers
LEFT JOIN Reviews
    ON Reviewers.id = Reviews.reviewer_id
    GROUP BY first_name, last_name;

---- PRACTICE 7 -----
SELECT title, rating, CONCAT(first_name,' ',last_name) AS reviewer
FROM Reviewers
INNER JOIN Reviews ON Reviewers.id = Reviews.reviewer_id
INNER JOIN Series ON Series.id = Reviews.series_id;

-- most popular registration date ---
SELECT
    DAYNAME(created_at) AS dayy,
    COUNT(*) AS Total
FROM users
GROUP BY dayy
ORDER BY Total

--- find the inactive users ( users with no photos)
SELECT username FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
    WHERE photos.id IS NULL ;