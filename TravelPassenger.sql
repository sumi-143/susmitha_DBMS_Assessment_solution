create database if not exists DBMS_ASSIGNMENT_SCHEMA;
use DBMS_ASSIGNMENT_SCHEMA;

-- 1) Create Tables

CREATE TABLE PASSENGER
(Passenger_name varchar(50),
Category varchar(15),
Gender varchar(1),
Boarding_City varchar(25),
Destination_City varchar(25),
Distance int,
Bus_Type varchar(10)
);


CREATE TABLE PRICE
(
Bus_Type varchar(10),
Distance int,
Price int
);

-- 2) Insert Values

INSERT INTO PASSENGER VALUES ('Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper');
INSERT INTO PASSENGER VALUES ('Anmol', 'Non-AC' ,'M','Mumbai', 'Hyderabad', 700, 'Sitting');
INSERT INTO PASSENGER VALUES ('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper');
INSERT INTO PASSENGER VALUES ('Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper');
INSERT INTO PASSENGER VALUES ('Udit', 'Non-AC', 'M', 'Trivandrum', 'panaji', 1000, 'Sleeper');
INSERT INTO PASSENGER VALUES ('Ankur', 'AC', 'M' ,'Nagpur', 'Hyderabad', 500 ,'Sitting');
INSERT INTO PASSENGER VALUES ('Hemant', 'Non-AC' ,'M', 'panaji', 'Mumbai', 700 ,'Sleeper');
INSERT INTO PASSENGER VALUES ('Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500 ,'Sitting');
INSERT INTO PASSENGER VALUES ('Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting');

INSERT INTO PRICE  VALUES ('Sleeper', 350, 770);
INSERT INTO PRICE  VALUES ('Sleeper', 500, 1100);
INSERT INTO PRICE  VALUES ('Sleeper', 600, 1320);
INSERT INTO PRICE  VALUES ('Sleeper', 700, 1540);
INSERT INTO PRICE  VALUES ('Sleeper', 1000, 2200);
INSERT INTO PRICE  VALUES ('Sleeper', 1200, 2640);
INSERT INTO PRICE  VALUES ('Sleeper', 350, 434);
INSERT INTO PRICE  VALUES ('Sitting', 500, 620);
INSERT INTO PRICE  VALUES ('Sitting', 500, 620);
INSERT INTO PRICE  VALUES ('Sitting', 600, 744);
INSERT INTO PRICE  VALUES ('Sitting', 700, 868);
INSERT INTO PRICE  VALUES ('Sitting', 1000, 1240);
INSERT INTO PRICE  VALUES ('Sitting', 1200, 1488);
INSERT INTO PRICE  VALUES ('Sitting', 1500, 1860);

-- 3) Solution Query

SELECT  GENDER,COUNT(*)
FROM PASSENGER 
WHERE DISTANCE >=600 
GROUP BY GENDER;

-- 4) Solution Query

SELECT min(price) FROM PRICE WHERE bus_type='Sleeper';

-- 5) Solution Query

SELECT * FROM PASSENGER WHERE passenger_name like 'S%';

-- 6) Solution Query

SELECT p1.Passenger_name, p1.Boarding_city,p1.Destination_city,p1.Category, p1.Bus_type
, max(p2.price) as Max_price
FROM passenger p1 
INNER JOIN price p2
USING (bus_type, distance)
group by p1.passenger_name, p1.Boarding_city,p1.Destination_city,p1.category, p1.Bus_type ;


-- 7) Solution Query

SELECT Passenger_name, Price
FROM Passenger p1, Price p2
WHERE p1.Distance = p2.Distance
AND p1.Bus_Type = p2.Bus_Type
AND p1.Bus_Type = 'Sitting'
AND p2.Distance = 1000;

-- 8) Solution Query

SELECT p1.Passenger_name, p1.Boarding_city,p1.Destination_city,p1.Category, p2.Bus_type
, p2.price as Price
FROM passenger p1 
INNER JOIN price p2
USING (distance)
where 
 ( (p1.Boarding_city='Bengaluru' and p1.Destination_city='Panaji')
or (p1.Boarding_city='Panaji' and p1.Destination_city='Bengaluru') ) ;

-- 9) Solution Query

SELECT distinct(distance) from passenger order by distance desc;

-- 10) Solution Query

SELECT p1.passenger_name, (p1.distance/(SELECT sum(distance) FROM passenger))*100 percentage
FROM passenger p1;

-- 11) Solution Query
select p1.distance ,p1.price ,
case 
when p1.price >1000 then 'expensive' 
when (p1.price >500 and p1.price<1000) then 'average'
else 'cheap' end  p1_category 
from price p1;
