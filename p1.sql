drop table if exists FriendRequest; /* references Patient */
drop table if exists WorkAddress; /* references Doctor, City */
drop table if exists Specialization; /* references Doctor */
drop table if exists Review; /* references Patient, Doctor */
drop table if exists Patient; /* references User, City */
drop table if exists City; /* references Province */
drop table if exists Province;
drop table if exists Doctor; /* references User */
drop table if exists User;


create table User (user_alias varchar(64) not null unique, email varchar(64) not null unique, password_hash varchar(128) not null, name_first varchar(64) not null, name_middle varchar(64) default null, name_last varchar(64) not null, account_type enum('Doctor', 'Patient') not null, primary key(user_alias));
insert into User values ('s4bhatta', 's4bhatta@uwaterloo.ca', password('s4bhatta'), 'Sekhar', null, 'Bhattacharya', 'Patient');
insert into User values ('rsawhney', 'rsawhney@uwaterloo.ca', password('rsawhney'), 'Raunaq', null, 'Sawhney', 'Doctor');
insert into User values ('jreign', 'jreign@singh.com', password('jreign'), 'Jus', null, 'Reign', 'Doctor');
insert into User values ('aka_amazing', 'aka@amazing.com', password('aka_amazing'), 'AKA', null, 'Amazing', 'Patient');
insert into User values ('rtakeuchi', 'rtakeuchi@uwaterloo.ca', password('rtakeuch'), 'Rachel', null, 'Takeuchi', 'Patient');
insert into User values ('sparacha', 'sparacha@uwaterloo.ca', password('sparacha'), 'Saleh', null, 'Paracha', 'Patient');

create table Doctor(doctor_alias varchar(64) not null unique, gender enum('M', 'F') not null, license_year year(4) not null, primary key(doctor_alias), foreign key(doctor_alias) references User(user_alias));
insert into Doctor values('rsawhney', 'M', 2001);
insert into Doctor values('jreign', 'M', 1992);

create table Province(province enum('AB', 'BC', 'MB', 'NB', 'NL', 'NS', 'NT', 'NU', 'ON', 'PE', 'QC', 'SK', 'YT') unique not null, primary key(province));
insert into Province values('AB'), ('BC'), ('MB'), ('NB'), ('NL'), ('NS'), ('NT'), ('NU'), ('ON'), ('PE'), ('QC'), ('SK'), ('YT');

create table City(city_id serial, city varchar(64) not null, province enum('AB', 'BC', 'MB', 'NB', 'NL', 'NS', 'NT', 'NU', 'ON', 'PE', 'QC', 'SK', 'YT') not null, primary key(city_id), foreign key(province) references Province(province));
insert into City(city, province) values('Mississauga', 'ON'), ('Brampton', 'ON'), ('Kamloops', 'BC');

create table Patient(patient_alias varchar(64) not null unique, city_id bigint unsigned not null, primary key(patient_alias), foreign key(patient_alias) references User(user_alias), foreign key(city_id) references City(city_id));
insert into Patient values('s4bhatta', 1);
insert into Patient values('aka_amazing', 2);
insert into Patient values('rtakeuchi', 3);
insert into Patient values('sparacha', 1);

create table Review(review_id serial, patient_alias varchar(64) not null, doctor_alias varchar(64) not null, star_rating enum('0', '1', '2', '3', '4', '5') not null, comments varchar(1000), date timestamp not null default current_timestamp, primary key(review_id), foreign key(patient_alias) references Patient(patient_alias), foreign key(doctor_alias) references Doctor(doctor_alias));
insert into Review(patient_alias, doctor_alias, star_rating, comments) values('s4bhatta', 'rsawhney', '1', 'He was very creepy and he wore a weird thing on his head');
insert into Review(patient_alias, doctor_alias, star_rating, comments) values('s4bhatta', 'jreign', '3', 'HAHAHA very good funny guy but he has thing on his head');
insert into Review(patient_alias, doctor_alias, star_rating, comments) values('aka_amazing', 'jreign', '5', 'This guys too cool dawg. Asked for addy pills and he prescribed some right away without even batting an eye. I like him.');

create table Specialization(doctor_alias varchar(64) not null, specialization_name varchar(64) not null, primary key(doctor_alias, specialization_name), foreign key(doctor_alias) references Doctor(doctor_alias));
insert into Specialization values ('rsawhney', 'testicles'), ('rsawhney', 'anus'), ('jreign', 'general practitioner');

create table WorkAddress(address_id serial, doctor_alias varchar(64), street_number int not null, street_name varchar(64) not null, unit_number int, city_id bigint unsigned not null, postal_code char(6) not null, primary key(address_id), foreign key(doctor_alias) references Doctor(doctor_alias), foreign key(city_id) references City(city_id));
insert into WorkAddress(doctor_alias, street_number, street_name, unit_number, city_id, postal_code) values ('jreign', 366, 'Main Street North', 1, 2, 'L6V1P8'), ('jreign', 100, 'City Centre Drive', 26, 1, 'L5B2C9'), ('rsawhney', 180, 'Sandalwood Parkway East', 1, 2, 'L6Z1Y4');

create table FriendRequest(patient_alias varchar(64) not null, friend_alias varchar(64) not null, accepted bool not null default 0, primary key(patient_alias, friend_alias), foreign key(patient_alias) references Patient(patient_alias), foreign key(friend_alias) references Patient(patient_alias));
insert into FriendRequest values ('aka_amazing', 's4bhatta', 0), ('rtakeuchi', 's4bhatta', 1), ('sparacha', 'rtakeuchi', 0);

/* for a different review date */
insert into Review(patient_alias, doctor_alias, star_rating, comments) values('s4bhatta', 'jreign', '5', 'He is a total bro! He makes youtube videos too WOOO!');

/* Views */
drop view if exists PatientFriendRequestView;
create view PatientFriendRequestView as select f.patient_alias, f.friend_alias, u.email from User as u inner join FriendRequest as f on f.patient_alias=u.user_alias where accepted=0;

drop view if exists PatientDoctorProfileView;
create view PatientDoctorProfileView as select u.user_alias, u.name_first, u.name_middle, u.name_last, d.gender, (year(current_timestamp)-d.license_year) as num_years_licensed, avg(r.star_rating-1) as avg_rating, count(distinct r.review_id) as num_reviews from (User as u inner join Doctor as d on u.user_alias=d.doctor_alias) left join Review as r on d.doctor_alias=r.doctor_alias group by u.user_alias;

drop view if exists DoctorOwnProfileView;
create view DoctorOwnProfileView as select d.doctor_alias, u.email, u.name_first, u.name_middle, u.name_last, d.gender, (year(current_timestamp)-d.license_year) as num_years_licensed, avg(r.star_rating-1) as avg_rating, count(distinct r.review_id) as num_reviews from (User as u inner join Doctor as d on u.user_alias=d.doctor_alias) left join Review as r on d.doctor_alias=r.doctor_alias group by d.doctor_alias;

drop view if exists PatientOwnProfileView;
create view PatientOwnProfileView as select p.patient_alias, u.email, u.name_first, u.name_middle, u.name_last, c.city, c.province from (User as u inner join Patient as p on u.user_alias=p.patient_alias) natural join City as c;

/* data operations */

/* O1. Patient Search */
/* O2. Patient add friend 
		accepted == 1 => patient A added patient B and vice versa, 0 means 
		accepted == 0 && friend_alias == A => Patient A must accept friend request 
		accepted == 0 && friend_alias == B => Patient A must wait for Patient B to accept friend request 
		accepted == NULL => Neither patient A nor  patiend B have added each other
*/
select pcr.*, fr.friend_alias, fr.accepted from (select pc.*, count(distinct review_id) as num_reviews, max(r.date) as last_review from (select p.patient_alias, c.city, c.province from Patient as p natural join City as c where patient_alias='<patient_alias>' and city='<city>' and province='<province>') as pc left join Review as r on r.patient_alias=pc.patient_alias group by patient_alias) as pcr left join FriendRequest as fr on (fr.patient_alias='<current_user_alias>' and fr.friend_alias=pcr.patient_alias) or (fr.patient_alias=pcr.patient_alias and fr.friend_alias='<current_user_alias>');

/* O2. Patient add friend */
select friend_alias, accepted from FriendRequest where patient_alias='<current_user_alias>';

/* O3. Patient view friend requests */
select u.user_alias, u.email from User as u inner join (select patient_alias from FriendRequest where friend_alias='<current_user_alias>' and accepted=0) as fr on u.user_alias=fr.patient_alias;
select patient_alias, email from PatientFriendRequest where friend_alias='<current_user_alias>'; /* using view */

/* O4. Flexible doctor search */
select u.name_first, u.name_middle, u.name_last, d.gender, (year(current_timestamp)-d.license_year) as num_years_licensed, w.street_number, w.street_name, w.postal_code, c.city, c.province, s.specialization_name, ar.avg_rating, t.reviewed_by_friend, t.comments from ((((((Doctor as d inner join User as u on d.doctor_alias=u.user_alias) natural join Specialization as s) natural join WorkAddress as w) natural join City as c) natural join Province as p) left join (select avg(star_rating-1) as avg_rating, doctor_alias from Review group by doctor_alias) as ar on d.doctor_alias=ar.doctor_alias) inner join (select r.doctor_alias, r.comments, fr.accepted as reviewed_by_friend from Review as r left join (select * from FriendRequest where patient_alias='<current_user_alias>' or friend_alias='<current_user_alias>') as fr on r.patient_alias=fr.patient_alias or r.patient_alias=fr.friend_alias) as t on t.doctor_alias=d.doctor_alias where u.name_first like '%<first name>%' and u.name_middle like '%<middle name>%' and u.name_last like '%<last name>%' and d.gender='<gender>' and num_years_licensed>=<num years> and w.street_number=<street number> and w.street_name like '%<street name>%' and w.postal_code like '%<postal code>%' and c.city like '%<city>%' and c.province like '%<province>%' and s.specialization_name like '%<specialization name>%' and ar.avg_rating>=<avg rating> and t.reviewed_by_friend=<reviewed by friend> and t.comments like '%<keyword>%';
select distinct d.doctor_alias, u.name_first, u.name_middle, u.name_last, ar.avg_rating from (((((((Doctor as d inner join User as u on d.doctor_alias=u.user_alias) natural join Specialization as s) natural join WorkAddress as w) natural join City as c) natural join Province as p) left join (select avg(star_rating-1) as avg_rating, doctor_alias from Review group by doctor_alias) as ar on d.doctor_alias=ar.doctor_alias) inner join (select r.doctor_alias, r.comments, fr.accepted as reviewed_by_friend from Review as r left join (select * from FriendRequest where patient_alias='<current_user_alias>' or friend_alias='<current_user_alias>') as fr on r.patient_alias=fr.patient_alias or r.patient_alias=fr.friend_alias) as t on t.doctor_alias=d.doctor_alias) left join (select doctor_alias, count(distinct review_id) as num_reviews from Review group by doctor_alias) as nr on d.doctor_alias=nr.doctor_alias where u.name_first like '%<first name>%' and u.name_middle like '%<middle name>%' and u.name_last like '%<last name>%' and d.gender='<gender>' and num_years_licensed>=<num years> and w.street_number=<street number> and w.street_name like '%<street name>%' and w.postal_code like '%<postal code>%' and c.city like '%<city>%' and c.province like '%<province>%' and s.specialization_name like '%<specialization name>%' and ar.avg_rating>=<avg rating> and t.reviewed_by_friend=<reviewed by friend> and t.comments like '%<keyword>%';

/* O5. View doctor profile */
select u.user_alias, u.name_first, u.name_middle, u.name_last, gender, license_year, count(distinct r.review_id) as num_reviews, avg(r.star_rating-1) as avg_rating from (Doctor as d inner join User as u on d.doctor_alias=u.user_alias) left join Review as r on r.doctor_alias=d.doctor_alias where d.doctor_alias='<selected_doctor_alias>';
select * from PatientDoctorProfile where user_alias='<selected_doctor_alias>'; /* Using view */
select specialization_name from Specialization where doctor_alias='<selected_doctor_alias>'; /* specializations */
select unit_number, street_number, street_name, postal_code, city, province from WorkAddress natural join City where doctor_alias='<selected_doctor_alias>'; /* Work addresses */
select review_id from Review where doctor_alias='<selected_doctor_alias>' order by date desc; /* List of review ids */

/* O6 View doctor review */
select u.name_first, u.name_last, r.patient_alias, r.star_rating, r.date, r.comments from Review as r inner join User as u on u.user_alias=r.doctor_alias where r.review_id=<selected_review_id>; /* Review details */
select r.review_id from (select doctor_alias, review_id, date from Review where review_id=<selected_review_id>) as rd inner join Review as r on rd.doctor_alias=r.doctor_alias where r.date<=rd.date and r.review_id!=rd.review_id having max(r.date); /* Previous review */
select r.review_id from (select doctor_alias, date from Review where review_id=<selected_review_id>) as rd inner join Review as r on rd.doctor_alias=r.doctor_alias where r.date>rd.date having max(r.date);

/* O7. Write doctor review */
insert into Review(patient_alias, doctor_alias, star_rating, comments) values('<current_user_alias>', '<selected_doctor_alias', '<selected_star_rating>', '<entered_comments>');

/* O8. Doctor view own profile */
select u.user_alias, u.name_first, u.name_middle, u.name_last, d.gender, (year(current_timestamp)-d.license_year) as num_years_licensed, avg(r.star_rating-1) as avg_rating, count(distinct r.review_id) as num_reviews from (User as u inner join Doctor as d on u.user_alias=d.doctor_alias) left join Review as r on d.doctor_alias=r.doctor_alias where d.doctor_alias='<current_doctor_alias>';
select * from DoctorOwnProfile where user_alias='<current_doctor_alias>'; /* using view */
select specialization_name from Specialization where doctor_alias='<selected_doctor_alias>'; /* specializations */
select unit_number, street_number, street_name, postal_code, city, province from WorkAddress natural join City where doctor_alias='<selected_doctor_alias>'; /* Work addresses */
select review_id from Review where doctor_alias='<selected_doctor_alias>' order by date desc; /* List of review ids */
