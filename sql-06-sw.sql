use omega;

-- Zad 3
select *
from employees
where pos_id = (select pos_id
				from positions
                where name = 'Specjalista');

-- Zad 4
select *
from employees
where hire_date < (select hire_date
				from employees
				where last_name = 'Niedziejko');


-- zad 5
select *
from products
where price < (select price from products where name = 'Grill GK2011');

#funkcje grupowe w podzapytaniach jednowierszowych                
-- zad 6
select p.*
from products p
join product_categories pc on (p.pc_id = pc.pc_id)
where p.price < (select max(p2.price)
				from products p2
                join product_categories pc2 on (p2.pc_id = pc2.pc_id)
                where pc2.name = 'Czajniki');
-- zad 7
select *
from employees 
where salary + ifnull(allowance, 0) > (select avg(salary + ifnull(allowance, 0)) 
										from employees e join positions p on (e.pos_id = p.pos_id) 
                                        where p.name = 'Starszy specjalista');
                                        
-- zad 8
select *
from products
where price = (select min(price)
				from products);

-- zad 9
select pos_id, avg(salary)
from employees 
group by pos_id
having avg(salary) > (select avg(salary) 
						from employees where dep_id = 50) 
		and avg(salary) < (select avg(salary) 
						from employees where dep_id = 10)
order by pos_id;

# podzapytania wielowierszowe FROM/CTE
-- zad 10
with stazpracy as (
	select e.emp_id, e.pos_id,
	year(current_date)- year(e.hire_date) as staz_pracy
    from employees e)
 
select p.pos_id, round (avg(staz_pracy),2), min(staz_pracy), max(staz_pracy)
from positions p
join stazpracy e on (e.pos_id = p.pos_id)
group by p.pos_id
order by p.pos_id;
select * from products;
select * from product_categories order by name;

-- zad 11
select e.emp_id, e.first_name, e.last_name, dep_stat.name, pos_stat.name, jg_stat.name, e.salary, dep_stat.dep_avg, pos_stat.pos_avg, jg_stat.jg_avg,
concat(if (e.salary > dep_stat.dep_avg, '↑', if(e.salary = dep_stat.dep_avg, '-', '↓')), if (e.salary > pos_stat.pos_avg, '↑', if(e.salary = pos_stat.pos_avg, '-', '↓')), if (e.salary > jg_stat.jg_avg, '↑', if(e.salary = jg_stat.jg_avg, '-', '↓'))) as 'emp salary vs. avg salary(dep, pos, jg)'
from employees e join (select d.dep_id, d.name, avg(salary) 'dep_avg'
		from employees e join departments d on (e.dep_id = d.dep_id)
		group by d.dep_id) dep_stat on (e.dep_id = dep_stat.dep_id)
        join (select p.pos_id, p.name, avg(salary) 'pos_avg'
			from employees e join positions p on (e.pos_id = p.pos_id)
			group by p.pos_id) pos_stat on (e.pos_id = pos_stat.pos_id)
		join (select jg.jg_id, jg.name, avg(salary) 'jg_avg'
			from employees e join job_grades jg on (e.jg_id = jg.jg_id)
			group by jg.jg_id) jg_stat on (e.jg_id = jg_stat.jg_id);
            
                    
#podzapytania wielowierszowe w klauzuli where i having
-- zad 12
select *
from employees e
where e.emp_id in (select e2.emp_id
				from employees e2
                join positions p2 on (e2.pos_id = p2.pos_id)
                where p2.name like '%starszy%');
                    
-- zad 13
select *
from employees
where dep_id =ANY (select dep_id
					from departments
                    where location <> 'Pokój 21' and location <> 'Pokój 205');
                    
-- zad 14
select *
from employees e
join positions p on (p.pos_id = e.pos_id)
where p.name = 'Specjalista'
and e.birth_date < (select min(e2.birth_date) #1968-10-29 birth date, 1997-05-15 hire_date
				from employees e2
                join positions p2 on (p2.pos_id = e2.pos_id)
                where p2.name = 'Kierownik');
					
-- zad 15
select proj_id, name
from projects 
where proj_id in (select proj_id
					from project_participants
                    group by proj_id
                    having count(emp_id) = 3);
                    
-- zad 16
WITH Staz AS (
    SELECT
        p.name AS nazwa_stanowiska,
        AVG(YEAR(CURRENT_DATE()) - YEAR(e.hire_date)) AS avg_staz,
        AVG(e.salary) AS avg_pensja,
        COUNT(e.emp_id) AS licz_pracownikow
    FROM employees e
    JOIN positions p ON e.pos_id = p.pos_id
    GROUP BY p.name
    ORDER BY avg_staz DESC
)

SELECT
    s.nazwa_stanowiska,
    ROUND(s.avg_staz) AS avg_staz, 
    ROUND(s.avg_pensja, 2) AS avg_pensja,
    s.licz_pracownikow,
    GROUP_CONCAT(CONCAT(e.first_name, ' ', e.last_name) 
    ORDER BY e.last_name, e.first_name) AS lista_pracownikow
FROM Staz s
JOIN employees e ON e.pos_id = (SELECT p.pos_id 
								FROM positions p 
                                WHERE p.name = s.nazwa_stanowiska)
WHERE s.avg_staz = (SELECT MAX(avg_staz) 
					FROM Staz)
GROUP BY s.nazwa_stanowiska, s.avg_staz, s.avg_pensja, s.licz_pracownikow;

-- zad 17 
select *
from employees e join project_participants pp on (e.emp_id = pp.emp_id) 
join projects p on (p.proj_id = pp.proj_id)
where (e.pos_id, p.proj_id) = (select e.pos_id, p.proj_id, year(hire_date) = 2000);

SELECT DISTINCT e.*
FROM employees e
JOIN positions p ON e.pos_id = p.pos_id
JOIN project_participants pp ON e.emp_id = pp.emp_id
JOIN projects pr ON pp.proj_id = pr.proj_id
WHERE year(e.hire_date) = 2000
AND (p.pos_id, pr.proj_id) IN (
    SELECT p.pos_id, pr.proj_id
    FROM employees e2
    JOIN positions p2 ON e2.pos_id = p2.pos_id
    JOIN project_participants pp2 ON e2.emp_id = pp2.emp_id
    JOIN projects pr2 ON pp2.proj_id = pr2.proj_id
    WHERE year(e2.hire_date) != 2000
);


                        
                    



