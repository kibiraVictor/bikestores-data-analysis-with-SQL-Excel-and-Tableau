use pizzasales;

select count(*) from pizza_sales;

select * from pizza_sales;


-- add a new column
alter table pizza_sales
add column new_order_date datetime;


-- Step 2: Update the new column with corrected date values
update pizza_sales
set new_order_date = str_to_date(order_date, '%d-%m-%Y');

-- Step 3: Drop the old column and rename the new one
alter table pizza_sales
drop column order_date,
change column new_order_date order_date datetime;



-- total revenue
select 
  sum(total_price) as total_revenue
from pizza_sales;

-- average value for orders(average order value)
select 
  sum(total_price) / count(distinct order_id) as average_order_value
from pizza_sales;

-- total number of pizzs sold
select 
  sum(quantity) as total_pizzas_sold
from pizza_sales;

-- total orders placed
select 
 count(distinct order_id) as total_number_of_orders
from pizza_sales;

-- average pizzas sold per order
select 
  sum(quantity) / count(distinct order_id) as average_pizzas_sold_per_order
from pizza_sales;

-- hourly trend of pizzas sold
SELECT 
  HOUR(order_time) AS order_hour,
  SUM(quantity) AS total_pizzas_sold
FROM 
  pizza_sales
GROUP BY 
  order_hour
order by order_hour desc
LIMIT 200;


/*
SELECT 
  DATE_FORMAT(order_time, '%Y-%m-%d %H:00:00') AS order_hour,
  SUM(quantity) AS total_pizzas_sold
FROM 
  pizza_sales
GROUP BY 
  order_hour
LIMIT 200;
*/

-- weekly trend for the pizzas sold
-- one year has a 52 weeks
-- work on this code to bring the best results and not null
select
  week(order_date, 1) as week_number,  -- '1' indicates weeks start on Monday (ISO standard)
  year(order_date) as year,
  count(distinct order_id) as total_orders
from 
  pizza_sales
group by 
  week_number, year
limit 200;

-- percentage of category per the total sales
select 
  pizza_category,
  sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as percentage_of_sales_per_category
from pizza_sales
group by pizza_category;


-- percentage of sales per pizza size
select 
  pizza_size,
  sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as percentage_of_sales_per_category
from pizza_sales
group by pizza_size;

-- top 5 best sellers
select 
   pizza_name,
   sum(total_price) as total_sales,
   quantity
from pizza_sales
group by pizza_name,quantity
order by total_sales desc
limit 5;

-- top 5 bottom sellers
select 
   pizza_name,
   sum(total_price) as total_sales,
   quantity
from pizza_sales
group by pizza_name,quantity
order by total_sales asc
limit 5;






