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
select sum (salary), ename from employee;
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

--전체사원번호의 수는?
select count (eno)from employee;



--커머션이 있는 사람들의 수는? 
select commission from employee; --커머션현황
select count(commission) from employee;-- null은 읽히지 않는다.

--전체 레코드 카운트 
--전체 인원의 수를 알고 싶으면 * 또는 null없는 값을 지정하자
select count(*) from employee;
select count (eno)from employee;
 
 
-- 중복되지 않는 직업의 개수
select job from employee; --전체 직업의 현황
select count(distinct job) from employee; --직업의 개수
select distinct job from employee; --직업종류

--부서의 개수(dno)
select count (distinct dno) from employee;
select distinct dno from employee; --부서의 종류

--Groub by: 특정 컬럼의 값을 그룹핑한다. 주로 집계함수를 select 절에서 같이 사용함.
/*
    select 컬럼명, 집계함수처리된 컬럼
    from 테이블 
    where 조건
    group by 컬럼명
    having 조건 (group by한 결과의 조건)
    order by 정렬

*/

--부서별 평균급여.
select dno as 부서번호, avg(salary) as 평균급여
from employee
group by dno ; -- dno 컬럼의 중복된 것을 그룹핑함.

select dno 
from employee
order by dno;

--전체 평균 급여.
select avg (salary) as 평균급여
from employee;

--dno를 기준 으로 count 된 각 dno, 그룹핑된 값들의 salary의 합계
select dno, count(dno) , sum(salary)
from employee
group by dno;

--goup by를 사용하면서 select 절에 가져올 컬럼을 잘 지정해야한다. ename은 조건에 맞지않는다 따라서 오류
select dno, count(dno) , sum(salary),ename
from employee
group by dno;

--해당 부서에서의 값들이 나오는 것.
select dno, count(dno) , sum(salary), avg(salary), max(commission), min(commission)
from employee
group by dno;

--동일한 직책을 그룹핑해서 월급은 평균 ,합계 최대값 최소값을 출력
select job ,sum(salary),round(avg(salary),2),max(salary),min(salary)
from employee
group by job;

--여러 컬럼을 그룹핑하기
select dno, job, count(*),sum(salary)
from employee
group by dno,job; --두컬럼 모두 일치하는 것을 그룹핑

select dno, job ,sum(salary),round(avg(salary),2),max(salary),min(salary)
from employee
group by dno,job;

select ename,dno,job 
from employee
where dno = 20 and job = 'CLERK';

-- having : goup by에서 나온 결과를 조건으로 처리할 때.
    --별칭이름을 조건으로 사용하면 안된다.
-- 부서별 월급의 합계가 9000이상인 것만 출력.  
select dno 부서, count(*)부서인원,sum (salary)as 부서별합계, round(avg(salary),2) as 부서별평균
from employee
GROUP by dno
having sum (salary)>9000;

select dno,sum (salary)as 부서별합계, round(avg(salary),2) as 부서별평균
from employee
group by dno
having sum (salary)>9900;

--부서별 월급의 평균이 2000이상만 출력
select dno 부서, count(*)부서인원,sum (salary)as 부서별합계, round(avg(salary),2) as 부서별평균
from employee
GROUP by dno
having round(avg(salary),2)>2000;

select dno , round(avg(salary),2) as 부서별평균
from employee 
group by dno
having round(avg(salary),2)>2200;


--where와 having이 같이 사용되는 경우
 --where : 실제 테이블에 조건을 줘서 검색
 --having : group by 결과에 대해서 조건을 처리. 
 
 --월급이 1500이하는 제외하고 각부서별로 월급의 평균을 구하되 월급의 평균이 2000이상인건만 출력
 select dno,count(*),round(avg(salary))
 from employee
 where salary >1500
 group by dno
 having round(avg(salary))>2500;
 
  select *
 from employee;
 
 --job이 CLERK를 제외하고 부서별로 월급의 합계와 평균을 구한다음 평균이2000이상인 경우 출력
 select job,count(job), sum(salary), round(avg(salary))
 from employee
 where job != upper('CLERK')
 group by job
 having round(avg(salary))>2000;
 
 --ROLLUP
 --CUBE
    --GROUP BY 절에서 사용하는 특수한 함수
    --여러컬럼을 나열할 수 있다.
    -- GROUP BY절의 자세한 정보를 출력
 
 --ROLLUP,CUBE를 사용하지 않은 경우
select dno, count(*),sum (salary),round(avg(salary))
from employee
group by dno
order by dno;

--ROLLUP: 부서별 합계와 평균을 출력하고 마지막 라인에 전체 합계,평균
select dno, count(*),sum (salary),round(avg(salary))
from employee
group by rollup(dno)
order by dno;

--직급별 + 전체 값
select job ,count(job),sum (salary),round(avg(salary))
from employee
group by rollup(job);
  
--부서별 합계와 평균을 출력하고 마지막 라인에 전체 합계,평균
select dno, count(*),sum (salary),round(avg(salary))
from employee
group by CUBE(dno)
order by dno;
  
--Rollup : 두컬럼이상 각dno별로 정리 
select dno, job, count(*),max(salary),sum(salary),round(avg(salary))
from employee
group by rollup(dno,job); --두개의 컬럼이 적용됨 두컬럼에 걸쳐서 동일할때 그룹핑.

select job, dno, count(*),max(salary),sum(salary),round(avg(salary))
from employee
group by rollup(job,dno);

--rollup 없고 order by로 정렬한 경우 전체 처리한 결과들이 보이지 않는다.
select dno, job, count(*),max(salary),sum(salary),round(avg(salary))
from employee
group by dno,job
order by dno asc;
 
--cube :dno를 기준으로 각 job 정리 -> dno를그룹한 값들결과 + job별로 결과도 나옴
select dno, job, count(*),max(salary),sum(salary),round(avg(salary))
from employee
group by cube(dno,job)
order by dno , job ; 

--JOIN: 여러테이블을 합쳐서 각 테이블의 컬럼을 가져온다.
 --deparment와 employee는 원래는 하나의 테이블이었으나 모델링(중복제거,성능향상)을 통해서 두테이블을 분리시킴 
 --두테이블의 공통키컬럼(dno) ,employee테이블의 dno 컬럼은 department테이블의 dno컬럼을 참조하고 있다.
 --두개 이상의 테이블의 컬럼을 JOIN구문을 사용해서 출력.

select * from department; --부서정보를 저장하는 테이블 
select * from employee; -- 사원정보를 저장하는 테이블 

--EQUI JOIN : 오라클에서 제일 많이 사용하는 JOIN, Oracle에서만 사용가능
    --from 절 : 조인할 테이블을 ,로 처리
    --whrere 절 : 두 테이블의 공통의 키 컬럼을 " = "로 처리
        --and 절: 조건을 처리
    
    --where절 : 공통키 컬럼을 처리한 경우
select *
from employee,department
where department.dno = employee.dno
and job= 'MANAGER';



-- ANSI 호환 : [INNER] JOIN <==모든 SQL에서 사용가능한 join 방법 (INNER은 생략가능)
--ON 절 : 공통키컬럼을 처리한 경우
    --where절 : 조건을 처리
select * 
from employee e join department d
on e.dno = d.dno
where job ='MANAGER';

--JOIN시 테이블 알리어스 (테이블이름을 별침으로 두고 많이 사용 )
select *
from employee e, department d
where e.dno=d.dno
and salary >1500;


--select 절에서 공통의 키컬럼을 출력시 어느테이블의 컬럼인지 명시 : dno
select eno , job , d.dno, dname 
from employee e , department d
where e.dno=d.dno;

--두테이블을 JOIN해서 월급(salary)의 최대값을 부서별으로 출력해보세여
select dname,count(*),max(salary)
from  department d , employee e
where d.dno=e.dno
group by dname;

select dname ,max(salary)
from employee e join department d
on e.dno=d.dno
group by dname;


--NATUAL JOIN : Oracle 9i 지원
    -- EQUI JOIN 의 Where 절을 없앰 : 두테이블의 공통의 키컬럼을 정의 "="
    --공통의 키컬럼을 Oracle 내부적으로 자동으로 감지해서 처리
    --공통 키컬럼을 별칭이름 사용 시 오류가 발생.
    --반드시 공통 키컬럼은 데이터타입이 같아야한다.
    --from 절에 natural join 키워드를 사용.
    
select e.eno, e.ename , d.dname , dno
from employee e natural join department d;

--주의 : select 절의 공통키 컬럼을 출력 시 테이블명을 명시하면 오류 발생.
-- EQUI JOIN vs NATUAL JOIN 의 공통키컬럼 처리
    --EQUI JOIN : select에서 공통키 컬럼을 출력할때 테이블명을 반드시 명시
    --NATUAL JOIN:select에서 공통키 컬럼을 출력할때 테이블명을 반드시 명시하지 않아야함.
    
--EQUI                            
select ename,salary,dname,d.dno   --d.dno이런식으로 명시가 무조건되어있어야한다!!(EQUI JOIN)
from employee e, department d
where e.dno=d.dno
and salary >2000;

--NATURAL                        
select ename, salary, dname, dno  --dno : 명시하면 오류발생!!!(natural join)
from employee natural join department d
where salary >2000;

--ANSI : INNER JOIN
select ename, salary, dname, e.dno
from employee e join department d 
on e.dno = d.dno
where salary >2000;


--NON EQUI JOIN : EQUI JOIN에서 where절의 "=" 사용하지 않는 JOIN
--select * from salgrade; : 월급의 등급을 표시하는 테이블 

select ename, salary, grade
from employee,salgrade
where salary BETWEEN losal and hisal;

--테이블 3개 조인 
--ename,salary : employee / dname : department / grade : salgrade
select ename,dname,salary,grade
from employee e, department d, salgrade s
where e.dno = d.dno
and salary between losal and hisal;
