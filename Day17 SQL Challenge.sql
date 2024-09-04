use datalemur

create table Payments(	transaction_id int, merchant_id int, credit_card_id int, amount int, transaction_timestamp datetime)

insert into Payments values
(1,	101,	1,	100,	'2022-09-25 12:00:00'),
(2,	101,	1,	100,	'2022-09-25 12:08:00'),
(3,	101,	1,	100,	'2022-09-25 12:28:00'),
(4,	102,	2,	300,	'2022-09-25 12:00:00'),
(6,	102,	2,	400,	'2022-09-25 14:00:00');


select * from payments

with CTE as(
select merchant_id, credit_card_id, amount,  transaction_timestamp-
lag(transaction_timestamp) over(partition by merchant_id, credit_card_id, amount order by merchant_id) as rn from payments
 )
 select count(rn) as payment_count from CTE
 where DATEPART(minute, rn)<=10;