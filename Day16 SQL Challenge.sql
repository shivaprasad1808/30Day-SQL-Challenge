use analyst;
/*
Query1: Write SQL query to find maximum id without duplicates
*/

create table user2(id int)
insert into users2 values 
(2),
(5),
(6),
(6),
(7),
(8),
(8),
(9);
 
select * from user2;



select top 1 id from user2 where id not in(
select id from user2
group by id
having count(id)>1)
order by id desc;


/*
Query2: Write SQL query to find state and city with highest and lowest population 
*/

create table place(state varchar(20), city varchar(20), population int)

insert into place values
('Haryana',	'Ambala',	100        ),
('Haryana',	'Panipat',	200        ),
('Haryana',	'Gurugaon',	300        ),
('Punjab',	'Amritsar',	150        ),
('Punjab',	'Ludhiana',	400        ),
('Punjab',	'Jalandhar',	250    ),
('Maharashtra',	'Mumbai',	1000   ),
('Maharashtra',	'Pune',	600        ),
('Maharashtra',	'Nagpur',	300    ),
('Karnataka',	'Bangalore',	900),
('Karnataka',	'Mysore',	400    ),
('Karnataka',	'Mangalore',	200);



select * from place;


WITH CTE AS (
SELECT state, city,
ROW_NUMBER() OVER(PARTITION BY state ORDER BY population DESC) AS max_population,
ROW_NUMBER() OVER(PARTITION BY state ORDER BY population ASC) AS min_population
FROM place)
SELECT state,
max(CASE WHEN max_population = 1 THEN city END) AS high_population,
max(CASE WHEN min_population = 1 THEN city END) AS low_population
FROM  CTE
GROUP BY state;
   
   
