/*

#Query: Write SQL query to numbers that appears consecutively for 3 or more times

*/
create table value(id int, num int)
insert into value values
(1	,1)
(2	,1)
(3	,1)
(4	,2)
(5	,3)
(6	,3)
(7	,3)
(8	,3)
(9	,4)
(10,5)
(11,5)
(12,6)
(13,1)
(14,1)
(15,2)
(16,2)
(17,4)
(18,2)
(19,4)
(20,5);

select * from  value;



with CTE as (
select id, num, 
id-ROW_NUMBER() over(partition by num order by id) as rn from value)
select num
from CTE
group by num,rn
having count(num)>=3
