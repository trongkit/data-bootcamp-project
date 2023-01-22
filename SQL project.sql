-- Restaurant Owners
-- 5 Tables
-- 1x FACT 4x Dim
-- search google, how to add foreign key
-- write SQL 3-5 queries analyze data
-- 1x subquery/ with



--Fact Table  
CREATE TABLE orders (
  order_id INT,
  order_date date,
  menu_id INT,
  amount real,
  payment_id int,
  staff_id int,
  order_type int,
  primary key (order_id),
  foreign key (menu_id) references menu(menu_id),
  foreign key (payment_id) references payment(payment_id),
  foreign key (staff_id) references staff(staff_id)
  foreign key (order_type) references type(order_type)
);

insert into orders values
(1 , '2022-08-01' , 2 , 250.00 , 1 , 1 , 3),
(2 , '2022-08-01' , 3 , 300.00 , 1 , 2 , 2),
(3 , '2022-08-02' , 1 , 200.00 , 2 , 2 , 1),
(4 , '2022-08-03' , 2 , 250.00 , 2 , 2 , 1),
(5 , '2022-08-04' , 1 , 200.00 , 1 , 1 , 3),
(6 , '2022-08-05' , 2 , 250.00 , 2 , 1 , 2),
(7 , '2022-08-06' , 1 , 200.00 , 2 , 3 , 1),
(8 , '2022-08-06' , 2 , 250.00 , 2 , 2 , 1),
(9 , '2022-08-07' , 1 , 200.00 , 1 , 1 , 1),
(10, '2022-08-07' , 2 , 250.00 , 2 , 3 , 3),
(11, '2022-08-07' , 2 , 250.00 , 1 , 1 , 3),
(12, '2022-08-07' , 3 , 300.00 , 1 , 2 , 2),
(13, '2022-08-07' , 1 , 200.00 , 2 , 2 , 1),
(14, '2022-08-08' , 2 , 250.00 , 2 , 2 , 1),
(15, '2022-08-08' , 1 , 200.00 , 1 , 3 , 3),
(16, '2022-08-09' , 2 , 250.00 , 2 , 1 , 2),
(17, '2022-08-10' , 3 , 300.00 , 2 , 3 , 1),
(18, '2022-08-10' , 2 , 250.00 , 2 , 2 , 1),
(19, '2022-08-10' , 3 , 300.00 , 1 , 1 , 1),
(20, '2022-08-10' , 1 , 200.00 , 2 , 1 , 3);

--Dim table 1
CREATE TABLE menu (
    menu_id INT,
    menu_name character,
    menu_price real,
    primary key (menu_id)
);
INSERT INTO menu values
(1, 'Hamburger', 200.00),
(2, 'Steak', 250.00),
(3, 'Mix Grilled', 300);

--Dim table 2
CREATE TABLE payment (
  payment_id int,
  payment_method character,
  primary key (payment_id)
);
INSERT INTO payment values
  (1, 'cash'),
  (2, 'credit card');

--Dim table 3
CREATE TABLE staffs (
  staff_id int,
  staff_firstname character,
  staff_lastname character,
  sex character,
  primary key (staff_id)
);
INSERT INTO staffs values
  (1, 'John', 'Mayer', 'Male' ),
  (2, 'Sarah', 'Conner', 'Female' ),
  (3, 'Jamie', 'Oliver', 'Male');

--Dim table 4
CREATE TABLE order_type (
  id int,
  type character,
  primary key (id)
);
INSERT INTO order_type values
  (1, 'Delivery'),
  (2, 'TakeAway'),
  (3, 'SitDown');
  
-- Analyze Data
-- Query 1: Show the selling of each menu from top to lowest

WITH sub AS(
  SELECT 
  	men.menu_name AS menu_list
  FROM   menu AS men
    JOIN orders AS ord
    ON ord.menu_id == men.menu_id
)

SELECT 
	menu_list,
  count (*) AS number_of_order
FROM sub
GROUP BY 1
ORDER BY 2 desc 
;

-- Query 2: Show the top seller staff from top to lowest performance?
  WITH sub AS(
  SELECT 
  	stf.staff_firstname || ' ' || stf.staff_lastname AS staff_name,
  	men.menu_name AS menu_count
  FROM   staffs AS stf
    JOIN orders AS ord
    ON ord.staff_id == stf.staff_id
  	JOIN menu AS men
  	ON ord.menu_id == men.menu_id
)

SELECT 
	staff_name,
    menu_count,
  	count (*) AS number_of_order
FROM sub
GROUP BY 1
ORDER BY 2 desc 
;

-- Query 3: What is the top payment type without sit down in the café?
SELECT
    method,
	COUNT (*) 
FROM
(
      SELECT
          men.menu_name AS menulist,
          pay.payment_method AS method
    	FROM orders AS ord 
      	JOIN menu AS men ON ord.menu_id == men.menu_id
      	JOIN payment AS pay ON ord.payment_id == pay.payment_id
     	WHERE order_type <> 'SitDown'
      	   )
GROUP by 1
ORDER by 2 DESC;
 



--SQLite Command
.mode markdown
.header on
