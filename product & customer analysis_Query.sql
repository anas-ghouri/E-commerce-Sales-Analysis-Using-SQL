
-- =====================================================
-- 🛒 SQL Portfolio Project: Product & Customer Analysis
-- 📊 Objective: Analyze customer behavior & product sales using SQL
-- 🛠️ Tools Used: MySQL 8.0
-- =====================================================

-- ==========================================
-- SALES OVERVIEW METRICS
-- ==========================================
-- Q1. What is the total revenue generated overall?

select sum(total_amount) as total_revenue from orders;

 -- What is the total number of orders placed?
 
 select count(order_id) as total_orders from orders;
 
 --  Q3. What is the Average Order Value (AOV)?
 
 
 select avg(total_amount) as Avg_order_value from orders;

 -- What is the Monthly Revenue Trend?
 
SELECT 
    DATE_FORMAT(order_date, '%m') AS month,
    SUM(total_amount) AS monthly_revenue
FROM orders
GROUP BY DATE_FORMAT(order_date, '%m')
ORDER BY month;

-- ==========================================
-- CUSTOMER BEHAVIOR ANALYSIS
-- ==========================================

-- Which customers have placed the most orders?

SELECT c.customer_id, c.name, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_orders DESC;

-- Alice have placed the most orders 

-- Which customers have generated the highest total revenue?

select c.customer_id, c.name, sum(o.total_amount) as total_spend
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.customer_id, c.name
order by total_spend desc;

-- Which city brings in the highest revenue?

select c.city, sum(o.total_amount) as Revenue
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.city
order by Revenue desc;

-- Lahore brings the highest revenue

-- ==========================================
-- Product-Level Insights
-- ==========================================

-- Which products are the most frequently purchased?

select p.product_name, sum(o.quantity) as total_quantity_sold
from products p
join order_items o
on p.product_id=o.product_id
group by p.product_name
order by total_quantity_sold desc;

-- Which product category generates the highest revenue?

SELECT 
    p.category,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- Find the top 3 best-selling products per category by quantity

with ranked_products as(
    SELECT 
        p.category,
        p.product_name,
        SUM(oi.quantity) AS total_quantity,
        rank() OVER (PARTITION BY p.category ORDER BY SUM(oi.quantity) DESC) AS rank_in_category
    FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.category, p.product_name
) 
SELECT * FROM ranked_products
WHERE rank_in_category <= 3;

-- Identify products that haven’t been sold at all (if any)

SELECT p.product_id, p.product_name
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;


select * from order_items;

-- ==========================================
-- Advanced KPIs & Retention Metrics
-- ==========================================

-- Calculate Customer Lifetime Value (CLTV)
-- (Total revenue each customer has contributed to date)

SELECT c.customer_id, c.name, SUM(o.total_amount) AS lifetime_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY lifetime_value DESC;

-- Find the first and latest order date of each customer, also find active days of each customer

select c.customer_id, c.name, 
min(o.order_date) as first_order_date,
max(o.order_date) as latest_order_date,
DATEDIFF(MAX(o.order_date), MIN(o.order_date)) AS active_days
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.customer_id, c.name
order by active_days desc;

-- Find repeat customers (more than 1 order)

select c.customer_id, c.name, count(o.order_id) as order_count
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.customer_id, c.name
having order_count>1;

-- Segment customers based on lifetime value:

select c.customer_id, c.name, sum(o.total_amount) as lifetime_value,
case
	when sum(o.total_amount) > 1000 then 'Gold'
    when sum(o.total_amount) between 500 and 1000 then 'Silver'
    else 'Bronze'
end as customer_tier
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.customer_id, c.name
order by lifetime_value desc;

-- Customer Retention Analysis (Repeat Orders by Month)
-- Track customer retention by checking how many customers placed repeat orders month by month

-- Step 1: Identify first order month and compare with each order
WITH orders_with_months AS (
    SELECT 
        customer_id,
        DATE_FORMAT(order_date, '%Y-%m') AS order_month,
        MIN(DATE_FORMAT(order_date, '%Y-%m')) OVER (PARTITION BY customer_id) AS first_order_month
    FROM orders
)

-- Step 2: Count repeat customers (orders after their first month)
SELECT 
    order_month,
    COUNT(DISTINCT customer_id) AS repeat_customers
FROM orders_with_months
WHERE order_month > first_order_month
GROUP BY order_month
ORDER BY order_month;


