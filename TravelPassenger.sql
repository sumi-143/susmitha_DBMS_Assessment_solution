/* Create a new database */
create database travelonthego1;

/*start using the database */
use travelonthego1; 

/* Disabling foreign key checks to enter Khusboo data as it does not have corresponding entry in price_details table */
SET foreign_key_checks = 0;

/* create table passenger details */
 create table if not exists passenger_details
 (passenger_id int NOT NULL AUTO_INCREMENT,
 passenger_name varchar(60),
 gender varchar(1),
 primary key(passenger_id));
 
 /* create table busroute details */
  create table if not exists busroute_details 
  (route_id int NOT NULL AUTO_INCREMENT,
   boarding_city varchar(60),
   destination_city varchar(60),
   distance int,
   bus_type varchar(10),
   primary key(route_id));

/*create table price details */
  create table  if not exists price_details 
  (price_id int NOT NULL AUTO_INCREMENT,
   bustype varchar(10),
   distance int,
   price int,
   primary key(price_id));
   
/*create table trip details */
create table  if not exists trip_details
(trip_id int NOT NULL AUTO_INCREMENT,
passenger_id int,
route_id int,
price_id int,
category varchar(10),
primary key(trip_id),
foreign key (passenger_id) references passenger_details(passenger_id), 
foreign key (route_id) references busroute_details(route_id),
foreign key (price_id) references price_details(price_id)
);

/*Insert values into passenger details */
INSERT into passenger_details values (NULL, 'Sejal', 'F');
INSERT into passenger_details values (NULL, 'Anmol', 'M');
INSERT into passenger_details values (NULL, 'Pallavi', 'F');
INSERT into passenger_details values (NULL, 'Khusboo', 'F');
INSERT into passenger_details values (NULL, 'Udit', 'M');
INSERT into passenger_details values (NULL, 'Ankur', 'M');
INSERT into passenger_details values (NULL, 'Hemant', 'M');
INSERT into passenger_details values (NULL, 'Manish', 'M');
INSERT into passenger_details values (NULL, 'Piyush', 'M');

/*Insert values into busroute details */
INSERT into busroute_details values (NULL, 'Bengaluru', 'Chennai', 350, 'Sleeper');
INSERT into busroute_details values (NULL, 'Mumbai', 'Hyderabad', 700, 'Sitting');
INSERT into busroute_details values (NULL, 'Panaji', 'Bengaluru', 600, 'Sleeper');
INSERT into busroute_details values (NULL, 'Chennai', 'Mumbai', 1500, 'Sleeper');
INSERT into busroute_details values (NULL, 'Trivandrum', 'Panaji', 1000, 'Sleeper');
INSERT into busroute_details values (NULL, 'Nagpur', 'Hyderabad', 500, 'Sitting');
INSERT into busroute_details values (NULL, 'Panaji', 'Mumbai', 700, 'Sleeper');
INSERT into busroute_details values (NULL, 'Hyderabad', 'Bengaluru', 500, 'Sitting');
INSERT into busroute_details values (NULL, 'Pune', 'Nagpur', 700, 'Sitting');


/*Insert values into price details */
INSERT into price_details values (NULL, 'Sleeper', 350, 770);
INSERT into price_details values (NULL, 'Sleeper', 500, 1100);
INSERT into price_details values (NULL, 'Sleeper', 600, 1320);
INSERT into price_details values (NULL, 'Sleeper', 700, 1540);
INSERT into price_details values (NULL, 'Sleeper', 1000, 2200);
INSERT into price_details values (NULL, 'Sleeper', 1200, 2640);
INSERT into price_details values (NULL, 'Sleeper', 350, 434);
INSERT into price_details values (NULL, 'Sitting', 500, 620);
INSERT into price_details values (NULL, 'Sitting', 600, 744);
INSERT into price_details values (NULL, 'Sitting', 700, 868);
INSERT into price_details values (NULL, 'Sitting', 1000, 1240);
INSERT into price_details values (NULL, 'Sitting', 1200, 1488);
INSERT into price_details values (NULL, 'Sitting', 1500, 1860);


/*Insert into trip details */

/*Sejals Data */
INSERT into trip_details values (NULL,1, 1, 1, 'AC');

/*Anmols Data */
INSERT into trip_details values (NULL,2, 2, 10, 'Non-AC');

/* Pallavi Data*/
INSERT into trip_details values (NULL,3, 3, 3,'AC');

/*Khusboo Data - It does have referential key in price_details table hence NULL is given*/
INSERT into trip_details values (NULL,4, 4, Null,'Non-AC');

/*Udit data*/
INSERT into trip_details values (NULL,5, 5, 5,'Non-AC');

/*Ankur data*/
INSERT into trip_details values (NULL,6, 6,8, 'AC');

/*Hemant data */
INSERT into trip_details values (NULL,7, 7, 4, 'Non-AC');

/*Manish data*/
INSERT into trip_details values (NULL,8, 8, 8,'Non-AC');

/*Piyush data*/
INSERT into trip_details values (NULL,9, 9, 10, 'AC');


/* Question no 3 - How many females and how many male passengers travelled for a  minimum distance of 600 Km*/
select count(case when gender='M' then 1 end) as male_coun,
count(case when gender='F' then 1 end) as female_cnt from passenger_details 
where passenger_id = ANY (select passengeR_id from trip_details
where route_id = ANY(select route_id from busroute_details where distance >= 600));

/* Question no 4 - Find minimum ticket price for Sleeper Bus */
select min(price) as minimum_sleeper_price from price_details where price_details.bustype = "Sleeper";

/* Question no 5 - select passenger names whose names start with character 'S' */
select passenger_name from passenger_details where passenger_name like 'S%' or passenger_name like 's%' ;


/* Question 6  - Calculate price charges for each passenger displaying Passenger name, boardng city, destination city, bus type, price in output */
/* Ouput of this query does not have khusboo's enry s price details does not have her distance */
select passenger_details.passenger_name, busroute_details.boarding_city, 
busroute_details.destination_city, busroute_details.bus_type, price_details.price from 
passenger_details, trip_details, busroute_details, price_details where 
passenger_details.passenger_id = trip_details.passenger_id and 
trip_details.route_id = busroute_details.route_id and 
trip_details.price_id = price_details.price_id ;


/* Question 7  - What is the passenger name and his/her ticket price who travelled in Sitting bus for a 
distance of 1000 KM s */
 select passenger_details.passenger_name, price_details.price from 
 passenger_details, price_details, trip_details where 
 passenger_details.passenger_id = trip_details.passenger_id and 
trip_details.price_id = price_details.price_id and 
price_details.distance = 1000 and price_details.bustype = 'Sitting';

/* Question 8 - What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji? */

/* Here the destination and boarding city is in inverse, so we need to check either way to get the ouput, otherwise the output will be no entry */
select price_details.bustype, price from 
price_details where price_details.distance = 
(select busroute_details.distance from busroute_details where
(busroute_details.boarding_city = 'Bengaluru' and 
busroute_details.destination_city = 'Panaji' or
busroute_details.boarding_city = 'Panaji' and 
busroute_details.destination_city = 'Bengaluru' ));

/* Question 9 -  List the distances from the "Passenger" table which are unique (non-repeated 
distances) in descending order */
/* after normalization distance is removed from Passenger table and is available in price_detail and bus route details */
select distinct(busroute_details.distance) from busroute_details order by distance desc;
select distinct(price_details.distance) from price_details order by distance desc;

/* Questoin 10 -  Display the passenger name and percentage of distance travelled by that passenger 
from the total distance travelled by all passengers without using user variables */

select passenger_details.passenger_name, 
busroute_details.distance *100/sum(busroute_details.distance) over() as 
percentage_of_distance_travelled  from 
busroute_details, passenger_details, trip_details where 
passenger_details.passenger_id = trip_details.passenger_id and 
trip_details.route_id = busroute_details.route_id ;

/* ) Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise
 */
 
delimiter &&
CREATE PROCEDURE pricecategory()
BEGIN
select price_details.distance, price_details.price, 
case when  price_details.price > 1000 then 'Expensive'
when price_details.price < 1000 and price_details.price > 500  then 'Average Cost'
else 'Cheap Cost'
end as price_category from price_details;
END && ;
delimiter ;

call pricecategory();