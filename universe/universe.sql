drop table moon;
drop table planet;
drop table star;
drop table galaxy;
drop table galaxy_types;
drop table planet_types;

create table planet_types(planet_types_id serial primary key, name varchar(30) not null unique, description text not null, diameter_km numeric, characteristics text, formation_process text, potential_for_life boolean);
create table galaxy_types(galaxy_types_id serial primary key, name varchar(30) not null unique, description text not null, characteristics text, formation_process text, contains_active_star_formation boolean);

create table galaxy(galaxy_id serial primary key, name varchar(60) not null unique, description text not null, galaxy_types_id int references galaxy_types(galaxy_types_id), billions_of_stars int);
create table star(star_id serial primary key, name varchar(60) not null unique, description text not null, galaxy_id int references galaxy(galaxy_id) not null, age_million_years int, solar_mass numeric);
create table planet(planet_id serial primary key, name varchar(60) not null unique, description text not null, star_id int references star(star_id) not null, diameter_km int);
create table moon(moon_id serial primary key, name varchar(60) not null unique, description text not null, planet_id int references planet(planet_id) not null, diameter_km numeric);

insert into planet_types(name, description, characteristics, formation_process, potential_for_life) values
('Terrestrial', 'Rocky planets with solid surfaces.', 'Composed mainly of rock and metal; has solid crusts, atmospheres may vary.', 'Formed from the accretion of dust and gas in the inner solar system.', true),
('Gas Giant', 'Large planets primarily composed of hydrogen and helium.', 'Thick atmospheres, lack solid surfaces; may have small rocky cores.', 'Formed in the outer solar system from the accumulation of gas and ice.', false),
('Ice Giant', 'Similar to gas giants but with a larger proportion of icy materials.', 'Contains ices like water, ammonia, and methane; has thick atmospheres.', 'Formed in the outer solar system, capturing ice and gas from the solar nebula.', false),
('Dwarf Planet', 'Small planetary bodies that do not clear their orbits.', 'Share characteristics with both planets and asteroids; may have moons.', 'Formed from the same processes as larger planets but did not accumulate enough mass.', true),
('Exoplanet', 'Planets located outside our solar system.', 'Can be rocky or gaseous; may exist in habitable zones around their stars.', 'Formed from the same processes as solar system planets but around other stars.', true),
('Super-Earth', 'A type of exoplanet with a mass larger than Earth''s but significantly smaller than gas giants.', 'May be rocky or have thick atmospheres; potential for liquid water.', 'Formed from protoplanetary disks around stars, capturing more material than Earth.', true);

insert into galaxy_types(name, description, characteristics, formation_process, contains_active_star_formation) values
('Spiral', 'Galaxies with a flat, rotating disk and spiral arms.', 'Contains young stars, gas, and dust; often has a central bulge.', 'Formed from the gravitational collapse of gas and dust.', true),
('Elliptical', 'Rounded or elongated shapes, with no distinct features.', 'Older stars, little gas and dust; usually lacks new star formation.', 'Result from galaxy mergers or the accumulation of gas over time.', false),
('Irregular', 'Galaxies that do not fit into the other categories.', 'Chaotic appearance; often rich in gas and dust, with active star formation.', 'Formed from interactions and mergers of other galaxies.', true),
('Lenticular', 'A type between spiral and elliptical, with a central bulge.', 'Features a disk but lacks spiral arms; contains older stars.', 'Evolved from spiral galaxies that have lost their gas and dust.', false),
('Peculiar', 'Galaxies with unusual shapes, often due to interactions.', 'Often a result of galaxy mergers or gravitational interactions.', 'Formed through gravitational interactions or collisions with other galaxies.', true);

insert into galaxy(name, description, galaxy_types_id, billions_of_stars) values
('Milky Way', 'The galaxy that contains our solar system.', 1, 100),
('Andromeda', 'The nearest spiral galaxy to the Milky Way.', 1, 1000),
('Triangulum', 'A smaller spiral galaxy located near Andromeda.', 1, 40),
('Whirlpool', 'A well-known spiral galaxy in the constllation Canes Venatici.', 1, 100),
('Sombrero', 'Notable for its bright nucleus and large dust lanes.', 1, 800),
('Large Magellanic Cloud', 'A satellite galaxy of the Milky Way.', 3, 10),
('Small Magellanic Cloud', 'Another satallite galaxy of the Milky Way.', 3, 3);

insert into star(name, description, galaxy_id, age_million_years, solar_mass) values
('Sol', 'The sun, central to our solar system.', 1, 4600, 1),
('Betelgeuse', 'A prominent star in the constellation Orion.', 1, 800, 20),
('Proxima Centauri', 'The closest known star to the sun.', 1, 4500, 0.12),
('Alpha Centauri A', 'A component of the Alpha Centauri star system.', 2, 5800, 1.1),
('Rigel', 'A bright star in Orion, known for its blue color.', 2, 800, 21),
('Sirius A', 'The brightest star in the night sky.', 1, 200, 2.1),
('Vega', 'A prominent star in the constellation Lyra.', 1, 455, 2.1),
('Deneb', 'A bright star in the constellation Cygnus.', 1, 1000, 19);

insert into planet(name, description, star_id, diameter_km) values
('Earth', 'The third planet from the sun, home to life.', 1, 12742),
('Mars', 'Known as the Red Planet due to iron oxide.', 1, 6779),
('Jupiter', 'The largest planet in the solar system.', 1, 139820),
('Proxima b', 'An exoplanet in the habitable zone of Proxima Centauri.', 3, 11200),
('Venus', 'The second planet from the sun, known for its thick atmosphere.', 1, 12104),
('Saturn', 'Known for its prominent ring system.', 1, 116460),
('Neptune', 'The farthest planet in the solar system.', 1, 49528),
('Uranus', 'Known for its tilted axis and unique color.', 1, 50724),
('Mercury', 'The closest planet to the sun, with extreme temperatures.', 1, 4879),
('Kepler-22b', 'An exoplanet in the habitable zone of its star.', 1, 14000),
('Gliese 581g', 'An exoplanet that may support life conditions.', 1, 12000),
('Tau Ceti e', 'An exoplanet in the Tau Ceti system, potentially habitable.', 1, 8000);

insert into moon(name, description, planet_id, diameter_km) values
('Moon', 'Earth''s only natural satellite.', 1, 3473),
('Phobos', 'The larger of Mars'' two moons.', 2, 22.4),
('Deimos', 'The smaller moon of Mars.', 2, 12.4),
('Europa', 'An icy moon of Jupiter with a subsurface ocean.', 3, 3121),
('Ganymede', 'The largest moon in the solar system.', 3, 5262),
('Callisto', 'A heavily cratered moon of Jupiter.', 3, 4821),
('Titan', 'The largest moon of Saturn, with a thick atmosphere.', 4, 5150),
('Enceladus', 'Known for its geysers and potential subsurface ocean.', 4, 504),
('Io', 'The most volcanically active body in the solar system.', 3, 3642),
('Miranda', 'A moon of Uranus with a varied landscape.', 5, 471.6),
('Titania', 'The largest moon of Uranus.', 5, 1523),
('Oberon', 'The second-largest moon of Uranus.', 5, 1523),
('Triton', 'Neptune''s largest moon, known for its retrograde orbit.', 4, 2706),
('Charon', 'The largest moon of Pluto, in a binary system with it.', 6, 1212),
('Rhea', 'The second-largest moon of Saturn.', 7, 1528),
('Iapetus', 'Known for its unique two-tone coloration.', 7, 1469),
('Dione', 'A medium-sized moon of Saturn.', 7, 1123),
('Tethys', 'Known for its large impact craters.', 7, 1062),
('Janus', 'A small moon of Saturn, known for its irregular shape.', 7, 178),
('Hyperion', 'A moon of Saturn, known for its sponge-like appearance.', 7, 270);
