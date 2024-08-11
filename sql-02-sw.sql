use omega;
-- Zadania SQL 2, funkcje jednowierszowe do samodzielnego wykonania

-- zad 3
select pos_id, last_name, reverse(last_name)
from employees
where pos_id=4;

-- zad 4
select *
from positions
where name like 'S%';

select * 
from positions
WHERE LEFT(name, 1) = 'S';

-- zad 5
select CONCAT(name, ', ', location) AS 'Opis Działu'
FROM departments;

-- zad 6
SELECT *, SUBSTR(location, 7) as pokój 
FROM departments;

-- zad 7
select first_name, last_name, Concat(left(first_name,1), '.',left(last_name,1)) as inicjały
from employees;

-- zad 8
select emp_id, first_name, last_name, ifnull(manager_id,'---')
from employees
where dep_id = 10;

-- zad 9
select emp_id, ifnull(dep_id,'---'), first_name, last_name, salary, allowance, ifnull(salary+allowance, '---') as 'całkowita wypłata'
from employees
where salary+allowance < 4000;

-- zad 10
select emp_id, first_name, last_name, (salary+ifnull(allowance,0))*1.2
from employees
where dep_id = 20;

-- zad 11
SELECT emp_id, first_name, last_name, salary, IFNULL(allowance, 0) AS allowance,
  IF((salary + IFNULL(allowance, 0)) > 6156.25, ';)', ':(') AS status
FROM employees;

-- zad 12
SELECT emp_id, first_name, last_name, pos_id, salary,
CASE
    WHEN pos_id = 1 OR pos_id = 2 THEN 0
    WHEN salary > 7000 THEN 1000
    WHEN salary BETWEEN 4000 AND 7000 THEN 2000
    WHEN salary < 4000 THEN 3000
    ELSE NULL
END AS "wczasy pod gruszą"
FROM employees;

-- zad 13
select *
from employees
where year(hire_date) =2001;

-- zad 14
select emp_id, first_name, last_name, hire_date
from employees
where month(hire_date) between 05 and 08;

-- zad 15 
SELECT emp_id, first_name, last_name, hire_date,
	DATEDIFF(
	  LAST_DAY(hire_date) + INTERVAL 1 DAY,
	  hire_date
	) AS days_in_first_month
FROM employees
ORDER BY emp_id;
-- DATEDIFF do obliczenia różnicy w dniach między dwiema datami. Ostateczny wynik funkcji 
-- DATEDIFF to liczba dni między pierwszym dniem drugiego miesiąca a datą zatrudnienia pracownik


-- zad 16
select emp_id, first_name, last_name, hire_date, timestampdiff(year, hire_date, curdate()), allowance
from employees
where allowance is null;

-- zad 17
SELECT emp_id, first_name, last_name, hire_date, DATE_ADD(hire_date, INTERVAL 25 YEAR) as jubileusz
FROM employees
WHERE DATE_ADD(hire_date, INTERVAL 25 YEAR) BETWEEN NOW() AND DATE_ADD(NOW(), INTERVAL 2 YEAR);

-- zad 18
select emp_id, first_name, last_name, hire_date, year(now())-year(hire_date) as wiek
from employees
where (year(now())-year(birth_date))%2=0;

-- zad 19
SELECT emp_id, first_name, last_name, hire_date, YEAR(NOW()) - YEAR(birth_date) AS age
FROM employees
WHERE YEAR(NOW()) - YEAR(birth_date) BETWEEN 25 AND 30;

-- zad 20
-- wiek emerytalny K-60, M-65
SELECT emp_id, first_name, last_name, birth_date, gender, 
	CASE
		WHEN gender = 'K' then date_add(birth_date, interval 60 year)
		else date_add(birth_date, interval 60 year)
	END as emerytura    
FROM employees;
-- add_date służący do dodawania określonego przedziału czasowego do daty

-- zad 21
SELECT emp_id, first_name, last_name, hire_date, birth_date, gender,
    CASE
        WHEN gender = 'K' THEN -1 * TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) + 60
        ELSE -1 * TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) + 65
    END AS 'liczba lat do emerytury'
FROM employees;
-- TIMESTAMPDIFF(unit, start_date, end_date) 
-- unit: Określa jednostkę czasu, w której chcemy obliczyć różnicę. 
-- Przykładowe jednostki to 'SECOND', 'MINUTE', 'HOUR', 'DAY', 'WEEK', 'MONTH' i 'YEAR'.
-- start_date: Data początkowa.
-- end_date: Data końcowa.
