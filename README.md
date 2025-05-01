# 🛍️ Retail Sales Analysis using SQL

This project focuses on performing comprehensive data analysis on a fictional retail sales dataset using SQL. The main objectives are to clean the data, explore it for insights, and solve key business problems using well-structured SQL queries.

🔧 Key Features:
Data Preparation: Created a RETAIL_SALES table with appropriate schema design and ensured data integrity by identifying and removing null records.

Data Exploration:

Counted total transactions and unique customers.

Identified available product categories.

Business-Focused Analysis:

Tracked daily sales, including filtering sales by specific dates and categories.

Computed total and average sales per category and month.

Identified top-performing customers and high-value transactions.

Segmented orders based on time of day into Morning, Afternoon, and Evening shifts.

Evaluated customer demographics such as average age for specific product categories.

Ranked best-selling months using window functions.

🧠 Insights Derived:
Found top 5 customers by total purchase volume.

Determined which category had the highest number of unique buyers.

Ranked months by average sales to discover seasonal trends.

Analyzed sales shifts to understand peak transaction hours.

This analysis helps businesses gain actionable insights on customer behavior, sales trends, and performance across different product segments.
## 📁 Table of Contents
- [Dataset Schema](#dataset-schema)
- [Data Cleaning](#data-cleaning)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Business Questions & Solutions](#business-questions--solutions)
- [Insights & Summary](#insights--summary)

---

# 🛍️ Retail Sales Analysis using SQL

This project focuses on SQL-based analysis of a retail sales dataset, covering everything from data preparation to answering key business questions.

---

## 📊 Dataset Schema

```sql
DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales (
    transactions_id     INT PRIMARY KEY,
    sale_date           DATE,
    sale_time           TIME,
    customer_id         INT,
    gender              VARCHAR(15),
    age                 INT,
    category            VARCHAR(15),    
    quantity            INT,
    price_per_unit      FLOAT,
    cogs                FLOAT,
    total_sale          FLOAT
);

🧹 Data Cleaning
✅ Check total number of rows
SELECT COUNT(*) FROM retail_sales;
❓ Find and remove null values

SELECT * 
FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL 
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

DELETE  
FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL 
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
🔍 Exploratory Data Analysis
👥 How many unique customers?

SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
🛍️ What product categories are there?

SELECT DISTINCT category FROM retail_sales;
🧾 Total number of sales?

SELECT COUNT(*) AS total_sales FROM retail_sales;
💼 Business Questions & Solutions
1️⃣ Retrieve all sales made on 2022-11-05

SELECT * 
FROM retail_sales 
WHERE sale_date = '2022-11-05';
2️⃣ Clothing sales with quantity >= 4 in November 2022

SELECT * 
FROM retail_sales 
WHERE category = 'Clothing' 
  AND quantity >= 4 
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';
3️⃣ Total sales and number of transactions by category

SELECT category, SUM(total_sale) AS total_sales, COUNT(*) AS num_transactions 
FROM retail_sales 
GROUP BY category;
4️⃣ Average age of customers who purchased Beauty products

SELECT ROUND(AVG(age), 2) AS avg_age 
FROM retail_sales 
WHERE category = 'Beauty';
5️⃣ Transactions with total sale > 1000

SELECT * 
FROM retail_sales 
WHERE total_sale > 1000;
6️⃣ Number of transactions by gender and category

SELECT gender, category, COUNT(*) AS num_of_transactions 
FROM retail_sales 
GROUP BY gender, category;
7️⃣ Best selling month (average sale) each year

SELECT * 
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date) 
            ORDER BY AVG(total_sale) DESC
        ) AS rank
    FROM retail_sales 
    GROUP BY 1, 2
) ranked_sales
WHERE rank = 1;
8️⃣ Top 5 customers by total sales

SELECT customer_id, SUM(total_sale) AS total_spent 
FROM retail_sales 
GROUP BY customer_id 
ORDER BY total_spent DESC 
LIMIT 5;
9️⃣ Unique customers per product category

SELECT category, COUNT(DISTINCT customer_id) AS unique_customers 
FROM retail_sales 
GROUP BY category;
🔟 Number of orders by time of day (shifts)

WITH hourly_sale AS (
    SELECT *,
           CASE
               WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
               WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
               ELSE 'Evening'
           END AS shift
    FROM retail_sales
)
SELECT shift, COUNT(*) AS total_orders 
FROM hourly_sale 
GROUP BY shift;
📌 Insights & Summary
✅ Identified and removed 3 rows with missing data.

👤 Top 5 customers contributed significantly to total revenue.

💄 Beauty and 👕 Clothing were among the most popular categories.

📅 Best-selling months varied by year, showing seasonal patterns.

🕒 Most transactions occurred during the Afternoon shift.

🚀 Technologies Used
PostgreSQL / MySQL

SQL Window Functions

Data Cleaning & Aggregation

Git & GitHub for version control

📂 Project Status
✅ Complete
🔧 Ready for dashboarding with Tableau / Power BI
📈 Suitable for trend analysis and business decision-making

---



