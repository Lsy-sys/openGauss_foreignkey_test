-- 删除所有表
drop table students_courses cascade ;
drop table students cascade ;
drop table teachers cascade ;
drop table courses cascade ;
drop table instructors_courses cascade ;

create schema school;
set schema 'school';

-- 创建所有表
create table students(
    id int not null ,
    name varchar(50) not null,
    age int not null,
    primary key (id)
                     );

create table teachers(
    id int not null ,
    name varchar(50) not null,
    age int not null,
    primary key (id)
                     );

create table courses(
    id int not null ,
    name varchar(50) not null,
    primary key (id)
                     );

create table students_courses(
    student_id int not null,
    course_id int not null
                            );

create table instructors_courses(
    instructor_id int not null,
    course_id int not null,
    primary key (instructor_id,course_id),
    foreign key (instructor_id) references teachers(id),
    foreign key (course_id) references courses(id)
                             );



insert into students(id,name,age) values
                                      (1,'张三',20),
                                      (2,'李四',21),
                                      (3,'王麻子',22),
                                      (4,'Alice',23);

insert into teachers(id,name,age) values
                                      (1,'Mr. Smith',35),
                                      (2,'Mrs. Johnson',40),
                                      (3,'Mr. Brown',45);

insert into courses(id,name) values
                                  (1,'数学'),
                                  (2,'英语'),
                                  (3,'数据库');

insert into students_courses(student_id,course_id) values
                                                       (1,1),
                                                       (1,2),
                                                       (2,1),
                                                       (2,3),
                                                       (3,2),
                                                       (4,3);

insert into instructors_courses(instructor_id,course_id) values
                                                             (1,1),
                                                             (1,2),
                                                             (2,2),
                                                             (3,3);


select * from students;

-- 一、基本的增删改查操作
insert into students(id,name,age) values (5,'Emily',24);

delete from students
    where id = 5;

update students
    set age= age+1;


select name from students where age >= 22;



-- 二、外键约束问题
-- 1. 定义级联外键
alter table students_courses
add constraint sc_students
foreign key (student_id) references students(id)
on delete cascade
on update cascade ;


-- 2. 定义无级联外键
alter table students_courses
add constraint sc_students
foreign key (student_id) references students(id)
on delete no action
on update no action;


-- 删除定义的外键关系
alter table students_courses
drop constraint sc_students;



-- 删除外键值的影响
DELETE FROM students WHERE id = 1;

select * from students
where id = 1;

select * from students_courses
where student_id = 1;


-- 修改外键值(主键)的影响
UPDATE students SET id = 8 WHERE id = 2;


select * from students_courses;
select * from students;

-- 增加主键的影响
INSERT INTO students (id, name, age) VALUES (6, 'Emily', 24);

--修改对应的外键值（外键）的影响
delete from students_courses
where student_id = 4;
select * from students_courses;


insert into students_courses values (4,1);

update students_courses
set student_id = 4
where student_id = 2;

insert into students_courses values (2,2);
-- 三、复杂查询
-- 查询Mr. Smith这个老师教授的所有学生
select name from students--学生名
where id in (
    select student_id from students_courses--查出选了这些课的学生
    where course_id in (
        select course_id from instructors_courses
        where instructor_id = (
            select id from teachers
            where name = 'Mr. Smith'--查出老师教了几门课
                                )
        )
    );


-- 四，check语句，视图，索引的用法
--1.check的用法
alter table students
add constraint check_age
check (age > 18);

insert into  students(id,name,age) values (5,'Sam',16);
--2.视图的创建
create view student_view as
    select id,name from students
    where age > 20;
select * from student_view;
--3.索引的创建
create index index_name on students(name);
