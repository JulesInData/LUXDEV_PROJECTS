set search_path to nairobi_academy;

set search_path to city_hospital;

		-- SET OPERATORS --

-- write a UNION query to show a combine list of all unique cities from students table and patients table, order alphabetiically --
select 
	city, 'student_city' as location_type from nairobi_academy.students
	union
select 
	city, 'patient_city' as location_type from patients
order by city;

-- write a UNION ALL query to combine all student first names and all patient full names into one list --
-- add a second column called source that says 'Student' or 'Patient' so you can tell where each name came from --

select 
	first_name, 'Student' as source from nairobi_academy.students
	union all 
select 
	full_name, 'Patient' as source from patients
order by source;

-- write an INTERSECT query to find cities that appear in BOTH the students table and patients table --
-- cities that are home to both students and patients --

select 
	city from nairobi_academy.students
	intersect
select 
	city from patients
order by city;

-- write a query that combines student names (labelled 'Student'), patient full names (labelled 'Patient'), and doctor full names (labelled 'Doctor') using UNION ALL --
-- order the final result by the source label, then by name --

select 
	full_name, 'Patient' as source_label from patients
	union all 
select
	concat(first_name,' ',last_name), 'Student' as source_label from nairobi_academy.students 
	union all
select 
	full_name, 'Doctor' as source_label from doctors
order by source_label, full_name asc;


-- NOTE: My city_hospital schema was running so I did not append the tables like I did with the nairobi_academy tables --