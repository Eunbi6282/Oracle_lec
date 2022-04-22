
-- Sub Query : select 문 내에 select문이 있는 쿼리
    -- where 조건절 : sub query
    -- having 조건절 : sub query
select ename, salary from employee;
select salary from employee where ename = 'SCOTT';

    -- SCOTT의 월급보다 많은 사용자를 출력하라 (쿼리 내의 쿼리 - 서브쿼리)
    select ename, salary from employee where salary >= 3000;
    select ename, salary from employee 
    where salary >= (select salary from employee where ename = 'SCOTT'); --select 문이 단일값과 맞아야 함
    
    -- SCOTT과 동일한 부서에 근무하는 사원들 출력하기
    select * from department;
    
    select ename as 사원이름, e.dno as 부서 ,dname as 부서이름
    from employee e , department d
    where e.dno = d.dno
    and e.dno = (select dno from employee where ename = 'SCOTT');
    
    -- 최소 급여를 받는 사원의 이름, 담당업무, 급여 출력하기 (sub query)
    select ename 사원이름, job 담당업무, salary 급여
    from employee
    where salary = (select min(salary) from employee);
    
    -- 30번 부서의 최소 월급보다 많이 받는 사람들 출력

    select ename 사원이름, dno 부서명, salary 월급
    from employee
    where dno = 30;
    
    select ename 사원이름, dno 부서명, salary 월급
    from employee
    where salary > ( select min(salary) from employee where dno = 30);
    
    -- Having절에 sub query사용하기
        -- 각 부서의 최소 월급을 가져옴 -> 그 중에서도 30번 부서의 최소 월급보다 큰 값들
    select dno, min(salary), count(dno)
    from employee 
    group by dno
    having min(salary) > (select min(salary) from employee where dno = 30);
    
-- 단일행 서브쿼리 : sub query의 결과 값이 단 하나면 출력
        -- 단일행 비교 연산자 : > ,  < ,= , >= , <= , <>
-- 다중행 서브쿼리 : sub query의 결과괎이 여러개 출력
        -- 다중행 서브쿼리 연산자 : In, Any, Some, All, Exists
            -- In : 메인 쿼리의 비교조건(' = ' 연산자로 비교할 경우) 이 서브쿼리의 결과값중에 하나라도 일치하면 참
            -- Any, Some : 메인쿼리의 비교 조건이 서브 쿼리의 검색결과와 하나 이상 일치하면 참
            -- All : 메인쿼리의 비교조건이 서브쿼리의 검색결과와 모든 값이 일치하면 참
            -- Exist: 메인쿼리의 비교조건이 서브쿼리의 결과값중에서 만족하는 값이 하나라도 존재하면 참
            
    -- In 연산자 사용
    select ename, eno, dno ,salary
    from employee 
    order by dno asc;
    
        -- 부서별로 최소 월급을 받는 사용자들 출력하기(Sub Query 사용해서 출력)
        select dno, min(salary), count(*)
        from employee
        group by dno; -- 1. 각 부서의 최소 월급값
        
        select dno , min(salary), coun(*)
        from employee
        group by dno
        having min(salary) = (select min(salary) from employ ee);  -- group에 대한 조건주기!! 조건 줄때에도 그룹타입 맞추기
        
        select ename , dno, salary 
        from employee
        where salary in(950,800,1300); -- 2. 조건 줌 (서브쿼리 사용 x)
        
        select ename , dno, salary 
        from employee
        where salary in( select min(salary) from employee group by dno); -- 1+2 -> 서브쿼리 사용
        
-- Any 연산자 사용
    -- 서브 쿼리가 반환하는 각각의 값과 비교함
    -- ' < any'는 최대값보다 작음을 나타냄
    -- ' > any' 는 최소값보다 큼을 나타냄
    -- ' == any'는 in 과 동일함
    
        -- 직급이 salesman 이아니면서 급여가 임의의 salesman의 최대값(1600)보다 작은 사원을 출력
        select eno, ename, job , salary 
        from employee
        where salary < any (select salary from employee where job = 'SALESMAN') 
                and job <> 'SALESMAN';
                
       -- 직급이 salesman 이아니면서 급여가 임의의 salesman의 최소값(1250)보다 큰 사원을 출력
        select eno, ename, job , salary 
        from employee
        where salary > any (select salary from employee where job = 'SALESMAN') 
                and job <> 'SALESMAN';         
        
        select eno, ename, job , salary from employee order by job, salary;
        
-- All 연산자
    --Sub query의 반환하는 모든 값과 비교
    -- ' > all' : 최대값보다 큼을 나타냄
    -- ' < all' : 최소값보다 작음을 나타냄
        
        -- 직급이 salesman이 아니면서 salesman 보다 월급이 작은 모든 사원들 모두 출력
        select eno, ename, job, salary
        from employee
        where salary < all (select salary from employee where job = 'SALESMAN')
                     and job <> 'SALESMAN';  -- 최소값인 1250보다 작은 값을 출력
                     
        -- 담당 업무가 분석가인 사원보다 급여가 적으면서 업무가 분석가가 아닌 사원들 출력
        select ename, salary, job
        from employee e
        where salary < all (select salary from employee where job = 'ANALYST')
                    and job <> 'ANALYST';
        
        -- 급여가 평균급여보다 많은 사원들의 사원번호와 이름을 표시하되 결과 급여에 대해서 오름차순 하시오.
        select eno 사원번호, ename 사원이름, salary 월급
        from employee
        where salary > all (select avg(salary) from employee)
        order by salary asc;
        
