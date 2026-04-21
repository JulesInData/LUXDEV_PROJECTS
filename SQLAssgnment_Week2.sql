set search_path to nairobi_academy;

select * from students;
select * from subjects;
select * from exam_results;


-- 	STRING FUNCTIONS	--


-- Display each student's fullname in UPPERCASE and their city in lowercase --

select *,
	concat(UPPER(first_name),' ', UPPER(last_name)) as upper_name,
	LOWER(city) as lower_city
from students;


-- show each student's first name LENGTH order the results from longest to shortest --
	
select 
	first_name,
	LENGTH(first_name) as length_name
from students
	order by length_name desc;


-- show each subject's name short version the first 4 characters as short_name, also show lenth of full subject name --
-- I also ordered from longest to shortest subject name --

select * from subjects;

select 
	subject_name,
	substring(subject_name,1,4) as short_name,
	length(subject_name) as full_subject_length
from subjects
order by full_subject_length desc;


-- use concat to produce a sentence for each student --
select 
	student_id,
	concat(first_name, ' ', last_name,' ','is',' ','in',' ',class,' ','and',' comes',' from ',city) as sentence
from students;


-- NUMBER FUNCTIONS --


-- show each exam result alongside the marks ROUNDED to 1 decimal place, ROUNDED UP to the nearest 10 using CEIL, and ROUNDED DOWN using FLOOR --

select * from exam_results;

select 
	result_id,
	marks,
	round(marks/10.0, 1) as mark_out_of_ten,
	ceil(marks/10.0) as ceil_out_of_ten,
	floor(marks/10.0) as floor_out_of_ten
from exam_results;
	

-- summary of exam results in one query, COUNT, AVG rounded to 2 decimal place, MAX, MIN, SUM --

select 
	count(marks) as total_results,
	round(AVG(marks),2)as average_marks,
	MAX(marks) as highest_marks,
	MIN(marks) as lowest_marks
from exam_results;


-- apply 10% bonus to all marks --

select
	result_id,
	marks as original_marks,
	ROUND(marks * 1.10) as boosted_mark
from exam_results;
	

--	DATE & TIME FUNCTIONS 	--


-- extract birth YEAR, MONTH, DAY ---

select
    first_name,
    date_of_birth,
    TO_CHAR(date_of_birth, 'YYYY')  as birth_year,
    TO_CHAR(date_of_birth, 'Month')  as birth_month,
    TO_CHAR(date_of_birth, 'DD')  as birth_day,
    TO_CHAR(date_of_birth, 'Day') as day_of_birth
from students;


-- show fullname of each student, their date_of_birth, and their age in complete years. Order from oldest to youngest --

select
	concat(first_name,' ', last_name) as full_name,
	extract(year from age(date_of_birth)) as age_years
from students
order by age_years desc;


-- display exam date in this formart --

select 
	exam_date,
	TO_CHAR(exam_date, 'Day, DDth Month YYYY') as formatted_date
from exam_results;


		-- JOINS --


set search_path to city_hospital;

select * from departments;
select * from doctors;
select * from patients;
select * from appointments;
select * from prescriptions;


-- write an INNER JOIN to show appointment alongside patient's full name, the doctor's full name, the appointment date, and the diagnosis --

select 
	a.diagnosis,
	a.appt_date,
	p.full_name as patient_name,
	d. full_name as doctor_name
from appointments a
	inner join patients p on a.patient_id = p.patient_id
	inner join doctors d on a.doctor_id = d.doctor_id
;
	
-- write a LEFT JOIN show all patients --
-- if they have an appointment show appointment date and diagnosis --
-- if they don't have an appointment show NULL values --

select 
	p.full_name as patient_name,
	a.appt_date,
	a.diagnosis
from patients p
	left join appointments a on p.patient_id = a.patient_id
;

-- write a RIGHT JOIN to show all doctors --
-- if the have seen a patient show patient name if not they should appear --

select 
	d.full_name as doctor_name,
	p.full_name as patient_name,
	a.appointment_id
from appointments a
	right join doctors d on a.doctor_id = d.doctor_id
	left join patients p on a.patient_id = p.patient_id
;

-- query using LEFT JOIN and WHERE IS NULL to find all patients who have never had an appointment, show thei fullname and city --

select
	P.full_name as patient_name,
	a.appointment_id,
	city 
from patients p
	left join appointments a on a.patient_id = p.patient_id
	where a.appointment_id is null
;

-- write a three-table INNER JOIN to show each appointment with --
-- patient name, doctor name, medicine prescribed --
-- show appointment_id, patient name, doctor name, and medicine_name --

select 
	p.full_name as patient_name,
	d.full_name as doctors_name,
	a.appointment_id,
	pr.medicine_name
from appointments a
	inner join patients p on a.patient_id = p.patient_id
	inner join doctors d on a.doctor_id = d.doctor_id
	inner join prescriptions pr on a.appointment_id = pr.appointment_id
;

		-- WINDOW FUNCTIONS --


set search_path to nairobi_academy;
select * from students;
select * from subjects;
select * from exam_results;


-- write query using ROW_NUMBER() to assign unique rank to each exam result order from highest mark to lowest --
-- show result_id, student_id, marks and row_num --

select 	
	result_id,
	student_id,
	marks,
	ROW_NUMBER() over(order by marks desc) as row_num
from exam_results;


-- query using RANK() and DENSE_RANK() on exam results order by descending, show columns side by side --

select 
	marks,
	RANK() OVER(order by marks desc) as rank_marks,
	DENSE_RANK() OVER(order by marks desc) as denserank_marks
from exam_results;


-- query using NTILE(3) to divide exam results into 3 perfomance bands(1=top, 2=middle, 3=bottom) --
-- show result_id, marks, and band --

WITH ranked as(
select 
	result_id,
	marks,
	NTILE(3) OVER(order by marks desc) as band
from exam_results)
select 
	result_id,
	marks,
	band,
	case band
		when '1' then 'Top'
		when '2' then 'Middle'
		when '3' then 'Bottom'
	end as perfomance_bands
from ranked;


-- query AVG()OVER(PAARTITION BY student_id) to show exam_result alongside the average --
-- show student_id, marks, and student_avg rounded to 2 decimal places --

select 
	student_id,
	marks,
	ROUND(AVG(marks) OVER(partition by student_id),2)as student_avg
from exam_results;


-- query using LAG() to show each exam result alongside previous result's marks for same student --
-- calculate the improvement(current marks minus previous marks) use PARTITION BY student_id --

select 
	student_id,
	marks as current_mark,
	LAG(marks) OVER(partition by student_id order by result_id) as previous_mark,
	marks - LAG(marks) OVER(partition by student_id order by result_id) as improvement
from exam_results;


