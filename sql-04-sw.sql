use omega;
-- Zad 3
select e.emp_id, e.first_name, e.last_name, d.name
from employees e join departments d on (e.dep_id = d.dep_id)
order by d.name, e.last_name;

-- zad 4
### Skąd w tym zapytaniu tworzą się duplikaty??? --> zapytać na zajęciach
select e.emp_id, e.first_name, e.last_name, p.name, e.salary
from employees e join positions p on (e.pos_id = p.pos_id and p.name= 'Specjalista' or p.name = 'Ekspert' or p.name = 'Kierownik')
order by p.name asc, e.salary;

select e.emp_id, e.first_name, e.last_name, p.name, e.salary
from employees e join positions p on (e.pos_id = p.pos_id)
where p.name= 'Specjalista' or p.name = 'Ekspert' or p.name = 'Kierownik'
order by p.name asc, e.salary; # to zapytanie jest ok

-- zad 5
select e.emp_id, e.first_name, e.last_name, p.name, e.salary, e.allowance, d.name
from employees e 
join positions p on (e.pos_id = p.pos_id)
join departments d on (e.dep_id = d.dep_id)
where e.salary > 5000 and ifnull(e.allowance,0)!=0
order by e.salary desc; 

-- zad 6
select e.emp_id, e.first_name, e.last_name, e.salary, p.name, d.name, jg.name
from employees e
join  positions p on (e.pos_id = p.pos_id)
join departments d on (e.dep_id = d.dep_id)
join job_grades jg on (e.jg_id = jg.jg_id)
where (year(hire_date) = 1999 or year(hire_date)=2001) and ifnull(e.allowance,0)=0;

-- zad 7
# SUBSTRING_INDEX(location, ' ', -1) pobiera ostatnie słowo z kolumny location, 
# a następnie funkcja TRIM usuwa ewentualne białe znaki z początku i końca uzyskanego numeru pokoju.

select e.emp_id, e.first_name, e.last_name, d.name, d.location, TRIM(SUBSTRING_INDEX(location, ' ', -1)) AS room_number
from employees e
join departments d on (e.dep_id=d.dep_id)
where  TRIM(SUBSTRING_INDEX(location, ' ', -1))> 200;

-- zad 8 #LIKE
select e.emp_id, e.first_name, e.last_name, d.name, jg.name
from employees e
join departments d on (e.dep_id = d.dep_id)
join job_grades jg on (e.jg_id = jg.jg_id)
join positions p on (e.pos_id = p.pos_id)
where p.name like '%starszy%'
order by e.emp_id;

-- zad 9 
select p.name, e.first_name, e.last_name
from positions p
left outer join employees e on (p.pos_id = e.pos_id)
order by p.seq, e.last_name;

-- zad 10
select jg.name, e.first_name, e.last_name
from job_grades jg
left outer join employees e on (jg.jg_id =e.jg_id)
order by jg.jg_id, e.last_name;

-- zad 11
#SAMOZŁĄCZENIE (Self-Join) 
select e.emp_id, e.first_name, e.last_name, e.hire_date as 'data zatrudnienia pracownika' , m.hire_date as 'data zartudnienia szefa danego pracownika'
from employees e
join employees m on (e.manager_id = m.emp_id) # gdzie id menagera pracownika = przypisanemu id pracownika
where e.hire_date<m.hire_date;

-- zad 12
select e.emp_id, e.first_name, e.last_name, m.emp_id as 'id szef', m.first_name 'szef name', 
m.last_name 'szef nazwisko', e.dep_id 'dział pracownika', m.dep_id 'dział szefa', d.name as 'nazwa działu pracownika', md.name as 'nazwa działu szefa'
from employees e
join employees m on (e.manager_id = m.emp_id)
join departments d on e.dep_id = d.dep_id #nazwa działu pracownika
join departments md on m.dep_id = md.dep_id #nazwa działu managera
where e.dep_id != m.dep_id
order by e.emp_id;

-- zad 13
select e.*
from employees e
left join customers c on (e.emp_id = c.account_manager_id)
join departments d on (e.dep_id = d.dep_id)
where e.emp_id != c.account_manager_id or c.account_manager_id is null and d.name='Sprzedaż';

-- zad 14 
#SELECT e.emp_id, e.first_name, e.last_name, e.salary, e.jg_id, '---', jg.name, '---', 
#e2.salary,'---', jg2.emp_id, jg2.name
#FROM employees e
#left JOIN employees e2 ON (e.emp_id = e2.emp_id)
#JOIN job_grades jg ON (e.jg_id = jg.jg_id)
#JOIN job_grades jg2 ON (e2.jg_id = jg2.jg_id);

select e.emp_id, e.first_name, e.last_name, e.salary, jg.name, e.salary * 1.13 as 'pensja po podwyżce', jg2.name
from employees e
join job_grades jg on e.jg_id = jg.jg_id
join job_grades jg2 on (e.salary * 1.13 between jg2.min_salary and jg2.max_salary)
where e.salary * 1.13 not between jg.min_salary and jg.max_salary
order by e.emp_id;
