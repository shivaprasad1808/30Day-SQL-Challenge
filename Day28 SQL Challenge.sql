/*
#Query: Write SQL query to extract the 2nd flight with the most duration between each pair of cities. 
Order the flights by the flight id ascending.

Note: For any cities X and Y, (source_location=X, destination_location=Y) and 
(source_location=Y, destination_location=X) are counted as the same pair of cities.

*/

create table flights(id int, destination_location varchar(20), source_location varchar(20), plane_id int, flight_start datetime,
flight_end	datetime);

insert into flights values
(1,	'Paris',	'Rome',		1,	'2021-01-01 12:00:00',	'2021-01-01 14:00:00'),
(2,	'Paris',	'Rome',		2,	'2021-01-01 12:00:00',	'2021-01-01 14:10:00'),
(3,	'Rome',		'Munich',	3,	'2021-01-01 12:00:00',	'2021-01-01 13:30:00'),
(4,	'Rome',		'Belgrade',	4,	'2021-01-01 12:00:00',	'2021-01-01 13:25:00'),
(5,	'Munich',	'Paris',	5,	'2021-01-01 12:00:00',	'2021-01-01 13:35:00'),
(6,	'Paris',	'Munich',	6,	'2021-01-01 12:00:00',	'2021-01-01 13:30:00'),
(7,	'Munich',	'Paris',	7,	'2021-01-02 12:00:00',	'2021-01-02 13:25:00'),
(8,	'Munich',	'Paris',	8,	'2021-01-02 12:00:00',	'2021-01-02 13:20:00');

select * from flights;

 

with CTE as (
select distinct a.id, a.destination_location, a.source_location, a.flight_start, a.flight_end,
dense_rank() over(partition by 
least(a.destination_location, a.source_location),
greatest(a.destination_location, a.source_location)
order by datediff(MINUTE,  a.flight_start, a.flight_end) DESC) as rn  
from flights a join flights b
on 
a.plane_id<>b.plane_id
or (a.source_location = b.destination_location and a.destination_location = b.source_location)
or (a.source_location = b.source_location and  a.destination_location =  b.destination_location))
select  destination_location, flight_end, flight_start, id, source_location  from CTE where rn=2;




 


 