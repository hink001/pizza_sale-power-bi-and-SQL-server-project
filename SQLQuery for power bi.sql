use [Pizza DB];
select*from pizza_sales

--  Give me the total price of all pizza order
select sum(total_price) as Total_revenue from pizza_sales

-- Average Order Value : find the average order spent per order,calculated by dividing total revenue 
-- by the total number of orders
SELECT SUM(total_price) / COUNT(DISTINCT order_id) as avg_order_value from pizza_sales ;

-- Total pizza sold: the sum of quantites of all pizzza sold
SELECT  SUM(quantity) as total_pizza_sold from pizza_sales

--Total orders : the total number of order placed
SELECT COUNT(DISTINCT order_id) AS Total_ordes from  pizza_sales;
 
-- Average Pizza per order: The average number of pizza sold per order,calculated by dividing
-- the total number of pizzas sold by total number of orders
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2))/CAST(COUNT(DISTINCT order_id)AS DECIMAL(10,2))
 AS DECIMAL(10,2)) FROM pizza_sales;

 -- Daily Trends for Total Order 
 SELECT DATENAME(DW,order_date) as order_day, COUNT(DISTINCT order_id) AS Total_orders FROM pizza_sales
 GROUP BY 
 DATENAME(DW,order_date),
 DATEPART(DW,order_date)
 ORDER BY DATEPART(DW,order_date)

 -- Monthly Trend for Total Orders
 SELECT DATENAME(MONTH,order_date) as Month_name,COUNT(DISTINCT order_id) as Total_orders FROM pizza_sales
 GROUP BY 
 DATENAME(MONTH,order_date)
 ORDER BY
Total_orders DESC

-- Percentage of Sale by Pizza Category
SELECT pizza_category,SUM(total_price) as total_sales ,SUM(total_price)*100/(SELECT SUM(total_price)
from pizza_sales)as PTC
FROM pizza_sales
GROUP BY pizza_category
    
    --Percentage of Sale by Pizza Size
    SELECT pizza_size,CAST(SUM(total_price)AS DECIMAL(10,2)) as total_sales,CAST(SUM(total_price)*100/(SELECT SUM(total_price)
    from pizza_sales WHERE DATEPART(quarter,order_date)=1)AS DECIMAL(10,2)) as PTC
    FROM pizza_sales
    WHERE DATEPART(quarter,order_date)=1
    GROUP BY pizza_size
    ORDER BY PTC DESC   

    --Top 5 Best Sellers by Revenue,Total Quantity and Total Orders
  SELECT TOP 5 pizza_name,SUM(total_price) AS Total_revenue FROM pizza_sales
  GROUP BY pizza_name
  ORDER BY Total_Revenue DESC