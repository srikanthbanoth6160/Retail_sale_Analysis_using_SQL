--CREATE TABLE
drop table if exists retail_sales;
Create table retail_sales
               (
					transactions_id	 INT PRIMARY KEY,
					sale_date DATE,
					sale_time TIME,
					customer_id	INT,
					gender	VARCHAR(15),
					age	INT,
					category VARCHAR(15),	
					quantity	INT,
					price_per_unit	FLOAT,
					cogs FLOAT,
					total_sale FLOAT

                );

SELECT * FROM RETAIL_SALES;

--no of rows in our data set

SELECT count(*) 
FROM RETAIL_SALES;

--lets find out null values if any in our data set
--Data Cleaning
SELECT * 
FROM RETAIL_SALES
where transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null 
or category is null
or quantity is null
or price_per_unit is null
or cogs is null
or total_sale is null

--here we found three rows empty so lets delete them 
delete  
FROM RETAIL_SALES
where transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null 
or category is null
or quantity is null
or price_per_unit is null
or cogs is null
or total_sale is null

--Data exploration
--how many unique customers we have 

SELECT count(distinct(customer_id))
FROM RETAIL_SALES;

-- how many categories we have

SELECT distinct category
FROM RETAIL_SALES;

--how many sales we have 

select count(*) as total_sales
from retail_sales



-- Data analysis & business problems 
--1)write a sql query to retrive all columns for sales made on '2022-11-05'

select *
from retail_sales
where sale_date ='2022-11-05';

--2)write a sql query to retrive all transactions where the category is clothing and the quantity sold is more than 4 OR EQUAL in the month of nov_2022

select *
from retail_sales
where category ='Clothing'
and quantity>=4
and to_char(sale_date,'YYYY-MM')='2022-11';

--3) WRITE A SQL QUERY TO CALCULATE THE TOTAL SALES (total_sale) for each category
select category, sum(total_sale), count(total_sale)
from retail_sales
group by 1

--4) write a sql query to find average age of customers who purchased items from the beauty category

select round(avg(age),2) as Avg_age
from retail_sales
where category ='Beauty'

--5) write a sql query to find all transactions where the total_sale is greater than 1000
select * 
from retail_sales
where total_sale>1000

--6) write a sql query to find all transactions (transactions_id) made by each gender in each category
SELECT * FROM RETAIL_SALES;

select gender,category, count(*) as num_of_transactions
from retail_sales
group by gender,category

--7) write a SQL query to calculate the average sale for each month .find out best selling month in each year
SELECT * FROM
(
	select 
		extract (year from sale_date) as year,
		extract(month from sale_date) as month,
		avg(total_sale) AS AVG_SALE,
		RANK() OVER(PARTITION BY extract (year from sale_date) ORDER BY avg(total_sale) DESC) AS RANK
	from retail_sales
	group by  1,2
)
WHERE RANK=1
--ORDER BY 1,2,3 DESC

--8) WRITE A SQL query to find top 5 customers based on the highest total sales

SELECT customer_id, sum(total_sale)
FROM RETAIL_SALES
group by 1
order by 2 desc
limit 5

--9) write a sql query to findthe number of unique customers who purchased items from each category
 select category,count(distinct (customer_id)) as no_of_unique_customers
 from retail_sales
 group by category

 --10) write a sql query to create each shift and no of orders(example morning<=12, afternoon between 12&17, evening>17)
 with hourly_sale as
 (
 SELECT *,
     case
	     when extract (hour from sale_time)<12 then 'Morning'
		 when extract (hour from sale_time) between 12 and 17 then 'Afternoon'
		 else 'Evening'
     end as shift
 FROM retail_sales
 )
 select shift,count(*) as total_order
 from hourly_sale
 group by shift



 
 select extract(minute from current_time)