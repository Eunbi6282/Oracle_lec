-- 1. SUBSTR 함수를 사용하여 사원들의 입사한 년도와 입사한 달만 출력 하시오.
select * from employee;
select SUBSTR(hiredate,1,5) "입사년도 ,달"
from employee;

-- 2. SUBSTR 함수를 사용하여 4월에 입사한 사원을 출력 하시오. 
select *
from employee
where substr(hiredate,4,2) = 4;

-- 3. MOD 함수를 사용하여 직속상관이 홀수인 사원만 출력하시오. 
select *
from employee
where mod(manager,2) = 1;

-- 3-1. MOD 함수를 사용하여 월급이 3의 배수인 사원들만 출력하세요.
select *
from employee
where mod(salary,3) = 0;

-- 4. 입사한 년도는 2자리 (YY), 월은 (MON)로 표시하고 요일은 약어 (DY)로 지정하여 출력 하시오. 
select to_char(hiredate, 'YY/MON/DD DY')
from employee;

-- 5. 올해 몇 일이 지났는지 출력 하시오. 현재 날짜에서 올해 1월 1일을 뺀 결과를 출력하고 TO_DATE 함수를 사용하여 데이터 형식을 일치 시키시오. 
select trunc(SYSDATE - to_date(220101,'YYMMDD'))
from dual;

-- 5-1. 자신이 태어난 날짜에서 현재까지 몇 일이 지났는지 출력 하세요.
select trunc(sysdate - to_Date(19981018,'YYYYMMDD'))
from dual;

-- 5-2. 자신이 태어난 날짜에서 현재까지 몇 개월이 지났는지 출력 하세요. 
select trunc(MONTHS_BETWEEN(SYSDATE,to_date(19981018,'YYYYMMDD')))
from dual;

-- 6. 사원들의 상관 사번을 출력하되 상관이 없는 사원에 대해서는 null 값대신 0으로 출력 하시오. 
select ename, nvl(manager,0)
from employee;

-- 7.  DECODE 함수로 직급에 따라 급여를 인상하도록 하시오. 직급이 'ANAIYST' 사원은 200 , 'SALESMAN' 사원은 180,
    --'MANAGER'인 사원은 150, 'CLERK'인 사원은 100을 인상하시오. 
select ename 사원이름, eno 사원번호, job 직급,decode(job, 'ANALYST', salary + 200,
                                                        'SALESMAN', salary + 180,
                                                        'MANAGER' , salary + 150,
                                                        'CLERK' , salary + 100, 
                                                        salary) AS "직급별 월급인상"
from employee;    

-- 8. 사원번호, [사원번호 2자리만 출력, 나머지는 * 가림] as "가린번호", 이름,[이름의 첫자만 출력 총네자리, 세자리는 * 가림] as "가린이름"
select eno, rpad(substr(eno,1,2),length(eno),'*') "가린번호", ename, rpad(substr(ename,1,1),4,'*') "가린이름"
from employee;

-- 9.  주민번호:   를 출력하되 801210-1*******   출력 하도록 , 전화 번호 : 010-11******* dual 테이블 사용
select rpad(substr('801210-1234567',1,8),length('801210-1234567'),'*') 주민번호,
rpad(substr('010-1111-2222',1,6),length('010-1111-2222'),'*') 전화번호
from dual;

-- 10. 사원번호, 사원명, 직속상관, 
--	[직속상관의 사원번호가 없을 경우 : 0000
--	 직속상관의 사원번호가  앞 2자리가 75일 경우 : 5555
--	직속상관의 사원번호가  앞 2자리가 76일 경우 : 6666
--	직속상관의 사원번호가  앞 2자리가 77일 경우 : 7777
--	직속상관의 사원번호가  앞 2자리가 78일 경우 : 8888
--	그외는 그대로 출력. 

select eno 사원번호, ename 사원명, manager 직속상관, 
case when manager is null then 0000
    when substr(manager,1,2) = 75 then 5555
    when substr(manager,1,2) = 76 then 6666
    when substr(manager,1,2) = 77 then 7777
    when substr(manager,1,2) = 78 then 8888
    else manager end  as 직속상관
from employee;

select eno 사원번호, ename 사원명, manager 직속상관, 
case when manager is null then '0000'
    when substr(manager,1,2) = 75 then '5555'
    when substr(manager,1,2) = 76 then '6666'
    when substr(manager,1,2) = 77 then '7777'
    when substr(manager,1,2) = 78 then '8888'
    else to_char(manager, '9999') end  as 직속상관  -- '9999' -> 의미 없는 숫자
from employee;