--Self Join : 자기자신의 테이블을 조인한다.(주로 사원의 상사 정보를 출력할때 사용)
    --별칭을 반드시 사용해야한다. 
    --select 절 : 테이블이름 별칭.컬럼명,
select eno , ename, manager
from employee  
where manager ='7788';

--self join 을 사용해서 사원의 직속상관이름
select e.eno as"사원번호", e.ename as "사원이름" ,e.manager as "직속상관번호", m.ename as "직속상관이름" 
from employee e, employee m --셀프조인 : 별칭을 적어야한다!
where e.manager =m.eno
order by e.ename asc;

select e.ename ||'의 직속상관은' ||e.manager || '입니다.'
from employee e, employee m
where e.manager = m.eno
order by e.ename asc;

select eno, ename, manager, eno, ename
from employee;


--ANSI 호환 :INNER JOIN으로 처리,

select e.eno, e.ename , e.manager, m.ename
from employee e join employee m
on e.manager =m.eno
order by e.ename asc;

--ANSI 호환 :INNER JOIN
select e.ename ||'의 직속상관은' ||e.manager || '입니다.'
from employee e join employee m
on e.manager = m.eno
order by e.ename asc;

--OUTER JOIN :
    --특정컬럼의 두 테이블에서 공통적이지 않은 내용을 출력해야할때.
    --공통적이지 않는 컬럼은 null로 출력
    -- + 기호를 사용해서 출력한다. : Oracle 
    -- ANSI 호환 : OUTER JOIN 구문을 사용해서 출력 <==모든 DBMS에서 호환.

--Oracle 
select e.ename, m.ename
from employee e join employee m
on e.manager = m.eno (+) -- 오른쪽에 있는게 매칭안되더라도 걍 출력해! 없으면 출력안됌.
order by e.ename asc;

--Ansi 호환을 사용해서 출력 
    -- left Outer JOIN : 공통적인 부분이 없더라도 왼쪽은 무조건 모두 출력 
    -- right Outer JOIN : 공통적인 부분이 없더라도 오른쪽은 무조건 모두 출력 
    -- Full Outer Join : 공통적인 부분이 없더라도 양쪽 모두 무조건 모두 출력 
select e.ename , m.ename
from employee e left outer join employee m
on e.manager=m.eno
order by e.ename;

--서브쿼리
--subQuelry : select 문 내에 select문이 있는 쿼리/
    --where 조건절 : sub query
    --having 조건절 : sub query




--scott 의 월급보다 많은 사용자를 출력하라(서브쿼리)
select salary from employee where salary >=3000;

select ename, salary
from employee
where salary >= (select salary from employee where ename='SCOTT');

select * from employee;

--SCOTT과 동일한 부서에 근무하는 사원들 출력하기 
 select  dno ,e.ename
 from employee e, department d;
 
select dno from employee where ename ='SCOTT';
select ename , dno from employee where dno=20;

select ename , dno from employee where dno=(select dno from employee where ename ='SCOTT');

--최소 급여를 받는 사원의 이름 담당업무 급여 출력하기
select min (salary) from employee;
select ename, job, salary
from employee
where salary =(select min(salary)from employee);


--having 절에 sub query 사용하기

--30번부서(dno)에서 최소 월급을 받는 사원의 보다 많은 사원들 이름과 부서번호와 월급을 출력

select salary, dno from employee where dno=30;
select min(salary) from employee where dno=30;

--where 절사용 
select ename, dno , salary
from employee
where salary > (select min(salary) from employee where dno=30);
 
 --having 절에 sub query 사용하기
 --30번 부서의 최소월급보다 큰 각 부서의 최소월급
select dno, min(salary),count (dno)
from employee
group by dno
having min(salary)>(select min(salary) from employee where dno=30);

-- 단일행 서브쿼리 : sub query의 결과 값이 단 하나면 출력.
        --단일행 비교연산자 : >,=,>=,<,<=,<> 
--다중행 서브쿼리 : sub query의 결과 값이 여러개 출력
        --다중행 서브쿼리 연산자 : IN,ANY,SOME,ALL,EXISTS
            --IN : 메인쿼리의 비교 조건이 '='연산자로 비교할 경우) 이 서브쿼리의 결과 값 중에 하나라도 일치하면 참
            --ANY,SOME :메인쿼리의 비교조건이 서브쿼리의 검색결과와 하나 이상 일치하면 참
            --ALL : 메인쿼리의 비교조건이 서브쿼리의 검색결과와 모든 값이 일치하면 참
            --EXIST : 메인쿼리의 비교조건이 서브쿼리의 결과값 중에서 만족하는 값이 하나라도 존재하면 참
            
--IN 연산자 사용하기 .
select ename, eno,dno,salary
from employee
order by dno asc;

--부서별로 최소 월급을 받는 사용자들 출력하기(서브쿼리를 반드시 사용)
select dno, min(salary),count(*)
from employee
group by dno;

select ename, dno, salary 
from employee
where salary in(950,800,1300);

select ename, dno, salary 
from employee
where salary in(select min(salary) from employee group by dno);


--Any 연산자
    --서브쿼리가 반환하는 각각의 값과 비교함.
    --'<any'는 최대값보다 작음을 나타냄.
    --'>any'는 최소값보다 큼을 나타냄.
    --'=any'는 IN과 동일 함.
    
    
    --직급이 salesman이 아니면서 급여가 임의의 salesman 보다 작은 사원을 출력
    --1600(최대값)보다 작은 모든 사원이 아니고 
    select eno, ename,job, salary
    from employee
    where salary < any (select salary from employee
                            where job ='SALESMAN')
                       AND JOB<> 'SALESMAN';
                       
    select ename ,job ,salary from employee
    order by job asc;
    
--All 연산자
    --subquery의 반환하는 모든 값과 비교.
    --'>all' : 최대값보다 큼을 나타냄.
    --'<all' : 최소값보다 작음을 나타냄. 

--예) 직급이 salesman이 아니면서 직급이 salesman인 사원보다 급여가 적은 사원을 모두 출력.
    -- 1250(최소값) 보다 작은 사원(직급은 SALESMAN이 아님)
    select eno,ename, job, salary
    from employee
    where salary < all( select salary from employee where job = 'SALESMAN') AND job <>'SALESMAN';
    
--예) 담당 업무가 분석가인 사원보다 급여가 적으면서 업무가 분석가가 아닌 사원들을 표시
select eno,ename, job, salary
from employee
where salary<all(select salary from employee where job='ANALYST')and job <> 'ANALYST';

--급여가 평균급여보다 많은 사원들의 사원번호와 이름을 표시하되 결과 급여에 대해 오름차순 하시오
select eno , ename, salary
from employee
where salary> (select round(avg(salary)) from employee)
order by salary ;

