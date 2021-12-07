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
insert into users values
("admin", "password", "cuz", "in", 1,0,0),
("customer_rep", "password", "cuz", "oh", 0,1,0);

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
available bool,
class int,
primary key(ticket_id)
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

drop table if exists waitlisted;
create table waitlisted(
username varchar(20) references user,
flight_number int references flight,
primary key(username, flight_number)
);

drop table if exists purchases;
create table purchases(
username varchar(20) references user,
ticket_id int primary key references ticket,
purchase_date date,
purchase_time time, 
total_cost double,
fare_cost double,
booking_fee double
);
drop table if exists questions;
create table questions(
question_id int not null auto_increment,
question varchar(300) not null,
answer varchar(300),
primary key(question_id)
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

insert into users
values('admin', 'adminpassword', 'John', 'Doe', true, false, false);

insert into users
values('customer_rep', 'customerreppassword', 'Henry', 'Doe', false, true, false);
 SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
 
insert into airport
values
("EWR"),
("JFK"),
("ORD");
insert into flight
values
(123, "2022-01-09", "9:00", "EWR", "2022-01-09", "7:00", "ORD", 0, 1,0),
(115, "2022-01-09", "9:00", "EWR", "2022-01-09", "1:00", "ORD", 0, 1,0),
(1, "2022-01-09", "20:00", "EWR", "2022-01-09", "10:00", "ORD", 0, 1,0),
(2, "2022-02-09", "9:00", "JFK", "2022-02-09", "10:00", "ORD", 0, 1,0),
(3, "2022-01-09", "7:00", "EWR", "2022-01-09", "8:00", "JFK", 0, 1,0),
(6, "2022-02-09", "14:00", "ORD", "2022-02-09", "7:00", "EWR", 0, 1,0),
(5, "2022-02-09", "9:00", "ORD", "2022-02-09", "8:00", "EWR", 0, 1,0),
(4, "2022-02-09", "15:00", "ORD", "2022-02-09", "12:00", "EWR", 0, 1,0),
(7, "2022-02-09", "10:00", "EWR", "2022-02-09", "9:00", "ORD", 0, 1,0),
(8, "2022-02-09", "9:00", "EWR", "2022-02-09", "10:00", "ORD", 0, 1,0),
(9, "2022-02-09", "9:00", "EWR", "2022-02-09", "10:00", "ORD", 0, 1,0),
(11, "2022-02-09", "9:00", "EWR", "2022-01-09", "7:00", "ORD", 0, 1,0);
insert into airline values
('DEL', 'DELTA'),
('AAL', 'American Airlines'),
('JBL', 'JetBlue'),
('AUL', 'Australian Airlines'),
('BOU', 'Bolder Airlines');
insert into flight_operated_by
values
(1, 'DEL'),
(115, 'AAL'),
(123, 'JBL'),
(6, 'AUL'),
(5, 'BOU'),
(4, "DEL"),
(2, "DEL"),
(7, 'AUL');
insert into ticket
values
(11100,7, "A1",154.00,0,0),
(11101,7, "A2", 156.00,0,0),
(11109,7, "A4", 156.00,0,0),
(1110,7, "A3",154.00,0,0),
(1111,7, "A44", 156.00,0,0),
(11107,7, "F3",154.00,0,0),
(11108,7, "F4", 156.00,0,0),
(11106,7, "F8", 156.00,0,0)
;



