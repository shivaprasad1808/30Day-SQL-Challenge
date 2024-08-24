use techtfq

create table car_travels(cars varchar(10), days varchar(10), cummulative_distance int)

insert into car_travels values
('car1', 'day1', 50), 
('car1', 'day2', 100), 
('car1', 'day3', 200), 
('car2', 'day1', 0), 
('car3', 'day1', 0), 
('car3', 'day2', 50), 
('car3', 'day3', 50), 
('car3', 'day4', 100); 


select * from car_travels;

select cars, days, cummulative_distance-lag(cummulative_distance,1,0)
over(partition by cars order by days) as distance_travelled
from car_travels;