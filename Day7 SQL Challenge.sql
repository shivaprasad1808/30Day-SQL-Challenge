/*DAY 07*/
/*
#Query: Write a query to report the difference between the number of Cakes and Pies sold each day.
Output should include the date sold, the difference between cakes and pies, and which one sold more (cake or pie). 
The difference should be a positive number. If nothing is sold on a given day, output has to be 'nothing_sold'.
If both Cake and Pie are sold in same number on a given day, then output has to be 'Cake and Pie sold equally'.
Return the result table ordered by Date_Sold.
*/

 
create table desserts_new(date_sold date, product varchar(10), amount_sold int);

insert into desserts_new(date_sold, product, amount_sold) values
('01-Jun-2022',	'Cake',	6),
('01-Jun-2022',	'Pie',	18),
('02-Jun-2022',	'Pie',	3),
('02-Jun-2022',	'Cake',	2),
('03-Jun-2022',	'Pie',	14),
('03-Jun-2022',	'Cake',	15),
('04-Jun-2022',	'Pie',	15),
('04-Jun-2022',	'Cake',	6),
('05-Jun-2022',	'Cake',	16),
('05-Jun-2022',	'Pie',	NULL),
('06-Jun-2022',	'Cake',	NULL),
('06-Jun-2022',	'Pie',	NULL),
('07-Jun-2022',	'Cake',	16),
('07-Jun-2022',	'Pie',	16),
('08-Jun-2022',	'Cake',	NULL),
('08-Jun-2022',	'Pie',	NULL),
('09-Jun-2022',	'Cake',	NULL),
('09-Jun-2022',	'Pie',	10),
('10-Jun-2022', 'Cake',	NULL),
('10-Jun-2022',	'Pie',	NULL),
('11-Jun-2022',	'Cake',	25),
('11-Jun-2022',	'Pie',	25);



select * from desserts_new;

 
with CTE as (
select date_sold, product,
case when product = 'cake' then  amount_sold else 0 end  as cake,
case when product = 'pie' then amount_sold else 0 end as pie
from desserts_new)
select date_sold, 
abs(sum(cake) - sum(pie)) as difference,
case when sum(cake)>sum(pie) then 'Cake' 
when sum(pie)>sum(cake) then 'Pie'
when sum(cake) = 0 and  sum(pie) = 0  then 'nothing_sold'
when sum(cake) = sum(pie) then 'Cake and Pie sold equally'
end as sold_more
from CTE  group by date_sold;


/*
 Order of Case statements should be same, if the condition 'Cake and Pie sold equally' is addd before 'nothing_sold', 
 output will be incorrect, because even if nothing is sold for both cake and pie on a given day,
 sold_more column will show as 'Cake and Pie sold equally' which is incorrect.
 */


 

 
