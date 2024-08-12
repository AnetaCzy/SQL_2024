use omega;

-- Zadania do samodzielnego wykonania 3
-- zad 3
select jg_id,avg(salary), min(salary), max(salary)
from employees
group by jg_id
order by jg_id;

-- zad 4
select dep_id, avg(salary), max(salary), min(salary)
from employees
where dep_id in (10,30,50)
group by dep_id
order by dep_id;

-- zad 5
select pos_id, avg(salary), min(timestampdiff(YEAR, hire_date, now())) -- czas w latach od daty zatrudnienia do dzisiaj
from employees
where dep_id =30
group by pos_id
order by pos_id;

-- zad 6
select max(salary), min(salary), max(salary)-min(salary) as 'różnica'
from employees
where Year(hire_date) = 2001;

-- zad 7
select pos_id, min(salary), max(salary)
from employees
where pos_id in (3,4,5);

-- zad 8
select sum(salary+ifnull(allowance,0))
from employees;

-- zad 9
select min(hire_date)
from employees;

-- zad 10 
select count(distinct(cust_id))
from customers;

-- zad 11
select jg_id, count(*)
from employees
group by jg_id;

-- select 12
select year(hire_date), count(distinct(emp_id))
from employees
group by year(hire_date);

-- zad 13 
select pos_id, 
count(*) as 'liczba pracowników',
count(CASE WHEN allowance IS NOT NULL THEN 1 END) as 'allowance not null'
from employees
group by pos_id;

-- zad 14
select length(last_name) as 'liczba liter w nazwisku',
count(emp_id),
avg(salary)
from employees
group by length(last_name)
order by length(last_name);

-- zad 15
select count(*)
from employees
where allowance is not null;

-- zad 16
select dep_id, count(distinct(jg_id))
from employees
group by dep_id;

-- zad 17
select pos_id, count(distinct(jg_id))
from employees
where pos_id <=4
group by pos_id;

-- zad 18
select jg_id, dep_id, count(distinct(emp_id)), avg(salary)
from employees
group by jg_id, dep_id
order by jg_id, dep_id;

-- zad 19
select
	case
		when salary<4000 then 'grupa A'
        when salary between 4000 and 8000 then 'grupa B'
        when salary > 8000 then 'grupa C'
	end as salary_group,
    count(distinct(emp_id))
from employees
group by salary_group
order by salary_group;

-- zad 20
select manager_id, round(avg(salary),2)
from employees
group by manager_id
having count(manager_id) > 5;

-- zad 21
select dep_id, count(emp_id), min(year(hire_date))
from employees
where pos_id in (2,4,9)
group by dep_id
having min(year(hire_date)) <1999;

-- zad 22
select pos_id, count(*), min(salary), max(salary)
from employees
WHERE (allowance IS NULL OR allowance = 0 OR allowance < 1000)
group by pos_id
having sum(salary+ifnull(allowance,0)) <20000;

-- zad 23
select dep_id, 
	count(*) as 'liczba pracowników', 
    count(case
			when salary>6000 then emp_id end) as 'Liczba pracowników z pensją > 6000'
from employees
group by dep_id;

-- zad 24
SELECT
    FLOOR(YEAR(hire_date) / 10) * 10 AS start_of_the_decate,
    COUNT(*) AS 'liczba pracwoników'
FROM employees
GROUP BY FLOOR(YEAR(hire_date) / 10)
ORDER BY start_of_the_decate;
