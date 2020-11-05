--MVP1
--Are there any pay_details records lacking both a local_account_no and iban number?
--answer; No

SELECT 
	local_account_no,
	iban
FROM pay_details 
WHERE local_account_no IS NULL AND iban IS NULL;




--MVP2
--Get a table of employees first_name, last_name and country, 
--ordered alphabetically first by country and then by last_name (put any NULLs last).

SELECT 
	first_name,
	last_name,
	country
FROM employees 
ORDER BY country ASC NULLS LAST, last_name ASC NULLS LAST;
	

--MVP3
--Find the details of the top ten highest paid employees in the corporation.

SELECT *
	FROM employees 
	ORDER BY salary DESC NULLS LAST
	LIMIT 10 ;
	
	
--MVP4
--Find the first_name, last_name and salary of the lowest paid employee in Hungary.

SELECT 
	first_name,
	last_name,
	salary
FROM employees
WHERE country = 'Hungary' 
ORDER BY salary NULLS LAST
LIMIT 1;


--MVP5
--Find all the details of any employees with a ‘yahoo’ email address?

SELECT *
FROM employees
WHERE email LIKE '%yahoo%';


--MVP6
--Provide a breakdown of the numbers of employees enrolled, not enrolled, 
--and with unknown enrollment status in the corporation pension scheme.

SELECT 
	COUNT(id) AS num_emp, 
	pension_enrol
	FROM employees 
	GROUP BY pension_enrol;



--MVP7
--What is the maximum salary among those employees in the ‘Engineering’ department 
--who work 1.0 full-time equivalent hours (fte_hours)?
SELECT 
	MAX(salary)
FROM employees
WHERE department = 'Engineering' AND fte_hours = 1;



--MVP8
--Get a table of country, number of employees in that country, 
--and the average salary of employees in that country for any countries in which more than 30 employees are based. 
--Order the table by average salary descending.

SELECT 
	country,
	Count(id) AS number_employees,
	AVG(salary)
	FROM employees
GROUP BY country
HAVING COUNT(id) > 30
ORDER BY AVG(salary)DESC;



--MVP9
--Return a table containing each employees first_name, last_name, full-time equivalent hours (fte_hours), salary, 
--and a new column effective_yearly_salary which should contain fte_hours multiplied by salary.

SELECT 
	first_name,
	last_name,
	fte_hours,
	salary,
	(fte_hours * salary) AS effective_yearly_salary
FROM employees;




--MVP10
--Find the first name and last name of all employees who lack a local_tax_code.

SELECT 
	e.first_name,
	e.last_name,
	p.local_tax_code
	FROM employees AS e LEFT JOIN pay_details AS p
	ON e.id = p.id
	WHERE p.local_tax_code IS NULL;




--MVP11
--The expected_profit of an employee is defined as (48 * 35 * charge_cost - salary) * fte_hours, 
--where charge_cost depends upon the team to which the employee belongs. 
--Get a table showing expected_profit for each employee.


--expected_profit =(48 * 35 * charge_cost - salary) * fte_hours

SELECT 
	e.id,
	(48 * 35 * CAST (charge_cost AS INT) - salary) * fte_hours AS expected_profit
	FROM employees AS e LEFT join teams AS t 
	ON e.id = t.id
	ORDER BY expected_profit;
	
	

--MVP12
--[Tough] Get a list of the id, first_name, last_name, salary and fte_hours of employees in the largest department. 
--Add two extra columns showing the ratio of each employee’s salary to that department’s average salary, 
--and each employee’s fte_hours to that department’s average fte_hours.

--Writing a CTE to calculate the name, average salary, average fte_hours of largest department is an efficient way to do this.
CTE 1 name, AVG(salary)y AND AVG(fte_hours)



WITH employees_avgs(department, avg_salary, avg_fte_hours) AS (
	SELECT 
		department,
		AVG(e.salary) AS avg_salary,
		AVG(e.fte_hours) AS avg_fte_hours
	FROM employees AS e 
	GROUP BY department
	ORDER BY COUNT(id) DESC NULLS LAST
	LIMIT 1
	)
SELECT 
	e.id, 
	e.first_name, 
	e.last_name, 
	e.salary, 
	e.fte_hours, 
	e.department,
	(e.salary / a.avg_salary) AS salary_ratio,
	(e.fte_hours / a.avg_fte_hours) AS fte_hours_ratio
	FROM employees AS e CROSS JOIN employees_avgs AS a
	WHERE e.department = a.department;
	
	

	
	
	--MVP EXTENSION1
	
	--Return a table of those employee first_names shared by more than one employee, 
	--together with a count of the number of times each first_name occurs. 
	--Omit employees without a stored first_name from the table. 
	--Order the table descending by count, and then alphabetically by first_name.
	
	
	SELECT 
		e.first_name,
		Count(id)
		FROM employees AS e
		WHERE e.first_name = e.first_name
		GROUP BY e.first_name
		ORDER BY Count(id) DESC, e.first_name IS NOT NULL;
	
	--MVP X2
	--Have a look again at your table for core question 6. 
	--It will likely contain a blank cell for the row relating to employees with ‘unknown’ pension enrollment status. 
	--This is ambiguous: it would be better if this cell contained ‘unknown’ or something similar. 
	--Can you find a way to do this, perhaps using a combination of 
	
	COALESCE() and CAST(), or a CASE statement?
	
	SELECT 
	COUNT(id) AS num_emp, 
	pension_enrol,
CASE
	WHEN pension_enrol = TRUE THEN 'enrolled'
	WHEN pension_enrol = FALSE THEN 'not enrolled'
	ELSE 'not known '
	END AS pension_status
	FROM employees 
	GROUP BY pension_enrol;

		
	
		