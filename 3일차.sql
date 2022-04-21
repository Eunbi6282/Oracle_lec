-- 숫자 함수
/*
Round : 특정 자릿수에서 반올림
Trunc : 특정 자릿수에서 잘라낸다. (버린다.)
MOD : 입력받은 수를 나눈 나머지 값만 출력
*/

-- round (대상) : 소숫점 뒷자리에서 반올림
-- round (대상, 소숫점자릿수) : 
    -- 소숫점 자리수 : 양수일 때 소수점 오른쪽으로 자릿수만큼 이동해서 그 자릿수 뒤에서 반올림 <==!!주의!!
    -- 소숫점 자릿수 : 음수일 때 소숫점 왼쪽으로 자릿수만큼 이동하고 그 자릿수에서 반올림함
        -- 정수를 반올림
        -- 소숫점 자리는 모두 버림
select 98.7654 , Round (98.7564), Round(98.7654,2), round(98.7654,-1), round (98.7654,-2),
    round(98.7654,-3), round(98.7654,3)
from dual ;

select 1235.6789, round(12345.6789), round(12345.6789, -3), round(123678.123456, -3)
from dual;

-- trunc
select 98.7654, Trunc(98.7654),trunc(98.7654 ,2), trunc(98.7654,-1) 
from dual;

-- mod (대상, 나누는 수) : 대상을 나누어서 나머지만 출력
select mod(31,2) , mod(31,5), mod(31,8)
from dual;

select * from employee;

select salary, mod(salary , 300) from employee;

-- employee테이블에서 사원번호가 짝수인 사용자만 
select ename 사원이름, eno 사원번호 from employee
where mod(eno,2) = 0;

/*
    sysdate : 시스템에 저장된 현재 날짜를 출력
    months_between : 두 날짜 사이의 몇개월 인지를 반환
    add_months : 특정날짜의 개월수를 더한다. 
    next_day : 특정날짜에서 최초로 도래하는 인자로 받은 요일의 날짜를 반환
    last_day : 달의 마지막 날짜를 반환
    round : 인자로 받은 날짜를 특정 기준으로 반올림 가능
    trunc : 인자로 받은 날짜를 특정 기준으로 버림.
*/
-- 자신의 시스템의 날짜 출력
select sysdate
from dual;

select sysdate -1 as 어제날짜, sysdate as 오늘날짜, sysdate +1 내일날짜
from dual;

select * from employee 
order by hiredate asc;

select hiredate, hiredate - 1 , hiredate + 10 from employee;

desc employee

-- 입사일에서부터 현재까지의 근무일수를 출력
select round(sysdate - hiredate) as "총 근무 일수", trunc(sysdate - hiredate) as "총 근무 일수"
from employee;
select sysdate - hiredate, round((sysdate - hiredate), 2) as "총 근무 일수"
from employee;

-- 특정날짜에서 월(Month)를 기준으로 버림한 날짜 구하기  -- 다 버림
select hiredate, trunc(hiredate,'MONTH')
from employee;

-- 특정날짜에서 월(Month)를 기준으로 반올림한 날짜 구하기 : 16일(day) 이상일 경우 월을 반올림
select hiredate, round(hiredate,'MONTH')  --
from employee;

-- months_between(date1, date2) : date1과 date2 사이의 월의 개월수를 출력

    -- 입사일에서 현재까지 각 사원들의 근무한 개월 수 구하기
    select ename, sysdate, hiredate, MONTHS_BETWEEN(SYSDATE,hiredate) as "근무 개월수"
    from employee;
    select ename, sysdate, hiredate, trunc(MONTHS_BETWEEN(SYSDATE,hiredate)) as "근무 개월수"
    from employee;

-- add_months(date1, 개월수) : date1날짜에 개월수를 더한 날짜를 출력

    -- 입사한 후 6개월이 지난 시점 출력
    select hiredate, add_months(hiredate, 6)
    from employee;
    
    -- 입사한 후 100일이 지난 시점의 날짜 
    select hiredate, hiredate + 100 as "입사후 100일"
    from employee;

-- next_day (date, '요일') : date의 도래하는 요일에 대한 날짜를 출력하는 함수
select sysdate, next_day(sysdate, '토요일') as "이번주 토요일의 날짜"
from dual;

-- last_Day(date) : date에 들어간 달의 마지막 날짜
select hiredate, last_day(hiredate)
from employee;

-- !!!!!!! 형변환 함수 !!!!!!!! <== 중요
/*
    TO_CHAR : 날짜형 또는 숫자형을 문자형으로 변환
    TO_DATE : 문자형을 날짜형으로 변환하는 함수
    TO_NUMBER : 문자형을 숫자형으로 변환하는 함수
*/

-- 날짜 함수 사용하기
    -- TO_CHAR (date, 'YYYYMMDD')
    select ename, hiredate, to_char(hiredate, 'YYYYMMDD'), to_char(hiredate, 'YYMM'),
    to_char(hiredate, 'YYYYMMDD DAY'), to_char(hiredate, 'YYYYMMDD dy')
    from employee;
    
    -- 오늘 날짜를 출력하고 시간 초 (HH:MI:SS)까지 출력.
    select sysdate, to_char(sysdate, 'YYYY-MM-DD HH:MI:SS DY') 
    from dual;
    
    desc employee;
    
    select hiredate, to_char(hiredate, 'YYYY-MM-DD HH:MI:SS DY' )
    from employee;
    
    -- to_char 에서 숫자와 관련된 형식
    /*
        0 : 자릿수를 나타내며 자릿수가 맞지 않을 경우 0으로 채운다.
        9 : 자릿수를 나타내며 자릿수가 맞지 않을 경우 채우지 않는다.
        L : 각 지역별 통화 기호를 출력
        . : 소숫점으로 표현
        , : 천단위의 구분자
    */
    desc employee;
        -- salay -> num
        select ename, salary,to_char(salary, 'L999,999'), to_char(salary,'L0000,0000')
        from employee;
    
-- to_date( 'char', 'format') : 날짜 형식으로 변환

    --오류발생 : date - char (날짜형식에서 문자형식을 빼서 오류)
    --select sysdate, sysdate - '20000101'
    --from dual;
    
    -- 200000101에서 오늘까지의 일수를 뺌 (날짜 - 날짜)
    select sysdate , Trunc(sysdate - to_date(20000101, 'YYYYMMDD'))
    from dual;
    
    select sysdate,to_date('02/10/10', 'YY/MM/DD') ,trunc(sysdate - to_date('021010' , 'YYMMDD') ) as "날짜의 차"
     -- YY/MM/DD 형식으로 정의된 것을 날짜 타입으로 변환 시켜줌
    from dual;
    
    select hiredate
    from employee;
    
    -- 81/02/22에 입사한 사람 출력
    select ename, hiredate 
    from employee
    where hiredate = '81/02/22';
    
    -- 오류발생
    --select ename, hiredate 
    --from employee
    --where hiredate = 19810222; --num 타입을 hiredate와 같은 데이터 타입으로 변환시켜줘야 함
    
    select ename, hiredate 
    from employee
    where hiredate = to_date(19810222,'YYYYMMDD'); 
    
    -- 오류발생
    --select ename, hiredate
    --from employee
    --where hiredate = 1981-02-22; -- 문자열 변환 필요
    
    select ename, hiredate
    from employee
    where hiredate = to_date('1981-02-22','YYYY-MM-DD');
    
    -- 2000년 12월 25일 부터 오늘까지 총 몇달인지
    select trunc(months_between(sysdate, to_date('2000-12-25','YYYY-MM-DD'))) AS 달의차
    from dual;
    
    select trunc(months_between(sysdate, '2000-12-25')) 
    from dual;
    
-- to_number : number데이터 타입으로 변환
    select 100000 - 50000
    from dual;
    
    -- 오류발생
    select '100,000' - '50,000'
    from dual;
    
    -- '999,999' 의 형식인 '100,000'을 num타입으로 변환해라
    select to_number('100,000' , '999,999') - to_number('50,000','999,999')
    from dual;
    
-- NVL 함수 : null을 다른값으로 치환해주는 함수
    -- nvl (expr1, expr2) : expr1에서 null을 expr2로 치환
select commission
from employee;

select commission, NVL(commission , 0)
from employee;

select manager, NVL(manager, 1111)
from employee;

-- NVL2 
    -- nvl2(expr1, expr2, expr3) : expr1이 null이 아니면 expr2를 출력, expr1이 null이면 expr3출력
select salary, commission
from employee;

    -- NVL1함수로 연봉 계산하기
    select salary, salary * 12, commission, nvl (commission,0), salary * 12 + nvl(commission,0) as 연봉
    from employee;
    
    -- NVL2 함수를 사용해서 연봉 계산하기
    select salary, commission , nvl2(commission, salary * 12 + commission, salary * 12) as 연봉
    from employee;
    
-- nullif : 두 표현식을 비교해서 동일한 경우 Null을 반환하고 동일하지 않은 경우 첫번째 표현식을 반환
select nullif('A','A') , nullif('A','B')
from dual;

-- coalesce함수
coalesce (expr1, expr2, expr3, ....,expr-n) : 
    --  expr1이 null이 아니면 expr1을 반환하고, 
    -- expr1이 null 이고 expr2가 null이 아니면 expr2 반환
    -- expr1 이 null, expr2가 null, expr2 가 null이 아니면 expr3 반환
    
select coalesce ('abc','bcd','efg','ghi')
from  dual;
select coalesce ('','bcd','efg','ghi')
from  dual;
select coalesce ('',null,'efg','ghi')
from  dual;

select ename, salary, commission, coalesce(commission, salary,0)
from employee;

-- decode 함수
/*
    decode (표현식,  조건1, 결과1,
                    조건2, 결과2,
                    조건3, 결과3,
                    기본결과
            )
*/

select ename, dno, decode (dno, 10, 'ACCOUNTING',  -- dno컬럼이 10 이면 ACCOUNTING출력
                                20, 'RESEARCH',
                                30, 'SALES',
                                40, 'OPERATIONS',
                                'DEFAULT') AS DNAME
from employee;                            

-- dno 컬럼이 10번 부서일 경우 월급 + 300, 20번 부서일 경우 월급 + 500 , 30일 경우 월급 + 700/ 이름, 월급, 부서별 월급 플러스한 결과 출력

select * from employee;

select ename 사원이름, salary 월급, dno 부서,decode(dno, 10, salary + 300,
                                             20, salary + 500,
                                             30, salary + 700)
                                             as "부서별 월급"
from employee
order by dno;

-- case : if ~ else, else if~
    /*
    case 표현식 when 조건1 then 결과1
               when 조건2 then 결과2
               when 조건3 then 결과3
               else 결과n
     END
    */
select ename, dno, case when dno = 10 then 'Accounting'
                        when dno = 20 then 'Research'
                        when dno = 30 then 'Sales'
                        else 'Default'
end as 부서명
from employee
order by dno;

                        

