-- COFFEE SALES ANALYSIS


DROP TABLE  IF EXISTS coffee_sales;

CREATE TABLE coffee_sales(
transaction_id INT PRIMARY KEY,
transaction_date DATE,
transaction_time TIME,
transaction_qty INT,
store_id INT,
store_location VARCHAR(25),
product_id INT,
unit_price NUMERIC (10,2),
product_category VARCHAR(50),
product_type VARCHAR(50),
product_detail VARCHAR(50)

)

SELECT * FROM coffee_sales
LIMIT 10
-- TOTAL SALES BY MONTH
SELECT ROUND(SUM(transaction_qty * unit_price)) AS total_sales
FROM coffee_sales
WHERE 
EXTRACT(MONTH FROM transaction_date) = 4 

-- MONTH OVER MONTH SALES PERCENT GROWTH
WITH monthly_sales AS (
SELECT EXTRACT(MONTH FROM transaction_date) AS MONTH,
SUM(transaction_qty * unit_price) AS total_sales
FROM coffee_sales
GROUP BY month
)

SELECT month,
total_sales,
ROUND ((total_sales-LAG(total_sales) OVER(ORDER BY MONTH)) /
LAG(total_sales) OVER(ORDER BY MONTH)*100,2) AS mom_increase_percentage
FROM monthly_sales
WHERE month in (4,5)
ORDER BY month

-- total orders by month
SELECT count(transaction_id) AS total_orders
FROM coffee_sales
WHERE (EXTRACT (MONTH FROM transaction_date)) = 3

-- MONTH OVER MONTH ORDER PERCENT GROWTH
WITH MONTHLY_ORDERS AS (
SELECT 
(EXTRACT (MONTH FROM transaction_date))  AS month,
count(transaction_id) AS total_orders
FROM coffee_sales
GROUP BY (EXTRACT (MONTH FROM transaction_date))
)

SELECT month,
total_orders,
ROUND((total_orders-LAG(total_orders) OVER (ORDER BY month)) ::numeric/
LAG(total_orders) OVER (ORDER BY month) *100,2) AS mom_order_increase
FROM MONTHLY_ORDERS
WHERE month in (3,4)
ORDER BY month

-- quantity sold month wise
SELECT SUM(transaction_qty) as total_quantity
FROM coffee_sales
WHERE EXTRACT(MONTH FROM transaction_date) = 6

-- MONTH OVER MONTH Quantity PERCENT GROWTH
WITH Monthly_quantity as (
SELECT 
EXTRACT(MONTH FROM transaction_date) as month,
SUM(transaction_qty) AS total_quantity
FROM coffee_sales
GROUP BY EXTRACT(MONTH FROM transaction_date) 
)

SELECT month,
total_quantity,
ROUND((total_quantity-LAG(total_quantity) OVER (ORDER BY month)) ::numeric/
LAG(total_quantity) OVER (ORDER BY month) *100,2) AS mom_quantity_increase
FROM Monthly_quantity
WHERE month in(4,5)
ORDER BY month

--TOTAL SALES,Quantity,Orders day by day 

SELECT
CONCAT(ROUND(SUM(transaction_qty * unit_price)/1000,1),'K') AS total_sales,
CONCAT(ROUND(SUM(transaction_qty)/1000,1),'K') AS total_quantity,
CONCAT(ROUND(COUNT(transaction_id)/1000.0,1),'K')  AS total_orders
FROM coffee_sales
WHERE
transaction_date = '2023-01-1'

-- Sales Trend Weekdays vs Weekends by month
SELECT
CASE WHEN EXTRACT(DOW FROM transaction_date) in (0,6) THEN 'WEEKENDS'
ELSE 'WEEKDAYS'
END AS Day_Type,
CONCAT(ROUND(SUM(unit_price*transaction_qty)/1000,1),'K') AS total_sales
FROM coffee_sales
WHERE EXTRACT(Month FROM transaction_date) = 5
GROUP BY CASE WHEN EXTRACT(DOW FROM transaction_date) in (0,6) THEN 'WEEKENDS'
ELSE 'WEEKDAYS'
END 

-- Sales from store location month by month
select 
store_location, 
CONCAT(ROUND(SUM(unit_price*transaction_qty)/1000,1),'K') AS total_sales
FROM coffee_sales
WHERE  EXTRACT(Month FROM transaction_date) = 5
GROUP BY store_location
ORDER BY SUM(unit_price*transaction_qty) DESC

--AVG SALES BY MONTH
SELECT 
CONCAT(ROUND(AVG(total_sales)/1000,1),'K') AS Avg_sales
FROM
(
SELECT SUM(unit_price*transaction_qty) AS total_sales
FROM coffee_sales
WHERE EXTRACT(Month FROM transaction_date) = 4
GROUP BY transaction_date
) AS INNER_QUERY

-- DAILY SALES BY MONTH
SELECT 
EXTRACT (DAY FROM transaction_date) AS day_of_month,
SUM(unit_price*transaction_qty) AS Total_sales
FROM coffee_sales
Where EXTRACT(Month FROM transaction_date) = 5
GROUP BY EXTRACT (DAY FROM transaction_date) 

-- Compare daily sales with avg sales
SELECT 
day_of_month,
CASE 
WHEN  total_sales > avg_sales THEN 'ABOVE AVERAGE'
WHEN  total_sales < avg_sales THEN 'BELOW AVERAGE'
ELSE 'AVERAGE'
END sales_status,
total_sales
FROM 
(
SELECT 
EXTRACT (DAY FROM transaction_date) AS day_of_month,
SUM(transaction_qty * unit_price) AS total_sales,
AVG(SUM(transaction_qty * unit_price)) OVER() AS avg_sales
FROM coffee_sales
WHERE EXTRACT(Month FROM transaction_date) = 5
GROUP BY EXTRACT (DAY FROM transaction_date)
) AS sales_data
ORDER By day_of_month


-- SALES BY PRODUCT_CATEGORY
SELECT
product_category,
ROUND(SUM(transaction_qty * unit_price),2) AS total_sales_k
FROM coffee_sales
WHERE EXTRACT(Month FROM transaction_date) = 3
GROUP by product_category
ORDER BY SUM(transaction_qty * unit_price) DESC

-- TOP 10 product type  by sales
SELECT
product_type,
ROUND(SUM(transaction_qty * unit_price),2) AS total_sales_k
FROM coffee_sales
WHERE EXTRACT(Month FROM transaction_date) = 3 
GROUP by product_type
ORDER BY SUM(transaction_qty * unit_price) DESC
LIMIT 10

-- PEAK 5 hours in any month 
SELECT 
EXTRACT (HOUR FROM transaction_time) AS peak_hours,
SUM (transaction_qty * unit_price) AS total_sales,
SUM(transaction_qty) AS total_quantity,
COUNT(transaction_id) AS total_orders
From coffee_sales
WHERE EXTRACT (MOnth FROM transaction_date) = 3 -- ANY MONTH
AND  EXTRACT (DOW FROM transaction_date) = 0 --ANy DAY
GROUP BY EXTRACT (HOUR FROM transaction_time)
ORDER BY SUM (transaction_qty * unit_price) DESC
LIMIT 5

-- SALES ANALYSIS DAY BY DAY
SELECT 
CASE 
WHEN EXTRACT (DOW FROM transaction_date) = 1 THEN 'Monday'
WHEN EXTRACT (DOW FROM transaction_date) = 2 THEN 'Tuesday'
WHEN EXTRACT (DOW FROM transaction_date) = 3 THEN 'Wednesday'
WHEN EXTRACT (DOW FROM transaction_date) = 4 THEN 'Thursday'
WHEN EXTRACT (DOW FROM transaction_date) = 5 THEN 'Friday'
WHEN EXTRACT (DOW FROM transaction_date) = 6 THEN 'Saturday'
ELSE 'Sunday'
END as day,
ROUND(SUM(transaction_qty * unit_price)) AS total_sales
FROM coffee_sales
WHERE EXTRACT (MOnth FROM transaction_date) = 5
GROUP BY day
ORDER BY total_sales DESC 

