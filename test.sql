-- 删除所有表
drop table students_courses;
drop table students;
drop table teachers;
drop table courses;

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

insert into students(id,name,age) values
                                      (1,'John',20),
                                      (2,'Jane',21),
                                      (3,'Bob',22),
                                      (4,'Alice',23);

insert into teachers(id,name,age) values
                                      (1,'Mr. Smith',35),
                                      (2,'Mrs. Johnson',40),
                                      (3,'Mr. Brown',45);

insert into courses(id,name) values
                                  (1,'Math'),
                                  (2,'English'),
                                  (3,'Science');

insert into students_courses(student_id,course_id) values
                                                       (1,1),
                                                       (1,2),
                                                       (2,1),
                                                       (2,3),
                                                       (3,2),
                                                       (4,3);





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


-- 修改外键值的影响
UPDATE students SET id = 5 WHERE id = 1;
select * from students_courses
where student_id = 5;
select * from students;

-- 增加主键的影响
INSERT INTO students (id, name, age) VALUES (6, 'Emily', 24);
