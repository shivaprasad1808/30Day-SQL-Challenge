create database sqlchallenge

--Write an  SQL query that'll identify active users. An active user is a user that has made a second purchase within 7 days of any other of their purchases.

use sqlchallenge

create table users(user_id int, item varchar(40), purchase_date date, amount int)

insert into users(user_id, item, purchase_date, amount) values
(5, 	'Smart Crock Pot',   	'2021-09-18', 	 698882),
(6, 	'Smart Lock',        	'2021-09-14', 	  11487),
(6, 	'Smart Thermostat', 	'2021-09-10', 	 674762),
(8, 	'Smart Light Strip', 	'2021-09-29', 	 630773),
(4, 	'Smart Cat Feeder',  	'2021-09-02', 	 693545),
(4, 	'Smart Bed',         	'2021-09-13', 	 170249),
(5,		'Classic Cars',			'2005-01-20',		4515),
(5,		'Motorcycles',			'2005-01-05',		3664),
(5,		'Classic Cars',			'2005-01-31',		4046),
(9,		'Classic Cars',			'2005-01-20',		2297),
(9,		'Classic Cars',			'2005-01-06',		2818),
(10,	'Classic Cars',			'2005-01-23',		3561),
(11,	'Trucks and Buses',		'2005-01-20',		8470),
(11,	'Motorcycles',			'2005-01-05',		3877),
(11,	'Classic Cars',			'2005-01-26',		5862),
(12,	'Classic Cars',			'2005-01-06',		3289),
(12,	'Classic Cars',			'2005-01-26',		5942),
(12,	'Classic Cars',			'2005-01-06',		2775),
(12,	'Trucks and Buses',		'2005-01-23',		1750),
(15,	'Classic Cars',			'2005-01-06',		4069),
(21,	'Trucks and Buses',		'2005-01-20',		3911),
(21,	'Classic Cars',			'2005-01-07',		2612),
(20,	'Vintage Cars',			'2005-01-20',		9240),
(20,	'Vintage Cars',			'2005-01-20',		3156),
(21,	'Classic Cars',			'2005-01-12',		2759),
(22,	'Planes',				'2005-01-31',		1611),
(23,	'Vintage Cars',			'2005-01-12',		4704),
(23,	'Classic Cars',			'2005-01-06',		3687)

select * from users order by user_id, purchase_date;

--Solution

 with CTE as ( select distinct user_id, purchase_date as current_purchase_date from USERS)  
,CTE2 as(
select user_id, current_purchase_date, lag(current_purchase_date) over(partition by user_id order by current_purchase_date)
as previous_purchase_date from CTE)
select user_id from CTE2 where DATEDIFF(DAY, previous_purchase_date, current_purchase_date) <=7;
