--> USERS
--> PHOTOS
--> COMMENTS
--> LIKES
--> HASHTAGS
--> FOLLOWERS/FOLLOWEES

--> Users: id, user_name, create_at
CREATE DATABASE ig_clone;
USE ig_clone;

CREATE TABLE users(
id INT AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(255) UNIQUE NOT NULL,
create_at TIMESTAMP DEFAULT  NOW()
);

INSERT INTO users( username ) VALUES ('blueTheCat'),
('Charles Brown'),
('ColtSteeles');

--> photos
CREATE TABLE photos(
id INT AUTO_INCREMENT PRIMARY KEY,
image_url VARCHAR(255) NOT NULL,
user_id INT NOT NULL,
create_at TIMESTAMP DEFAULT NOW(),
FOREIGN KEY(user_id) REFERENCES users(id)
);

INSERT INTO photos(image_url, user_id) VALUES
('/alskjd76',1),
('/alskjd89',2),
('/alskjddd76',2);

SELECT photos.image_url, users.username
FROM photos
JOIN users
    ON photos.user_id = users.id;

--> comment
CREATE TABLE Comments(
id INT AUTO_INCREMENT PRIMARY KEY,
comment_text VARCHAR(255) NOT NULL,
user_id INT NOT NULL,
photo_id INT NOT NULL,
created_id TIMESTAMP DEFAULT NOW(),
FOREIGN KEY(user_id) REFERENCES users(id),
FOREIGN KEY (photo_id) REFERENCES photos(id)
);

INSERT INTO Comments(comment_text, user_id, photo_id) VALUES
('Meow!', 1, 2),
('amazint!', 3, 2),
('I <3 it!', 2, 1);

--> LIKES
CREATE TABLE likes(
    photo_id INT NOT NULL,
    user_id INT NOT NULL,
    create_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(photo_id) REFERENCES  photos(id),
    FOREIGN KEY(user_id) REFERENCES users(id),
    PRIMARY KEY(user_id, photo_id)
);

CREATE TABLE follows(
follower_id INT NOT NULL,
followee_id INT NOT NULL,
create_at TIMESTAMP DEFAULT NOW(),
FOREIGN KEY(followee_id) REFERENCES users(id),
FOREIGN KEY(follower_id) REFERENCES users(id),
PRIMARY KEY( follower_id, followee_id)
);

INSERT INTO follows( follower_id, followee_id) VALUES
(1,2),
(1,3),
(3,1),
(2,3);

CREATE TABLE tags(
    id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photo_tags(
    photo_id INT NOT NULL,
    tag_id INT NOT NULL,
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(tag_id) REFERENCES tags(id),
    PRIMARY KEY(photo_id, tag_id)
);


---- 5 oldest users ---3333

SELECT *
FROM users
ORDER BY created_at
LIMIT 5;
