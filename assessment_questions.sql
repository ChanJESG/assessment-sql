USE userprogressdb;

-- 1. Analyse the data
-- Hint: use a SELECT statement via a JOIN to sample the data
-- ****************************************************************
SELECT u.*, p.*
FROM users u JOIN progress p
ON u.user_id = p.user_id;

-- 2. What are the Top 25 schools (.edu domains)?
-- Hint: use an aggregate function to COUNT() schools with most students
-- ****************************************************************
SELECT u.email_domain, COUNT(u.email_domain) AS "Number of Schools - Top 25"
    FROM users u
    WHERE u.email_domain LIKE "%edu"
    GROUP BY u.email_domain
    ORDER BY `Number of Schools - Top 25` DESC
    LIMIT 25;

-- 3. How many .edu learners are located in New York?
-- Hint: use an aggregate function to COUNT() students in New York
-- ****************************************************************
SELECT u.city, COUNT(u.city) AS "Number of students in New York"
    FROM users u
    WHERE u.email_domain LIKE "%edu" AND u.city IN ("New York");

-- 4. The mobile_app column contains either mobile-user or NULL. 
-- How many of these learners are using the mobile app?
-- Hint: COUNT()...WHERE...IN()...GROUP BY...
-- Hint: Alternate answers are accepted.
-- ****************************************************************
SELECT u.mobile_app, COUNT(u.mobile_app) AS "Number of Mobile App Users"
    FROM users u
    WHERE u.mobile_app IN ("mobile-user")
    GROUP BY u.mobile_app;

-- 5. Query for the sign up counts for each hour.
-- Hint: https://dev.mysql.com/doc/refman/5.7/en/date-and-time-functions.html#function_date-format 
-- ****************************************************************
SELECT EXTRACT(HOUR FROM u.sign_up_at) AS "Sign-Up Hour", COUNT(u.user_id) AS "Sign-Up Count"
    FROM users u
    GROUP BY `Sign-Up Hour`
    ORDER BY `Sign-Up Hour` DESC;

-- 6. What courses are the New Yorker Students taking?
-- Hint: SUM(CASE WHEN learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "New Yorker learners taking C++"
-- ****************************************************************
SELECT u.city,
SUM(CASE WHEN p.learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "New Yorker learners taking C++",
SUM(CASE WHEN p.learn_sql NOT IN('') THEN 1 ELSE 0 END) AS "New Yorker learners taking SQL",
SUM(CASE WHEN p.learn_html NOT IN('') THEN 1 ELSE 0 END) AS "New Yorker learners taking HTML",
SUM(CASE WHEN p.learn_javascript NOT IN('') THEN 1 ELSE 0 END) AS "New Yorker learners taking JavaScript",
SUM(CASE WHEN p.learn_java NOT IN('') THEN 1 ELSE 0 END) AS "New Yorker learners taking Java"
    FROM users u JOIN progress p
    ON u.user_id = p.user_id
    WHERE u.city IN ("New York");


-- 7. What courses are the Chicago Students taking?
-- Hint: SUM(CASE WHEN learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking C++"
-- ****************************************************************
SELECT u.city,
SUM(CASE WHEN p.learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking C++",
SUM(CASE WHEN p.learn_sql NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking SQL",
SUM(CASE WHEN p.learn_html NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking HTML",
SUM(CASE WHEN p.learn_javascript NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking JavaScript",
SUM(CASE WHEN p.learn_java NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking Java"
    FROM users u JOIN progress p
    ON u.user_id = p.user_id
    WHERE u.city IN ("Chicago");

