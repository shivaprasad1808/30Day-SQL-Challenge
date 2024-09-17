/*

#Query: If the customer's preferred delivery date is the same as the order date,
then the order is called immediate; otherwise, it is called scheduled.

The first order of a customer is the order with the earliest order date that the customer made. 
It is guaranteed that a customer has precisely one first order.

Write SQL Query to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.
*/

create table Delivery(delivery_id int, customer_id int, order_date date, customer_pref_delivery_date date);

insert into delivery values
 (1,           1,           '2019-08-01', '2019-08-02'),                 
 (2,           2,           '2019-08-02', '2019-08-02'),                 
 (3,           1,           '2019-08-11', '2019-08-12'),                 
 (4,           3,           '2019-08-24', '2019-08-24'),                 
 (5,           3,           '2019-08-21', '2019-08-22'),                 
 (6,           2,           '2019-08-11', '2019-08-13'),                 
 (7,           4,           '2019-08-09', '2019-08-09');

 select * from Delivery;

WITH CTE AS (
    SELECT 
        customer_id, 
        order_date, 
        customer_pref_delivery_date,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS rn,
        CASE 
            WHEN order_date = customer_pref_delivery_date THEN 'immediate' 
            ELSE 'scheduled' 
        END AS status
	 FROM Delivery)
 SELECT 
    CAST(
        (COUNT(CASE WHEN rn = 1 AND status = 'immediate' THEN 1 END) * 100.0) / 
        COUNT(CASE WHEN rn = 1 THEN 1 END) 
    AS DECIMAL(5, 2)
    ) AS immediate_order_percentage
FROM CTE;


 
