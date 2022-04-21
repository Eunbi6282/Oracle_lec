--4일차
/*
    그룹함수 : 동일한 값에 대해서 그룹핑해서 처리하는 함수 
            group by 절에 특정컬럼을 정의할 경우, 해당 컬럼의 동일한 값들을 그룹핑해서 연산을 적용.
            
    집계함수 : 
        -sum : 그룹의 합계
        -AVG : 그룹의 평균
        -MAX : 그룹의 최대값         
        -MIN : 그룹의 최대값 
        -COUNT : 그룹의 총개수(레코드수 record, 로우수 row )
*/


select  sum(salary),round(avg(salary),2),max(salary),min(salary)
from employee;

--주의 : 집계함수를 처리할 때 , 출력 컬럼이 단일값으로 나오는 컬럼을 정의
--sum한 값이 단일로나오는데 다른 값이 단일 값이 아닌경우 오류발생
select sum (salary),ename from employee;
select sum (salary) from employee;

select *
from employee;

--집계함수는 null 값을 처리해서 연산한다.
select sum (commission),avg(commission),max(commission),min(commission)
from employee;

--count() : 레코드 수, 로우 수 
    --null은 처리되지 않는다.
    --테이블의 전체 레코드 수를 가져올경우  : count(*) 또는 not null 컬럼을 count())
select eno from employee; --레코드 14개 
select count (eno)from employee;

select commission from employee;
select count(commission) from employee;

select count(*) from employee;
--전체 레코드 카운트
select count(*) from employee;
select count (eno)from employee;
 
-- 중복되지 않는 직업의 개수

select job from employee;

select count(distinct job) from employee;

--부서의 개수 (dno)
select count( distinct dno) from employee;

-- Group by : 특정 컬럼의 값을 그룹핑. 주로 집계 함수를 select 절에서 같이 사용한다. 
/*
    select 컬럼명, 집계함수처리된 컬럼
    from 테이블
    where 조건
    group by 컬럼명
    having 조건 (group by한 결과의 조건)
    order by 정렬
*/

--부서별 평균 급여
select dno as 부서번호, avg(salary) as 평균급여
from employee
group by dno; -- dno 컬럼의 중복된 것을 그룹핑



select dno from employee order by dno;

-- 전체 평균 급여
select avg(salary) as 평균급여
from employee;

-- group by를 사용하면서 select 절에 가져올 컬럼을 잘 지정해야 한다. 
select dno ,count(dno) ,sum(salary), ename  --ename(레코드 14개)컬럼이 들어가면 오류 발생, 나머지는 그룹핑 한 것에 대한 함수가 들어와야 함
from employee
group by dno;

select dno ,count(dno) ,sum(salary), avg(salary), max(commission), min(commission)  --ename(레코드 14개)컬럼이 들어가면 오류 발생, 나머지는 그룹핑 한 것에 대한 함수가 들어와야 함
from employee
group by dno; --!! 부서내 !!의 평균, 합계, 최대값, 최소값

-- 
select job from employee;

-- 직책에 따라서 그룹핑 , 동일한 직책을 그룹핑해서 월급의 평균, 합계, 최대값, 최소값
select job,count(job) ,trunc(avg(salary)), sum(salary), min(salary), max(salary)
from employee
group by job;

-- 여러 컬럼을 그룹핑하기
    -- 그룹핑한 컬럼은 select문에 올 수 있다. 
select dno, job,  count(*), sum(salary) 
from employee
group by dno, job;      -- 두 컬럼 모두 일치하는 것을 그룹핑

select dno, job
from employee
where dno = 20 and job = 'CLERK';

-- having : group by에서 나온 결과를 조건으로 처리할 때 , group by가 있어야 사용할 수 있다. 
    -- having절에 별칭 이름을 조건으로 사용하면 안된다. 
    
    -- 부서별 월급의 합계가 9000이상인 것만 출력
    select dno, count(*), sum(salary) as "부서별 합계", round(avg(salary),2) as "부서별 평균"
    from employee
    group by dno
    having sum(salary) >= 9000;  -- 그룹별로 묶은 것에 조건을 줄 때 having 사용
    
    -- 부서별 월급의 평균이 2000이상인것만 출력
    select dno, count(*), sum(salary) as "부서별 합계", round(avg(salary),2) as "부서별 평균"
    from employee
    group by dno
    having round(avg(salary),2) >= 2000.00;  -- 그룹별로 묶은 것에 조건을 줄 때 having 사용
    
    -- where 와 having절이 같이 사용되는 경우
        -- where : 실제 테이블의 조건으로 검색
        -- having : group by 결과에 대해서 조건을 처리할 때 사용
    select * from employee;
    
    -- 월급이 1500이하는 제외하고 각 부서별로 월급의 평균을 구하되 월급의 평균이 2000이상인것만 출력
    select dno , round(avg(salary))
    from employee
    where salary > 1500
    group by dno
    having avg(salary) >= 2500;
    
-- ROLLUP
-- CUBE
    -- Group by 절에서 사용하는 특수한 함수
    -- 여러 컬럼을 나열할 수 있다. 
    -- group by절의 자세한 정보를 출력

    -- 1. rollup과 cube를 사용하지 않는 경우
    SELECT dno, count(*), sum(salary), round(avg(salary))
    FROM employee
    GROUP BY dno
    order by dno;
    
    -- rollup : 부서별 합계와 평균을 출력후, 마지막라인에 전체합계, 평균
    SELECT dno, count(*), sum(salary), round(avg(salary))
    FROM employee
    GROUP BY rollup(dno)
    order by dno;
    
    -- cube : 부서별 합계와 평균을 출력후, 마지막라인에 전체합계, 평균
    SELECT dno, count(*), sum(salary), round(avg(salary))
    FROM employee
    GROUP BY cube(dno)
    order by dno;
    
    -- rollup: 두 컬럼이상
    select dno ,  job, count(*), max(salary), sum(salary), round(avg(salary))
    from employee 
    group by rollup(dno, job); -- 두개의 컬럼이 적용됨, 두 컬럼에 걸쳐서 동일할 때 그룹핑.
    --10		3	5000	8750	2917 <rollup>
                --3개에대한 최대값     -- 3개에대한 합  -3개에대한 평균
    select dno ,  job, count(*), max(salary), sum(salary), round(avg(salary))
    from employee 
    group by dno, job
    order by dno;             
    
    select dno ,  job, count(*), max(salary), sum(salary), round(avg(salary))
    from employee 
    group by cube(dno, job)
    order by dno, job;
    
   
    
    
    
    


