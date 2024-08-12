/* Below are list of SQL queries for Day10 SQL Challenge */ 
select * from netflix order by show_id

/* Query1
Write SQL Query to show total count of movies and shows */
 
select  type, count(type) as total_count from netflix group by type;

/* Query2
Write SQL Query to calculate the average runtime of movies  */

with CTE as (
select duration from netflix where type = 'movie'),
CTE2 as (
select SUBSTRING(duration, 1, CHARINDEX(' ', duration)-1) as runtime from CTE)
select avg(cast(runtime as int)) as average_runtime_of_movies from CTE2
 

 /* Query3
Write SQL Query to calculate average runtime of movies for each year released */

with CTE as (
select release_year, duration from netflix where type = 'movie'),
CTE2 as (
select release_year, SUBSTRING(duration, 1, CHARINDEX(' ', duration)-1) as runtime from CTE)
select release_year, avg(cast(runtime as int)) as average_runtime from CTE2 
group by release_year
order by release_year


 /* Query4
Write SQL Query to show TOP 5 movies with highest duration, if more than 1 movie
has same duration, then output  movies in ascending order of release_year */

with CTE as (
select release_year, title, duration from netflix where type = 'movie'),
CTE2 as (
select release_year, title, duration,
cast(SUBSTRING(duration, 1, CHARINDEX(' ', duration)-1) as int) as runtime from CTE),
CTE3 as (
select release_year, title, duration, runtime,
dense_RANK() over( order  by runtime desc) as rn from CTE2)
select release_year, title, duration, rn as rank from CTE3 where rn<=5 
order by duration DESC,  release_year ASC; 

 /* Query5
Write SQL Query to show TOP 5 TV Shows with highest seasons, 
if more than 1 movie has same duration, then output  movies in ascending order of release_year */

with CTE as (
select release_year, title, duration from netflix where type = 'TV Show'),
CTE2 as (
select release_year, title, duration,
cast(SUBSTRING(duration, 1, CHARINDEX(' ', duration)-1) as int) as runtime from CTE),
CTE3 as (
select release_year, title, duration, runtime,
dense_rank() over(order by runtime desc) as rn from CTE2)
select  release_year, title, duration, rn as rank from CTE3 where rn<=5
order by runtime DESC,
release_year ASC;


 /* Query6
Write SQL Query to show  number of movies added per year. Output data by ascending order of added_year */

 with CTE as (
 select date_added from netflix where type = 'movie')
 select year(date_added) as added_year, count(date_added) as count_of_movies 
 from CTE
 group by year(date_added)
 order by added_year;
 

 /* Query7
Write SQL Query to show number of TV Shows added per year. Output data by ascending order of added_year */

 with CTE as (
 select date_added from netflix where type = 'TV Show')
 select year(date_added) as added_year, count(date_added) as count_of_movies 
 from CTE
 group by year(date_added)
 order by added_year;


  /* Query8
Write SQL Query to show the movie_count and show_count for each country */

---one county has no name, so it will be blank in output

with CTE as (
select title, type, trim(value) as country from netflix
CROSS APPLY STRING_SPLIT(country, ','))
select country, 
count(case when type = 'Movie' then 1 end) as movie_count,
count(case when type = 'TV Show' then 1 end) as show_count
from CTE group by country
order by country;





