USE walmart_sales;

SELECT * FROM sales;

-- ==================================================================================================================================
-- ============================================= DATA CLEANING PART =================================================================

-- modify all the column after importing CSV file ----------------

ALTER TABLE sales MODIFY COLUMN invoice_id VARCHAR (20) NOT NULL;
ALTER TABLE sales MODIFY COLUMN branch VARCHAR (5) NOT NULL;
ALTER TABLE sales MODIFY COLUMN city VARCHAR (15) NOT NULL;
ALTER TABLE sales MODIFY COLUMN customer_type VARCHAR (15) NOT NULL;
ALTER TABLE sales MODIFY COLUMN gender VARCHAR (10) NOT NULL;
ALTER TABLE sales MODIFY COLUMN product_line VARCHAR (30) NOT NULL;
ALTER TABLE sales MODIFY COLUMN unite_price DECIMAL (10,2) NOT NULL;
ALTER TABLE sales MODIFY COLUMN quantity INT NOT NULL;
ALTER TABLE sales MODIFY COLUMN sales INT NOT NULL;
ALTER TABLE sales MODIFY COLUMN tax_percentage DECIMAL (6,4) NOT NULL;
ALTER TABLE sales MODIFY COLUMN total DECIMAL (12,4) NOT NULL;
ALTER TABLE sales MODIFY COLUMN time TIME NOT NULL;
ALTER TABLE sales MODIFY COLUMN payment VARCHAR (20) NOT NULL;
ALTER TABLE sales MODIFY COLUMN cogs DECIMAL (10,2) NOT NULL;
ALTER TABLE sales MODIFY COLUMN gross_margin_percentage DECIMAL (11,9) NOT NULL;
ALTER TABLE sales MODIFY COLUMN gross_income DECIMAL (12,4) NOT NULL;
ALTER TABLE sales MODIFY COLUMN rating FLOAT (4,2) NOT NULL;

-- 1) Changing date format type it was dd-mm-yyyy format conver it to yyyy-mm-dd format.

SET SQL_SAFE_UPDATES = 0;

UPDATE sales
SET date = DATE_FORMAT(STR_TO_DATE( date, '%d-%m-%Y'), '%Y-%m-%d');

-- 2) Add a day name column for latter we can use it.

SELECT * FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR (20) AFTER date;

UPDATE sales 
SET day_name = DAYNAME(date);

-- 3) Add a column called month name for letter we cal use it.
 
ALTER TABLE sales ADD COLUMN month_name VARCHAR (20) AFTER date;

UPDATE sales 
SET month_name = MONTHNAME(date);

SELECT * FROM sales;

-- 4) add time of the day column for letter we can use it in which time in the highest and lowest sales.

ALTER TABLE sales ADD COLUMN time_of_the_day VARCHAR (20) AFTER time;

UPDATE sales 
SET time_of_the_day = 
					 CASE WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
						  WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
                          else "Evening"
                          end;

-- ============================================================================================================================================
-- ========================================== BUSINESS QUERIES ======================================================================================

-- 5) how many unique city dose have? 

SELECT COUNT(DISTINCT city) FROM sales;

-- 6) in which city each branch name ? 

SELECT  DISTINCT(city) , branch FROM sales;

-- 7) How many unique product does data have? 

SELECT COUNT(DISTINCT product_line) AS unique_product FROM sales;

-- 8) What is the most selling product line? 

SELECT product_line, SUM(quantity) AS qty FROM sales
GROUP BY product_line
ORDER BY qty desc;

-- 9) What is the total revenue by month? 

SELECT month_name AS month, SUM(total) AS total_revenue FROM sales
GROUP BY month
ORDER BY total_revenue DESC;

-- 10) Which month had the largest COGS?

SELECT month_name AS month , SUM(cogs) AS cogs FROM sales
GROUP BY month
ORDER BY cogs DESC;

-- 11) Which product line had the largest revenue? 

SELECT product_line , SUM(total) AS revenue FROM sales
GROUP BY product_line
ORDER BY revenue DESC;

-- 12) Which is the city with the largest revenue?

SELECT city, branch, SUM(total) AS revenue FROM sales
GROUP BY city, branch
ORDER BY revenue DESC;

-- 13) Which product line had the largest VAT?

ALTER TABLE sales RENAME COLUMN tax_percentage TO tax_pct;

SELECT product_line , AVG(tax_pct) AS avg_tax FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;

-- 14) Add a new column those product have > avg sales mark as "Good" < avg sales marks "Bad" ? 

SELECT * FROM sales;

SELECT AVG(total) FROM sales;

SELECT
	product_line,
	CASE
		WHEN AVG(total) > 322.72424476 THEN "Good"
        ELSE "Bad"
    END AS remark
FROM sales
GROUP BY product_line;

-- 14) Which branch sold more products than average product sold ?

SELECT * FROM sales;

SELECT branch , SUM(quantity) AS total_Product FROM sales
GROUP BY branch
ORDER BY total_product;

SELECT branch , AVG(quantity) AS avg_qty FROM sales
GROUP BY branch
ORDER BY avg_qty;

SELECT branch, SUM(quantity) AS total_qty FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

-- 15) What is the most common product line by gender? 

SELECT * FROM sales;

SELECT gender, COUNT(gender) AS total_cust FROM sales
GROUP BY gender;

SELECT product_line, gender, COUNT(gender) AS total_cust FROM sales
GROUP BY  product_line, gender
ORDER BY total_cust DESC;

-- 16) What is the average rating of each product line? 

SELECT * FROM sales;

SELECT product_line, ROUND(AVG(rating),2) AS avg_rating FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- 17) How many unique customer types does the data have? 

SELECT DISTINCT(customer_type) FROM sales;

-- 18) How many unique payment methods does the data have? 

SELECT DISTINCT (payment) FROM sales;

-- 19) Which customer type buys the most?

SELECT customer_type, COUNT(quantity) AS total_buys FROM sales
GROUP BY customer_type
ORDER BY total_buys DESC;

-- 20) What is the gender distribution per branch?

SELECT branch, gender, COUNT(gender) AS total_cust FROM sales
GROUP BY branch, gender
ORDER BY total_cust DESC;

SELECT branch, gender, COUNT(gender) AS total_cust FROM sales
WHERE branch = 'C'
GROUP BY branch, gender
ORDER BY total_cust DESC;

-- gender per branch is more or lass then the same . i don't think it much more affter the sales.


-- 21) Which time of the day do customers give most ratings? ----

SELECT time_of_the_day , ROUND(AVG(rating),2) AS avg_rating FROM sales
GROUP BY time_of_the_day
ORDER BY avg_rating DESC;

-- it looks like time_of_the_day does not affect the rating.

-- 22) Which time of the day do customers give most ratings per branch?

SELECT branch, time_of_the_day , ROUND(AVG(rating),2) AS avg_rating FROM sales
GROUP BY Branch, time_of_the_day
ORDER BY avg_rating DESC;

-- A and C branch rating is good but C branch needs littile more better to get more ratings

-- 23) Which day fo the week has the best avg ratings?

SELECT day_name , ROUND(AVG(rating),2) AS avg_rating FROM sales
GROUP BY day_name
ORDER BY avg_rating DESC;

-- saturday is the best ratting and monday is the lowest rating

-- 24) Which day of the week has the best Sales per branch?

SELECT branch, day_name , COUNT(total)  AS total_qty_sales FROM sales
GROUP BY branch, day_name
ORDER BY total_qty_sales DESC;

-- For B branch friday and saturday, for c branch saturday and wednesday , for A monday is the lowest qty sales.

-- 25) Number of sales made in each time of the day per weekday?

SELECT * FROM sales;

SELECT day_name, time_of_the_day AS day_time, COUNT(sales) AS no_of_sales FROM sales
GROUP BY day_name, day_time
ORDER BY no_of_sales DESC;

-- in morning every day lowest no of sales happed, in evening highest no of sales happed.

-- 26) Which of the customer types brings the most revenue?

SELECT customer_type, SUM(total) AS revenue FROM sales
GROUP BY customer_type
ORDER BY revenue DESC;

-- Member customars are bring most revenue.

-- 27) Which city has the largest tax/VAT percent?

SELECT city, ROUND(AVG(tax_pct),2) AS avg_tax FROM sales
GROUP BY city
ORDER BY avg_tax DESC;

-- naypyitaw city has largest tax.

-- 28) Which customer type pays the most in VAT?

SELECT customer_type, ROUND(SUM(tax_pct),2) AS vat FROM sales
GROUP BY customer_type
ORDER BY vat DESC;

-- member customers are pays most in vat.

-- =================================================================================================================================
-- =================================================================================================================================
























 

