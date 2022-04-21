-- 다양한 함수 사용하기
/*
    1. 문자를 처리하는 함수
    - UPPER : 대문자로 변환
    - LOWER : 소문자로 변환
    - INITCAP : 첫자는 대문자로 나머지는 소문자로 변환
    
    dual 테이블 :하나의 결과를 출력하도록 하는 테이블, 그냥 출력물보기 (가상테이블)
*/

select '안녕하세요' as 안녕 from dual;

select 'Oracle mania', upper ('Oracle Mania'), lower ('Oracle Mania'), initcap   
('Oracle Mania')
from dual;

select * from employee;
select ename, lower (ename), INITCAP(ename), upper(ename) from employee;

select * from employee
where lower(ename) = 'allen';          -- 소문자여서 검색이 안됨, lower적용해주기

select * from employee
where initcap(ename) = 'Allen';  --initcap(ename)을 적용했을 때 Allen인것 출력

-- 문자 길이를 출력하는 함수
    -- length : 문자의 길이를 반환. 한글 영문 상관없이 글자수 리턴
    
    -- lengthb : 문자의 길이를 반환, 한글을 3byte로 반환, 
    
select length ('Oracle mania'), length ('오라클 매니아') from dual;
select lengthb ('Oracle mania'), lengthb ('오라클 매니아') from dual; --공백은 한바이트

select * from employee ;

select ename, length(ename), job, length(job) from employee;

-- 문자 조작 함수
    -- concat : 문자와 문자를 연결해서 출력
    -- substr : 문자를 특정 위치에서 잘라오는 함수 (영문 한글 모두 1byte)
    -- substrb :  문자를 특정 위치에서 잘라오는 함수 (영문은 1byte, 한글은 3byte)
    -- instr : 문자의 특정 위치의 인덱스값을 반환 
    -- instrb : 문자의 특정 위치의 인덱스값을 반환 (영문은 1byte, 한글은 3byte)
    -- lpad, rpad : 입력받은 문자열에서 특수문자를 적용.
    -- trm : 잘라내고 남은 문자를 반환
    
select 'Oracle', 'maina', concat('Oracle', 'mania') from dual;

-- concat
select * from employee;
select concat(ename , '  ' || job) from employee;   -- || : 연결할 때 사용
select '이름은: ' || ename || '이고 , 직책은: ' || job || '입니다' as 출력
from employee;

select '이름은: ' || ename || '이고 , 직속상관사번은 : ' || manager || '입니다.' as 직속상관출력
from employee;


--substr(대상,시작 위치, 추출할 갯수) : 특정 위치에서 문자를 잘라온다.  
select 'Oracle maina', substr('Oracle maina', 4,3), substr('오라클 매니아',2,4) from dual;

select 'Oracle maina', substr('Oracle maina', -4,3), substr('오라클 매니아',-6,4) from dual;

select ename , substr(ename, 2,3) , SUBSTR(ename, -5,2) from employee;

select substrb('Oracle maina',3,3), substrb('오라클 매니아',3,6) from dual;  -- 한글 3바이트 

-- 이름이 M으로 끝나는 사원들 출력하기 (substr사용)
select ename 사원이름, SUBSTR(ename,-1,1) 마지막글자
from employee
where SUBSTR(ename,-1,1)  = 'N';

select ename 사원이름
from employee
where ename like '%N';

-- 87년도 입사한 사원들 출력하기 (substr)사용
select ename 사원이름, substr(hiredate,1,2)
from employee
where substr(hiredate,1,2) = '87';

select ename 사원이름
from employee
where hiredate like '87%';

-- instr(대상, 찾을 글자, 시작 위치, 몇번째 발견) : 대상에서 찾을 글자의 index값을 출력.
select 'Oracle maina' , instr('Oracle maina', 'O') from dual;   -- O가 첫번째에 있다. 
select 'Oracle maina' , instr('Oracle maina', 'a' , 5 , 2) from dual; -- 5번째 부터 a를 찾기 시작, 2번째에 발견되는 a의 index번호를 출력

select 'Oracle maina' , instr('Oracle maina', 'a' , -5 , 1) from dual; 


select distinct instr(job, 'A', 1,1) from employee
where lower(job) = 'manager';

-- lpad, rpad : 특정길이만큼 문자열을 지정해서 왼쪽 혹은 오른쪽에 공백을 특정문자로 처리하는 함수
    --lpad(대상, 늘려줄 문자열 크기, 특수문자적용)  왼쪽으로 늘림
    --rpad(대상, 늘려줄 문자열 크기, 특수문자적용) 오른쪽으로 늘림
select lpad(1234, 10, '#') from dual;  -- 문자열 길이 10자리로 지정
select rpad(1234, 10, '#') from dual; 
select lpad (salary , 10,'*') from employee;
select rpad (salary , 10,'*') from employee;

-- trim : 공백제거, 특정문자도 제거 
    -- ltrim : 왼쪽 공백제거 
    -- rtrim : 오른쪽 공백제거 
    -- trim : 왼쪽, 오른쪽 공백을 제거
select ltrim ('   Oracle maina   ') a, rtrim('   Oracle maina   ') b , trim ('   Oracle maina   ')  c
from dual;



    
    
