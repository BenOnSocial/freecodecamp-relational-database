drop table if exists appointments;
drop table if exists services;
drop table if exists customers;
drop database if exists salon;


create database salon;
alter database salon owner to freecodecamp;

\connect salon;

create table customers(
  customer_id serial primary key,
  phone varchar(10) unique,
  name varchar(20)
);

create table services(
  service_id serial primary key,
  name varchar(20)
);

create table appointments(
  appointment_id serial primary key,
  customer_id int references customers(customer_id),
  service_id int references services(service_id),
  time varchar(20)
);

alter table customers owner to freecodecamp;
alter table services owner to freecodecamp;
alter table appointments owner to freecodecamp;


insert into services (name) values
  ('Cut'),
  ('Color'),
  ('Style');