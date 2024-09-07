/*
Query:

Given a table of product subscriptions with a subscription start date
and end date for each user, write a query that returns true or false whether 
or not each user has a subscription date range that overlaps with any other completed subscription.


*/

create table subscriptions(user_id int, start_date date, end_date date);

insert into subscriptions values
(1,	'2019-01-01',	'2019-01-31'),
(2,	'2019-01-15',	'2019-01-17'),
(3,	'2019-01-29',	'2019-02-04'),
(4,	'2019-02-05',	'2019-02-10');

select * from subscriptions;

select   a.user_id,
max(case when a.start_date<=b.end_date and b.start_date >= a.end_date then 1 else 0 end)   as rn 
from subscriptions a join subscriptions b
on a.user_id <> b.user_id
 group by a.user_id;
