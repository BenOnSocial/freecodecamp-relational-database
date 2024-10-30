drop table if exists bikes;
drop database if exists bikes;

create database bikes;

alter database bikes set owner freecodecamp;

\connect bikes;

create table bikes(
  bike_id serial primary key,
  type varchar(50) not null,
  size int not null,
  available boolean not null default true
);

create table customers(
  customer_id serial primary key,
  phone varchar(15) not null unique,
  name varchar(40) not null
);

create table rentals(
  rental_id serial primary key,
  customer_id int not null references customers(customer_id),
  bike_id int not null references bikes(bike_id),
  date_rented date not null default now(),
  date_returned date
);

alter table bikes owner to freecodecamp;
alter table customers owner to freecodecamp;

insert into bikes(type, size) values
  ('Mountain', 27),
  ('Mountain', 28),
  ('Mountain', 29),
  ('Road', 27),
  ('Road', 28),
  ('Road', 29)
  ('BMX', 19),
  ('BMX', 20),
  ('BMX', 21);
