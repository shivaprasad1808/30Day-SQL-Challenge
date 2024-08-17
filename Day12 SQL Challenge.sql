
create table products_new(product_id int, price_date date, price int);
create table orders_new(order_id int, order_date date, product_id int);

insert into products_new values
(100, '2024-01-01', 150),
(100, '2024-01-21', 170),
(100, '2024-02-01', 190),
(101, '2024-01-01', 2000),
(101, '2024-01-27',1200),
(101, '2024-02-05', 1250),
(100, '2024-02-25', 180),
(100, '2024-03-01',	120);


insert into orders_new values
(1, '2024-01-05', 100),
(2, '2024-01-21', 100),
(3, '2024-02-20', 100),
(4, '2024-01-07', 101),
(5, '2024-02-04',101),
(6, '2024-02-05', 101),
(7,'2024-02-28', 100),
(8,'2024-03-05', 100);



select * from products_new;
select * from orders_new;


insert into orders_new
values
(7,'2024-02-28', 100),
(8,'2024-03-05', 100)



with CTE as (
select distinct p.product_id, o.order_date,  price,
row_number() over(partition by p.product_id, o.order_date order by price_date desc) as rn
from products_new p
join orders_new o
on  o.product_id = p.product_id 
where p.price_date<= o.order_date)
select product_id, sum(price) as total_price
from CTE
where rn=1
group by product_id;
