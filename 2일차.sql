-- 2일차 : DQL : Select

-- desc 테이블 명 : 테이블의 구조를 확인

desc department;

select * from department;

/*
SQL : 구조화된 질의 언어
Select 구문의 전체 필드 내용
!!!순서를 바꾸면 안됨!!!

Select  <== 컬럼명
Destinct <== 컬럼내의 값의 중복을 제거해라 
From <== 테이블명,뷰명
Where <== 조건
Group by <== 특정값을 그룹핑
Having <== 그룹핑한 값을 정렬
Order by <== 값을 정렬해서 출력
*/

desc employee;
select *
from employee;

-- 특정 컬럼만 출력하기
select eno, ename from employee;

-- 특정 컬럼을 여러번 출력할 수 있다.
select eno, ename, eno, ename, ename from employee;

select eno, ename, salary from employee;

-- 컬럼에 연산을 적용할 수 있다. 
select eno,ename,salary,salary * 12 from employee;

-- 컬럼명 알리어스(Alias) : 컬럼의 이름을 변경, 
    -- 컬럼에 연산을 하거나 함수를 사용하면 컬럼명이 없어진다. 
select eno, ename, salary, salary * 12 as 연봉 from employee; -- 컬럼명이 연봉으로 바뀌어짐
select eno as 사원번호, ename as 사원명, salary as 월급, salary * 12 as 연봉 from employee;
select eno  사원번호, ename  사원명, salary  월급, salary * 12  연봉 from employee;  -- as생략도 가능
    -- 컬럼명 알리어스시 공백이나 특수문자가 들어갈 때는 ""으로 처리
-- select eno  사원 번호, ename  사원*명, salary  월급, salary * 12  연봉 from employee; 
select eno  "사원 번호", ename  "사원*명", salary  "월?급", salary * 12  연봉 from employee;

-- nvl 함수 : 연산시에 null을 처리하는 함수
select * from employee;

-- nvl 함수를 사용하지 않고 전체 연봉을 계산. (null이 들어간 컬럼에 연산을 적용하면 null이 표시됨) -> null처리 필요
    -- null을 0으로 처리해서 연산해야 함. : NVL
select eno 사원번호, ename 사원명, salary 월급, commission 보너스 ,
salary * 12 연봉,  -- null값이 포함되어 있지 않기 때문에 문제 없음
(salary * 12 ) + commission "전체연봉(보너스포함)"        -- 전체 연봉(null값 포함)
from employee;

-- nvl함수를 사용해서 연산
select eno 사원번호, ename 사원명, salary 월급, commission 보너스 ,
salary * 12 연봉,  -- null값이 포함되어 있지 않기 때문에 문제 없음
(salary * 12 ) + NVL(commission, 0) "전체연봉(보너스포함)"        -- 전체 연봉(null값 포함)
                -- commission 컬럼의null을 0으로 처리해라
from employee;

--Distinct : 특정 컬럼의 내용을 중복제거후 출력
select * from employee;
select dno from employee;
select distinct dno from employee;

select ename, dno from employee;
-- select  ename, distinct dno from employee;  --오류 : distinct를 쓸때는 하나의 컬럼만 가져와서 사용하기 , 다른 컬럼때문에 오류가 날 수 있다.

-- 조건을 사용해서 검색(Where)
select * from employee;
select eno 사원번호, ename 사원명, job 직책, manager 사수, hiredate 입사날짜 ,
salary 월급, commission 보너스, dno 부서번호 
from employee;

-- 사원번호가 7788인 사원의 이름을 검색. 
select * from employee
where eno = 7788;

-- 사원번호가 7788인 사원의 이름만
select ename from employee 
where eno = 7788; 

-- 사원번호가 7788인 사원의 부서번호, 월급과 입사날짜를 검색
select dno 부서번호, salary 월급, hiredate 입사날짜 from employee
where eno = 7788;

-- 값을 가져올 때 테이블 구조로 레코드의 자료형 확인해야 함
desc employee;

select * from employee
where ename = 'SMITH';

-- 레코드(로우)을 가져올 때
    -- number 일 때는 ''를 붙이지 않는다.
    -- 문제 데이터(char, varchar2)나 날짜(date)를 가져올 때는 ''를 처리. 대소문자를 구분함
    
-- 입사날짜가 '81/12/03'인 사원 출력 <date형식>
select ename, hiredate
from employee
where hiredate = '81/12/03';

-- 부서코드가 10인 모든 사원들을 출력해라
select ename, dno
from employee
where dno = 10;

select * from employee;

-- 월급이 3000이상인 사원의 이름과 부서와 입사날짜를 출ㄹ
select ename, job, hiredate
from employee
where salary >= 3000;

-- null 검색: is 키워드 사용. null을 검색할때 =nullㄹ 사용하면 안된다. 
select *
from employee
where commission is null;

-- 커미션이 300이상인 사ㅜ원 이름고 직책, 월급 출려
select *
from employee
where commission >= 300;

-- 커미션이 없는 사원들의 이름을 출력
select ename, commission
from employee
where commission is null;

-- 조건에서 and, or, not

-- 월급이 500이상 2500 미만인 사원들의 이름, 사원번호, 입사날짜를 출력
select ename 이름,eno 사원번호, hiredate 입사날짜
from employee
where salary >= 500 and salary < 2500;

-- 1. 직책이 SALESMAN이거나 부서코드가 20인 사원이름, 직책, 월급, 부서코드
select ename 사원이름, job 직책, salary 월급, dno 부서코드 
from employee
where job = 'SALESMAN' or dno = 20;

-- 2. 커미션이 없는 사용자중에 부서코드가 20인사용자의 이름, 부서코드와 입사날짜를 출력
select ename 사원이름, dno 부서코드, hiredate 입사날짜, commission 보너스
from employee
where commission is null and dno = 20;

-- 3. 커미션이 null이 아닌 사용자의 이름, 입사날짜, 월급
select ename 사원이름, hiredate 입사날짜, salary 월급, commission 보너스
from employee
where commission is not null;

-- 날짜 검색 :
select * from employee;

-- 1982/1/1 ~ 1983/12/31 사이에 입사한 사원의 이름, 직책, 입사날짜
select ename 사원이름, job 직책, hiredate 입사날짜
from employee
where hiredate >= '1982/1/1' and hiredate < '1983/12/31';

-- 1981년도에 입사한 사원들 사원의 이름, 직책, 입사날짜
select ename 사원이름, job 직책, hiredate 입사날짜
from employee
where hiredate >= '1981/1/1' and hiredate < '1981/12/31';

-- Betwwen A and B 를 사용하여 처리
select ename 사원이름, job 직책, hiredate 입사날짜
from employee
where hiredate between '1981/1/1' and '1981/12/31';

-- In 연산자
select * from employee;

    -- 커미션이 300, 500, 1400인 사원의 이름, 직책, 입사일을 출력
    select ename 사원이름, job 직책, hiredate 입사일
    from employee
    where commission =300 or commission = 500 or commission = 1400;
    
    -- In 연산자 사용
    select ename 사원이름, job 직책, hiredate 입사일
    from employee
    where commission In (300,500,1400) ;
    
    -- like : 컬럼내의 특정한 문자열을 검색      <= 글 검색기능을 사용할 때 like사용
        --  % : 뒤에 어떤 글자가 와도 상관이 없다. 
        --  _ : 한글자가 어떤 값이 와도 상관없다. 
        
    -- F로 시작하는 이름을 가진 사용자검색하기
    select * from employee
    where ename like 'F%';
    
    -- 이름이 ES로 끝나는 사원 검색
    select ename from employee
    where ename like '%ES';
    
    -- J로 시작되고 J뒤에 두글자가 어떤것이 와도 상관없다. 뒤에는 es로 마무리
    select ename from employee
    where ename like 'J__ES';
    
    -- 마지막 글자가 R로 끝나는 사원 출력
    select ename from employee
    where ename like '%R';
    
    -- MAN 단어가 들어간 직책찾기
    select * from employee
    where job like '%MAN%';
    
    -- 81년도에 입사한 사원을 출력하기
    select *
    from employee
    where hiredate >= '81/1/1'  and hiredate <= '81/12/31';
    
    -- 81년 2월에 입사한 사원만 출력
    select *
    from employee
    where hiredate like '81/02%';
    
    -- 정렬 : order by , asc(오름차순정렬) : default, desc (내림차순 정렬)
       
    select * 
    from employee
    order by eno; -- asc 생략됨
        
        -- 이름을 정렬
    select * 
    from employee
    order by ename desc;
    
    --날짜 정렬
    select *
    from employee
    order by hiredate desc;
    
 -- 질문답변형 게시판에서 주로사용. 두개이상의 컬럼을 정렬할 때 
     -- 두개의 컬럼이 정렬 : 제일 처음 컬럼이 정렬을 하고 동일한 값(중복된 값)에 대해서 두번째 컬럼을 정렬.
     
     select dno, ename from employee
     order by dno , ename ; -- 두개 다 asc생략
     
     select dno, ename from employee
     order by dno desc, ename1 desc ;-- asc생략
     
-- where 절과 order by절이 같이 사용될 때
    --order by은 제일 마지막에 와야 함
select *
from employee
where commission is null
order by ename desc;
     



