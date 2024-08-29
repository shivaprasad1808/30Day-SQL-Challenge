 /*
from pharma-data5 file, export data from sheet1 to sheet4 to SQL Server into different tables and transfer data from 
4 tables to a single table to get 254082 records

Path to download data: https://drive.google.com/file/d/1npKF_C2tG5psY-at4wvpEgh6T-7KHxEZ/view
*/
select * from pharma_sales1;
 

/* Query1
Write SQL query to find sales of all Quarters of all years 
*/

SELECT
    Year,
format(SUM(CASE WHEN DATEPART(q, Month + ' 1 ' + CAST(Year AS VARCHAR)) = 1 THEN Sales ELSE 0 END), 'C', 'en-US') AS Q1Sales,
format(SUM(CASE WHEN DATEPART(q, Month + ' 1 ' + CAST(Year AS VARCHAR)) = 2 THEN Sales ELSE 0 END), 'C', 'en-US') AS Q2Sales,
format(SUM(CASE WHEN DATEPART(q, Month + ' 1 ' + CAST(Year AS VARCHAR)) = 3 THEN Sales ELSE 0 END), 'C', 'en-US') AS Q3Sales,
format(SUM(CASE WHEN DATEPART(q, Month + ' 1 ' + CAST(Year AS VARCHAR)) = 4 THEN Sales ELSE 0 END), 'C', 'en-US') AS Q4Sales,
format(SUM(Sales), 'C', 'en-US') AS GrandTotal
FROM pharma_sales1
GROUP BY    Year
	order by year;


/* Query2
Write SQL query to find sales of product_class
*/
 
select product_class, format(sum(sales), 'C', 'en-US') as total_sales from pharma_sales1 group by product_class
order by total_sales DESC;


/* Query3
Write SQL query  to SELECT top 10 product_name and its total sales,if more than 1 product_name has same total sales, 
output all product_name by ascending order of product_name
*/

with CTE as(
 select product_name, format(sum(sales), 'C', 'en-US') as total_sales ,
 DENSE_RANK() over(order by format(sum(sales), 'C', 'en-US') DESC) as rn
 from pharma_sales1 group by product_name)
select product_name, total_sales 
from CTE
where rn<=10 order by total_sales DESC, product_name  ASC; 

 
/* Query4
Write SQL query to find total sales  
*/

SELECT FORMAT(sum(sales), 'C', 'en-US') AS SalesAmountWithDollar
FROM pharma_sales1;
