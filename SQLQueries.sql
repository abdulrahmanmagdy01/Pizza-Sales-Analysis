USE pizzaDB 

Select *
from pizza_sales

-- 1. Total Revenue:
select sum(total_price) as total_revenue
from pizza_sales

-- 2. Average Order Value
select sum(total_price)/ count(distinct(order_id)) as AvgOrderValue
from pizza_sales

--3. Total Pizzas Sold
select sum(quantity) as Total_Pizzas_Sold
from pizza_sales

-- 4. Total Orders
select count(distinct(order_id)) as Total_Orders
from pizza_sales

-- 5. Average Pizzas Per Order
select round(
		cast(sum(quantity)as float)/cast(count(distinct(order_id)) as float),
		2) as AvgPizzaPerOrder
from pizza_sales


-- Daily Trend for Total Orders
SELECT 
	DATENAME(DW, order_date) AS order_day, 
	COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY DATENAME(DW, order_date),DATEPART(WEEKDAY, order_date)
ORDER BY DATEPART(WEEKDAY, order_date);


-- Monthly  Trend for Total Orders
SELECT 
	DATENAME(MONTH, order_date) AS order_day, 
	COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date),DATEPART(MONTH, order_date)
ORDER BY DATEPART(MONTH, order_date);

-- Percentage of Sales by Pizza Category
SELECT 
	pizza_category, 
	CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category


-- Percentage of Sales by Pizza Size
SELECT 
	pizza_size, 
	CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size


-- Total Pizzas Sold by Pizza Category
SELECT 
	pizza_category, 
	SUM(quantity)  as total_Pizzas_sold
FROM pizza_sales
GROUP BY pizza_category

-- Top 5 Pizzas by Quantity
SELECT top 5
	pizza_category,pizza_name ,sum(quantity) as total_Pizzas_sold
FROM pizza_sales
GROUP BY pizza_category,pizza_name
order by total_Pizzas_sold desc

-- Top 5 Pizzas by Revenue
SELECT top 5
	pizza_category,pizza_name ,sum(total_price) as Revenue
FROM pizza_sales
GROUP BY pizza_category,pizza_name
order by Revenue desc

-- Bottom 5 Pizzas by Revenue
SELECT top 5
	pizza_category,pizza_name ,sum(total_price) as Revenue
FROM pizza_sales
GROUP BY pizza_category,pizza_name
order by Revenue 

-- Top 5 Pizzas by Total Orders
SELECT top 5
	pizza_category,pizza_name ,count(distinct(order_id)) as Total_Orders
FROM pizza_sales
GROUP BY pizza_category,pizza_name
order by Total_Orders desc 