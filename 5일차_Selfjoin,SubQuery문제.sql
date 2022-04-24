-- 7. SELF JOIN을 사용하여 사원의 이름 및 사원번호를 관리자 이름 및 관리자 번호와 함께 출력 하시오. 
 	-- 각열에 별칭값을 한글로 넣으시오. 
    
    select * from employee;
    select 가.ename 사원이름, 가.eno 사원번호 ,나.ename 관리자이름 , 나.eno 관리자사번
    from employee 가, employee 나
    where 가.manager = 나.eno;

-- 8. OUTER JOIN, SELF JOIN을 사용하여 관리자가 없는 사원을 포함하여 사원번호를 기준으로 내림차순 정렬하여 출력 하시오.
    -- Outer Join
    select 가.ename 사원이름, 가.eno 사원번호 ,나.ename 관리자이름 , 나.eno 관리자사번
    from employee 가 join employee 나
    on 가.manager  = 나.eno (+)
    order by 가.eno desc; 
    
    -- Self Join
    


-- 9. SELF JOIN을 사용하여 지정한 사원('SCOTT')의 이름, 부서번호, 지정한 사원과 동일한 부서에서 근무하는 사원을 출력하시오. 
   --단, 각 열의 별칭은 이름, 부서번호, 동료로 하시오. 
   
   select e.ename 이름, e.dno 부서번호 , m.dno ,m.ename 동료 
   from employee e, employee m
   where e.dno = m.dno  --SCOTT 20번 부서에 다님, 20번 부서에 다니는 사원들 출력
   and e.ename = 'SCOTT';

-- 10. SELF JOIN을 사용하여 WARD 사원보다 늦게 입사한 사원의 이름과 입사일을 출력하시오. 
    select m.ename 사원이름, m.hiredate 입사일
    from employee e, employee m
    where e.hiredate = m.hiredate
    and m.hiredate > (select hiredate from employee where ename = 'WARD')
    order by m.hiredate;
   

-- 11. SELF JOIN을 사용하여 관리자 보다 먼저 입사한 모든 사원의 이름 및 입사일을 관리자 이름 및 입사일과 함께 출력하시오. 
    -- 단, 각 열의 별칭을 한글로 넣어서 출력 하시오. 
    select 가.ename , 가.hiredate, 나.ename, 나.hiredate
    from employee 가, employee 나
    where 가.manager = 나.eno
    and 가.hiredate < 나.hiredate;
    
 -- <<아래 문제는 모두 Subquery를 사용하여 문제를 푸세요.>>

-- 1. 사원번호가 7788인 사원과 담당 업무가 같은 사원을 표시(사원이름 과 담당업무) 하시오.  
    select ename 사원이름, job 담당업무, eno
    from employee
    where job  = (select job from employee where eno = 7788);

-- 2. 사원번호가 7499인 사원보다 급여가 많은 사원을 표시 (사원이름 과 담당업무) 하시오.
    select ename 사원이름, job 담당업무, salary 급여
    from employee
    where salary > (select salary from employee where eno = 7499)
    order by salary;

-- 3. 최소 급여를 받는 직급별로 사원의 이름, 담당 업무 및 급여를 표시 하시오(그룹 함수 사용)
    select job , min(salary) 
    from employee
    group by job; 
    
    select ename 사원이름, job 담당업무, salary 월급
    from employee
    where
    salary = any (select min(salary) from employee  group by job)
    order by job;  

-- 4. 직급별로 평균급여를 구하고, 가장 작은 직급 평균에서 가장 작은 사원을 직급과 급여를 표시하시오
    select job, round(avg(salary))
    from employee 
    group by job;
    
    select ename 사원이름, job 직급, salary 급여
    from employee
    where job = 'CLERK' and salary = (select min(salary) from employee where job = 'CLERK');
    

-- 5. 각 부서의 최소 급여를 받는 사원의 이름, 급여, 부서번호를 표시하시오.
    select ename 사원이름, salary 급여, dno 부서번호
    from employee
    where salary = any ( select min(salary)
    from employee
    group by dno);
    
    -- 각 부서번호 별 최소값
    select min(salary)
    from employee
    group by dno;

-- 6. 담당 업무가 분석가(ANALYST) 인 사원보다 급여가 적으면서 업무가 분석가가 아닌 사원들을 표시 (사원번호, 이름, 담당업무, 급여) 하시오.
    select eno 사원번호, ename 이름, job 담당업무 , salary 급여
    from employee
    where salary < all (select salary  from employee where job = 'ANALYST')
                    and job <> 'ANALYST'
    order by salary desc;

-- 7. 부하직원이 없는 사원의 이름을 표시 하시오. 
    select ename, job, manager , eno
    from employee
    where eno not in (select manager
    from employee
    group by manager);
    
    -- manager 에 들어있는 사원번호가 아닌 사원 찾기
    select manager
    from employee
    group by manager;
    
    select eno 
    from employee
    group by eno
    having eno not in manager;

-- 8. 부하직원이 있는 사원의 이름을 표시 하시오. 
    select ename
    from employee
    where eno in (select manager
    from employee
    group by manager);

-- 9. BLAKE 와 동일한 부서에 속한 사원의 이름과 입사일을 표시하는 질의를 작성하시오(단, BLAKE 는 제외). 
    select ename 사원번호 ,hiredate 입사일, dno 부서번호
    from employee
    where dno = (select dno from employee where ename = 'BLAKE') 
                and ename <> 'BLAKE';

-- 10. 급여가 평균보다 많은 사원들의 사원번호와 이름을 표시하되 결과를 급여에 대해서 오름 차순으로 정렬 하시오. 
    select eno 사원번호, ename 사원이름, salary 급여
    from employee
    where salary > all (select round(avg(salary)) from employee)
    order by salary;
    

-- 11. 이름에 K 가 포함된 사원과 같은 부서에서 일하는 사원의 사원번호와 이름을 표시하는 질의를 작성하시오. 
    select eno 사원번호, ename 사원이름, dno 부서
    from employee
    where  dno in (select distinct dno from employee where ename like '%K%') -- dno = 10, 30
    order by ename ;
    
    -- 확인용 ( %k%들어가는 부서 10,30 -> 부서번호 10,30 사원들 결과)
    select eno, ename, dno
    from employee
    where dno = 10 or dno = 30
    order by ename;

-- 12. 부서 위치가 DALLAS 인 사원의 이름과 부서 번호 및 담당 업무를 표시하시오. 
    select * from department;
    
    select ename 사원이름, e.dno 부서번호, dname 담당업무
    from employee e, department d
    where e.dno = d.dno
    and d.dname = (select dname from department where loc = 'DALLAS');

-- 13. KING에게 보고하는 사원의 이름과 급여를 표시하시오. 
    select ename 사원이름 , salary 급여
    from employee e
    where manager in (select eno from employee where ename = 'KING') -- 관리자 사원번호가 king인 경우 
    order by salary;
 
-- 14. RESEARCH 부서의 사원에 대한 부서번호, 사원이름 및 담당 업무를 표시 하시오. 
    select e.dno 부서번호, ename 사원이름 , job 담당업무
    from employee e , department d
    where e.dno = d.dno
    and dname = (select dname from department where dname = 'RESEARCH');

-- 15. 평균 급여보다 많은 급여를 받고 이름에 M이 포함된 사원과 같은 부서에서 근무하는 사원의 사원번호, 이름, 급여를 표시하시오. 

   select eno 사원번호, ename 사원이름, salary 급여, dno 부서번호
    from employee
    where salary > (select round(avg(salary)) from employee)   
          and dno = any (select dno from employee where ename like '%M%')
    order by salary;

-- 16. 평균 급여가 가장 적은 업무를 찾으시오.  

    select job 업무, round(avg(salary)) 평균월급
    from employee
    group by job
    having round(avg(salary)) in (select min(round(avg(salary))) from employee group by job);
    
    
    -- 각 부서별 평균 <확인용>
    select round(avg(salary)), job
    from employee
    group by job;
    
    -- 부서별 평균의 최소값 <확인용>
    select min(round(avg(salary))) 
    from employee
    group by job;

-- 17. 담당업무가 MANAGER인 사원이 소속된 부서와 동일한 부서의 사원을 표시하시오. 
    select * from department;
    
    select ename 사원이름, job 담당업무 , e.dno 부서번호, d.dname 부서이름
    from employee e, department d
    where e.dno = d.dno
    and dname = any(select distinct dname from employee e, department d where job = 'MANAGER');

    