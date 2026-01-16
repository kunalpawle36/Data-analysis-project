use dummy;

# CUSTOMER ORDERS VIEW

Create view 
customer_orders as 
select 
customernumber,
customername,
country,
ordernumber,
orderdate,
status,
productcode,
quantityordered,
priceeach
from customers 
join orders using(customernumber)
join orderdetails using(ordernumber);

# SALES SUMMARY VIEW

Create view sales_summary as
select 
orderdate,
productcode,
productname,
productline,
quantityordered,
priceeach,
(quantityordered*priceeach) as total_sales
from orders 
join orderdetails using(ordernumber)
join products using(productcode);

# CUSTOMER PAYMENTS VIEW

Create view customer_payments as
select
customernumber,
customername,
country,
paymentdate,
amount,
creditlimit
from customers
join payments using(customernumber);

# EMPLOYEE SALES VIEW

Create view EMPLOYEE_SALES as
select
employeenumber,
concat(firstname," ",lastname) as employeename,
jobtitle,
ordernumber,
orderdate,
status
from employees e 
join customers c 
on e.employeenumber=c.salesrepemployeenumber
join orders using(customernumber); 

