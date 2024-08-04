
create table desserts(date_sold date, product varchar(10), amount_sold int)

insert into desserts(date_sold, product, amount_sold) values
('01-Jun-2022',	'Cake',	6),
('01-Jun-2022',	'Pie',	18),
('02-Jun-2022',	'Pie',	3),
('02-Jun-2022',	'Cake',	2),
('03-Jun-2022',	'Pie',	14),
('03-Jun-2022',	'Cake',	15),
('04-Jun-2022',	'Pie',	15),
('04-Jun-2022',	'Cake',	6),
('05-Jun-2022',	'Cake',	16),
('05-Jun-2022',	'Pie',	NULL)

select * from desserts;

with CTE as (
select date_sold, 
case when product = 'cake' then amount_sold else 0 end   as cake,
case when product = 'pie' then amount_sold else 0 end  as pie
from desserts)
select date_sold,
abs(sum(cake) - sum(pie)) as difference,
case when sum(cake)>sum(pie) then 'Cake' else 'Pie' end as sold_more
from CTE group by date_sold;



