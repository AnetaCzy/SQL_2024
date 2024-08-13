use omega;

-- zad 3 
select e.emp_id, concat(e.first_name, ' ',last_name), p.name
from employees e
join project_participants pp on (e.emp_id = pp.emp_id)
join projects p on (p.proj_id = pp.proj_id)
where p.name = 'Wdrożenie modułu FK';

-- zad 4
select distinct(pr.name)
from employees e
join positions p on (e.pos_id = p.pos_id and p.name = 'Specjalista')
join project_participants pp on (e.emp_id = pp.emp_id)
join projects pr on (pr.proj_id= pp.proj_id)
where e.salary >4200;

-- zad 5 
select distinct d.name
from departments d
join employees e on (e.dep_id = d.dep_id)
join project_participants pp on (pp.emp_id = e.emp_id)
join projects pr on (pp.proj_id =  pr.proj_id)
where month(pr.start_date) = 3
order by d.name;

-- zad 6 
select d.name
from departments d
join dep_eq dq on (d.dep_id = dq.dep_id)
join equipment eq on (eq.eq_id = dq.eq_id and eq.name = 'smartfon')
order by d.name;

-- zad 7 --> żle zlicza
SELECT  d.name, eq.name , count(*)
FROM employees e
RIGHT JOIN departments d ON e.dep_id = d.dep_id
JOIN positions p ON p.pos_id = e.pos_id
JOIN dep_eq dq ON d.dep_id = dq.dep_id
JOIN equipment eq ON eq.eq_id = dq.eq_id
WHERE p.name = 'Ekspert'
GROUP BY d.name, eq.name;

-- zad 8 --> zapytać o ten głupi warunek w złączeniu
SELECT p.name AS position_name, COUNT(e.emp_id) AS employee_count
FROM positions p
LEFT JOIN employees e ON e.pos_id = p.pos_id
LEFT JOIN departments d ON e.dep_id = d.dep_id
-- LEFT JOIN departments d ON e.dep_id = d.dep_id and d.name = 'Sprzedaż'
where d.name = 'Sprzedaż'
GROUP BY p.name
ORDER BY COUNT(e.emp_id);

-- zad 9
SELECT e.gender AS płeć,
COUNT(*) AS 'liczba pracowników',
MIN(e.salary) AS 'min pensja',
MAX(e.salary) AS 'max pensja'
FROM employees e
JOIN departments d ON d.dep_id = e.dep_id
JOIN job_grades jg ON jg.jg_id = e.jg_id
WHERE d.name = 'Marketing'
GROUP BY e.gender;

-- zad 10 
select d.name, count(*), count(if(e.allowance!=0, true, null)) as 'Liczba pracowników z dodatkami'
from employees e
join positions p on (e.pos_id = p.pos_id)
join departments d on (e.dep_id = d.dep_id)
where p.name = 'Specjalista' or p.name = 'Starszy specjalista'
group by d.name;

-- zad 11
select p.name, year(e.hire_date), round(avg(e.salary),2), count(emp_id) as 'liczba pracowników na danym stanowisku'
from employees e
join positions p on (e.pos_id = p.pos_id)
group by p.name, year(e.hire_date)
order by p.name, year(e.hire_date);

-- zad 12
select emp_id, e.first_name, e.last_name
from employees e 
join customers c on (c.account_manager_id = e.emp_id)
group by emp_id
having count(c.account_manager_id)=3;

-- zad 13
select pr.name, count(pp.emp_id)
from employees e
join project_participants pp on (e.emp_id = pp.emp_id)
join projects pr on (pp.proj_id = pr.proj_id)
group by pr.name
having count(pp.emp_id) >=5;

-- zad 14
-- Nazwy urządzeń, w więcej niż 2 działach
select eq.name, count(distinct d.dep_id) 
from equipment eq
join dep_eq dep_eq on (eq.eq_id = dep_eq.eq_id)
join departments d on (d.dep_id = dep_eq.dep_id)
group by eq.name
having count(distinct d.dep_id) >2;


-- zad 15
select e.emp_id, e.first_name, e.last_name, count(c.cust_id) as 'liczba klientów pod opieką',
group_concat(c.name separator ', ') as 'lista klientów pod opieką'
from employees e
join customers c on (e.emp_id = c.account_manager_id)
group by e.emp_id, e.first_name , e.last_name
order by emp_id;
select* from product_categories;

-- zad 16 #tutaj sortownie nie działa
select jg.jg_id, jg.name, 
group_concat(
	concat(e.last_name, ' (', 
    case 
    when d.name is not null then d.name 
    else '---' 
    end,
    ')') separator' - ') as 'lista pracowników'
from employees e
left outer join job_grades jg on (jg.jg_id = e.jg_id)
left outer join departments d on (d.dep_id = e.dep_id)
group by jg.jg_id, jg.name
order by jg_id, d.name, e.last_name;

#funkcja COALESCE -->  funkcja COALESCE pomaga w obsłudze sytuacji, w których chcemy zwrócić pierwszą 
#niepustą wartość spośród wielu opcji. W tym konkretnym przypadku jest używana do dostarczenia domyślnej 
# wartości '---', gdy nazwa działu (d.name) jest NULL.
SELECT
  jg.jg_id,
  jg.name,
  GROUP_CONCAT(CONCAT(e.first_name, ' (', COALESCE(d.name, '---'), ')') SEPARATOR ', ') AS employee_info
FROM
  employees e
LEFT OUTER JOIN
  job_grades jg ON jg.jg_id = e.jg_id
LEFT OUTER JOIN
  departments d ON d.dep_id = e.dep_id
GROUP BY
  jg.jg_id, jg.name;

-- zad 17
select p.*
from projects p
except
select p.*
from projects p
join project_participants pp on (p.proj_id = pp.proj_id)
join employees e on (pp.emp_id = e.emp_id)
join departments d on (e.dep_id = d.dep_id)
where d.name = 'Sprzedaż';

-- zad 18
select concat(e.last_name, ', ', e.first_name) as "Nazwisko i imię pracownika",
case
	when pp.proj_id is not null then 'Projekty'
    when c.cust_id is not null then 'Obsługa klienta'
#    else 'Brak zaangażowania'
end as "Rodzaj zaangażowania",
case
    when pp.proj_id is not null then GROUP_CONCAT(p.name separator ', ')
    when c.cust_id is not null then GROUP_CONCAT(c.name separator ', ')
#    else 'Brak zaangażowania'
end as "Szczegóły zaangażowania"
from employees e
left join project_participants pp on e.emp_id = pp.emp_id
left join projects p on pp.proj_id = p.proj_id
left join customers c on e.emp_id = c.account_manager_id
group by e.emp_id, e.last_name, e.first_name
order  by e.last_name;

-- zad 19
select d.name as 'Nazwa działu'
from departments d
join employees e on d.dep_id = e.dep_id
join dep_eq deq on d.dep_id = deq.dep_id
join equipment eq on deq.eq_id = eq.eq_id
group by d.name
having count(distinct e.emp_id) in (3,10) and count(distinct eq.eq_id)=5;
