
--Title histories for eligible retirees (contains duplicate rows)
SELECT e.emp_no,
	e.first_name,
	e.last_name,
		t.title,
		t.from_date,
		t.to_date
INTO retirement_titles
FROM titles as t
LEFT JOIN employees as e
ON (t.emp_no = e.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM retirement_titles;


-- Use Dictinct with Orderby to remove duplicate rows (eligible retirees)
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
 rt.first_name,
 rt.last_name,
 rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE (rt.to_date = '9999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC;

SELECT * FROM unique_titles;

-- Retiring employee count by title name
SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;

SELECT * FROM retiring_titles;


--Mentorship eligibility for current employees born between 1965-01-01 and 1965-12-31.
SELECT DISTINCT ON (e.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
LEFT JOIN titles AS t
ON (t.emp_no = e.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31');

SELECT * FROM mentorship_eligibility;


--Title histories for eligible retainees (contains duplicate rows)
SELECT e.emp_no,
	e.first_name,
	e.last_name,
		t.title,
		t.from_date,
		t.to_date
INTO retainment_titles
FROM titles as t
LEFT JOIN employees as e
ON (t.emp_no = e.emp_no)
WHERE (e.birth_date BETWEEN '1956-01-01' AND '1979-12-31')
ORDER BY e.emp_no;

SELECT * FROM retainment_titles;

-- Use Dictinct with Orderby to remove duplicate rows (eligible retainees)
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
 rt.first_name,
 rt.last_name,
 rt.title
INTO unique_titles_retainees
FROM retainment_titles as rt
WHERE (rt.to_date = '9999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC;

SELECT * FROM unique_titles_retainees;

-- Retaining employee count by title name
SELECT COUNT(ut.title), ut.title
INTO retaining_titles
FROM unique_titles_retainees as ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;

SELECT * FROM retaining_titles;