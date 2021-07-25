--Create retirment titles table
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
	USING(emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;	

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) 
	emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- Create unique titles table
SELECT COUNT(emp_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

--Create mentorship eligibility table
SELECT DISTINCT ON (emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees AS e
INNER JOIN dept_emp AS de
	USING(emp_no)
INNER JOIN titles AS t
	USING(emp_no)
WHERE de.to_date = ('9999-01-01')
	AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY emp_no;

/*New Queries*/
/* Updated with hire_date and current employees*/
SELECT DISTINCT ON (e.emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	t.title
INTO unique_titles_UPD	
FROM employees AS e
INNER JOIN titles AS t
	USING(emp_no)
INNER JOIN dept_emp AS de
	USING(emp_no) 
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
	 AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	 AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

SELECT COUNT(emp_no), title
INTO retiring_titles_UPD
FROM unique_titles_UPD
GROUP BY title
ORDER BY count DESC;

--Create updated mentorship eligibility table
SELECT DISTINCT ON (emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibilty_UPD
FROM employees AS e
INNER JOIN dept_emp AS de
	USING(emp_no)
INNER JOIN titles AS t
	USING(emp_no)
WHERE de.to_date = ('9999-01-01')
	AND e.birth_date BETWEEN '1964-01-01' AND '1965-12-31'
ORDER BY emp_no;

SELECT *
FROM retiring_titles_UPD;
