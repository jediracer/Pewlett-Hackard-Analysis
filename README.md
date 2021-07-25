# Pewlett-Hackard-Analysis

## Project Overview
- Create a PostgreSQL database and populate the database with data from six csv files.  
- Using the newly created database:
    - Use SQL queries to create subsets of data and save them to new tables.
    - Export new tables to csv files.
    - Create lists of employees who will soon be retiring.
    - Create a list of potential employees to participate in the mentorship program.

## Resources
- Data Sources: 
    - departments.csv
    - dept_emp.csv
    - dept_manager.csv
    - employees.csv
    - salaries.csv
    - titles.csv
- Software: PostgreSQL 13, pgAdmin4 v5.2

## Results
- Number of Retiring Employees
    - 77,598 potential employees will soon be retiring based date of birth.
    - More than 32% of the current workforce will be retiring based on birth date.
    - Based on the results in retiring_titles, 74% of the retirees will be from Senior level positions, based on birth date.
    - Retiring Titles:
    
    ![Retiring Titles](https://github.com/jediracer/Pewlett-Hackard-Analysis/blob/main/images/retiring_titles.png)
- Employees Eligible for the Mentorship Program
    - Based on the eligibility requirements for the mentorship program, there are 1,549 possible mentors.

## Summary
 - To determine a more accurate number of potential retirees, I would adjust the queries to filter on hire_date and current employees.
    ```/* Updated with hire_date and current employees*/
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
    ```
    - Based on the adjusted parameters 72,458 positions will need to be filled.
    - Retiring Titles (updated):
    
    ![Retiring Titles (updated)](https://github.com/jediracer/Pewlett-Hackard-Analysis/blob/main/images/retiring_titles_upd.png)
 - I do not believe there are enough employees eligible for the mentorship program, with only 1,549 eligible.
    - I would adjust the mentorship eligibility birth year range to include 1964 to greatly increase the number of potential mentors to 19,905.
    ```
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
    ```