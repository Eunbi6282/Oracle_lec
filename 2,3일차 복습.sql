-- 다양한 함수 확인
-- 문자 조작 함수
    -- concat : 문자와 문자를 연결해서 출력
    -- substr : 문자를 특정 위치에서 잘라오는 함수 (영문, 한글 모두 1byte)
    -- substr :문자를 특정위치에서 잘라오는 함수 (영문은 1byte, 한글은 3byte)
    -- instr : 문자의 특정 위치의 인덱스값을 반환
    -- instrb : 문자의 특정위치의 인덱스값을 반환( 영문은 1byte, 한글은 3byte)
    -- lpad, rpad : 입력받은 문자열에서 특수문자를 적용
    -- trm : 잘라내고 남은 문자를 반환
select 'Oracle', 'maina', concat('Oracle' , 'mania') from dual;

-- concat 
select * from employee;
select '이름은: ' || ename || '이고, 직책은: ' || job || '입니다' as 출력
from employee;

select '이름은: ' || ename || '이고 , 직속상관사번은 : ' || manager || '입니다' 
as 직속상관출력
from employee;

select concat(ename, ' ' || job,hiredate) from employee;

-- substr(대상, 시작위치, 추출할 개수) : 특정 위치에서 문자를 잘라온다.
select 'Oracle maina', substr('Oracle maina',4,3), substr('오라클 매니아' , 2,4) from dual;
select 'Oracle maina', substr('Oracle maina' ,-4,3) , substr('오라클 매니아' , -6,4) from dual;

select ename, substr(ename,2,3) , substr(ename, -5,2) from employee;

-- 형변환 함수
-- to_char : 날짜형 또는 숫자형을 문자형으로 변환
-- to_Date : 문자형을 날짜형으로 변환하는 함수
-- to_number : 문자형을 숫자형으로 변환하는 함수

-- 날짜함수 사용하기
    -- to_char(date,'YYYYMMDD') DAY - 요일 전체 dy-> 요약요일
    select ename, hiredate, to_char(hiredate,'YYYYMMDD'), to_char(hiredate, 'YYMM'),
    to_char(hiredate, 'YYYYMMDD DAY'), to_char(hiredate,'YYYYMMDD dy')
    from employee;
    
    select sysdate, to_char(sysdate, 'YYYY-MM-DD HH:MI:SS DY')
    from dual;
    
    select hiredate, to_char(hiredate, 'YYYY-MM-DD HH:MI:SS DY')
    from employee;
    
    -- to_char에서 숫자와 관련된 형식
/*
    0 :  자릿수를 나타내며 자릿수가 맞지 않을 경우 0으로 채운다.
    9 : 자릿수를 나타내며 자릿수가 맞지 않을 경우 채우지 않는다.
    L : 각 지역별 통화 기호를 출력
    . : 소숫점으로 표현
    , : 천단위 구분자
*/
desc employee;
    --salary -> num
    select ename, salary, to_char(salary, 'L999,999'), to_char(salary,'L0000,0000')
    from employee;

-- to_date('char','format') : 날짜 형식으로 변환
    -- 오류 발생 : date- char (날짜형식에서 문자형식을 빼서 오류)
    select sysdate , sysdate - '20000101'
    from dual;
    
    select sysdate, trunc(sysdate - to_date('20000101','YYYYMMDD'))
    from dual;
    
    select sysdate, to_Date('02/10/10' , 'YY/MM/DD'),trunc( sysdate - to_Date('021010' , 'YYMMDD')) as 날짜의차
    from employee;
