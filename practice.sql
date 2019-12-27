DROP DATABASE IF EXISTS ig_clone;
CREATE DATABASE ig_clone;
USE ig_clone;

CREATE TABLE users (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photos (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(255) NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE comments (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    comment_text VARCHAR(255) NOT NULL,
    photo_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE likes (
    user_id INTEGER NOT NULL,
    photo_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    PRIMARY KEY(user_id, photo_id)
);

CREATE TABLE follows (
    follower_id INTEGER NOT NULL,
    followee_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(follower_id) REFERENCES users(id),
    FOREIGN KEY(followee_id) REFERENCES users(id),
    PRIMARY KEY(follower_id, followee_id)
);

CREATE TABLE tags (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  tag_name VARCHAR(255) UNIQUE,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photo_tags (
    photo_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(tag_id) REFERENCES tags(id),
    PRIMARY KEY(photo_id, tag_id)
);

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

--- find the most popular photo ( and user who created it)
SELECT username, photos.id, photos.image_url, COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
    LIMIT 1;

--- How many times does the average user post ---
--total number of photos / total number of users
SELECT (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS AveragePost

--- 5 most commonly used hashtags ---
SELECT tags.tag_name, COUNT(*) AS total FROM tags
INNER JOIN  photo_tags
    ON photo_tags.tag_id = tags.id
GROUP BY tags.id
ORDER BY total DESC
LIMIT 5;

---- find users who have liked every single photo on the side
SELECT users.username, users.id, COUNT(*) AS num_likes FROM users
INNER JOIN likes
    ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING num_likes = (SELECT COUNT(*) FROM photos);

