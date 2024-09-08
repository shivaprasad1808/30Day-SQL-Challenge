use leetcode
/*

Write a solution to swap the seat id of every two consecutive students. 
If the number of students is odd, the id of the last student is not swapped.
Return the result table ordered by id in ascending order.
*/

create table seat(id int, student varchar(20))

insert into seat values
 (1,   'Abbot'),   
 (2,   'Doris'),   
 (3,   'Emerson'), 
 (4,   'Green'),   
 (5,   'Jeames');

select * from seat;



SELECT id,
CASE WHEN id % 2 = 0 THEN lag(student) OVER(ORDER BY id)
ELSE COALESCE(lead(student) OVER(ORDER BY id), student) END AS student
FROM Seat;