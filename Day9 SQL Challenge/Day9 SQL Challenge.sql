/* DAY9
Write SQL query for find employees who are on leave consecutively for 3 or more days */

 select * from employee

with CTE as(
select distinct * from employee where on_leave = 'Yes'),
CTE2 as (
select emp_id, office_date, row_number() over(partition by emp_id order by office_date) as rn  from CTE), 
CTE3 as (
select emp_id, office_date, dateadd(day, -rn, office_date) as rn2 from CTE2),
CTE4 as (
select *, count(*) over(partition by emp_id, rn2 order by emp_id) as rn3 from CTE3)
select distinct emp_id from CTE4 where rn3>=3;
 


