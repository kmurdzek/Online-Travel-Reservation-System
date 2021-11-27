create database if not exists ticketing;
use ticketing;
drop table if exists users;
create table users(
username varchar(20) primary key,
password varchar(20),
fname varchar(20),
lname varchar(20),
is_admin bool,
is_customer_rep bool,
is_customer bool
);

drop table if exists flight;
create table flight(
flight_number int primary key,
arrival_date date,
arrival_time time,
arrival_airport varchar(5) references airport(airport_id),
departure_date date,
departure_time time,
departure_airport varchar(5) references airport(airport_id),
occupied_seats int,
is_domestic bool,
is_international bool
);
insert into airport
values
("EWR"),
("JFK"),
("ORD");
insert into flight
values
(1, "2022-01-09", "9:00", "EWR", "2022-01-09", "10:00", "ORD", 0, 1,0),
(2, "2022-02-09", "9:00", "JFK", "2022-02-09", "10:00", "ORD", 0, 1,0),
(3, "2022-01-09", "7:00", "EWR", "2022-01-09", "8:00", "JFK", 0, 1,0),
(6, "2022-02-09", "9:00", "ORD", "2022-02-09", "10:00", "EWR", 0, 1,0),
(5, "2022-02-09", "9:00", "ORD", "2022-02-09", "10:00", "EWR", 0, 1,0),
(4, "2022-02-09", "9:00", "ORD", "2022-02-09", "10:00", "EWR", 0, 1,0),
(7, "2022-02-09", "9:00", "EWR", "2022-02-09", "10:00", "ORD", 0, 1,0),
(8, "2022-02-09", "9:00", "EWR", "2022-02-09", "10:00", "ORD", 0, 1,0),
(9, "2022-02-09", "9:00", "EWR", "2022-02-09", "10:00", "ORD", 0, 1,0);



drop table if exists aircraft;
create table aircraft(
aircraft_model_number int primary key,
number_of_seats int
);
drop table if exists airline;
create table airline(
airline_id varchar(5) primary key,
airline_name varchar(50)
);
drop table if exists airport;
create table airport(
airport_id varchar(5) primary key
);
drop table if exists ticket;
create table ticket(
ticket_id int,
flight_number int references flight,
seat varchar(3),
price double,
primary key(ticket_id, flight_number)
);
insert into ticket
values
(100,1, "A1",154.00),
(101,1, "A2", 156.00)
;
select ticket_id, seat
from ticket t
where t.flight_number = 1;
drop table if exists economy_class;
create table economy_class(
ticket_id varchar(10) primary key references ticket,
cancellation_fee double
);
drop table if exists business_class;
create table business_class(
ticket_id varchar(10) primary key references ticket
);
drop table if exists first_class;
create table first_class(
ticket_id varchar(10) primary key references ticket
);
drop table if exists flight_uses;
create table flight_uses(
flight_number int primary key references flight,
aircraft_model_number int references aircraft
);
drop table if exists airline_owns_aircrafts;
create table airline_owns_aircrafts(
airline_id varchar(5) references airline,
aircraft_model_number int references aircraft,
primary key(airline_id, aircraft_model_number)
);
drop table if exists airport_services_flight;
create table airport_services_flight(
flight_number int primary key references flight,
departure_id varchar(5) references airport(airport_id),
arrival_id varchar(5) references airport(airport_id)
);
drop table if exists destination;
create table destination(
ticket_id varchar(10) primary key references ticket,
destination varchar(30),
departing varchar(30)
);
drop table if exists waitlisted;
create table waitlisted(
username varchar(20) references user,
flight_number int references flight,
primary key(username, flight_number)
);
drop table if exists purchases;
create table purchases(
username varchar(20) primary key references user,
ticket_id varchar(10) references ticket,
purchase_date date,
purchase_time time, 
total_cost double,
fare_cost double,
booking_fee double
);
drop table if exists airline_operates_from;
create table airline_operates_from(
airport_id varchar(5) references airport,
airline_id varchar(5) references airline,
primary key(airport_id, airline_id)
);
drop table if exists flight_operated_by;
create table flight_operated_by(
flight_number int primary key references flight,
airline_id varchar(5) references airline
);


show tables; 
select *
from users

insert into users
values('admin', 'adminpassword', 'John', 'Doe', true, false, false);

insert into users
values('customer_rep', 'customerreppassword', 'Henry', 'Doe', false, true, false);



