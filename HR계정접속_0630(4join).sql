select * from employees;
select * from departments;
select * from job_history;
select * from locations;

select * 
from employees e, departments d, job_history j, locations l
where e.department_id = d.department_id
    and d.location_id = l.location_id
    and d.department_id = j.department_id;