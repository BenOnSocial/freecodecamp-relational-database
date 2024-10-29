drop table if exists games;
drop table if exists teams;
drop database if exists worldcup;


create database worldcup;
alter database worldcup owner to freecodecamp;

\connect worldcup;


create table teams(
  team_id serial primary key not null,
  name varchar(50) unique not null
);

create table games(
  game_id serial primary key not null,
  year int not null, round varchar(50) not null,
  winner_id int references teams(team_id) not null,
  winner_goals int not null,
  opponent_id int references teams(team_id) not null,
  opponent_goals int not null
);

alter table teams owner to freecodecamp;
alter table games owner to freecodecamp;
