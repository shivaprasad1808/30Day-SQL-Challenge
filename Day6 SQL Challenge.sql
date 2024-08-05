/*DAY 6*/
---Query: For each region, find the house that has won maximum number of battles. Display region, house, number of wins



create table king_data(k_no int, king varchar(30), house varchar(30))

insert into king_data values
(1, 'Robb Stark', 'House Stark'),
(2, 'Joffrey Baratheon', 'House Lannister'),
(3, 'Stannis Baratheon', 'House Baratheon'),
(4, 'Balon Greyjoy', 'House Greyjoy'),
(5, 'Mace Tyrell', 'House Tyrell'),
(6, 'Doran Martell', 'House Martell');


create table battle_data(battle_number int, name varchar(30), attacker_king int, defender_king int, 
atatcker_outcome int, region varchar(30))


insert into battle_data values
(1, 'Battle of Oxcross', 1, 2, 1, 'The North'),
(2, 'Battle of Blackwater', 3, 4, 0, 'The North'),
(3, 'Battle of the Fords', 1, 5, 1, 'The Reach'),
(4, 'Battle of the Green Fork', 2, 6, 0, 'The Reach'),
(5, 'Battle of the Ruby Ford', 1, 3, 1, 'The Riverlands'),
(6, 'Battle of the Golden Tooth', 2, 1, 0, 'The North'),
(7, 'Battle of Riverrun', 3, 4, 1, 'The Riverlands'),
(8, 'Battle of Riverrun', 1, 3, 0, 'The Riverlands');


select  * from king_data;
select * from battle_data;				

with king_wins as (
select a.k_no, a.house,  b.region, 
sum(b.attacker_outcome)  as wins
from king_data a
join battle_data b
on a.k_no = b.attacker_king where b.attacker_outcome = 1
group by a.k_no, a.house, b.region
UNION ALL
select a.k_no, a.house, b.region, 
sum(case when b.attacker_outcome = 0  then 1 end) as wins
from king_data a 
join battle_data b
on a.k_no = b.defender_king where attacker_outcome = 0
group by a.k_no, a.house, b.region),
king_wins_by_region as (
select  region, house, sum(wins) as total_wins,  rank() over(partition by region order by sum(wins) DESC)as no_of_wins
from king_wins
group by 
house, region)
select  region, house, total_wins from king_wins_by_region where no_of_wins=1;
