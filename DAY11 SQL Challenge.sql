
create table Orders (order_id int, customer_id int, order_date date, price int);

insert into Orders values
(1,	1,	 '2019-07-01', 	1100),
(2,	1,	 '2019-11-01', 	1200),
(3,	1,	 '2020-05-26', 	3000),
(4,	1,	 '2021-08-31', 	3100),
(5,	1,	 '2022-12-07', 	4700),
(6,	2,	 '2015-01-01', 	700 ),
(7,	2,	 '2017-11-07', 	1000),
(8,	3,	 '2017-01-01', 	900 ),
(9,	3,	 '2018-11-07', 	900 );

select * from Orders


with customer_spending as (
select customer_id, year(order_date) as year,
sum(price) as amount_spent from orders
group by customer_id, year(order_date))
select distinct a.customer_id
from customer_spending a join customer_spending b
on a.customer_id = b.customer_id
and a.year=b.year+1
and a.amount_spent>b.amount_spent;

