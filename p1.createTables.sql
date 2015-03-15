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

create table Province(province enum('AB', 'BC', 'MB', 'NB', 'NL', 'NS', 'NT', 'NU', 'ON', 'PE', 'QC', 'SK', 'YT') unique not null, primary key(province));

create table City(city_id serial, city varchar(64) not null, province enum('AB', 'BC', 'MB', 'NB', 'NL', 'NS', 'NT', 'NU', 'ON', 'PE', 'QC', 'SK', 'YT') not null, primary key(city_id), foreign key(province) references Province(province));

create table Patient(patient_alias varchar(64) not null unique, city_id bigint unsigned not null, primary key(patient_alias), foreign key(patient_alias) references User(user_alias), foreign key(city_id) references City(city_id));

create table Review(review_id serial, patient_alias varchar(64) not null, doctor_alias varchar(64) not null, star_rating enum('0', '1', '2', '3', '4', '5') not null, comments varchar(1000), date timestamp not null default current_timestamp, primary key(review_id), foreign key(patient_alias) references Patient(patient_alias), foreign key(doctor_alias) references Doctor(doctor_alias));

create table Specialization(doctor_alias varchar(64) not null, specialization_name varchar(64) not null, primary key(doctor_alias, specialization_name), foreign key(doctor_alias) references Doctor(doctor_alias));

create table WorkAddress(address_id serial, doctor_alias varchar(64), street_number int not null, street_name varchar(64) not null, unit_number int, city_id bigint unsigned not null, postal_code char(6) not null, primary key(address_id), foreign key(doctor_alias) references Doctor(doctor_alias), foreign key(city_id) references City(city_id));

create table FriendRequest(patient_alias varchar(64) not null, friend_alias varchar(64) not null, accepted bool not null default 0, primary key(patient_alias, friend_alias), foreign key(patient_alias) references Patient(patient_alias), foreign key(friend_alias) references Patient(patient_alias));
	