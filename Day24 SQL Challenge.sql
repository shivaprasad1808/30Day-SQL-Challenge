/*
Query:
Write a SQL Query to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively.
A user was active on someday if they made at least one activity on that day.
*/

create table Activity(user_id int, session_id int, activity_date date, activity_type varchar(20));

insert into activity values
 (1,        1,           '2019-07-20',     'open_session'),  
 (1,        1,           '2019-07-20',     'scroll_down'),   
 (1,        1,           '2019-07-20',     'end_session'),   
 (2,        4,           '2019-07-20',     'open_session'),  
 (2,        4,           '2019-07-21',     'send_message'),  
 (2,        4,           '2019-07-21',     'end_session'),   
 (3,        2,           '2019-07-21',     'open_session'),  
 (3,        2,           '2019-07-21',     'send_message'),  
 (3,        2,           '2019-07-21',     'end_session'),   
 (4,        3,           '2019-06-25',     'open_session'),  
 (4,        3,           '2019-06-25',     'end_session'); 
 


 select * from activity;



 
select activity_date as day,   count(distinct user_id) as  active_users
from Activity
where activity_date between dateadd(day, -30, '2019-07-27') and  '2019-07-27'
group by activity_date;