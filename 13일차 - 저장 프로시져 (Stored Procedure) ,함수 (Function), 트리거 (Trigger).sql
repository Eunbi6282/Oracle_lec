-13일차 - 저장 프로시져 (Stored Procedure) ,함수 (Function), 트리거 (Trigger)

/*
    저장 프로시저의 장점
        1. PL/SQL 을 사용 가능하다. 자동화
        2. 성능이 빠르다
            일반적인 SQL : 구문분석 -> 개체이름확인 -> 사용권한 확인 -> 최적화 -> 컴파일 - 실행
            저장 프로시저 처음 실행 : 구문분석 -> 개체이름확인 -> 사용권한 확인 -> 최적화 -> 컴파일 - 실행
            저장 프로시저 두번째 실행부터 : 컴파일(메모리에 로드된) 이 바로 실행됨
        3. 입력 매개변수 , 출력 매개변수를 사용할 수 있다.
        5. 일련의 작업을 묶어서 저장(모듈화 된 프로그래밍이 가능하다.)
*/

1 . 저장 프로시저 생성 
    -- 스콧 사원의 월급을 출력하는 저장 프로시저
    Create procedure sp_salary 
    is 
        v_salary employee.salary%type;  -- 저장 프로시져는 is 블락에서 변수를 선언
    begin
        select salary into v_salary 
        from employee
        where ename = 'SCOTT';
        
        dbms_output.put_line ('SCOTT의 급여는 : ' || v_salary || '입니다.');
        
    end;
    /
    
    drop procedure sp_salary;
2. 저장 프로시저를 정보를 확인하는 데이터 사전
    select  *from user_source
    where name = 'SP_SALARY';
    
3. 저장 프로시저 실행
    execute sp_salary; -- 전체이름
    exec sp_salary; -- 약식이름
    
4. 저장 프로시저 수정, 삭제
   Create or replace procedure sp_salary -- sp_salary가 존재하지 않으면 생성, 존재하면 수정
    is 
        v_salary employee.salary%type;  -- 저장 프로시져는 is 블락에서 변수를 선언
        v_commission employee.commission%type;
    begin
        select salary, commission into v_salary , v_commission
        from employee
        where ename = 'SCOTT';
        
        dbms_output.put_line ('SCOTT의 급여는 : ' || v_salary || '입니다. 보너스는 '
                              || v_commission  || '입니다.');
        
    end;
    /
    
    drop procedure sp_salary;
    
--------------------------<인풋 매개변수를 처리하는 저장 프로시저>--------------------
    Create or replace procedure sp_salary_ename (       --()안에 입력매개변수, 출력매개변수를 정의 
        v_ename in  employee.ename%type -- !!!!!! 변수명 in  자료형 =>  in (입력매개변수) !!!!!!!
            -- 주의 : 보통 자료형 선언하고 ; 처리 하는데 여기선  ; 하면 안됨!!!! 입력, 출력 매개변수가 여러개 일경우 , 로 처리
    )
    is 
        -- 변수 선언 (저장 프로시저에서 사용할 변수 선언블락)
        v_salary employee.salary%type;
    begin
        select salary into v_salary
        from employee
        where ename = v_ename;  -- 인풋 매개변수 v_ename
        
    
    end;
    /

    exec sp_salary_ename('SCOTT');
    exec sp_salary_ename('SMITH');
    exec sp_salary_ename('KING');
    
    /* 부서 번호를 인풋받아서 이름, 직책, 부서번호를 출력하는 저장 프로시저 생성 . 커서 사용*/
    Create or replace procedure sp_emp(
        v_dno in employee.dno%type
    )
    is 
        v_ename employee.ename%type;
        v_job employee.job%type;
        
        cursor c1
        is 
        select ename, job
        from employee
        where dno = v_dno;
    
    begin
        open c1;
        
        loop
            fetch c1 into v_ename, v_job;
            exit when c1%notfound;
            dbms_output.put_line (v_ename || '의 직책은 ' ||v_job || '이고 부서번호는 ' || v_dno || '입니다.');
        end loop;
        
        close c1;
    end;
    /
    drop procedure sp_emp;
    select * from employee
    where dno = 10;
    exec sp_emp(10);
    
    select * from user_tables;
    
    /* 테이블 이름을 인풋받아서 employee 테이블을 복사해서 생성하는 저장 프로시저를 생성  인풋값 -> emp_copy33*/
    create or replace procedure sp_emp_copy (
        v_tablename in user_tables%rowtype
    )
    begin
    
        create table v_tablename
        as
        select * from employee;
    
  
    end;
    /
    exec sp_emp_copy (emp_copy33);
    
    ---------------------- <선생님>
    create or replace procedure sp_createTable (
        v_name in varchar2
    )
    is 
        cursor1 integer;    -- 커서 담는 변수
        dbsql varchar2(200); -- sql 쿼리를 저장하는 변수
        
    begin
        -- Create table ! 공백이 하나 적용되어 있어야 함!
        dbsql := 'Create table ' || v_name || ' as select * from employee'; -- 테이블 생성 쿼리를 변수에 할당
        cursor1 := DBMS_SQL.OPEN_CURSOR;    -- 커서사용
        DBMS_SQL.parse (cursor1, dbsql, dbms_sql.v7);   -- 커서 사용해서 sql 쿼리를 실행
        DBMS_SQL.close_cursor (cursor1);  -- 커서 중지
        
    end;
    /
    
    grant create table to public;  --<<sys>> 계정에서 실행, 권한을 부여 받아야 함
    
    exec sp_createTable('emp_copy773');
    select * from emp_copy33;
    select * from emp_copy773;
    
------------------------<< 출력 매개변수 사용>>-----------------------------
/*
    저장 프로시저 : 출력 매개변수 지원(여러개의), 함수 : 출력 매개변수를 하나만 가짐
        -- OUT 키워드를 사용
        -- 저장 프로시저를 호출시 먼저 출력. 매개변수 변수 선언 후 호출이 가능
        -- 호출시 출력 매개변수 이름앞에 ' :변수명(출력매개변수명)'
        -- 출력 매개변수를 출력하기 위해서 Print 명령문이나 PL/SQL을 사용해서 출력할 수 있다. 
*/
    create or replace procedure sp_salary_ename2 (  -- 입력/ 출력 매개변수 선언부 
        v_ename in employee.ename%type,     -- 입력 매개 변수 
        v_salary out employee.salary%type   -- 출력 매개 변수 
    )
    is
    
    begin
        select salary into v_salary 
        from employee
        where ename = v_ename;
    end;
    /
       
    
    -- 데이터 사전에서 확인
    select * from user_source where name = 'SP_SALARY_ENAME2'
    
    -- 인풋받은 변수를 v_salary에 담는다. v_salary는 아웃풋 매개변수 -> 호출하는 곳 (varsalry)로 감
    -- 주석처리 주의
    variable var_salary varchar2(50); 
    exec sp_salary_ename2 ('SCOTT' , :var_salary); -- SCOTT의 월급을 계산해서 출력 
    print var_salary;
    
    -- 호출부에서 아웃풋 매개변수를 선언해줘야 함
    -- :아웃풋매개변수명 :var_salary !! : 주의 !!
    
-- OUT 파라미터를 여러개 가지는 저장 프로시저 생성 및 출력 (PL/SQL)
-- 사원 번호 input, 사원이름, 급여, 직책을 out 파라미터에 넘겨주는 프로시져를 pl/sql을 사용해서 출력
    create or replace procedure sel_empo (  -- In, Out: 자료형은 참조자료형 (%type) , 기본 자료형일 경우 바이트수 생략
        v_eno in number,
        v_ename out varchar2,
        v_sal out number,
        v_job out varchar2
    )
    is
    
    begin
        select ename, salary , job into v_ename, v_sal, v_job  -- 호출하는 곳으로 다시 던져줌
        from employee
        where eno = v_eno;
    end;
    /
    -- 출력 파라미터 (PL/SQL사용)/ 출력 구문
    declare -- 변수 선언
        var_ename varchar2(50);
        var_sal number;
        var_job varchar2(50);
    begin
    -- 익명 블록에서는 저장 프로시저 호출 시 exec를 붙이지 않는다. 
        -- 프로시저 호출
        sel_empo (7788 , var_ename, var_sal, var_job); -- 저장 프로시저 호출 / 변수 이름앞에 콜론 안붙임
 
        
    end;
    /
    
-----------------------------------------------------------------------------
/* 함수 (Function) : 값을 넣어서 하나의 값을 반환, 받아온다. <= SQL구문 내에서 사용 불가 가능
    -- 비교 => 저장 프로시저는 out 매개 변수를 여러개 반환 받아올 수 있다. <= SQL구문 내에서는 사용 불가
*/

    create or replace function fn_salary_ename (  --()안에 인풋 매개변수
            v_ename in employee.ename%type  -- 인풋 매개변수는 있지만 아웃풋은 없음
    )
    return number   -- 호출하는 곳으로 값을 던져줌
    is
        v_salary number(7,2);
    begin 
        select salary into v_salary
        from employee
        where ename = v_ename;  
        
        return v_salary; 
    end;
    /
    
    /* 함수의 데이터 사전 */
    select * from user_source
    where name = 'FN_SALARY_ENAME';
    
    -- 1. 함수사용 
        -- var_salary : 월급을 받을 변수 선언
        -- 리턴받을 땐 변수 앞에 : 을 넣는다. 
    variable var_salary number;
    exec :var_salary := fn_salary_ename('SCOTT'); 
    print var_salary;
    
    -- 2. 함수사용 (SQL구문내에서 함수 사용)
    select ename, fn_salary_ename('SCOTT') as 월급
    -- scott의 월급이 출력됨
    from employee
    where ename = 'SCOTT';
    
    -- 3. 함수 삭제
    drop function fn_salary_ename;
    
    