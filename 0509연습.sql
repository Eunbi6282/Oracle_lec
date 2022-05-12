
drop table emp_copy;

create table emp_copy
as
select * from employee;

select * from emp_copy;
rollback;

desc emp_copy;

"Insert into emp_copy (eno, name, job, manager, hiredate, salary, commission , dno) 
values(eno,'" + name + "' , '" + job + "', manager, hiredate, salary, commission, dno)";

Insert into emp_copy (eno, name, job, manager, hiredate, salary, commission , dno) 
values(enoo,'" + name + "','" + job + "', managerr + "','"+ to_date(hiredate,'yyyy-mm-dd') + "', salaryy  , commissionn , dnoo);

Insert into emp_copy (eno, name, job, manager, hiredate, salary, commission , dno) 
values(enoo,'" + name + "','" + job + "', managerr , to_date(hiredate,'yyyy-mm-dd'), salaryy  , commissionn , dnoo)";

Insert into emp_copy (eno, name, job, manager, hiredate, salary, commission , dno) 
values(enoo,'" + name + "','" + job + "', managerr , '" + hiredate + "', salaryy  , commissionn , dnoo)"

update emp_copy set manager = '" + manager + "', commission = '" + commission + "'where ename = '" + name + "'