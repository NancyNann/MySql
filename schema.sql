CREATE TABLE users(
    email VARCHAR(255) PRIMARY KEY,
    create_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO users(email) VALUES
('kATIE34@yahoo.com'),('nancy001993@gmail.com');
---challenge 1 ---
SELECT
    DATE_FORMAT(MIN(create_at)," %M, %D, %Y") AS created_at
FROM users;

--challenge 2
SELECT email, create_at FROM users WHERE create_at = (SELECT MIN(create_at) FROM users);

--challenge 3
SELECT
    MONTHNAME(create_at) AS month, COUNT(*) AS count
FROM users
GROUP BY month
ORDER BY count DESC;

-- challenge 4, find users with yahoo email
SELECT COUNT(*) AS yahoo_users FROM users
    WHERE email LIKE '%yahoo.com%';

SELECT
    CASE
        WHEN email LIKE '%yahoo.com' THEN 'yahoo'
        WHEN email LIKE '%gmail.com' THEN 'gmail'
        WHEN email LIKE '%@hotmail.com' THEN 'hotmail'
        ELSE 'other'
    END AS provider,
    COUNT(*) as total_users
FROM users
GROUP BY provider;