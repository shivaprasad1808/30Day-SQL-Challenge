/*
#Query: Find the top 5 states with the most 5 star businesses. Output the state name 
along with the number of 5-star businesses and order records by the number of 5-star businesses in descending order. 
In case there are ties in the number of businesses, return all the unique states.
If two states have the same result, sort them in alphabetical order.
*/

create table yelp_business(business_id varchar(30), name varchar(100), neighborhood varchar(30), address varchar(100),
city varchar(30), state varchar(5), postal_code  varchar(15), latitude decimal(10,3), longitude decimal(10,3), stars int, review_count int,
is_open int, categories varchar(200)
);

select * from yelp_business;

with CTE as (
select state, count(stars) as star_count,
dense_rank() over( order by count(stars) desc ) as rn
from yelp_business where stars = 5
group by state)
select state, star_count as n_businesses 
from CTE
where rn<=5 order by  n_businesses DESC, state ASC;

