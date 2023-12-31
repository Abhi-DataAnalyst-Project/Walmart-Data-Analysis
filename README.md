# Walmart-data-analysis
About
This project aims to explore the Walmart Sales data to understand top performing branches and products, sales trend of different products, customer behaviour. The aims are to study how sales strategies can be improved and optimized. The dataset was obtained from the Kaggle Walmart Sales. 

Purposes Of the Project
The major aim of this project is to gain insight into the sales data of Walmart to understand the different factors that affect sales of the different branches.

About Data
The dataset was obtained from the Kaggle Walmart Sales. This dataset contains sales transactions from three different branches of Walmart, respectively located in Mandalay, Yangon and Naypyitaw. The data contains 17 columns and 1000 rows:

Column                        	Description	                                         Data Type
Invoice_id	               Invoice of the sales made                                VARCHAR(20)
branch	                   Branch at which sales were made	                        VARCHAR(5)
city	                     The location of the branch	                              VARCHAR(15)
customer_type	             The type of the customer	                                VARCHAR(15)
gender	                   Gender of the customer making purchase                   VARCHAR(10)
product_line               Product line of the product solf	                        VARCHAR(30)
unit_price	               The price of each product	                              DECIMAL(10, 2)
quantity	                 The amount of the product sold	                          INT
Tax_pct	                   The amount of tax on the purchase	                      DECIMAL(6, 4)
total	                     The total cost of the purchase	                          DECIMAL(12, 4)
date	                     The date on which the purchase was made                  DATE
time	                     The time at which the purchase was made	                TIMESTAMP
Payment_method	           The total amount paid	                                  VARCHAR (20)
cogs	                     Cost Of Goods sold	                                      DECIMAL(10, 2)
Gross_margin_percentage    Gross margin percentage	                                DECIMAL(11, 9)
gross_income               Gross Income	                                            DECIMAL(12, 4)
rating	                   Rating	                                                  FLOAT(4, 2)

Analysis List :-

Product Analysis
Conduct analysis on the data to understand the different product lines, the products lines performing best and the product lines that need to be improved.

Sales Analysis
This analysis aims to answer the question of the sales trends of product. The result of this can help use measure the effectiveness of each sales strategy the business applies and what modifications are needed to gain more sales.

Customer Analysis
This analysis aims to uncover the different customers segments, purchase trends and the profitability of each customer segment.

Approach Used
•	Data Wrangling: This is the first step where inspection of data is done to make sure NULL values and missing values are detected and data replacement methods are used to replace, missing or NULL values.

•	Build a database

•	Insert the data then modify the column.

•	Select columns with null values in them. There are no null values in our database as in Altering the tables, we set NOT NULL for each field, hence null values are filtered out.

•	Add a new column named time_of_day to give insight of sales in the Morning, Afternoon and Evening. This will help answer the question on which part of the day most sales are made.

•	Add a new column named day_name that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the day each branch is busiest.

•	Add a new column named month_name that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.

•	Exploratory Data Analysis (EDA): Exploratory data analysis is done to answer the listed questions and aims of this project.

Business Questions To Answer
1)	How many unique cities does the data have?
2)	In which city is each branch?
3)	How many unique product lines does the data have?
4)	What is the most common payment method?
5)	What is the most selling product line?
6)	What is the total revenue by month?
7)	What month had the largest COGS?
8)	What product line had the largest revenue?
9)	What is the city with the largest revenue?
10)	What product line had the largest VAT?
11)	Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
12)	Which branch sold more products than average product sold?
13)	What is the most common product line by gender?
14)	What is the average rating of each product line?
15)	Number of sales made in each time of the day per weekday
16)	Which of the customer types brings the most revenue?
17)	Which city has the largest tax percent/ VAT (Value Added Tax)?
18)	Which customer type pays the most in VAT.
19)	How many unique customer types does the data have?
20)	How many unique payment methods does the data have?
21)	What is the most common customer type?
22)	Which customer type buys the most?
23)	What is the gender of most of the customers?
24)	What is the gender distribution per branch?
25)	Which time of the day do customers give most ratings?
26)	Which time of the day do customers give most ratings per branch?
27)	Which day of the week has the best avg ratings?
28)	Which day of the week has the best average ratings per branch?

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

