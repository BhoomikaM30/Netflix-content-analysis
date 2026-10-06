create database netflix_project;
use netflix_project;
show tables;
DROP TABLE IF EXISTS netflix_cleaned_data;
CREATE TABLE netflix_cleaned_data (
    show_id VARCHAR(10),
    type VARCHAR(20),
    title TEXT,
    director TEXT,
    cast TEXT,
    country TEXT,
    date_added DATE,
    release_year INT,
    rating VARCHAR(10),
    duration VARCHAR(20),
    listed_in TEXT,
    description TEXT,
    year_added INT,
    month_name VARCHAR(15)
);
LOAD DATA LOCAL INFILE 'C:/Users/BHOOMIKA/Downloads/netflix_cleaned_data2.csv'
INTO TABLE netflix_cleaned_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SHOW VARIABLES LIKE 'secure_file_priv';
SHOW VARIABLES LIKE 'secure_file_priv';
SELECT @@secure_file_priv;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/netflix_cleaned_data2.csv'
INTO TABLE netflix_cleaned_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
show tables;
CREATE TABLE netflix_genres (
    show_id VARCHAR(10),
    genre VARCHAR(50)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/netflix_genres.csv'
INTO TABLE netflix_genres
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE netflix_countries (
    show_id VARCHAR(10),
    country VARCHAR(100)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/netflix_country.csv'
INTO TABLE netflix_countries
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;







-- sql quesries 
select * from netflix_cleaned_data;

-- write the query to find out how many titles were added to Netflix each year
select year_added , count(title) from netflix_cleaned_data group by year_added;

-- Now find the split between Movies and TV Shows — how many of each type are in the dataset overall.
select type,  count(*) from netflix_cleaned_data group by type;

-- can you extend this to show the Movie vs TV Show split by year instead of just overall?
select type, year_added, count(*) from netflix_cleaned_data group by type, year_added;

-- Using the netflix_genres table, write a query to find the top 10 most common genres. What would it look like?
select * from netflix_genres;
select genre , count(*) as total from netflix_genres group by genre order by total desc limit 10;

-- Using the netflix_countries table, write a query to find the top 10 countries producing the most content.
select * from netflix_countries;

-- Write a query to find the ratings breakdown — how many titles fall under each rating (TV-MA, PG-13, etc.), sorted from most to least common
select * from netflix_cleaned_data;
select rating , count(title) as total from netflix_cleaned_data group by rating order by total desc limit 10;

-- This one's a bit harder — using a JOIN. Write a query to find, for each year, how many titles were added in the "International Movies" genre specifically.
select * from netflix_cleaned_data;
select * from netflix_genres;
SELECT nc.year_added, COUNT(*) AS total
FROM netflix_cleaned_data AS nc
INNER JOIN netflix_genres AS ng ON nc.show_id = ng.show_id
WHERE ng.genre = 'International Movies'
GROUP BY nc.year_added
ORDER BY nc.year_added;

-- 
select * from netflix_countries;
SELECT DISTINCT country FROM netflix_countries WHERE country LIKE '%United%';
SELECT DISTINCT country FROM netflix_countries WHERE country LIKE '%States%';

DROP TABLE netflix_countries;

CREATE TABLE netflix_countries (
    show_id VARCHAR(10),
    country VARCHAR(100)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/netflix_countries2.csv'
INTO TABLE netflix_countries
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(DISTINCT country) FROM netflix_countries;

