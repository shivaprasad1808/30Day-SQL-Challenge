use leetcode

/*
Write a solution to display the records with three or more rows with consecutive id's,
and the number of people is greater than or equal to 100 for each.

*/

create table Stadium(id int, visit_date date, no_of_people int);

insert into stadium values
 (1,   '2017-01-01',  10    ), 
 (2,   '2017-01-02',  109   ), 
 (3,   '2017-01-03',  150   ), 
 (4,   '2017-01-04',  99    ), 
 (5,   '2017-01-05',  145   ), 
 (6,   '2017-01-06',  1455  ), 
 (7,   '2017-01-07',  199   ), 
 (8,   '2017-01-09',  188 	);

select * from stadium;
 

with CTE as (
select id, visit_date, people, 
id-ROW_NUMBER() over(order by id) as rn from stadium where people>100)
select id, visit_date, people
from CTE 
where rn IN(
select rn from CTE group by rn having count(rn)>=3)
order by id;