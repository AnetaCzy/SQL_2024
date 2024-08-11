-- Zadania do samodzielnego wykonania
use omega;

-- zad 3
select emp_id, first_name, last_name, dep_id
from employees;

-- zad 4
select *, max_salary-min_salary as widełki
from job_grades;

-- zad 5
select *
from employees
where jg_id='5';

-- zad 6
select *
from employees
where first_name='Jerzy';

-- zad 7 
select *
from employees
where manager_id = 100;

-- zad 8
select *
from employees
where salary <= 5000;

-- zad 9
select *
from employees
where hire_date > '2003-07-01' and dep_id=30;

-- zad 10
select *
from employees
where hire_date between '1999-02-01' and '2001-08-31';

-- zad 11
select * 
from employees
where hire_date between '2000-01-01' and '2002-12-31';

-- zad 12
select *
from employees
where first_name like '_a%';
-- '_a%' druga litera to a 

-- zad 13
select *
from employees
where hire_date not between '1999-01-01' and '2015-12-31' OR (last_name like '__o%' OR last_name like '___%r%');

-- zad 14
select *, max_salary-min_salary as 'różnica'
from job_grades
where max_salary-min_salary between 1500 and 3000;

-- zad 15
select *
from employees
order by jg_id;

-- zad 16
select *
from employees
order by dep_id desc;

-- zad 17
select *
from employees
order by jg_id, salary desc;

-- zad 18
SELECT last_name, hire_date
FROM employees
WHERE YEAR(hire_date) BETWEEN 2010 AND 2015
ORDER BY hire_date;

-- zad 19
select *
from employees
where pos_id in (3,4,6)
order by pos_id;

-- zad 20;
select *
from employees
where dep_id not in (30,40) and pos_id not in (1,9);

-- zad 21
select*
from employees
where manager_id is null;

-- zad 22
select *
from employees
where dep_id is not null and allowance is null;

-- zad 23
select *
from employees
where jg_id in (2,5,9) and allowance is null;

-- zad 24
select distinct first_name
from employees
order by first_name;

-- zad 25
select distinct salary
from employees 
order by salary desc;

-- zad 26
select emp_id, first_name, last_name, hire_date
from employees
order by hire_date asc
limit 1;

-- zad 27
select emp_id, first_name, last_name, salary
from employees
order by salary desc
limit 1;

-- zad 28
select emp_id, first_name, last_name, hire_date
from employees
order by hire_date desc
limit 1;

-- zad 29
select name
from positions
order by seq asc
limit 3;

-- zad 30
select name
from job_grades
order by max_salary-min_salary asc
limit 1;
