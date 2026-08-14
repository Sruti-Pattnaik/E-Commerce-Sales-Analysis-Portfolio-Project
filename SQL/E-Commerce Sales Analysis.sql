select * from superstore;
select count(*)  from superstore;
-- find the total sales-- 
select sum(sales) as total_sales from superstore;
-- find the total profit-- 
select sum(profit) as total_sales from superstore;
-- find the average sales-- 
select avg(sales) as average_sales from superstore;
-- find the highest sale-- 
select max(sales) as highest_sale from superstore;
-- find the lowest sale-- 
select min(sales) as lowest_sale from superstore;
-- total sales by category-- 
select category, sum(sales) as total_sales from superstore group by category order by total_sales desc;
-- total profit by region-- 
select region, sum(sales) as total_sales from superstore group by region order by total_sales desc;
-- find the number of oreders in each ship mode-- 
select ship_mode, count(*) as total_orders from superstore group by ship_mode;
-- find the average discount by category-- 
select category, avg(discount) as average_discount from superstore group by category;
-- find sales and profit by sub-category-- 
select `sub-category`, sum(sales) as total_sales, sum(profit) as total_profit from superstore group by `sub-category` order by total_sales desc;
-- find the top-selling product-- 
select product_name, sum(sales) as total_sales from superstore group by Product_Name order by total_sales desc limit 1;
-- find the category with the highest average profit-- 
SELECT Category, AVG(Profit) AS Avg_Profit FROM Superstore GROUP BY Category ORDER BY Avg_Profit DESC LIMIT 1;
-- find the percentage contribution of each category to total sales-- 
select category, round(sum(sales) * 100 / (select sum(sales) from superstore), 2) as sales_percentage from superstore group by category;
-- Rank customers based on sales-- 
select customer_name, sum(sales) as total_sales, rank() over (order by sum(sales) desc) as sales_rank from superstore group by Customer_Name;
-- find the top 10 customers by total sales-- 
select customer_name, sum(sales) as total_sales from superstore group by Customer_Name order by total_sales desc limit 10;
-- find the top 10 customers by profit--  
select customer_name, sum(profit) as total_sales from superstore group by Customer_Name order by total_sales desc limit 10;
-- find the top 5 products by sales-- 
select product_name, sum(sales) as total_sales from superstore group by Product_Name order by total_sales desc limit 5;
-- find the top 5 loss-making products-- 
select product_name, sum( sales) as total_sales from superstore group by Product_Name order by total_sales asc limit 5 ;
-- find sales and profit by region -- 
select region, sum(sales) as total_sales, sum(profit) as total_profit from superstore group by Region;
-- find the most profitable state--
select state, sum(profit) as total_profit from superstore group by state order by total_profit desc limit 1;
-- find states with negative profit-- 
select state, sum(profit) as total_profit from superstore group by state having sum(Profit) < 0;
-- find average order value-- 
select round(sum(sales) / count(distinct order_id),2) as avg_order_value from superstore;
-- calculate profit margin(%)--  
select round((sum(profit)/ sum(sales)) * 100, 2) as profit_margin from superstore;
-- Find monthly sales trend-- 
select month(Order_date) as month, sum(sales) as total_sales from superstore group by month(Order_date) order by month;
-- find monthly profit trend-- 
select month(Order_Date) as month, sum(profit) as total_profit from superstore group by month(order_date) order by month;
-- find yearly sales-- 
select year(order_date) as year, sum(sales) as total_sales from superstore group by year(order_date);
-- find repeat customers-- 
select customer_name, count(distinct order_id) as total_orders from superstore group by Customer_Name having count(distinct Order_ID) > 1;
-- Rank customers by sales-- 
select customer_name, sum(sales) as total_sales, rank() over(order by sum(sales) desc) as sales_rank from superstore group by Customer_Name;
-- rank products within each category-- 
select category, product_name, sum(sales) as total_sales, dense_rank() over(partition by category order by sum(sales) desc) as product_rank from superstore group by Category, Product_Name;
-- find top product in each category-- 
SELECT *
FROM (
    SELECT Category,
           Product_Name,
           SUM(Sales) AS Total_Sales,
           ROW_NUMBER() OVER(
               PARTITION BY Category
               ORDER BY SUM(Sales) DESC
           ) AS rn
    FROM Superstore
    GROUP BY Category, Product_Name
) x
WHERE rn = 1;
-- Running total of sales-- 
select order_date, sales, sum(sales) over(order by order_date) as running_total from superstore;
-- moving average of sales-- 
select order_date, sales, avg(sales) over(order by order_date) as running_total from superstore;
-- find customers whose sales are above average-- 
select customer_name, sum(sales) as total_sales from superstore group by Customer_Name having sum(sales) > ( select avg(sales) from superstore);
-- percentage contribution of each region-- 
select region, round(sum(sales)*100/(select sum(sales) from superstore),2) as sales_percentage from superstore group by Region;
-- find top product by profit in each category-- 
select * from ( select category, product_name, sum(profit) as total_profit, rank() over(partition by category order by sum(profit) desc) rnk from superstore group by Category, Product_Name) t where rnk=1;
-- find delivery time for each order-- 
select order_id,order_date,ship_date,datediff(ship_date, order_date) as delivery_days from superstore;
-- find the most frequently ordered product-- 
select product_name, count(order_id) as order_count from superstore group by Product_Name order by Order_count desc limit 1;
-- find orders with the highest discount-- 
select order_id, product_name, discount from superstore order by Discount desc;
-- -- find average sales by segment-- 
 select segment, round(avg(sales),2) as avg_sales from superstore group by Segment;
-- -- find total sales for every month and year-- 
 select year(order_date) as year, month(order_date) as month, sum(sales) as total_sales from superstore group by year(order_date), month(order_date) order by year,month;
-- -- find products sold in more than 100 ordes-- 
select product_name, count(distinct order_id) as orders from superstore group by Product_Name having count(distinct Order_ID) > 100;
-- -- find top 5 cities by profit-- 
select city, sum(profit) as total_profit from superstore group by city order by total_profit desc limit 5;
-- find the least profitable city--   
 select city, sum(profit) as total_profits from superstore group by City order by total_profit; 
-- find the highest profit order-- 
select order_id, customer_name, profit from superstore order by profit desc limit 1;
-- find the largest order by sales-- 
select order_id, customer_name, profit from superstore order by Profit desc limit 1;
-- Find Customers Who Purchased from More Than One Category-- 
SELECT Customer_Name,COUNT(DISTINCT Category) AS Categories FROM Superstore GROUP BY Customer_Name HAVING COUNT(DISTINCT Category) > 1;
-- Find Orders with Multiple Products-- 
SELECT Order_ID, COUNT(Product_Name) AS Products FROM Superstore GROUP BY Order_ID HAVING COUNT(Product_Name) > 1;
-- Find Products with Negative Total Profit-- 
SELECT Product_Name, SUM(Profit) AS Total_Profit FROM Superstore GROUP BY Product_Name HAVING SUM(Profit) < 0;
-- Find States Where Average Profit Is Negative--
 SELECT State, AVG(Profit) AS Avg_Profit FROM Superstore GROUP BY State HAVING AVG(Profit) < 0;
 
 
























