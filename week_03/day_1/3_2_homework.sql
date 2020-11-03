--Find all the employees who work in the ‘Human Resources’ department.

SELECT *
FROM employees
WHERE department = 'Human Resources';



--Get the first_name, last_name, and country of the employees who work in the ‘Legal’ department.
SELECT 
	first_name, 
	last_name,
	department,
	country
FROM employees 
WHERE department = 'Legal';


--Count the number of employees based in Portugal.


SELECT 
	COUNT(id) AS number_employees
FROM employees 
WHERE country = 'Portugal';


--Count the number of employees based in either Portugal or Spain.

SELECT 
	COUNT(id) AS number_employees
FROM employees 
WHERE country = 'Portugal' OR country = 'Spain';


--Count the number of pay_details records lacking a local_account_no.
SELECT *
FROM pay_details;



SELECT 
	COUNT(id) AS number_employees
FROM pay_details 
WHERE local_account_no IS NULL;



--6Get a table with employees first_name and last_name ordered alphabetically by last_name (put any NULLs last).

SELECT 
	first_name,
	last_name
FROM employees 
ORDER BY last_name;

--7How many employees have a first_name beginning with ‘F’?

SELECT 
	COUNT(id) AS number_employees_first_name_F
FROM employees 
WHERE first_name ILIKE 'F%';



--8Count the number of pension enrolled employees not based in either France or Germany.
SELECT 
	COUNT(id) AS number_employees
FROM employees
WHERE pension_enrol IS TRUE AND country != 'France' OR country != 'Germany';



--9Obtain a count by department of the employees who started work with the corporation in 2003.

SELECT 
	department,
	COUNT(id) AS number_employees_start_2003
FROM employees 
WHERE start_date BETWEEN '2003-01-01' AND '2003-12-31'
GROUP BY department;




--10btain a table showing department, 
			--fte_hours and 
			--the number of employees in each department who work each fte_hours pattern. 
			--Order the table alphabetically by department, 
			--and then in ascending order of fte_hours.
			
SELECT
	department,
	fte_hours,
	COUNT(id) AS number_employees_working_fte_hours_pattern
FROM employees
GROUP BY fte_hours
WHERE fte_hours IS NOT NULL
GROUP BY department
ORDER BY fte_hours;



 Hint
--11
--Obtain a table showing any departments in which there are two or more employees lacking a stored first name. 
--Order the table in descending order of the number of employees lacking a first name, 
--and then in alphabetical order by department.

 SELECT 
 	department,
 	COUNT(id) AS no_first_name
 FROM employees
 WHERE first_name IS NULL
 GROUP BY department 
HAVING COUNT(id) >= 2
ORDER BY department; 


 	
 
--12[Tough!] Find the proportion of employees in each department who are grade 1.


