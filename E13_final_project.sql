
-- Exercise 13: Final Project

-- Author: Kennedy Adriko
-- Email: s1085492@stud.sbg.ac.at
-- Date: 18-02-2022
-- -------------------------------------------------------------------------------

-- Task 1: Creating database and spatial extension
CREATE DATABASE webgis_backend
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_Austria.1252'
    LC_CTYPE = 'English_Austria.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
--
--
CREATE EXTENSION postgis;
-- 
--
-- -------------------------------------------------------------------------------

-- Task 2: Creating database tables, data types, primary and foreign keys

-- Company Table
CREATE TABLE department (
	department_id serial PRIMARY KEY,
	department_name VARCHAR(64) UNIQUE NOT NULL
);
--
--
--Employee table

CREATE TYPE gender AS ENUM('F','M');

CREATE TABLE employee (
	employee_id	serial PRIMARY KEY,
	first_name VARCHAR (64) NOT NULL,
	last_name VARCHAR(64) NOT NULL,
	birth_date date NOT NULL,	
	gender gender NULL,
	hire_date date NOT NULL,
	department_id int NOT NULL,
	FOREIGN KEY (department_id)
		REFERENCES department(department_id)
	);
--
-- Roles table

CREATE TABLE roles (
	role_id	serial PRIMARY KEY,
	role_name VARCHAR (255) UNIQUE NOT NULL
	);

--
--
--Employee assigned roles

CREATE TABLE role_assigned (
	id	serial PRIMARY KEY,
	employee_id int NOT NULL,
	show_id int NOT NULL,
	role_id int NOT NULL,
	FOREIGN KEY(employee_id)
		REFERENCES employee(employee_id),
	FOREIGN KEY(show_id)
		REFERENCES trade_show(id),
	FOREIGN KEY(role_id)
		REFERENCES roles(role_id)
	);

-- Service_provider table

CREATE TABLE service_provider (
	id	serial PRIMARY KEY,
	sp_name VARCHAR (255) UNIQUE NOT NULL,
	address VARCHAR(255) NOT NULL,
	);
--
--
--service table

CREATE TABLE service (
	id	serial PRIMARY KEY,
	service_name VARCHAR (255) UNIQUE NOT NULL
	);
--
--
-- package table

CREATE TABLE package (
	id	serial PRIMARY KEY,
	package_name VARCHAR (64) UNIQUE NOT NULL,
	fee decimal NOT NULL
	);

--
--
-- trade show table

CREATE TABLE trade_show (
	id	serial PRIMARY KEY,
	show_name VARCHAR (64) NOT NULL,
	date_from DATE NOT NULL,
	date_to	DATE NOT NULL,
	opening_time TIME NOT NULL,
	closing_time TIME NOT NULL,
	details	text
	);

--
--
-- sponsor table

CREATE TABLE sponsor (
	id	serial PRIMARY KEY,
	sponsor_name VARCHAR (64) UNIQUE NOT NULL,
	details	text,
	show_id int NOT NULL,
	package_id int NOT NULL,
	FOREIGN KEY (show_id)
		REFERENCES trade_show (id),
		FOREIGN KEY (package_id)
		REFERENCES package(id)
	);

--
--
-- ticket table

CREATE TABLE ticket (
	id	serial PRIMARY KEY,
	type VARCHAR (25) UNIQUE NOT NULL,
	price decimal NOT NULL,
	show_id int NOT NULL,
	FOREIGN KEY (show_id)
		REFERENCES trade_show (id)
	);

--
-- industry table

CREATE TABLE industry (
	id	serial PRIMARY KEY,
	industry_name VARCHAR(64) UNIQUE NOT NULL
	);

--
--
-- exhibitor table

CREATE TABLE exhibitor (
	id	serial PRIMARY KEY,
	exhibitor_name VARCHAR(255) UNIQUE NOT NULL,
	address VARCHAR(64) NOT NULL,
	industry_id int NOT NULL,
	details text,
	FOREIGN KEY(industry_id)
		REFERENCES industry(id)
	);

--
--
-- service provided table

CREATE TABLE service_provided (
	id	serial PRIMARY KEY,
	service_id int NOT NULL,
	provider_id int NOT NULL,
	start_date date NOT NULL,
	end_date date NOT NULL,
	show_id int NOT NULL,
	FOREIGN KEY(service_id)
		REFERENCES service(id),
	FOREIGN KEY(provider_id)
		REFERENCES service_provider(id),
	FOREIGN KEY(show_id)
		REFERENCES trade_show(id)
	);

--
--
-- service_at table

CREATE TABLE service_at (
	id	serial PRIMARY KEY,
	serv_prov_id int NOT NULL,
	facility_id int NOT NULL,
	FOREIGN KEY(serv_prov_id)
		REFERENCES service_provided(id),
	FOREIGN KEY(facility_id)
		REFERENCES facility(id)
	);

--
--
-- events table

CREATE TABLE events (
	event_id	serial PRIMARY KEY,
	event_name VARCHAR(64) UNIQUE NOT NULL,
	start_time timestamp NOT NULL,
	end_time timestamp NOT NULL,
	show_id int NOT NULL,
	exhibitor_id int NOT NULL,
	facility_id int NOT NULL,
	description text,
	FOREIGN KEY(exhibitor_id)
		REFERENCES exhibitor(id),
	FOREIGN KEY(facility_id)
		REFERENCES facility(id),
	FOREIGN KEY(show_id)
		REFERENCES trade_show(id) ON DELETE CASCADE
	);
-- -------------------------------------------------------------------------------

-- Task 3: Inserting data into database tables

-- department table

INSERT INTO department VALUES (1,'Marketing'),
	(2,'Finance'),(3, 'Production'),(4,'Innovations'),
	(5,'Administration');

-- employee table

INSERT INTO employee VALUES (10001,'Georgi','Facello',5,'1983-09-02','M','2014-06-26'),
    (10002,'Bezalel','Simmel',5,'1994-06-02','F','2008-11-21'),
    (10003,'Parto','Bamford',3,'1989-12-03','M','2009-08-28'),
    (10004,'Chirstian','Koblick',2,'1984-05-01','M','2008-12-01'),
    (10005,'Kyoichi','Maliniak',1,'1985-01-21','M','2008-09-12'),
    (10006,'Anneke','Preusig',3,'1983-04-20','F','2011-06-02'),
    (10007,'Tzvetan','Zielinski',4,'1987-05-23','F','2009-02-10'),
    (10008,'Saniya','Kalloufi',4,'1988-02-19','M','2004-09-15'),
    (10009,'Peac','Sumant',1,'1982-04-19','F','2005-02-18'),
    (10010,'Duangkaew','Piveteau',2,'1993-06-01','F','2009-08-24'),
    (10011,'Mary','Sluis',4,'1983-11-07','F','2010-01-22'),
    (10012,'Patricio','Bridgland',2,'1980-10-04','M','2012-12-18'),
    (10013,'Eberhardt','Terkki',1,'1983-06-07','M','2015-10-20'),
    (10014,'Berni','Genin',1,'1986-02-12','M','2017-03-11'),
    (10015,'Guoxiang','Nooteboom',1,'1989-08-19','M','2007-07-02'),
    (10016,'Kazuhito','Cappelletti',3,'1981-05-02','M','2005-01-27'),
    (10017,'Cristinel','Bouloucos',2,'1988-07-06','F','2013-08-03'),
    (10018,'Kazuhide','Peha',3,'1984-06-19','F','2007-04-03'),
    (10019,'Lillian','Haddadi',4,'1983-01-23','M','2009-04-30'),
    (10020,'Mayuko','Warwick',1,'1982-12-24','M','2011-01-26');


-- package table

INSERT INTO package VALUES (1,'Platnum', 200000.00),
	(2,'Diamond', 150000.00),(3, 'Gold', 100000.00),(4,'Silver', 50000.00),
	(5,'Bronze', 25000.00);


-- trade_show table

INSERT INTO trade_show VALUES (1,'Fourth UMA Annual Trade Show', 
							   '2022-10-03','2022-10-10','07:00:00','23:59:59', 
							   'The trade show will take place at the UMA show grounds
							   under the theme Empowering women parity in manufacturing');


-- sponsor table

INSERT INTO sponsor VALUES (1,'Mukwano','',1, 1),(2,'Ecobank','',1,3),
							(3,'Nytil','',1,2),(4,'GIZ','',1,1),
							(5,'UDB','',1,2),
							(6,'Ultra','',1, 5);


-- ticket table

INSERT INTO ticket VALUES (1,'1-day',10.00,1),
						  (2,'2-days',18.00,1),
						   (3,'All-days',60.00,1);


-- industry table

INSERT INTO industry VALUES (1,'Creative'),
						  (2,'Automotive'),
						  (3,'Building & Construction'),
						  (4,'Utilities'),
						  (5,'Satellite & Broadcasting'),
						  (6,'Home Appliances'),
						   (7,'Jewelry & Fashion'),
						   (8,'Beauty & Health');

-- service table

INSERT INTO service VALUES (1,'Waste & Cleaning'),
						  (2,'Fire & safety'),
						  (3,'Emergency &  Health'),
						  (4,'Food, Beverage & Catering'),
						  (5,'Audio-visuals'),
						  (6,'Transportation & Logistics'),
						   (7,'Security');

-- roles table

INSERT INTO roles VALUES (1,'Event coordination'),
						  (2,'Sponsors & Vendors'),
						  (3,'Facility & Venue management'),
						  (4,'Finance & Ticketing'),
						  (5,'Communication & social media'),
						  (6,'Volunteers & staffing');


-- service_provider

INSERT INTO service_provider VALUES (401,'The Sharp Logistics Managers','1165 San Jose CA 94217'),

(402,'Mini Auto Werke','6 Kirchgasse Graz 8010 AU'),

(403,'Super Scale Inc.','567 North Pendale Street US'),

(404,'Microscale Inc.','5290 North Street Suite 200 NYC US'),

(405,'Corrida Visual Replicas, Ltd','C/ Araquil, 67 Madrid'),

(406,'Warburg Security Exchange','Walserweg 21 Aachen Germany'),

(407,'FunGiftIdeas.com','1785 First Street New Bedford USA'),

(408,'Anton Designs, Ltd.',' 19-1 Urb. La Florida Madrid Spain'),

(409,'Australian Foods, Ltd','7 Glen Waverly Victoria Australia'),

(410,'Frau da Collezione','Alessandro Volta 16 Milan'),

(411,'West Coast Fires Co.','3675 Furth Circle CA USA'),

(412,'Mit Vergnügen & Co.','Forsterstr 57 Mannheim Germany'),

(413,'Kremlin Foods Co.','Saint Petersburg 196143 Russia'),

(414,'Raanan Stores, Inc','3 Hagalim Blv. 47625 Israel'),

(415,'Iberia Gift Imports, Corp.','33 Sevilla 41101 Spain'),

(416,'Motor Mint Distributors Inc.','Philadelphia PA 71270 USA'),

(417,'Signal Security Ltd.','2793 Fourth Circle Brisbane CA 94217 USA'),

(418,'Double Decker Ltd','120 Hanover Sq. London WA1 1DP UK'),

(419,'Diecast Impact','51003 Boston MA USA');


-- exhibitor table

(201,'UK Collectables, Ltd.','D12, Berkeley Gardens Blvd WX1 6LT UK',7,NULL),
(202,'Canadian Gift Exchange Network','1900 Oak St. Vancouver V3F 2K1 Canada',7,NULL),

(204,'Online Mini Collectables','7635 Spinnaker Dr. Brickhaven MA 58339 USA',8,NULL),

(205,'Toys4GrownUps.com','78934 Hillside Dr. Pasadena CA 90003 USA',5,NULL),

(206,'Asian Shopping Network, Co','Suntec Tower Three 8 Temasek Singapore',8,NULL),

(207,'Kommission Auto','Luisenstr. 48 Münster 44087 Germany',2,NULL),

(208,'Royale Belge','Boulevard Tirou, 255 Charleroi B-6000 Belgium',8,NULL),

(209,'Mini Caravy','24, place Kléber Strasbourg 67000 France',3,NULL),

(210,'SAR Distributors, Co','1250 Pretorius Street Pretoria 0028 South Africa',5,NULL),

(211,'King Kong Collectables, Co.','1 Garden Road Central Hong Kong',1,NULL),

(212,'Enaco Distributors','Rambla de Cataluña 23 Barcelona 08022 Spain',3,NULL),

(213,'Boards & Toys Co.','4097 Douglas Av. CA 92561 USA',6,NULL),

(214,'Natürlich Autos','Taucherstraße 10 Cunewalde 01307 Germany',2,NULL),

(215,'Heintze Ibsen Palle','3555 Smagsloget 45 Århus 8200 Denmark',4,NULL),

(216,'Québec Home Shopping Network','43 rue St. Laurent Montréal Québec H1J 1C3 Canada',6,NULL),

(217,'ANG Resellers','Gran Vía, 1 Madrid 28001 Spain',6,NULL),

(218,'Collectable Mini Designs Co.','361 Furth Circle San Diego CA 91217 USA',4,NULL),

(219,'giftsbymail.co.uk','Crowther Way 23 Isle of Wight PO31 7PJ UK',1,NULL),

(220,'Alpha Cognac','1 rue Alsace-Lorraine Toulouse 31000 France',2,NULL),

(221,'Messner Magazinweg','7 Magazinweg Frankfurt 60528 Germany',3,NULL),

(222,'Amica Models & Co.','Via Monte Bianco 34 Torino 10100 Italy',5, NULL),

(223,'Lyon Souveniers','27 rue du Colonel Pierre Avia Paris 75508 France',7,NULL),
(224,'Gift Depot Inc.','25593 South Bay Ln. Bridgewater CT 97562 USA',4,NULL),
(225,'Osaka Souveniers Co.','Kita-Osaka 30-0003 Japan',1,NULL);


-- role_assigned table

INSERT INTO role_assigned VALUES (1,10001,1,2),
    (2,10002,1,6),
    (3,10003,1,2),
    (4,10004,1,5),
    (5,10005,1,3),
    (6,10006,1,6),
    (7,10007,1,4),
    (8,10008,1,3),
    (9,10009,1,1),
    (10,10010,1,2),
    (11,10011,1,6),
    (12,10012,1,1),
    (13,10013,1,5),
    (14,10014,1,3),
    (15,10015,1,1),
    (16,10016,1,4),
    (17,10017,1,3),
    (18,10018,1,4),
    (19,10019,1,5),
    (20,10020,1,1);

-- service_provided table

INSERT INTO service_provided VALUES (51,6, 401,'2022-10-01','2022-10-12',1 ),
(52,1,403,'2022-10-01','2022-10-10',1 ),

(53,7,406,'2022-10-01','2022-10-10',1),

(54,4,409,'2022-10-03','2022-10-10',1),

(55,5,410,'2022-10-03','2022-10-10',1),

(56,1,412,'2022-10-01','2022-10-11',1),

(57,4,413,'2022-10-03','2022-10-10',1),

(58,2,417,'2022-10-03','2022-10-10',1),

(59,5,418,'2022-10-03','2022-10-10',1),

(60,3,419,'2022-10-03','2022-10-10',1);


-- service_at table

INSERT INTO service_at VALUES (3001,51,33),
(3002,51,38),
(3003,52,17),
(3004,52,44),
(3005,52,45),
(3006,52,47),
(3007,53,55),
(3008,53,62),
(3009,53,28),
(3010,54,26),
(3011,54,49),
(3012,55,34),
(3013,56,50),
(3014,56,54),
(3015,56,31),
(3016,57,59),
(3017,57,60),
(3018,58,16),
(3019,58,41),
(3020,59,23),
(3021,59,40),
(3022,60,20);


-- events table

INSERT INTO events VALUES
(2401,'Music Fest','2022-10-10 19:00:00','2022-10-10 23:59:59',1, 201,40,'Showcasing musical talent and creativity'),

(2402,'Runway show','2022-10-05 14:00:00','2022-10-10 18:00:00',1, 204,25,'Showcasing latest trends in fashion and beauty care'),

(2403,'Tech Gala','2022-10-03 09:00:00','2022-10-10 20:00:00',1, 205,28,'Future of satellite and broadcasting technology'),

(2404,'Auto show','2022-10-04 09:00:00','2022-10-08 22:00:00',1, 207,20,'Cars, speed and fast cars'),

(2405,'Your Dream home','2022-10-03 09:00:00','2022-10-10 16:00:00',1, 209,47,'We might just have the house of your dreams'),

(2406,'Family expo','2022-10-03 10:00:00','2022-10-05 17:00:00',1, 213,30,'Simplify your home life'),

(2407,'Home experience','2022-10-06 10:00:00','2022-10-10 17:00:00',1, 216,62,'Every family needs one'),

(2408,'Energy Innovations','2022-10-03 09:00:00','2022-10-10 19:00:00',1, 218,11,'Clean energy possibilities for the future'),

(2409,'Art Gala','2022-10-10 09:00:00','2022-10-9 23:00:00',1, 225,38,'Showing the artists of our time');


-- Task 4: Creating a view about  the trade show

CREATE VIEW event_schedule AS
	SELECT *
	FROM events 
	JOIN facility 
	ON events.facility_id = facility.id;

-- User query about event schedule

SELECT 
	event_name, 
	start_time, end_time, 
	description, 
	facility_name 
	FROM
	event_schedule; 

-- Task 5: Database Queries

-- User specific dynamic query to return facilities of a specific type

SELECT * FROM facility WHERE type='event hall';


-- Spatial query to select all facilities within 50 meters of Event Hall P

SELECT 
	f.*
FROM 
	facility AS f,
	(SELECT geom FROM facility WHERE facility_name = 'Event Hall P') AS h
WHERE ST_Distance(f.geom, h.geom) < 50;


-- Query to select only the first 5 facilities

SELECT * FROM facility
LIMIT 5;


-- Task 5: Spatial query that returns distance from one facility to another
-- facility ID 1 is an event hall and ID 5 is ticket office

SELECT 
	st_distance(h.geom, t.geom) 
FROM 
	facility h, facility t

WHERE h.id = 1 AND t.id= 5;

-- -------------------------------------------------------------------------------
-- END
-- -------------------------------------------------------------------------------