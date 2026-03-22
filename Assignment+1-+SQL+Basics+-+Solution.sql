-- Assignment 1 - SQL Basics

-- Q1. The HR department needs a query to display all unique job codes from the Employees table. Write the query to assist the team.
SELECT DISTINCT job_id FROM employees;

-- Q2. The HR department wants more descriptive column headings for its report on employees. They want employee_id, first_name, job_id, and hire_date columns but the output should have below column names as shown. Write a query to achieve this.
SELECT employee_id AS "Emp#", first_name AS "Employee", job_id AS "Job", hire_date AS "Hire Date" FROM employees;

-- Q3. The HR Department has requested a report of all employees and their job IDs. Display the last name concatenated with the job ID (separated by a comma and space) and name the column as "Employee and Title".
SELECT CONCAT(last_name, ', ', job_id) AS "Employee and Title" FROM employees;

-- Q4. Because of the budget issues the HR department needs a report that displays the last name and the salary of the employees who earn more than $12,000.
SELECT last_name, salary FROM employees WHERE salary > 12000;

-- Q5. Create a query which will display the last name and the department number for employee id 176.
SELECT last_name, department_id FROM employees WHERE employee_id = 176;

-- Q6. The HR department is looking for all the employees whose salary is in the range of $2000 and $4500. Write a query to get the output for business.
SELECT last_name, salary FROM employees WHERE salary BETWEEN 2000 AND 4500;

-- Q7. Write a query to get the employees who do not have a manager.
SELECT last_name, first_name FROM employees WHERE manager_id IS NULL;

-- Q8. Write a query which will give employee first name and last name as Employee Name, salary, and commission_pct. We are looking for the employees who get a commission.
SELECT first_name || ' ' || last_name AS "Employee Name", salary, commission_pct FROM employees WHERE commission_pct IS NOT NULL;

-- Q9. Write a query where the employee’s last name's 3rd character is "a".
SELECT last_name FROM employees WHERE SUBSTRING(last_name, 3, 1) = 'a';

-- Q10. Write a query that displays the last names of all the employees who have both an "a" and an "e" in their last name.
SELECT last_name FROM employees WHERE last_name LIKE '%a%' AND last_name LIKE '%e%';

-- Q11. Display the last name and department number of all the employees in the department number 50 or 20 in ascending alphabetical order by name.
SELECT last_name, department_id FROM employees WHERE department_id IN (50, 20) ORDER BY last_name ASC;

-- Q12. Display the last name and department number of all the employees in the department number 50 or 20 in ascending alphabetical order by name. (Duplicated question)
SELECT last_name, department_id FROM employees WHERE department_id IN (50, 20) ORDER BY last_name ASC;

-- Q13. HR Department needs a report to display the employee number, last name, salary, and salary increased by 15.5% for each employee for the employees whose name contains W. Also, create a new column which will have the difference between old salary and new salary.
SELECT employee_id, last_name, salary, 
       salary * 1.155 AS "Increased Salary", 
       (salary * 1.155) - salary AS "Salary Difference" 
FROM employees 
WHERE last_name LIKE '%W%';

-- Q14. Write a query that displays the last name (First letter as uppercase and rest of the letters as lowercase) and the length of the last name for all the employees whose last name starts with letters J, A, or M. Sort the output based on the last name in descending order.
SELECT CONCAT(UPPER(SUBSTRING(last_name, 1, 1)), LOWER(SUBSTRING(last_name, 2))) AS "Last Name", LENGTH(last_name) AS "Name Length"
FROM employees 
WHERE last_name LIKE 'J%' OR last_name LIKE 'A%' OR last_name LIKE 'M%' 
ORDER BY last_name DESC;

-- Q15. The HR department wants to find the duration of employment for each employee. For each employee, display the last name and calculate the number of months between today and the date of joining. Label the column as Months Worked. Order the results by the number of months employed. Round the number of months to the closest integer.
SELECT last_name, 
       ROUND(MONTHS_BETWEEN(CURRENT_DATE, hire_date)) AS "Months Worked" 
FROM employees 
ORDER BY "Months Worked" DESC;

-- Q16. Create a report that produces the below output: <Employee Last Name> earns <Salary> monthly but wants <3 times salary>. Label the column as dream salary.
SELECT last_name || ' earns ' || salary || ' monthly but wants ' || (salary * 3) AS "Dream Salary" 
FROM employees;

-- Q17. Create a query to display the last name and salary of all the employees. Format the salary to be 15 characters long, left-padded with the $ symbol. Label the column as Salary.
SELECT last_name, LPAD(salary, 15, '$') AS "Salary" 
FROM employees;

-- Q18. Create a query which will display last name, hire date, probation period as 3 months, and also find the date of the coming Wednesday and name that column as Induction date.
SELECT last_name, hire_date, 
       hire_date + INTERVAL '3' MONTH AS "Probation Period End", 
       NEXT_DAY(hire_date, 'WEDNESDAY') AS "Induction Date" 
FROM employees;

-- Q19. Write a query to display the last name, hire date, and day on which the employee joined.
SELECT last_name, hire_date, 
       TO_CHAR(hire_date, 'Day') AS "Day Joined" 
FROM employees;

-- Q20. Create a query to display the employee’s last name and commission amounts. If an employee does not earn a commission, show the output as “No Commission". Label the column as "Comm".
SELECT last_name, 
       NVL(TO_CHAR(commission_pct), 'No Commission') AS "Comm" 
FROM employees;

-- Q21. Write a query that displays the grade of all the employees based on the value of the job_id column using the below data.
SELECT last_name, job_id, 
       CASE job_id 
            WHEN 'AD_PRES' THEN 'A'
            WHEN 'ST_MAN' THEN 'B'
            WHEN 'IT_PROG' THEN 'C'
            WHEN 'SA_REP' THEN 'D'
            WHEN 'ST_CLERK' THEN 'E'
            ELSE 'O'
       END AS "Grade" 
FROM employees;

-- Q22. Find the highest, lowest, sum, and average salary of all the employees. Label the columns as Maximum, Minimum, Sum, and Average respectively. Round the results to the nearest whole number.
SELECT ROUND(MAX(salary)) AS "Maximum", 
       ROUND(MIN(salary)) AS "Minimum", 
       ROUND(SUM(salary)) AS "Sum", 
       ROUND(AVG(salary)) AS "Average" 
FROM employees;

-- Q23. Find the highest, lowest, sum, and average salary for each job type. Label the columns as Maximum, Minimum, Sum, and Average respectively. Round the results to the nearest whole number.
SELECT job_id, 
       ROUND(MAX(salary)) AS "Maximum", 
       ROUND(MIN(salary)) AS "Minimum", 
       ROUND(SUM(salary)) AS "Sum", 
       ROUND(AVG(salary)) AS "Average" 
FROM employees 
GROUP BY job_id;

-- Q24. Write a query to display the number of people with the same job.
SELECT job_id, COUNT(*) AS "Number of Employees" 
FROM employees 
GROUP BY job_id;

-- Q25. Determine the number of managers in the company without listing them.
SELECT COUNT(DISTINCT manager_id) AS "Number of Managers" 
FROM employees 
WHERE manager_id IS NOT NULL;

-- Q26. Create a report to display the manager number and the salary of the lowest paid employee for that manager. Exclude anyone whose manager is not known. Exclude any groups where the minimum salary is $6000 or less. Sort the output in descending order of the salary.
SELECT manager_id, MIN(salary) AS "Lowest Salary" 
FROM employees 
WHERE manager_id IS NOT NULL 
GROUP BY manager_id 
HAVING MIN(salary) > 6000 
ORDER BY MIN(salary) DESC;

-- Q27. Create a query to display the total number of employees and of that total the number of employees hired in 1995, 1996, 1997, and 1998.
SELECT COUNT(*) AS "Total Employees", 
       SUM(CASE WHEN TO_CHAR(hire_date, 'YYYY') = '1995' THEN 1 ELSE 0 END) AS "Hired in 1995", 
       SUM(CASE WHEN TO_CHAR(hire_date, 'YYYY') = '1996' THEN 1 ELSE 0 END) AS "Hired in 1996", 
       SUM(CASE WHEN TO_CHAR(hire_date, 'YYYY') = '1997' THEN 1 ELSE 0 END) AS "Hired in 1997", 
       SUM(CASE WHEN TO_CHAR(hire_date, 'YYYY') = '1998' THEN 1 ELSE 0 END) AS "Hired in 1998" 
FROM employees;

-- Q28. Create a matrix query to display the job, the salary for that job based on the department number, and the total salary for that job for departments 20, 50, 80, and 90, giving each column an appropriate heading.
SELECT job_id, 
       SUM(CASE WHEN department_id = 20 THEN salary ELSE 0 END) AS "Dept 20 Salary", 
       SUM(CASE WHEN department_id = 50 THEN salary ELSE 0 END) AS "Dept 50 Salary", 
       SUM(CASE WHEN department_id = 80 THEN salary ELSE 0 END) AS "Dept 80 Salary", 
       SUM(CASE WHEN department_id = 90 THEN salary ELSE 0 END) AS "Dept 90 Salary", 
       SUM(salary) AS "Total Salary" 
FROM employees 
WHERE department_id IN (20, 50, 80, 90) 
GROUP BY job_id;

-- Q29. Write a query for the HR department to produce the addresses of all the departments. Use the locations and countries tables. Show the location_id, street_address, city, state or province, and country in the output.
SELECT l.location_id, l.street_address, l.city, l.state_province, c.country_name 
FROM locations l 
JOIN countries c ON l.country_id = c.country_id;

-- Q30. The HR department needs a report of all employees. Write a query to display the last name, department number, and department name for all employees.
SELECT e.last_name, e.department_id, d.department_name 
FROM employees e 
JOIN departments d ON e.department_id = d.department_id;

-- Q31. The HR Department needs a report of employees in Toronto. Display the last name, job, department number, and department name for all employees who work in Toronto.
SELECT e.last_name, e.job_id, e.department_id, d.department_name 
FROM employees e 
JOIN departments d ON e.department_id = d.department_id 
JOIN locations l ON d.location_id = l.location_id 
WHERE l.city = 'Toronto';

-- Q32. Create a report for the HR department that displays employee last names, department numbers, and all the employees who work in the same department as a given employee.
SELECT e1.last_name, e1.department_id, e2.last_name AS "Co-workers" 
FROM employees e1 
JOIN employees e2 ON e1.department_id = e2.department_id 
WHERE e1.employee_id <> e2.employee_id;

-- Q33. The HR department needs a report on job grades and salaries. Use the job grades and employee tables to solve the problem.
SELECT e.last_name, e.salary, j.job_grade 
FROM employees e 
JOIN job_grades j ON e.job_id = j.job_id;

-- Q34. HR department wants to determine the names of all the employees who were hired after Davies. Create a query to display the name and hire date of any employee hired after employee Davies.
SELECT e1.first_name, e1.last_name, e1.hire_date 
FROM employees e1 
JOIN employees e2 ON e2.last_name = 'Davies' 
WHERE e1.hire_date > e2.hire_date;

-- Q35. The HR department needs a query where you pass the employee last name. The query then displays the last name and hire date of any employee in the same department as the employee whose name they supply (excluding that employee). For example, if the user enters Zlotkey, find all employees who work with Zlotkey (excluding Zlotkey).
SELECT e1.last_name, e1.hire_date 
FROM employees e1 
JOIN employees e2 ON e1.department_id = e2.department_id 
WHERE e2.last_name = :last_name 
AND e1.last_name <> e2.last_name;

-- Q36. Create a report that displays the employee number, last name, and salary of all employees who earn more than the average salary. Sort the results in ascending order by salary.
SELECT employee_id, last_name, salary 
FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees) 
ORDER BY salary ASC;

-- Q37. Write a query that displays the employee number and last name of all employees who work in a department with any employee whose last name contains a 'u'.
SELECT e1.employee_id, e1.last_name 
FROM employees e1 
JOIN employees e2 ON e1.department_id = e2.department_id 
WHERE e2.last_name LIKE '%u%';

-- Q38. The HR department needs a report that displays the last name, department number, and job ID of all employees whose department location ID is 1700.
SELECT e.last_name, e.department_id, e.job_id 
FROM employees e 
JOIN departments d ON e.department_id = d.department_id 
JOIN locations l ON d.location_id = l.location_id 
WHERE l.location_id = 1700;

-- Q39. Create a report for the HR department that displays the last name and salary of every employee who reports to King.
SELECT e.last_name, e.salary 
FROM employees e 
JOIN employees m ON e.manager_id = m.employee_id 
WHERE m.last_name = 'King';

-- Q40. Create a report for the HR department that displays the department number, last name, and job ID for every employee in the Executive department.
SELECT e.department_id, e.last_name, e.job_id 
FROM employees e 
JOIN departments d ON e.department_id = d.department_id 
WHERE d.department_name = 'Executive';

-- Q41. Write a query to display the last name, department number, and salary of any employee whose department number and salary both match the department number and salary of any employee who earns a commission.
SELECT e1.last_name, e1.department_id, e1.salary 
FROM employees e1 
JOIN employees e2 ON e1.department_id = e2.department_id 
AND e1.salary = e2.salary 
WHERE e2.commission_pct IS NOT NULL;

-- Q42. Display the last name, department name, and salary of any employee whose salary and commission match the salary and commission of any employee located in location ID 1700.
SELECT e.last_name, d.department_name, e.salary 
FROM employees e 
JOIN departments d ON e.department_id = d.department_id 
JOIN locations l ON d.location_id = l.location_id 
WHERE l.location_id = 1700 
AND e.salary = (SELECT salary FROM employees WHERE location_id = 1700)
AND e.commission_pct = (SELECT commission_pct FROM employees WHERE location_id = 1700);

-- Q43. Create a query to display the last name, hire date, and salary for all employees who have the same salary and commission as Kochhar. Note: Do not display Kochhar in the result set.
SELECT last_name, hire_date, salary 
FROM employees 
WHERE salary = (SELECT salary FROM employees WHERE last_name = 'Kochhar')
AND commission_pct = (SELECT commission_pct FROM employees WHERE last_name = 'Kochhar')
AND last_name <> 'Kochhar';

-- Q44. Create a query to display the employees who earn a salary that is higher than the salary of all the sales managers (JOB_ID = 'SA_MAN'). Sort the results on salary from the highest to the lowest.
SELECT employee_id, last_name, salary 
FROM employees 
WHERE salary > (SELECT MAX(salary) FROM employees WHERE job_id = 'SA_MAN')
ORDER BY salary DESC;

-- Q45. Display the employee ID, last name, and department ID of those employees who live in cities whose name begins with 'T'.
SELECT employee_id, last_name, department_id 
FROM employees 
JOIN departments d ON employees.department_id = d.department_id 
JOIN locations l ON d.location_id = l.location_id 
WHERE l.city LIKE 'T%';

-- Q46. Write a query to find all employees who earn more than the average salary in their departments. Display the last name, salary, department ID, and the average salary for the department. Sort by average salary. Use aliases for the columns retrieved by the query as shown in the sample output.
SELECT e.last_name, e.salary, e.department_id, AVG(e.salary) OVER (PARTITION BY e.department_id) AS "Avg Salary" 
FROM employees e 
WHERE e.salary > (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id)
ORDER BY "Avg Salary";

-- Q47. Write a query to display the last names of the employees who earn less than the average salary in their departments.
SELECT last_name 
FROM employees 
WHERE salary < (SELECT AVG(salary) FROM employees WHERE department_id = employees.department_id);

-- Q48. Write a query to display the last names of the employees who have one or more coworkers in their departments with later hire dates but higher salaries.
SELECT e1.last_name 
FROM employees e1 
WHERE EXISTS (SELECT 1 FROM employees e2 WHERE e1.department_id = e2.department_id AND e1.hire_date < e2.hire_date AND e1.salary < e2.salary);

-- Q49. Write a query to display the department names of those departments whose total salary cost is above one-eighth (1/8) the total salary cost of the whole company. Use the WITH clause to write this query. Name the query SUMMARY.
WITH TotalSalary AS (
    SELECT SUM(salary) AS total_salary FROM employees
), DepartmentSalary AS (
    SELECT department_id, SUM(salary) AS dept_salary FROM employees GROUP BY department_id
)
SELECT d.department_name 
FROM departments d 
JOIN DepartmentSalary ds ON d.department_id = ds.department_id 
JOIN TotalSalary ts ON ds.dept_salary > ts.total_salary / 8;

-- Q50. The HR department needs a list of department IDs for departments that do not contain the job ID 'ST_CLERK'. Use set operators to create this report.
SELECT department_id 
FROM departments 
WHERE department_id NOT IN (SELECT department_id FROM employees WHERE job_id = 'ST_CLERK');

-- Q51. Create a query using regular expressions to search in the employees table. Look for all the employees whose first name is starting with either 'Ne' or 'Na'.
SELECT first_name, last_name 
FROM employees 
WHERE REGEXP_LIKE(first_name, '^Ne|^Na');

