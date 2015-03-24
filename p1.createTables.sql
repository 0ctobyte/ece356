SET storage_engine=InnoDB;
use ece356db_s4bhatta;


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
create view PatientDoctorProfileView as select u.user_alias, u.name_first, u.name_middle, u.name_last, d.gender, (year(current_timestamp)-d.license_year) as num_years_licensed, avg(r.star_rating-1) as avg_rating, count(distinct r.review_id) as num_reviews from (User as u inner join Doctor as d on u.user_alias=d.doctor_alias) left join Review as r on d.doctor_alias=r.doctor_alias group by u.user_alias;

drop view if exists DoctorOwnProfileView;
create view DoctorOwnProfileView as select d.doctor_alias, u.email, u.name_first, u.name_middle, u.name_last, d.gender, (year(current_timestamp)-d.license_year) as num_years_licensed, avg(r.star_rating-1) as avg_rating, count(distinct r.review_id) as num_reviews from (User as u inner join Doctor as d on u.user_alias=d.doctor_alias) left join Review as r on d.doctor_alias=r.doctor_alias group by d.doctor_alias;

drop view if exists PatientOwnProfileView;
create view PatientOwnProfileView as select p.patient_alias, u.email, u.name_first, u.name_middle, u.name_last, c.city, c.province from (User as u inner join Patient as p on u.user_alias=p.patient_alias) natural join City as c;

drop view if exists DoctorFlexSearchView;
create view DoctorFlexSearchView as select u.name_first, u.name_last, d.gender, c.city, p.province, s.specialization_name, (YEAR(current_timestamp)-d.license_year) as num_years_licensed, r.avg_rating, t.comments, t.patient_alias, fr.accepted, fr.patient_alias, fr.friend_alias from Doctor as d inner join User as u on u.user_alias=d.doctor_alias natural join WorkAddress as w natural join City as c natural join Province as p natural join Specialization as s left join (select doctor_alias, AVG(star_rating) as avg_rating from Review group by doctor_alias) as r on r.doctor_alias=d.doctor_alias left join Review as t on t.doctor_alias=d.doctor_alias left join FriendRequest as fr on ((fr.patient_alias=t.patient_alias or fr.friend_alias=t.patient_alias) and fr.accepted=1);
