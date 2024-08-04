use sqlchallenge
/*Day5*/
--Write an sql query to output sales for that month, rolling average sales per month, rolling average sales per each month of an year
 use amazon_books
 
create table amazon_books (book_id varchar(5),	book_title varchar(50), 	unit_price int    )

insert into  amazon_books(book_id ,	book_title,unit_price)
values
('B001',	'The Hunger Games',	25),
('B002',	'The Outsiders',	50),
('B003',	'To Kill a Mockingbird',	100),
('B004',	'Pride and Prejudice',	20),
('B005',	'Twilight',	30),
('B006',	'The Book Thief', 50 ),
('B007',	'Animal Farm',	40),
('B008',	'The Chronicles of Narnia',	30),
('B009',	'Fahrenheit 451', 50),
('B010',	'Gone with the Wind', 25),
('B011',	'The Fault in Our Stars', 30),
('B012',	'The Lightning Thief', 35 ),
('B013',	'The Giving Tree',	40 ),
('B014',	'Wuthering Heights', 45 ),
('B015',	'The Da Vinci Code', 60 ),
('B016',	'Memoirs of a Geisha', 100),
('B017',	'Life of Pi', 80),
('B018',	'The Little Prince', 55),
('B019',	'Jane Eyre', 60),
('B020',	'The Pillars of the Earth',	60);

create table book_orders(order_id int, order_date date, book_id varchar(5), quantity int)

insert into book_orders(order_id, order_date, book_id , quantity)
values
(1001,	'2022-01-10',	'B001',	1),
(1002,	'2022-01-10',	'B009',	1),
(1003,	'2022-01-15',	'B012',	2),
(1004,	'2022-02-04',	'B006',	1),
(1005,	'2022-02-04',	'B019',	2),
(1006,	'2022-02-05',	'B017',	1),
(1009,	'2022-03-01',	'B005',	1),
(1010,	'2022-03-05',	'B001',	1),
(1011,	'2022-03-10',	'B002',	2),
(1012,	'2022-03-10',	'B003',	1),
(1013,	'2022-03-15',	'B020',	1),
(1014,	'2022-04-02',	'B006',	1),
(1015,	'2022-04-10',	'B007',	2),
(1016,	'2022-04-12',	'B019',	1),
(1017,	'2022-04-12',	'B003',	1),
(1019,	'2022-04-21',	'B011',	2),
(1020,	'2022-04-25',	'B001',	2),
(1021,	'2022-05-09',	'B011',	4),
(1022,	'2022-05-09',	'B012',	1),
(1023,	'2022-05-09',	'B006',	1),
(1024,	'2022-05-10',	'B010',	2),
(1025,	'2022-05-15',	'B013',	2),
(1026,	'2022-05-20',	'B012',	1),
(1027,	'2022-05-20',	'B013',	2),
(1028,	'2022-06-10',	'B001',	1),
(1029,	'2022-06-10',	'B009',	1),
(1030,	'2022-06-15',	'B012',	2),
(1031,	'2022-06-15',	'B006',	1),
(1032,	'2022-06-15',	'B019',	2),
(1036,	'2022-07-01',	'B005',	1),
(1037,	'2022-07-05',	'B001',	1),
(1038,	'2022-07-10',	'B002',	2),
(1039,	'2022-07-10',	'B003',	1),
(1040,	'2022-07-15',	'B020',	1),
(1041,	'2022-07-22',	'B006',	1),
(1044,	'2022-07-30',	'B003',	1),
(1045,	'2022-08-01',	'B006',	3),
(1046,	'2022-08-05',	'B011',	2),
(1049,	'2022-08-09',	'B012',	1),
(1050,	'2022-08-09',	'B006',	1),
(1051,	'2022-08-10',	'B010',	2),
(1052,	'2022-08-15',	'B013',	2),
(1053,	'2022-08-20',	'B012',	1),
(1054,	'2022-08-20',	'B013',	2),
(1055,	'2022-09-10',	'B001',	1),
(1056,	'2022-09-10',	'B009',	1),
(1057,	'2022-09-15',	'B012',	2),
(1058,	'2022-09-15',	'B006',	1),
(1059,	'2022-09-15',	'B019',	2),
(1060,	'2022-10-05',	'B017',	1),
(1061,	'2022-10-06',	'B020',	2),
(1062,	'2022-10-08',	'B020',	2),
(1063,	'2022-10-10',	'B005',	1),
(1064,	'2022-11-05',	'B001',	1),
(1065,	'2022-11-10',	'B002',	2),
(1066,	'2022-11-10',	'B003',	1),
(1067,	'2022-11-15',	'B020',	1),
(1068,	'2022-11-02',	'B006',	1),
(1069,	'2022-11-10',	'B007',	2),
(1070,	'2022-11-12',	'B019',	1),
(1071,	'2022-11-12',	'B003',	1),
(1072,	'2022-12-01',	'B006',	3),
(1073,	'2022-12-05',	'B011',	2),
(1074,	'2022-12-05',	'B001',	2),
(1075,	'2022-12-09',	'B011',	4),
(1076,	'2022-12-09',	'B012',	1),
(1077,	'2022-12-09',	'B006',	1),
(1078,	'2022-12-10',	'B010',	2),
(1079,	'2022-12-15',	'B013',	2),
(1080,	'2022-12-20',	'B012',	1),
(1081,	'2022-12-20',	'B013',	2),
(1082,	'2023-01-06',	'B016',	3),
(1083,	'2023-01-12',	'B017',	2),
(1084,	'2023-02-01',	'B009',	1),
(1085,	'2/1/2023',		'B001',	1),
(1086,	'3/10/2023',	'B009',	1),
(1087,	'3/11/2023',	'B012',	2),
(1088,	'3/12/2023',	'B006',	1),
(1089,	'3/13/2023',	'B019',	2),
(1090,	'3/14/2023',	'B017',	1),
(1091,	'3/15/2023',	'B005',	1),
(1092,	'5/5/2023',		'B001',	1),
(1093,	'5/6/2023',		'B002',	2),
(1094,	'5/7/2023',		'B003',	1),
(1095,	'5/8/2023',		'B020',	1),
(1096,	'5/9/2023',		'B006',	1),
(1097,	'5/10/2023',	'B007',	2),
(1098,	'10/12/2023',	'B019',	1),
(1099,	'10/12/2023',	'B003',	1),
(1100,	'10/12/2023',	'B011',	2),
(1101,	'11/10/2023',	'B001',	2),
(1102,	'11/11/2023',	'B011',	4),
(1103,	'11/12/2023',	'B012',	1),
(1104,	'11/13/2023',	'B006',	1),
(1105,	'11/14/2023',	'B010',	2),
(1106,	'12/1/2023',	'B013',	2),
(1026,	'12/2/2023',	'B012',	1),
(1027,	'12/3/2023',	'B013',	2),
(1028,	'12/4/2023',	'B001',	1),
(1029,	'12/5/2023',	'B009',	1),
(1030,	'1/1/2024',		'B012',	2),
(1031,	'1/10/2024',	'B006',	1),
(1032,	'1/15/2024',	'B019',	2),
(1036,	'1/21/2024',	'B005',	1),
(1037,	'2/10/2024',	'B001',	1),
(1038,	'2/12/2024',	'B002',	2),
(1039,	'2/15/2024',	'B003',	1);


select * from amazon_books;
select * from book_orders;


with monthly_sales as (
select  year(order_date) as year, month(order_date) as month, 
sum(quantity*unit_price) as sales_per_month
from amazon_books a
join book_orders b
on a.book_id= b.book_id
group by year(order_date) , month(order_date) 
)
select year, month, sales_per_month, 
(sum(sales_per_month) over(order by year, month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)/
(count(year) over(order by year, month 
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW))) as rolling_avg_sales_per_month,
(sum(sales_per_month) over(partition by year order by month 
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)/(
count(month) over(partition by year order by month
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW))) as rolling_avg_sales_per_month_of_an_year
from monthly_sales;