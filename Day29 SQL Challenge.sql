use leetcode

/*

Write SQL Query to report the period_state for each continuous interval of days .
period_state is 'failed' if tasks in this interval failed or 'succeeded' if tasks in this interval succeeded.
Interval of days are retrieved as start_date and end_date.
Return the result table ordered by start_date.

*/

create table Fail(fail_date date);
create table success(success_date date);

insert into fail values
('2018-12-28'),        
('2018-12-29'),        
('2019-01-04'),        
('2019-01-05');

insert into success values
('2018-12-30'),        
('2018-12-31'),        
('2019-01-01'),        
('2019-01-02'),        
('2019-01-03'),        
('2019-01-06');


 select * from fail;
 select * from success;



 with CTE as (
 select fail_date as date, 'fail' as status from fail
 union all
 select success_date, 'success' as status from success),
 CTE2 as (
 select *, 
 row_number() over(partition by status order by date) as rn,
 datediff(DAY, row_number() over(partition by status order by date) , date) as rn2 
 from CTE)
 select  status,
 MIN(DATE)  AS start_date,
  MAX(DATE)   AS end_date 
 from CTE2
 group by status, rn2
 order by start_date;