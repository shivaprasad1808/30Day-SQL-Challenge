use leetcode

/*
Query:
Write a solution to find employees who have the highest salary in each of the departments.

*/

create table Employee(id int, name varchar(20), salary int, departmentId int);

create table Department(id int, name varchar(20));

insert into Employee values
 (1,   'Joe',    70000,   1),            
 (2,   'Jim',    90000,   1),            
 (3,   'Henry',  80000,   2),            
 (4,   'Sam',    60000,   2),            
 (5,   'Max',    90000,   1);     

 insert into Department values
 (1, 'IT'),
 (2, 'Sales');


select * from Employee;
select * from Department;


with CTE as(
select d.name as Department, e.name as Employee, salary as max_salary,
rank() over(partition by d.name order by salary DESC) as rn
from Employee e
join Department d
on e.departmentId = d.id )
select Department, Employee, max_salary from CTE 
where rn =1;