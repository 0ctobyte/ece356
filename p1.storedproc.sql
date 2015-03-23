SET storage_engine=InnoDB;
use ece356db_s4bhatta;


DROP PROCEDURE IF EXISTS Test_ResetDB;
DELIMITER $
CREATE PROCEDURE Test_ResetDB ()
BEGIN
SET storage_engine=InnoDB;

drop table if exists FriendRequest; /* references Patient */
drop table if exists WorkAddress; /* references Doctor, City */
drop table if exists Specialization; /* references Doctor */
drop table if exists Review; /* references Patient, Doctor */
drop table if exists Patient; /* references User, City */
drop table if exists City; /* references Province */
drop table if exists Province;
drop table if exists Doctor; /* references User */
drop table if exists User;

/* Create the tables */
create table User (user_alias varchar(64) not null unique, email varchar(64) not null, password_hash varchar(128) not null, name_first varchar(64) not null, name_middle varchar(64) default null, name_last varchar(64) not null, account_type enum('Doctor', 'Patient') not null, primary key(user_alias));
create table Doctor(doctor_alias varchar(64) not null unique, gender enum('M', 'F') not null, license_year year(4) not null, primary key(doctor_alias), foreign key(doctor_alias) references User(user_alias));
create table Province(province enum('AB', 'BC', 'MB', 'NB', 'NL', 'NS', 'NT', 'NU', 'ON', 'PE', 'QC', 'SK', 'YT') unique not null, province_name varchar(64) not null, primary key(province));
create table City(city_id serial, city varchar(64) not null, province enum('AB', 'BC', 'MB', 'NB', 'NL', 'NS', 'NT', 'NU', 'ON', 'PE', 'QC', 'SK', 'YT') not null, primary key(city_id), foreign key(province) references Province(province));
create table Patient(patient_alias varchar(64) not null unique, city_id bigint unsigned not null, primary key(patient_alias), foreign key(patient_alias) references User(user_alias), foreign key(city_id) references City(city_id));
create table Review(review_id serial, patient_alias varchar(64) not null, doctor_alias varchar(64) not null, star_rating double(4, 3) not null, comments varchar(1000), date timestamp not null default current_timestamp, primary key(review_id), foreign key(patient_alias) references Patient(patient_alias), foreign key(doctor_alias) references Doctor(doctor_alias));
create table Specialization(doctor_alias varchar(64) not null, specialization_name varchar(64) not null, primary key(doctor_alias, specialization_name), foreign key(doctor_alias) references Doctor(doctor_alias));
create table WorkAddress(address_id serial, doctor_alias varchar(64), street_number int not null, street_name varchar(64) not null, unit_number int, city_id bigint unsigned not null, postal_code char(6) not null, primary key(address_id), foreign key(doctor_alias) references Doctor(doctor_alias), foreign key(city_id) references City(city_id));
create table FriendRequest(patient_alias varchar(64) not null, friend_alias varchar(64) not null, accepted bool not null default 0, primary key(patient_alias, friend_alias), foreign key(patient_alias) references Patient(patient_alias), foreign key(friend_alias) references Patient(patient_alias));

/* Views */
drop view if exists PatientFriendRequestView;
create view PatientFriendRequestView as select f.patient_alias, f.friend_alias, u.email from User as u inner join FriendRequest as f on f.patient_alias=u.user_alias where accepted=0;
drop view if exists PatientDoctorProfileView;
create view PatientDoctorProfileView as select u.user_alias, u.name_first, u.name_middle, u.name_last, d.gender, (year(current_timestamp)-d.license_year) as num_years_licensed, avg(r.star_rating) as avg_rating, count(distinct r.review_id) as num_reviews from (User as u inner join Doctor as d on u.user_alias=d.doctor_alias) left join Review as r on d.doctor_alias=r.doctor_alias group by u.user_alias;
drop view if exists DoctorOwnProfileView;
create view DoctorOwnProfileView as select d.doctor_alias, u.email, u.name_first, u.name_middle, u.name_last, d.gender, (year(current_timestamp)-d.license_year) as num_years_licensed, avg(r.star_rating) as avg_rating, count(distinct r.review_id) as num_reviews from (User as u inner join Doctor as d on u.user_alias=d.doctor_alias) left join Review as r on d.doctor_alias=r.doctor_alias group by d.doctor_alias;
drop view if exists PatientOwnProfileView;
create view PatientOwnProfileView as select p.patient_alias, u.email, u.name_first, u.name_middle, u.name_last, c.city, c.province from (User as u inner join Patient as p on u.user_alias=p.patient_alias) natural join City as c;

/* Create the Users */
insert into User values ('doc_aiken', 'aiken@head.com', '$2a$10$Ngcjlfgfy1bFUUaZ/bAwSO.b69wJ6rcxveuOsuQL/ERGDdLq1yC2K', 'John', null, 'Aikenhead', 'Doctor');
insert into User values ('doc_amnio', 'obgyn_clinic@rogers.com', '$2a$10$dBkdopvtmbmegauPL4lQ7eqvFPRvyqhh3pIE6RakHyDm.lUBJMx3O', 'Jane', null, 'Amniotic', 'Doctor');
insert into User values ('doc_umbilical', 'obgyn_clinic@rogers.com', '$2a$10$QDeLWc4z8yf12or1B02iueozCGbWfDS5UZK6elyODYkKwanNwjGjG', 'Mary', null, 'Umbilical', 'Doctor');
insert into User values ('doc_heart', 'jack@healthyheart.com', '$2a$10$81l3mUIay/n9agDIIO.aIOUL8N2hsnZBs1BTQVgLp6d/oHtQSTWMu', 'Jack', null, 'Hearty', 'Doctor');
insert into User values ('doc_cutter', 'beth@tummytuck.com', '$2a$10$nlzrD5F41bW3icovbxd57e2gjPnfiwdNqaowcoLivF7hmTua9hWPe', 'Beth', null, 'Cutter', 'Doctor');
insert into User values ('pat_bob', 'thebobbersons@sympatico.ca', '$2a$10$pNZrWg4yUQNXcVrPDGzCX.13EilA8Te50V5RqfYERXUbwhxwUgdiK', 'Bob', null, 'Bobberson', 'Patient');
insert into User values ('pat_peggy', 'thebobbersons@sympatico.ca', '$2a$10$sp3vM06xFRIGBRF0Z990mu3pHHrKgSEti8mnZlCrPjSSczt/URhoG', 'Peggy', null, 'Bobberson', 'Patient');
insert into User values ('pat_homer', 'homer@rogers.com', '$2a$10$qAgouphU.Zm4.5OM9QuhFOhmeC0jJHkKCt3rIyFy8jfJCdQOegCAy', 'Homer', null, 'Homerson', 'Patient');
insert into User values ('pat_kate', 'kate@hello.com', '$2a$10$xyZ6cieijsdh33EW98vSH.PC6K6e/FjyAeltHiKkQq8nWd1hcAtc6', 'Kate', null, 'Katemyer', 'Patient');
insert into User values ('pat_anne', 'anne@gmail.com', '$2a$10$nN3bsN8UU8Wtwqoc7NIeVO94VO59a4z7vKOSVcPQNxFfRAFuWjbKy', 'Anne', null, 'MacDonald', 'Patient');

/* Create the Doctors */
insert into Doctor values ('doc_aiken', 'M', 1990);
insert into Doctor values ('doc_amnio', 'F', 2005);
insert into Doctor values ('doc_umbilical', 'F', 2006);
insert into Doctor values ('doc_heart', 'M', 1980);
insert into Doctor values ('doc_cutter', 'F', 2014);

/* Create the provinces */
insert into Province values('AB', 'Alberta'), ('BC', 'British Columbia'), ('MB', 'Manitoba'), ('NB', 'New Brunswick'), ('NL', 'Newfoundland'), ('NS', 'Nova Scotia'), ('NT', 'Northwest Territories'), ('NU', 'Nunavut'), ('ON', 'Ontario'), ('PE', 'Prince Edward Island'), ('QC', 'Quebec'), ('SK', 'Saskatchewan'), ('YT', 'Yukon');

/* Create the cities */
insert into City(city, province) values ('Kitchener', 'ON'), ('Waterloo', 'ON'), ('Cambridge', 'ON'), ('Guelph', 'ON');

/* Create the Patients */
insert into Patient values ('pat_bob', 2);
insert into Patient values ('pat_peggy', 2);
insert into Patient values ('pat_homer', 1);
insert into Patient values ('pat_kate', 3);
insert into Patient values ('pat_anne', 4);

/* Create the Specializations */
insert into Specialization values ('doc_aiken', 'allergologist'), ('doc_aiken', 'naturopath');
insert into Specialization values ('doc_amnio', 'obstetrician'), ('doc_amnio', 'gynecologist');
insert into Specialization values ('doc_umbilical', 'obstetrician'), ('doc_umbilical', 'naturopath');
insert into Specialization values ('doc_heart', 'cardiologist'), ('doc_heart', 'surgeon');
insert into Specialization values ('doc_cutter', 'surgeon'), ('doc_cutter', 'psychiatrist');

/* Create the WorkAddresses */
insert into WorkAddress(doctor_alias, street_number, street_name, unit_number, city_id, postal_code) values ('doc_aiken', 1, 'Elizabeth Street', null, 2, 'N2L2W8'), ('doc_aiken', 2, 'Aikenhead Street', null, 1, 'N2P1K2');
insert into WorkAddress(doctor_alias, street_number, street_name, unit_number, city_id, postal_code) values ('doc_amnio', 1, 'Jane Street', null, 2, 'N2L2W8'), ('doc_amnio', 2, 'Amniotic Street', null, 1, 'N2P2K5');
insert into WorkAddress(doctor_alias, street_number, street_name, unit_number, city_id, postal_code) values ('doc_umbilical', 1, 'Mary Street', null, 3, 'N2L1A2'), ('doc_umbilical', 2, 'Amniotic Street', null, 1, 'N2P2K5');
insert into WorkAddress(doctor_alias, street_number, street_name, unit_number, city_id, postal_code) values ('doc_heart', 1, 'Jack Street', null, 4, 'N2L1G2'), ('doc_heart', 2, 'Heart Street', null, 2, 'N2P2W5');
insert into WorkAddress(doctor_alias, street_number, street_name, unit_number, city_id, postal_code) values ('doc_cutter', 1, 'Beth Street', null, 3, 'N2L1C2'), ('doc_cutter', 2, 'Cutter Street', null, 1, 'N2P2K5');

END;
$
DELIMITER ;

DROP PROCEDURE IF EXISTS Test_PatientSearch;
DELIMITER $
CREATE PROCEDURE Test_PatientSearch(IN province VARCHAR(20), IN city VARCHAR(20), OUT num_matches INT)
BEGIN
SELECT COUNT(*) INTO num_matches FROM Patient NATURAL JOIN City AS c NATURAL JOIN Province AS p WHERE c.city=city AND p.province_name=province;
END;
$
DELIMITER ;

DROP PROCEDURE IF EXISTS Test_DoctorSearch;
DELIMITER $
CREATE PROCEDURE Test_DoctorSearch(IN gender VARCHAR(20), IN city VARCHAR(20), IN specialization VARCHAR(20), IN num_years_licensed INT, OUT num_matches INT)
BEGIN
DECLARE inGender CHAR DEFAULT 'F';
IF gender='female' OR gender='Female' THEN SET inGender='F';
ELSE SET inGender='M';
END IF;
SELECT COUNT(DISTINCT doctor_alias) INTO num_matches FROM (SELECT *, (YEAR(current_timestamp) - license_year) AS num_years_licensed FROM Doctor) AS d NATURAL JOIN Specialization AS s NATURAL JOIN WorkAddress NATURAL JOIN City AS c WHERE d.gender=inGender AND c.city=city AND s.specialization_name=specialization AND d.num_years_licensed=num_years_licensed;
END;
$
DELIMITER ;

DROP PROCEDURE IF EXISTS Test_DoctorSearchStarRating;
DELIMITER $
CREATE PROCEDURE Test_DoctorSearchStarRating(IN avg_star_rating FLOAT, OUT num_matches INT)
BEGIN
SELECT COUNT(*) INTO num_matches FROM (SELECT AVG(star_rating) FROM Review GROUP BY doctor_alias HAVING AVG(star_rating)>=avg_star_rating) AS t;
END;
$
DELIMITER ;

DROP PROCEDURE IF EXISTS Test_DoctorSearchFriendReview;
DELIMITER $
CREATE PROCEDURE Test_DoctorSearchFriendReview(IN patient_alias VARCHAR(20), IN review_keyword VARCHAR(20), OUT num_matches INT)
BEGIN
SELECT COUNT(DISTINCT u.doctor_alias) INTO num_matches FROM (SELECT r.patient_alias, r.comments, r.doctor_alias FROM (SELECT * FROM FriendRequest AS fr WHERE accepted=1 AND (fr.patient_alias=patient_alias OR fr.friend_alias=patient_alias)) AS z INNER JOIN Review AS r ON z.patient_alias=r.patient_alias OR z.friend_alias=r.patient_alias WHERE r.patient_alias!=patient_alias) AS t INNER JOIN (SELECT * FROM Review WHERE comments LIKE CONCAT('%',review_keyword,'%')) AS u ON t.doctor_alias=u.doctor_alias;
END;
$
DELIMITER ;

DROP PROCEDURE IF EXISTS Test_RequestFriend;
DELIMITER $
CREATE PROCEDURE Test_RequestFriend(IN requestor_alias VARCHAR(20), IN requestee_alias VARCHAR(20))
BEGIN
INSERT INTO FriendRequest VALUES (requestor_alias, requestee_alias, 0);
END;
$
DELIMITER ;

DROP PROCEDURE IF EXISTS Test_ConfirmFriendRequest;
DELIMITER $
CREATE PROCEDURE Test_ConfirmFriendRequest(IN requestor_alias VARCHAR(20), IN requestee_alias VARCHAR(20))
BEGIN
UPDATE FriendRequest SET accepted=1 WHERE patient_alias=requestor_alias AND friend_alias=requestee_alias;
END;
$
DELIMITER ;

DROP PROCEDURE IF EXISTS Test_AreFriends;
DELIMITER $
CREATE PROCEDURE Test_AreFriends(IN patient_alias_1 VARCHAR(20), IN patient_alias_2 VARCHAR(20), OUT are_friends INT)
BEGIN
SET are_friends=0;
SELECT accepted INTO are_friends FROM FriendRequest WHERE (patient_alias=patient_alias_1 AND friend_alias=patient_alias_2) OR (patient_alias=patient_alias_2 AND friend_alias=patient_alias_1);
END;
$
DELIMITER ;

DROP PROCEDURE IF EXISTS Test_AddReview;
DELIMITER $
CREATE PROCEDURE Test_AddReview(IN patient_alias VARCHAR(20), IN doctor_alias VARCHAR(20), IN star_rating FLOAT, IN comments VARCHAR(256))
BEGIN
INSERT INTO Review(patient_alias, doctor_alias, star_rating, comments) VALUES (patient_alias, doctor_alias, star_rating, comments);
END;
$
DELIMITER ;

DROP PROCEDURE IF EXISTS Test_CheckReviews;
DELIMITER $
CREATE PROCEDURE Test_CheckReviews(IN doctor_alias VARCHAR(20), OUT avg_star FLOAT, OUT num_reviews INT)
BEGIN
SELECT AVG(star_rating), COUNT(DISTINCT review_id) INTO avg_star, num_reviews FROM Review as r GROUP BY r.doctor_alias HAVING r.doctor_alias=doctor_alias;
END;
$
DELIMITER ;
