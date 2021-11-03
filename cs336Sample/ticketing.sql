create database if not exists ticketing;
use ticketing;
drop table if exists users;
create table users(
username varchar(20) primary key,
password varchar(20),
fname varchar(20),
lname varchar(20),
is_admin bool,
is_customer bool,
is_customer_rep bool
);

select *
from users
