create database retail_analytics;
use retail_analytics;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    signup_date DATE
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price INT
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    total_amount INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Customers VALUES
(1,'Rahul','Mumbai','2023-01-15'),
(2,'Sneha','Pune','2023-02-10'),
(3,'Amit','Delhi','2023-01-25'),
(4,'Priya','Mumbai','2023-03-05'),
(5,'Karan','Bangalore','2023-02-20'),
(6,'Anjali','Delhi','2023-04-11'),
(7,'Rohan','Pune','2023-01-30'),
(8,'Neha','Mumbai','2023-05-02'),
(9,'Vikas','Chennai','2023-03-18'),
(10,'Simran','Delhi','2023-02-28'),
(11,'Arjun','Bangalore','2023-04-22'),
(12,'Pooja','Chennai','2023-05-15');

INSERT INTO Products VALUES
(101,'Wireless Mouse','Electronics',699),
(102,'Bluetooth Speaker','Electronics',1999),
(103,'Running Shoes','Footwear',2499),
(104,'Yoga Mat','Fitness',899),
(105,'Office Chair','Furniture',5499),
(106,'Notebook Set','Stationery',249),
(107,'Water Bottle','Fitness',399),
(108,'Study Lamp','Furniture',1299);

INSERT INTO Orders VALUES
(1001,1,101,2,'2023-06-01',1398),
(1002,2,103,1,'2023-06-02',2499),
(1003,3,105,1,'2023-06-03',5499),
(1004,4,101,1,'2023-06-04',699),
(1005,5,104,3,'2023-06-05',2697),
(1006,6,102,1,'2023-06-06',1999),
(1007,7,106,5,'2023-06-07',1245),
(1008,8,107,2,'2023-06-08',798),
(1009,9,108,1,'2023-06-09',1299),
(1010,10,103,2,'2023-06-10',4998),
(1011,1,102,1,'2023-06-11',1999),
(1012,2,104,2,'2023-06-12',1798),
(1013,3,101,3,'2023-06-13',2097),
(1014,4,106,2,'2023-06-14',498),
(1015,5,105,1,'2023-06-15',5499),
(1016,6,107,4,'2023-06-16',1596),
(1017,7,108,1,'2023-06-17',1299),
(1018,8,103,1,'2023-06-18',2499),
(1019,9,102,2,'2023-06-19',3998),
(1020,10,101,4,'2023-06-20',2796),
(1021,11,104,1,'2023-06-21',899),
(1022,12,105,1,'2023-06-22',5499),
(1023,11,106,3,'2023-06-23',747),
(1024,12,107,1,'2023-06-24',399);


select * from customers;
select * from products;
select * from orders;

-- Show all customers who live in Mumbai.
select * from customers where city="Mumbai";

-- Display customers who signed up after '2023-03-01'.
select * from customers where signup_date>"2023-03-01";

-- Show products with a price greater than 1000.
select * from products where price>1000;

-- Display products whose name starts with 'W'.
select * from products where product_name like "W%";

-- Show all orders with their total_amount.
select * from orders;

-- Display customer_id and product_id for every order.
select order_id,customer_id,product_id from orders;

-- Show all orders for product_id 101
select * from orders where product_id=101;

-- Display orders with quantity greater than 2.
select * from orders where quantity>2;

-- Show customers from Mumbai and their signup_date.
select * from customers where city="Mumbai";

-- Show customer name with the product name they ordered.
select c.name,p.product_name
from customers c
right join orders o
on c.customer_id=o.customer_id
left join products p on p.product_id=o.product_id;

-- Display customer name, product name, and total_amount for every order.
select c.name,p.product_name,o.total_amount
from customers c
right join orders o on c.customer_id=o.customer_id
left join products p on o.product_id=p.product_id;

-- Show orders where the product category is 'Electronics'.
select * from orders;
select * from products;
select o.order_id, p.product_name,p.category
from orders o
left join products p on p.product_id=o.product_id
where p.category="Electronics";

-- Show customer name, product name, category, and total_amount for every order.
select c.name,p.product_name,p.category,o.total_amount
from customers c
right join orders o on c.customer_id=o.customer_id
left join products p on p.product_id=o.product_id;

-- Find customers who signed up before the average signup_date.
select * from customers where signup_date<(select avg(signup_date) from customers);

-- Find the customer with the earliest signup_date.
select * from customers order by signup_date desc limit 1;

-- Find products that are the same price as 'Wireless Mouse'.
select * from products where price=(select price from products where category="Wireless Mouse" limit 1);

-- Find the highest total_amount among all orders.
select max(total_amount) from orders;

select o.order_id, o.total_amount from orders o
where o.total_amount=(select max(o2.total_amount) from orders o2);

-- Find orders where total_amount is greater than the average total_amount.
select * from orders where total_amount>(select avg(total_amount) from orders);

-- Find the order with the minimum total_amount.
select o.order_id,o.total_amount from orders o where o.total_amount=(select min(o2.total_amount) from orders o2);

-- Find names of customers who spent more than 3000 in a single order.
select c.name,o.total_amount,o.quantity
from customers c
right join orders o on c.customer_id=o.customer_id
where o.total_amount>3000 and o.quantity=1;

-- Display all products sorted by price in ascending order.
select * from products order by price;

-- Display customers sorted by signup_date in descending order.
select * from customers order by signup_date desc;

-- Show all orders sorted by total_amount (highest first).
select * from orders order by total_amount desc;

-- Display customers sorted alphabetically by name.
select * from customers order by name;

-- Show customers sorted first by city and then by name.
select * from customers order by city,name;

-- Find the average total_amount for each product.
select p.category,avg(o.total_amount)
from products p
left join orders o on o.product_id=p.product_id
group by p.category;

-- Find the maximum total_amount spent on each product.
select p.product_name,max(o.total_amount)
from products p
left join orders o
on p.product_id=o.product_id
group by p.product_name;

-- Find the minimum total_amount spent on each product.
select p.product_name,min(o.total_amount)
from products p
left join orders o
on p.product_id=o.product_id
group by p.product_name;

-- Find total number of orders placed by each customer.
select c.name,count(o.order_id)
from customers c
left join orders o
on c.customer_id=o.customer_id
group by c.name,c.customer_id;

-- Show products where average order total_amount is greater than 2000.
select p.product_name, avg(o.total_amount) from products p
left join orders o
on o.product_id=p.product_id
group by p.product_name
having avg(o.total_amount)>2000;

-- Show products that were ordered more than 2 times.
select p.product_name,count(o.order_id) from products p
left join orders o
on o.product_id=p.product_id
group by p.product_name
having count(o.order_id)>2;

-- Show cities with more than 2 customers.
select city,count(*) from customers group by city having count(*)>2;

-- Show products sorted by highest average order value.
select p.product_name,avg( o.total_amount )
from products p
left join orders o
on p.product_id=o.product_id
group by p.product_name
order by avg( o.total_amount) desc;

-- Show number of customers in each city sorted by highest count.
select city , count(customer_id) from customers group by city order by count(customer_id) desc;

-- Find each customer's total spending across all their orders.
select c.name,sum(o.total_amount) 
from customers c
left join orders o
on c.customer_id=o.customer_id
group by c.name,c.customer_id;

-- Find the top 3 customers by total spending.
select c.name,sum(o.total_amount) 
from customers c
left join orders o
on c.customer_id=o.customer_id
group by c.name,c.customer_id 
order by sum(o.total_amount) desc limit 3;

-- Find products that have never been ordered.
select * from products;
select p.product_name, count(o.order_id)
from products p
left join orders o
on p.product_id=o.product_id
group by p.product_name,p.product_id
having count(o.order_id)=0;

-- Find customers who have placed more than 2 orders.
select c.name,count(o.order_id) from customers c
left join orders o
on c.customer_id=o.customer_id
group by c.name, c.customer_id
having count(o.order_id)>2;

-- Find the second highest total_amount among all orders.
select * from orders where total_amount!=(select max(total_amount) from orders) order by total_amount desc limit 1;