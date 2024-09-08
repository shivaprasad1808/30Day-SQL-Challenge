use leetcode

/*
Query:
Write SQL query to sort Olympic table according to the following rules:

The country with more gold medals comes first.

If there is a tie in the gold medals, the country with more silver medals comes first.

If there is a tie in the silver medals, the country with more bronze medals comes first.

If there is a tie in the bronze medals, the countries with the tie are sorted in ascending order lexicographically.
*/

create table Olympic(country varchar(20), gold_medals int, silver_medals int, bronze_medals int)

insert into olympic values
('China', 			10, 10, 20), 
 ('South Sudan', 	0, 	0,	1),  
 ('USA', 			10,	10, 20), 
 ('Israel', 		2, 2,  3),  
 ('Egypt',  		2, 2, 2),   
('India', 			10, 12, 11),
('Japan', 			10, 13, 22),
('Indonesia', 		12, 20, 30),
('Africa',			10, 12, 40);  

select * from olympic;



 select * from olympic 
 order by gold_medals DESC, silver_medals DESC, bronze_medals DESC, country ASC;
