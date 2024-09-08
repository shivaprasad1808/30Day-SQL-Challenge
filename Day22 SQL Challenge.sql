use ankitbansal

/*
#Query: Write an SQL Query to find no of medals per swimmer for swimmers who won gold medal only.

*/

CREATE TABLE events2 (
ID int,
event varchar(255),
YEAR INt,
GOLD varchar(255),
SILVER varchar(255),
BRONZE varchar(255)
);

INSERT INTO events2 VALUES 
(1,'100m',2016, 'Amthhew Mcgarray','donald','barbara'),
(2,'200m',2016, 'Nichole','Alvaro Eaton','janet Smith'),
(3,'500m',2016, 'Charles','Nichole','Susana'),
(4,'100m',2016, 'Ronald','maria','paula'),
(5,'200m',2016, 'Alfred','carol','Steven'),
(6,'500m',2016, 'Nichole','Alfred','Brandon'),
(7,'100m',2016, 'Charles','Dennis','Susana'),
(8,'200m',2016, 'Thomas','Dawn','catherine'),
(9,'500m',2016, 'Thomas','Dennis','paula'),
(10,'100m',2016, 'Charles','Dennis','Susana'),
(11,'200m',2016, 'jessica','Donald','Stefeney'),
(12,'500m',2016,'Thomas','Steven','Catherine');

select * from events2;


with CTE as (
select gold as  name, 'gold' as medal from events2
UNION ALL
select silver, 'silver' as medal from events2
UNION ALL
select BRONZE, 'bronze' as medal from events2)
select name as player, count(name) as no_of_gold from CTE where name not in
(select name from CTE where medal IN ('silver', 'bronze'))
group by name;






 