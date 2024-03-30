use master;
drop database students;

create database students;

use  students;

Create table students_personal_data
( id int, first_name char(255), last_name char(255), major char(4));

Insert into students_personal_data (id, first_name, last_name, major)
Values (1, 'Joe', 'Smith', 'CS');
Insert into students_personal_data (id, first_name, last_name, major)
Values (2, 'Jane', 'Doe', 'CS');
Insert into students_personal_data (id, first_name, last_name, major)
Values (3, 'Alex', 'Lee', 'EE');

select * from students_personal_data;
select id, first_name, last_name, major from students_personal_data;




select count(*) from students_personal_data;
select major, count(*) from students_personal_data group by major;
select first_name, major from students_personal_data;

update students_personal_data SET major='AI' WHERE id=2;

delete from students_personal_data WHERE id=1;
select * from students_personal_data;

alter table students_personal_data add phone char(10);
select * from students_personal_data;

update students_personal_data set phone='2061112233' where id=2;
update students_personal_data set phone='4254445566' where id=3;
select * from students_personal_data;

Insert into students_personal_data (id, first_name, last_name, major)
Values (2, 'Joe', 'Smith', 'CS');
select * from students_personal_data;
delete from students_personal_data where first_name='Joe'; -- deleting the recently inserted duplicate
create unique index ix_personal_data_by_id on students_personal_data(id);
Insert into students_personal_data (id, first_name, last_name, major)
Values (2, 'Joe', 'Smith', 'CS');
Insert into students_personal_data Values (1, 'Joe', 'Smith', 'CS', '2069998877');
select * from students_personal_data;

select first_name, phone from students_personal_data;
select first_name, phone from students_personal_data where first_name ='Alex' or last_name='Doe';
select first_name, phone from students_personal_data ORDER BY phone;

Create table courses( course_id char(8), subject_name char(255));
Create table quarters( quarter_id char(4), quarter_name char(255));
Create table courses_groups( group_id int, course_id char(8), quarter_id char(4), group_number int);
Insert into courses Values ('CPCS5021', 'Database Systems');
Insert into courses Values ('CPCS5021', 'Database Systems');
Insert into courses Values ('SCEN1000', 'Introduction to Engineering');
Insert into quarters Values ('SQ24', 'Spring Quarter 2024');
Insert into quarters Values ('RQ24', 'Undergraduate Summer Quarter 2024');
Insert into quarters Values ('FQ24', 'Fall Quarter 2024');
Insert into quarters Values ('WQ24', 'Winter Quarter 2024');
insert into courses_groups Values (1, 'CPCS5021', 'SQ24', 1);
select * from courses;
select * from quarters;
select * from courses_groups;

select * from courses, quarters;
select courses_groups.*, subject_name, quarter_name from courses_groups, courses, quarters where
	courses_groups.course_id = courses.course_id and 
	courses_groups.quarter_id = quarters.quarter_id;


select courses_groups.*, courses.course_id, subject_name from
	courses LEFT OUTER JOIN courses_groups ON
	courses_groups.course_id = courses.course_id
	AND quarter_id='SQ24';

