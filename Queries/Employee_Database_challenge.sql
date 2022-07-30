-- Retrieve the emp_no, first_name, and last_name columns from the Employees table.
SELECT e.emp_no, e.first_name, e.last_name
FROM employees AS e;

-- Retrieve the title, from_date, and to_date columns from the Titles table.
SELECT t.title, t.from_date, t.to_date
FROM Titles AS t

-- Create a new table using the INTO clause.
-- Join both tables on the primary key.
-- Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. Then, order by the employee number.
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date

FROM employees AS e
JOIN titles AS t
ON (t.emp_no = e.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM retirement_titles;

-- Export the Retirement Titles table.
COPY public."retirement_titles" TO 'C:\Users\Public\retirement_titles.CSV' DELIMITER ',' CSV HEADER;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (r.emp_no) r.emp_no,
r.first_name,
r.last_name,
r.title

INTO unique_titles
FROM retirement_titles AS r
WHERE (to_date = '9999-01-01')
ORDER BY emp_no ASC, to_date DESC;

SELECT * FROM unique_titles;

-- Export the Retirement Titles table.
COPY public."unique_titles" TO 'C:\Users\Public\unique_titles.CSV' DELIMITER ',' CSV HEADER;

-- Retrieve the number of employees by their most recent job title who are about to retire.
SELECT COUNT(u.emp_no), u.title
INTO retiring_titles
FROM unique_titles as u
GROUP BY u.title
ORDER BY u.count DESC;

SELECT * FROM retiring_titles;

-- Export the Retirement Titles table.
COPY public."retiring_titles" TO 'C:\Users\Public\retiring_titles.CSV' DELIMITER ',' CSV HEADER;

-- write a query to create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program.
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO mentorship_eligibilty
FROM employees as e
JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
JOIN titles as t
ON (t.emp_no = e.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no ASC;

SELECT * FROM mentorship_eligibilty

-- Export the Mentorship Eligibility table
COPY public."mentorship_eligibilty" TO 'C:\Users\Public\mentorship_eligibilty.CSV' DELIMITER ',' CSV HEADER;

