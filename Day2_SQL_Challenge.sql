/*DAY2*/--
---Write a query to find users whose transactions has breached their credit limit

use analyst
create table users
(
 user_id int,
 user_name varchar(20),
 credit_limit int
);

create table transactions
(
 trans_id int,
 paid_by int,
 paid_to int,
 amount int,
 trans_date date
);

insert into users (user_id, user_name, credit_limit) values
(1,'Peter',100),
(2,'Roger',200),
(3,'Jack',10000),
(4,'John',800);

insert into transactions (trans_id, paid_by, paid_to, amount,trans_date) values
(1,1,3,400,'01-01-2024'),
(2,3,2,500,'02-01-2024'),
(3,2,1,200,'02-01-2024');


--Method1--
with CTE as (
select paid_by as id, amount, 'debit' as status from transactions
UNION ALL 
select paid_to, amount, 'credit' as status from transactions), CTE2 as (
select id, amount, status, credit_limit from CTE a
join users b on a.id = b.user_id), 
CTE3 as( 
select id, 
sum(case when status = 'debit' then  amount end) as spent,
sum(case when status = 'credit' then credit_limit+amount end) as new_credit_limit from CTE2 group by id)
select id from CTE3 where spent >new_credit_limit;



--Method2--
with CTE as (
select paid_by as id, amount, 'debit' as status from transactions
UNION ALL 
select paid_to, amount, 'credit' as status from transactions), CTE2 as (
select id, amount, status, credit_limit from CTE a
join users b on a.id = b.user_id), 
CTE3 as( 
select id, 
sum(case when status = 'debit' then  -1*amount
when status = 'credit' then credit_limit+amount end) as balance from CTE2 group by id)
select id from CTE3 where balance <0;