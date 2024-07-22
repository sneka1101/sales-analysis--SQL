create database walmart;

use walmart;

-- Drop the existing table
DROP TABLE IF EXISTS sales;

-- Create the table
CREATE TABLE wal_sales (
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct DECIMAL(6, 4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10, 2) NOT NULL,
    gross_margin_pct DECIMAL(5, 4),
    gross_income DECIMAL(12, 4),
    rating DECIMAL(3, 1)
);


select * from wal_sales ;
-- changing and updating table
SELECT time,
       CASE 
           WHEN time BETWEEN '00:00:00' AND '11:59:59' THEN 'morning'
           WHEN time BETWEEN '12:00:00' AND '16:59:59' THEN 'afternoon'
           ELSE 'evening'
       END AS time_as_date
FROM wal_sales;

alter table wal_sales add  column time_of_day varchar(20);

update wal_sales 
set time_of_day=(CASE 
           WHEN time BETWEEN '00:00:00' AND '11:59:59' THEN 'morning'
           WHEN time BETWEEN '12:00:00' AND '16:59:59' THEN 'afternoon'
           ELSE 'evening'
       END );
       
-- month name 
select date,monthname(date) from wal_sales;
alter table wal_sales add column month_name varchar(19);
update wal_sales set month_name=monthname(date);


-- day name
select date,
dayname(date)
 from wal_sales;
 alter table wal_sales add column day_name varchar(10);
update wal_sales 
 set day_name =dayname(date);
 
 
 -- Generic Question
-- 1.How many unique cities does the data have?
       select distinct city from wal_sales;
       
-- In which city is each branch?
select distinct  city,branch from wal_sales;

-- How many unique product lines does the data have?
SELECT COUNT(DISTINCT product_line) 
FROM wal_sales;

-- What is the most common payment method?
select distinct payment from wal_sales;
SELECT payment, COUNT(payment) AS cnt
FROM wal_sales
GROUP BY payment
ORDER BY cnt DESC;

-- What is the most selling product line?
select product_line ,count(product_line) as pl 
from wal_sales group by product_line
order by pl desc;

-- What is the total revenue by month?
select month_name as m,
sum(total) as total_revenue
 from wal_sales
 group by m 
 order by total_revenue desc;
 
 -- What month had the largest COGS?
 select month_name as m,
 sum(cogs) as cogs from wal_sales
 group by m 
 order by cogs desc;
 
 -- What product line had the largest revenue?
 select product_line,
 count(total)as revenue from wal_Sales 
 group by product_line
 order by revenue desc;
 
 -- What is the city with the largest revenue?
 select city,
 avg(total)as revenue from wal_Sales 
 group by city
 order by revenue desc;
 
 -- What product line had the largest VAT?
 select product_line,
 avg(gross_margin_pct)as pct from wal_Sales 
 group by product_line
 order by pct desc;
 
 -- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
 select branch,
 sum(quantity) as qty from wal_sales
 group by branch
 having sum(quantity)> (select avg(quantity) from wal_sales);
 
 -- What is the most common product line by gender?
 select product_line,gender,count(gender) as total_cnt
 from wal_sales
 group by gender,product_line
 order by total_cnt desc;
 
 -- What is the average rating of each product line?
 select avg(rating) as avg_rat,product_line
 from wal_sales 
 group by product_line
  order by avg_rat desc;
  
-- - ------------------------------------------------ sales -----------------------------------------------------------------------
-- Number of sales made in each time of the day per weekday
select  sum(total)as total_sales,time_of_day  from wal_sales
where  day_name = "monday"
group by time_of_day
order by total_sales desc;

-- Which of the customer types brings the most revenue?
select customer_type as c,
sum(total) as total_revenue
 from wal_sales
 group by c 
 order by total_revenue desc;
 
 -- Which city has the largest tax percent/ VAT (Value Added Tax)?
 select city,
 avg(tax_pct) as tax from wal_sales
 group by city
 order by tax desc;
 
 -- Which customer type pays the most in VAT?
select customer_type as c,
avg(tax_pct) as vat
 from wal_sales
 group by c 
 order by vat desc;
 
 -- customer  ----------------------------------------------------------------------
 -- How many unique customer types does the data have?
 select distinct customer_type from wal_sales;
 -- How many unique payment methods does the data have?
 select  distinct payment from wal_sales;
 -- Which customer type buys the most?
 select  customer_type,COUNT(*)as cust_count from wal_sales
 GROUP BY customer_type;
 -- What is the gender of most of the customers?
 select gender, count(*) as g
 from wal_sales
 group by gender
 order by g desc;
 -- What is the gender distribution per branch?
 select gender, count(*) as g
 from wal_sales
 where branch ='c'
 group by gender
 order by g desc;
 
 -- Which time of the day do customers give most ratings?
 select time_of_day, avg(rating) as avg_rate
 from wal_sales
 group by time_of_day
 order by avg_rate desc;
 
 -- Which time of the day do customers give most ratings per branch?
 select time_of_day,avg(rating) as r
 from wal_sales
 where branch ='A'
 group by time_of_day
 order by r desc;
 
 -- Which day do the week has the best avg ratings?
 select day_name, avg(rating) as rat
 from wal_sales
 group by day_name
 order by rat desc;
 
 -- Which day of the week has the best average ratings per branch?
 select day_name, avg(rating) as rat
 from wal_sales
 where branch = 'A'
 group by day_name
 order by rat desc;