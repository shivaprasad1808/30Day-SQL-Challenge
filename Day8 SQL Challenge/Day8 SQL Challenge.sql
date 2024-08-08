
select * from medicines;

/* Query1
SQL query to show count of medicines for each manufacturer in ascending order of manufacturer_name*/

select manufacturer_name, count(manufacturer_name) as count_of_medicines 
from medicines
group by manufacturer_name
order by manufacturer_name;



/* Query2
SQL query to show count of discontinued medicines for each manufacturer in descending 
order of count_of_discontinued_medicines */

select manufacturer_name, count(is_discontinued) as count_of_discontinued_medicines from medicines
where is_discontinued = 'YES'
group by manufacturer_name
order by count_of_discontinued_medicines DESC;

/* Query3
SQL query to show manufacturer name with highest count of discontinued medicines.
If more than one manufacturer has highest count of discontinued medicines, output all manufacturer name in 
ascending order*/

with highest_discontinued as(
select count(is_discontinued) as highest_count_of_discontinued_medicines, manufacturer_name, 
rank() over(order by count(is_discontinued) DESC) as rn 
from medicines
where is_discontinued = 'YES'
group by manufacturer_name)
select highest_count_of_discontinued_medicines, manufacturer_name 
from highest_discontinued
where rn=1;


/* Query4
SQL query to show manufacturer name with lowest count of discontinued medicines.
If more than one manufacturer has lowest count of discontinued medicines, output all manufacturer name in 
ascending order*/

with least_discontinued as(
select count(is_discontinued) as lowest_count_of_discontinued_medicines, manufacturer_name, 
rank() over(order by count(is_discontinued) asc) as rn 
from medicines
where is_discontinued = 'YES'
group by manufacturer_name)
select lowest_count_of_discontinued_medicines, manufacturer_name 
from least_discontinued
where rn=1
order by manufacturer_name;

/* Query5
SQL query to show manufacturer name with atmost ten discontinued medicines.
If more than one manufacturer has same count of discontinued medicines, output all manufacturer name in 
ascending order*/

with atmost_ten as(
select count(is_discontinued) as count_of_discontinued_medicines, manufacturer_name, 
dense_rank() over(order by count(is_discontinued) asc) as rn 
from medicines
where is_discontinued = 'YES'
group by manufacturer_name)
select count_of_discontinued_medicines, manufacturer_name 
from atmost_ten
where rn<=10
order by count_of_discontinued_medicines, manufacturer_name;


/* Query6
SQL query to show manufacturer name with more than ten discontinued medicines.
If more than one manufacturer has same count of discontinued medicines, output all manufacturer name in 
ascending order*/

with more_than_ten as(
select count(is_discontinued) as count_of_discontinued_medicines, manufacturer_name, 
dense_rank() over(order by count(is_discontinued) asc) as rn 
from medicines
where is_discontinued = 'YES'
group by manufacturer_name)
select count_of_discontinued_medicines, manufacturer_name from more_than_ten
where rn>10
order by count_of_discontinued_medicines, manufacturer_name;





