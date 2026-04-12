create schema nairobi_academy;
set search_path to nairobi_academy;

-- students table --

CREATE TABLE nairobi_academy.students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(1),
    date_of_birth DATE,
    class VARCHAR(10),
    city VARCHAR(50)
);

-- subjects table --

CREATE TABLE subjects (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL UNIQUE,
    department VARCHAR(50),
    teacher_name VARCHAR(100),
    credits INT
);

-- eaxams_results table --

CREATE TABLE exam_results (
    result_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    marks INT NOT NULL,
    exam_date DATE,
    grade VARCHAR(2)
);


select* from nairobi_academy.students;
select* from subjects;
select* from exam_results;

-- DML
-- filling in the students table --

INSERT INTO nairobi_academy.students VALUES
(1,'Amina','Wanjiku','F','2008-03-12','Form 3','Nairobi'),
(2,'Brian','Ochieng','M','2007-07-25','Form 4','Mombasa'),
(3,'Cynthia','Mutua','F','2008-11-05','Form 3','Kisumu'),
(4,'David','Kamau','M','2007-02-18','Form 4','Nairobi'),
(5,'Esther','Akinyi','F','2009-06-30','Form 2','Nakuru'),
(6,'Felix','Otieno','M','2009-09-14','Form 2','Eldoret'),
(7,'Grace','Mwangi','F','2008-01-22','Form 3','Nairobi'),
(8,'Hassan','Abdi','M','2007-04-09','Form 4','Mombasa'),
(9,'Ivy','Chebet','F','2009-12-01','Form 2','Nakuru'),
(10,'James','Kariuki','M','2008-08-17','Form 3','Nairobi');

-- filling in the subjects table --

INSERT INTO subjects VALUES
(1,'Mathematics','Sciences','Mr. Njoroge',4),
(2,'English','Languages','Ms. Adhiambo',3),
(3,'Biology','Sciences','Ms. Otieno',4),
(4,'History','Humanities','Mr. Waweru',3),
(5,'Kiswahili','Languages','Ms. Nduta',3),
(6,'Physics','Sciences','Mr. Kamande',4),
(7,'Geography','Humanities','Ms. Chebet',3),
(8,'Chemistry','Sciences','Ms. Muthoni',4),
(9,'Computer Studies','Sciences','Mr. Oduya',3),
(10,'Business Studies','Humanities','Ms. Wangari',3);

-- filling in the exam_ results table --

INSERT INTO exam_results VALUES
(1,1,1,78,'2024-03-15','B'),
(2,1,2,85,'2024-03-16','A'),
(3,2,1,92,'2024-03-15','A'),
(4,2,3,55,'2024-03-17','C'),
(5,3,2,49,'2024-03-16','D'),
(6,3,4,71,'2024-03-18','B'),
(7,4,1,88,'2024-03-15','A'),
(8,4,6,63,'2024-03-19','C'),
(9,5,5,39,'2024-03-20','F'),
(10,6,9,95,'2024-03-21','A');


-- Add hone_number column --

ALTER TABLE nairobi_academy.students
ADD COLUMN phone_number VARCHAR(20);


-- rename credits column in subjects table to credit_hours --

ALTER TABLE subjects
RENAME COLUMN credits TO credit_hours;


-- remove phone_number column completely --

ALTER TABLE nairobi_academy.students
DROP COLUMN phone_number;


select* from nairobi_academy.students;
select* from subjects;
select* from exam_results;

-- Update Akinyi's city from Nakuru to Nairobi --

UPDATE nairobi_academy.students
SET city = 'Nairobi'
WHERE student_id = 5;


-- updating results for result_id 5 they ere entered incorrectly--

UPDATE exam_results
SET marks = 59
WHERE result_id = 5;


-- remove the exam result from result_id 9 completely --

DELETE FROM exam_results
WHERE result_id = 9;


-- find all students in form 4 --

select * from nairobi_academy.students
where class = 'Form 4';


-- find all subjects in science department --

select * from subjects
where department = 'Sciences';


-- find all exam results greater than or equal to 70 --

select * from exam_results
where marks >= 70;

-- find all female students --

select * from nairobi_academy.students
where gender = 'F';


-- find all students in from 3 from Nairobi --

select * from nairobi_academy. students
where class = 'Form 3' and city = 'Nairobi';


-- find all students ho are in form 2 or form 4 --

select* from nairobi_academy.students
where class = 'Form 3' or class = 'Form 4'


-- find all exam results between 50 amd 80 --

select * from exam_results
where marks between 50 and 80;


-- find all exams that took place between 15th March 2024 and 18th March 2024 --

SELECT * FROM exam_results
WHERE exam_date BETWEEN '2024-03-15' AND '2024-03-18';


-- find all students who live in Nairobi, Mombasa or Kisumu --

SELECT * FROM nairobi_academy.students
WHERE city IN ('Nairobi','Mombasa','Kisumu');


-- find all students who are not in form or fom 3 --

SELECT * FROM nairobi_academy.students
WHERE class NOT IN ('Form 2','Form 3');


-- find all students whose first name starts with letter A or E --

select * from nairobi_academy.students
where first_name like 'A%' or first_name like 'E%';


-- find all subjects whose name contains the words studies --

select * from subjects
where subject_name like '%Studies%';


-- how many students are currently in form 3 --

select count(*) from nairobi_academy.students
where class = 'Form 3';


-- how many exam results have a mark of 70 and above --

select count(*) from exam_results
where marks >= 70;


-- use CASE WHEN to label each exam result with a grade bdescription --

SELECT *,
CASE
    WHEN marks >= 80 THEN 'Distinction'
    WHEN marks >= 60 THEN 'Merit'
    WHEN marks >= 40 THEN 'Pass'
    ELSE 'Fail'
END AS performance
FROM exam_results;


-- label each student --

SELECT first_name, last_name, class,
CASE
    WHEN class IN ('Form 3','Form 4') THEN 'Senior'
    ELSE 'Junior'
END AS student_level
FROM students;

SELECT * FROM nairobi_academy.students;
select * from subjects;
select * from exam_results;


-- 