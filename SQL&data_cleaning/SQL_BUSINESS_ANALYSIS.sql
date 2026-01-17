Use dummy;

 # Customer & Sales Analysis
 
 # 1.Which customers have generated the highest revenue?
 
 Select 
 customernumber,
 customername,
 sum(quantityordered*priceeach) as revenue,
 rank() over(order by sum(quantityordered*priceeach)desc) as ranks
 from customers 
 join orders using(customernumber)
 join orderdetails using(ordernumber)
 group by 1,2
 limit 1;
 
# 2.What is the average order value per customer?

Select 
customernumber,
avg(quantityordered*priceeach) as average_ordervalue
from orders 
join orderdetails using(ordernumber)
group by 1;

# 3.Which countries have the most customers?

Select
country,
count(customernumber) as customer_count
from customers 
group by 1
order by customer_count desc
limit 1;

# 4.What is the payment collection trend over time?

select 
orderdate,
amount
from payments 
join customers using(customernumber)
join orders using(customernumber);

# Product & Inventory Insights

# 1.Which products are top sellers by revenue and quantity?

Select
productname,
sum(quantityordered) as total_quantity_ordered,
sum(quantityordered*priceeach) as total_revenue,
rank() over(order by sum(quantityordered*priceeach)desc,sum(quantityordered)desc) as ranks
from orderdetails 
join products using(productcode)
group by 1 limit 5;  

# 2.Which product lines contribute most to total revenue?

Select 
productline,
sum(quantityordered*priceeach) as total_revenue,
rank() over(order by sum(quantityordered*priceeach)desc) as ranks
from products 
join orderdetails using(productcode)
group by 1 limit 1;

# 3.What are the top-selling products?

Select 
productname,
sum(quantityordered) as quantity
from products
join orderdetails using(productcode)
group by 1 
order by quantity desc 
limit 10;

# Order & Fulfillment Metrics- What is the average order fulfillment time?

# 1.What is the monthly order volume trend?
Select 
year(orderdate) as years,
monthname(orderdate) as months,
sum(quantityordered)  as order_volume
from orders 
join orderdetails 
group by 1,2 
order by years,months;

# Employee & Office Performance

# 1.Which sales reps manage the highest revenue customers?

Select salesrepemployeenumber,
sum(quantityordered*priceeach) as revenue,
rank() over(order by sum(quantityordered*priceeach)desc) as ranks
from customers 
join orders using(customernumber)
join orderdetails using(ordernumber)
group by 1
limit 1;

# 2.Which offices handle the most orders or payments?

Select 
officecode,
count(ordernumber) as order_count,
rank() over(order by count(ordernumber)desc) as ranks
from offices 
join employees e using(officecode)
join customers c on e.employeenumber=c.salesrepemployeenumber
join orders using(customernumber)
group by 1
limit 1;  

