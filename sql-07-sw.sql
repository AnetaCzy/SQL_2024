use omega;

-- zad 3
select *
from employees e
where salary > (select avg(e2.salary)
				from employees e2
                where e2.pos_id = e.pos_id)
order by pos_id;

-- zad 4
select *
from employees e
where salary = (select min(salary)
				from employees e2
                where e.jg_id = e2.jg_id)
order by jg_id;

-- zad 5
select * 
from employees e
where salary >= (select salary * 1.2
				from employees e2
                where e.manager_id = e2.emp_id);
                
-- zad 6
select *
from employees e
where allowance is not null 
and (salary+ifnull(allowance,0)) < (select salary 
									from employees e2
                                    where e.manager_id = e2.emp_id);
                                    
-- zad 7 --> błąd w odpowiedziach
select *
from employees e
where hire_date = (select min(hire_date)
					from employees e2
                    where e.pos_id = e2.pos_id)
order by pos_id;

-- zad 8
select *
from employees e
where ifnull(allowance,0) = (select max(ifnull(allowance,0))
					from employees e2
                    where e.dep_id = e2.dep_id)
order by dep_id;

-- zad 9
select e.pos_id, p.name
from employees e
join positions p on e.pos_id = p.pos_id
where e.pos_id in (select e2.pos_id
				from employees e2
                group by e2.pos_id
                having count(e2.pos_id) = 4)
group by e.pos_id;

-- zad 10 
select d.name, e.first_name, e.last_name, e.hire_date
from employees e
join departments d on (e.dep_id = d.dep_id) 
where e.hire_date = (select min(e2.hire_date)
					from employees e2
                    where e.dep_id = e2.dep_id);
                    
-- zad 11
select p.name, e.first_name, e.last_name, e.salary
from employees e
join positions p on (e.pos_id = p.pos_id) 
where e.salary = (select max(e2.salary)
					from employees e2
                    where e.pos_id = e2.pos_id)
order by p.seq;

-- zad 12
select e.last_name, (select p.name
					from positions p
                    where p.pos_id = e.pos_id)
from employees e
order by e.last_name;

-- zad 13
select d.dep_id, d.name, (select count(*)
				from employees e
                where d.dep_id = e.dep_id)
from departments d
order by d.dep_id;

-- zad 14
select *
from employees e
where exists (select 1
				from customers c
                where c.account_manager_id = e.emp_id);
                
-- zad 15
select jg.jg_id, jg.name
from job_grades jg
where exists( select 1
			from employees e
            join positions p on e.pos_id = p.pos_id
            where e.jg_id = jg.jg_id and p.name = 'Specjalista');

-- zad 16
select jg.jg_id, jg.name
from job_grades jg
where not exists( select 1
			from employees e
            where jg.jg_id = e.jg_id);

