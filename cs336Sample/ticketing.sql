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
create table flight(
flight_number int primary key,
arrival_date date,
arrival_time time,
departure_date date,
departure_time time,
occupied_seats int,
is_domestic bool,
is_international bool
);
create table aircraft(
aircraft_model_number int primary key,
number_of_seats int
);
create table airline(
airline_id varchar(5) primary key,
airline_name varchar(50)
);
create table airport(
airport_id varchar(5) primary key
);
create table ticket(
ticket_id varchar(10) primary key,
seat_number int
);
create table economy_class(
ticket_id varchar(10) primary key references ticket,
cancellation_fee double
);
create table business_class(
ticket_id varchar(10) primary key references ticket
);
create table first_class(
ticket_id varchar(10) primary key references ticket
);
create table flight_uses(
flight_number int primary key references flight,
aircraft_model_number int references aircraft
);
create table airline_owns_aircrafts(
airline_id varchar(5) references airline,
aircraft_model_number int references aircraft,
primary key(airline_id, aircraft_model_number)
);

create table airport_services_flight(
flight_number int primary key references flight,
airport_id varchar(5) references airport
);

create table destination(
ticket_id varchar(10) primary key references ticket,
destination varchar(30),
departing varchar(30)
);

create table waitlisted(
username varchar(20) references user,
flight_number int references flight,
primary key(username, flight_number)
);

create table purchases(
username varchar(20) primary key references user,
ticket_id varchar(10) references ticket,
purchase_date date,
purchase_time time, 
total_cost double,
fare_cost double,
booking_fee double
);

create table airline_operates_from(
airport_id varchar(5) references airport,
airline_id varchar(5) references airline,
primary key(airport_id, airline_id)
);

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




