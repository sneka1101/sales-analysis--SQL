# Walmart Sales Data Analysis

## About

This project aims to explore the Walmart Sales data to understand top performing branches and products, sales trend of of different products, customer behaviour. The aims is to study how sales strategies can be improved and optimized. The dataset was obtained from the [Kaggle Walmart Sales Forecasting Competition](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting).

"In this recruiting competition, job-seekers are provided with historical sales data for 45 Walmart stores located in different regions. Each store contains many departments, and participants must project the sales for each department in each store. To add to the challenge, selected holiday markdown events are included in the dataset. These markdowns are known to affect sales, but it is challenging to predict which departments are affected and the extent of the impact." [source](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting)

## Purposes Of The Project

The major aim of thie project is to gain insight into the sales data of Walmart to understand the different factors that affect sales of the different branches.

## About Data

The dataset was obtained from the [Kaggle Walmart Sales Forecasting Competition](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting). This dataset contains sales transactions from a three different branches of Walmart, respectively located in Mandalay, Yangon and Naypyitaw. The data contains 17 columns and 1000 rows:




### Analysis List

1. Product Analysis

> Conduct analysis on the data to understand the different product lines, the products lines performing best and the product lines that need to be improved.

2. Sales Analysis

> This analysis aims to answer the question of the sales trends of product. The result of this can help use measure the effectiveness of each sales strategy the business applies and what modificatoins are needed to gain more sales.

3. Customer Analysis

> This analysis aims to uncover the different customers segments, purchase trends and the profitability of each customer segment.


##  Question includes
1. How many unique product lines does the data have?
2. What is the most common payment method?
3. What is the most selling product line?
4. What is the total revenue by month?

```sql

-- updating table

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


-- solving question
-- What is the most selling product line?

select product_line ,count(product_line) as pl 
from wal_sales group by product_line
order by pl desc;

```




