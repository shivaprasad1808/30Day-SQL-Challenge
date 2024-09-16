/*
Query: Find the monthly retention rate of users for each account separately for Dec 2020 and Jan 2021.
Retention rate is the percentage of active users an account retains over a given period of time.
In this case, assume the user is retained if he/she stays with the app in any future months.
For example, if a user was active in Dec 2020 and has activity in any future month, consider them retained for Dec. 
You can assume all accounts are present in Dec 2020 and Jan 2021. Your output should have the account ID 
and the Jan 2021 retention rate divided by Dec 2020 retention rate.
*/

create table sf_events(event_date date, account_id varchar(5), user_id varchar(5));

insert into sf_events values
('2021-01-01',	'A1',	'U1'),
('2021-01-01',	'A1',	'U2'),
('2021-01-06',	'A1',	'U3'),
('2021-01-02',	'A1',	'U1'),
('2020-12-24',	'A1',	'U2'),
('2020-12-08',	'A1',	'U1'),
('2020-12-09',	'A1',	'U1'),
('2021-01-10',	'A2',	'U4'),
('2021-01-11',	'A2',	'U4'),
('2021-01-12',	'A2',	'U4'),
('2021-01-15',	'A2',	'U5'),
('2020-12-17',	'A2',	'U4'),
('2020-12-25',	'A3',	'U6'),
('2020-12-25',	'A3',	'U6'),
('2020-12-25',	'A3',	'U6'),
('2020-12-06',	'A3',	'U7'),
('2020-12-06',	'A3',	'U6'),
('2021-01-14',	'A3',	'U6'),
('2021-02-07',	'A1',	'U1'),
('2021-02-10',	'A1',	'U2'),
('2021-02-01',	'A2',	'U4'),
('2021-02-01',	'A2',	'U5'),
('2020-12-05',	'A1',	'U8');


select * from sf_events order by event_date; 


with CTE_dec as (
 select distinct account_id,  user_id
 from sf_events
 where month(event_date) = 12 and year(event_date) = 2020),
 CTE_jan as (
  select distinct account_id, user_id
 from sf_events
 where month(event_date) = 01 and year(event_date) = 2021),
CTE_max as (
 select  user_id, max(event_date) as max_date
 from sf_events
group by user_id),
Dec_retention as(
select account_id,
sum(case when max_date> '2020-12-31' then 1.0 else 0 end)/ count(*)*1.0 as retention_dec
from CTE_dec a  join CTE_max b
on a.user_id = b.user_id
group by account_id),
Jan_retention as (
select account_id,
sum(case when max_date> '2021-01-31' then 1.0 else 0 end)/ count(*)*1.0 as retention_jan
from CTE_jan a  join CTE_max b
on a.user_id = b.user_id
group by account_id)
select a.account_id,
retention_jan/retention_dec *1.0 as retention_rate
from Jan_retention a 
join Dec_retention b 
on a.account_id = b.account_id;

 
