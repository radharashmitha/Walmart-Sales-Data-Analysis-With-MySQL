CREATE DATABASE IF NOT EXISTS salesdatawalmart;

USE salesdatawalmart;

CREATE TABLE IF NOT EXISTS salesdata (
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    VAT FLOAT(6, 4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment_method VARCHAR (15) NOT NULL,
    cogs DECIMAL (10, 2) NOT NULL,
    gross_margin_pct FLOAT(11, 9),
    gross_income DECIMAL(12, 4) NOT NULL,
    rating FLOAT(2, 1)
);

ALTER TABLE salesdata
CHANGE COLUMN VAT tax_pct FLOAT(6, 4) NOT NULL;

-- FEATURE ENGINEEERING
-- time_of_day

SELECT
    time,
    CASE
        WHEN `time` BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN `time` BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_date
FROM salesdata;

ALTER TABLE salesdata ADD COLUMN time_of_day VARCHAR(20);

UPDATE salesdata
SET time_of_day = (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);

-- Add day_name column
SELECT
	date,
	DAYNAME(date)
FROM salesdata;

ALTER TABLE salesdata ADD COLUMN day_name VARCHAR(10);

UPDATE salesdata
SET day_name = DAYNAME(date);

-- Add month_name column
SELECT
	date,
	MONTHNAME(date)
FROM salesdata;

ALTER TABLE salesdata ADD COLUMN month_name VARCHAR(10);

UPDATE salesdata
SET month_name = MONTHNAME(date);

-- ---------------------------- Generic ------------------------------
-- How many unique cities does the data have?
SELECT 
	DISTINCT city
FROM salesdata;

-- In which city is each branch?
SELECT 
	DISTINCT city,
    branch
FROM salesdata;

-- ---------------------------- Product -------------------------------

-- How many unique product lines does the data have?
SELECT
	DISTINCT product_line
FROM salesdata;

-- What is the most selling product line
SELECT
	SUM(quantity) as qty,
    product_line
FROM salesdata
GROUP BY product_line
ORDER BY qty DESC;

-- What is the total revenue by month
SELECT
	month_name AS month,
	SUM(total) AS total_revenue
FROM salesdata
GROUP BY month_name 
ORDER BY total_revenue;


-- What month had the largest COGS?
SELECT
	month_name AS month,
	SUM(cogs) AS cogs
FROM salesdata
GROUP BY month_name 
ORDER BY cogs;


-- What product line had the largest revenue?
SELECT
	product_line,
	SUM(total) as total_revenue
FROM salesdata
GROUP BY product_line
ORDER BY total_revenue DESC;

-- What is the city with the largest revenue?
SELECT
	branch,
	city,
	SUM(total) AS total_revenue
FROM salesdata
GROUP BY city, branch 
ORDER BY total_revenue;

-- What product line had the largest VAT?
SELECT
	product_line,
	AVG(tax_pct) as avg_tax
FROM salesdata
GROUP BY product_line
ORDER BY avg_tax DESC;

-- Fetch each product line and add a column to those product 
-- line showing "Good", "Bad". Good if its greater than average sales

SELECT 
	AVG(quantity) AS avg_qnty
FROM salesdata;

SELECT
	product_line,
	CASE
		WHEN AVG(quantity) > 6 THEN "Good"
        ELSE "Bad"
    END AS remark
FROM salesdata
GROUP BY product_line;


-- What is the most common product line by gender
SELECT
	gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM salesdata
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

-- What is the average rating of each product line
SELECT
	ROUND(AVG(rating), 2) as avg_rating,
    product_line
FROM salesdata
GROUP BY product_line
ORDER BY avg_rating DESC;

 -------------------------- Customers -------------------------------
-- --------------------------------------------------------------------

-- How many unique customer types does the data have?
SELECT
	DISTINCT customer_type
FROM salesdata;

-- How many unique payment methods does the data have?
SELECT
	DISTINCT Payment_method
FROM salesdata;

-- What is the most common customer type?
SELECT
	customer_type,
	count(*) as count
FROM salesdata
GROUP BY customer_type
ORDER BY count DESC;

-- Which customer type buys the most?
SELECT
	customer_type,
    COUNT(*)
FROM salesdata
GROUP BY customer_type;

-- What is the gender of most of the customers?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM salesdata
GROUP BY gender
ORDER BY gender_cnt DESC;

-- What is the gender distribution per branch?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM salesdata
WHERE branch = "C"
GROUP BY gender
ORDER BY gender_cnt DESC;

-- Gender per branch is more or less the same hence, I don't think has
-- an effect of the sales per branch and other factors.

-- Which time of the day do customers give most ratings?
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM salesdata
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Looks like time of the day does not really affect the rating, its
-- more or less the same rating each time of the day.alter


-- Which time of the day do customers give most ratings per branch?
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM salesdata
WHERE branch = "A"
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Branch A and C are doing well in ratings, branch B needs to do a 
-- little more to get better ratings.


-- Which day fo the week has the best avg ratings?
SELECT
	day_name,
	AVG(rating) AS avg_rating
FROM salesdata
GROUP BY day_name 
ORDER BY avg_rating DESC;

-- Mon, Tue and Friday are the top best days for good ratings
-- why is that the case, how many sales are made on these days?

-- Which day of the week has the best average ratings per branch?
SELECT 
	day_name,
	COUNT(day_name) total_sales
FROM salesdata
WHERE branch = "C"
GROUP BY day_name
ORDER BY total_sales DESC;

-- query for segmenting customers based on responsiveness to different types of promotions

SELECT
    customer_type,
    CASE
        WHEN SUM(quantity) > 100 THEN 'High Volume'
        WHEN SUM(quantity) > 50 THEN 'Medium Volume'
        ELSE 'Low Volume'
    END AS segment
FROM salesdata
GROUP BY customer_type;

-- In the above query, customers are categorized into “High Volume,” “Medium Volume,” or “Low Volume” segments based on their purchase quantities.


-- ---------------------------- Sales ---------------------------------
-- --------------------------------------------------------------------

-- Number of sales made in each time of the day per weekday 
SELECT
	time_of_day,
	COUNT(*) AS total_sales
FROM salesdata
WHERE day_name = "Sunday"
GROUP BY time_of_day 
ORDER BY total_sales DESC;

-- Evenings experience most sales, the stores are 
-- filled during the evening hours

-- Which of the customer types brings the most revenue?
SELECT
	customer_type,
	SUM(total) AS total_revenue
FROM salesdata
GROUP BY customer_type
ORDER BY total_revenue;


-- Which city has the largest tax/VAT percent?
SELECT
	city,
    ROUND(AVG(tax_pct), 2) AS avg_tax_pct
FROM salesdata
GROUP BY city 
ORDER BY avg_tax_pct DESC;

-- Which customer type pays the most in VAT?
SELECT
	customer_type,
	AVG(tax_pct) AS total_tax
FROM salesdata
GROUP BY customer_type
ORDER BY total_tax;

