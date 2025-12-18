CREATE Table pizza(
pizza_id SERIAL  PRIMARY KEY,
order_id INTEGER,
pizza_name_id VARCHAR(150) NOT NULL,
quantity INTEGER,
order_date DATE,
order_time TIME,
unit_price NUMERIC(8,2),
total_price NUMERIC(10,2),
pizza_size CHAR(5) ,
pizza_category VARCHAR(20),
pizza_ingredients VARCHAR(250),
pizza_name VARCHAR(50)
);

--1. Total Revenue

SELECT SUM(total_price) AS Total_Revenue 
FROM pizza;

--2. Average Order Value

SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value 
FROM pizza;
 
--3. Total Pizzas Sold

SELECT SUM(quantity) AS Total_pizza_sold 
FROM pizza;
 
--4. Total Orders

SELECT COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza;
 
--5. Average Pizzas Per Order

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizza;
 
--6. Daily Trend for Total Orders

SELECT TO_CHAR(order_date, 'Day') AS order_day,
COUNT(DISTINCT order_id) AS total_orders
FROM pizza
GROUP BY TO_CHAR(order_date, 'Day');

 
--7. Hourly Trend for Orders

SELECT 
EXTRACT(HOUR FROM order_time) AS order_hours,
COUNT(DISTINCT order_id) AS total_orders
FROM pizza
GROUP BY EXTRACT(HOUR FROM order_time)
ORDER BY order_hours;

 
--8. % of Sales by Pizza Category

SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza) AS DECIMAL(10,2)) AS PCT
FROM pizza
GROUP BY pizza_category;

 
--9. % of Sales by Pizza Size

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza) AS DECIMAL(10,2)) AS PCT
FROM pizza
GROUP BY pizza_size
ORDER BY pizza_size;

 
--10. Total Pizzas Sold by Pizza Category

SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza
WHERE EXTRACT(MONTH FROM order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

 
--11. Top 5 Best Sellers by Total Pizzas Sold

SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
LIMIT 5;

 
--12. Bottom 5 Best Sellers by Total Pizzas Sold

SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
LIMIT 5;