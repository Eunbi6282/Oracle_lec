저장 프로시저 문제 

--1. 각 부서별로 최소급여, 최대급여, 평균급여를 출력하는 저장프로시져를 생성하시오. 
--	[employee, department ] 테이블 이용
     
     create or replace procedure pro_1
     is 
        min_salary employee.salary%type;
        max_salary employee.salary%type;
        avg_salary employee.salary%type;
        v_dno employee.dno%type;
        
        cursor c1
        is 
        select min(salary), max(salary), avg(salary), dno
        from employee
        group by dno;
    begin 
        open c1;
        loop
        
            fetch c1 into min_salary, max_salary, avg_salary, v_dno; 
            exit when c1%notfound;
            dbms_output.put_line (v_dno || '부서의 최소 급여는 : ' || min_salary || '이고 최대 급여는 ' || 
            max_salary || ' 이고 평균 급여는 ' || avg_salary || '입니다.'
            );
        end loop;
        close c1;
        
    end;
    /
    
    exec pro_1;
   

-- 2.  사원번호, 사원이름, 부서명, 부서위치를 출력하는 저장프로시져를 생성하시오.  
	-- [employee, department ] 테이블 이용
    
    create or replace procedure pro_2
    is 
        v_emp employee%rowtype;
        v_dept department%rowtype;
        
        cursor c1
        is 
        select eno, ename, dname, loc
        from employee e, department d
        where e.dno = d.dno;
    begin
        open c1;
        
        loop
            fetch c1 into v_emp.eno, v_emp.ename , v_dept.dname, v_dept.loc;
            exit when c1%notfound;
            dbms_output.put_line ( v_emp.eno || ' ' || v_emp.ename || ' ' || v_dept.dname|| ' ' || v_dept.loc
        );
        end loop;
        
        close c1;
    end;
    /
    
    exec pro_2;


-- 3. 급여를 입력 받아  입력받은 급여보다 높은 사원의 사원이름, 급여, 직책을 출력 하세요.
	-- 저장프로시져명 : sp_salary_b
    
    create or replace procedure sp_salary_b (
        v_salary in employee.salary%type
    )
    is
        v_ename employee.ename%type;
        v_job employee.job%type;
        vv_salary employee.salary%type;
        
        cursor c1
        is
        select ename, job, salary 
        from employee
        where salary > v_salary;
    begin 
        open c1;
        
        loop
            fetch c1 into v_ename, v_job, vv_salary;
            exit when c1%notfound;
            dbms_output.put_line (v_ename || '의 급여는 입력한 값 보다 높은' || vv_salary || '입니다. 직책은 ' || v_job);
        end loop;
        
        close c1;
    end;
    /
    select * from employee;
    exec sp_salary_b (3000);
    
    

-- 4. 인풋 매개변수 : emp_c10, dept_c10  두개를 입력 받아 각각 employee, department 테이블을 복사하는 저장프로시져를 생성하세요. 
	--저장프로시져명 : sp_copy_table
    
    set serveroutput on
    create or replace procedure sp_copy_table(
        v_emp in varchar2,              -- 주의 : ',' 넣으면 안됨, 자료형의 크기를 지정하면 안됨
        v_dept in varchar2
    )
    
    is 
        c1 integer; -- 커서 변수 선언 -> Integer 타입으로 선언
        v_sql1 varchar2(500);   -- 테이블 생성 쿼리를 담을 변수
        v_sql2 varchar2(500); -- 
    begin
        v_sql1 := 'Create table ' || v_emp || ' as select * from employee';
        v_sql2 := 'Create table ' || v_dept || ' as select * from department';
        
        -- 커서 오픈
        c1 := DBMS_SQL.OPEN_CURSOR;
        -- 커서 적용
        DBMS_SQL.Parse (c1, v_sql1, dbms_sql.v7);
        DBMS_SQL.Parse (c1, v_sql2, dbms_sql.v7);
        -- 커서 닫기
        DBMS_SQL.close_cursor(c1);
        
    end;
    /
    
    exec sp_copy_table ('emp_c10', 'dept_c10');

    select * from dept_c10;
	



-- 5. dept_c10 테이블에서 dno, dname, loc 컬럼의 값을 인풋 받아 인풋 받은 값을 insert하는 저장프로시져를 생성하시요. 
--	입력 값 : 50  'HR'  'SEOUL'
--	입력 값 : 60  'HR2'  'PUSAN' 
    
    create or replace procedure pro_3_1(
        v_dno in dept_c10.dno%type,
        v_dname in dept_c10.dname%type,
        v_loc in dept_c10.loc%type
    )
    is
    begin
        
        
        insert into dept_c10
        values(v_dno ,v_dname, v_loc);
    end;
    /
--    
    exec  pro_3_1 (50 , 'HR' , 'SEOUL');
    exec pro_3_1 (60 , 'HR2' , 'PUSAN' );
    select * from dept_c10;
    
--    

-- 6. emp_c10 테이블에서 모든 컬럼의 값을 인풋 받아 인풋 받은 값을 insert하는 저장프로시져를 생성하시요. 
	-- 입력 값 : 8000  'SONG'    'PROGRAMER'  7788  sysdate  4500  1000  50 
    select * from employee;
    create or replace procedure pro_4(
        v_eno in emp_c10.eno%type,
        v_ename in emp_c10.ename%type,
        v_job in emp_c10.job%type,
        v_manager in emp_c10.manager%type,
        v_hiredate in emp_c10.hiredate%type,
        v_salary in emp_c10.salary%type,
        v_commission in emp_c10.commission%type,
        v_dno in emp_c10.dno%type
    )
    is

    begin 
        
       insert into emp_c10
       values(v_eno, v_ename, v_job, v_manager, v_hiredate, v_salary, v_commission ,v_dno);
        
    end;
    /
    
    exec pro_4(8000 , 'SONG'  ,  'PROGRAMER' , 7788 , sysdate , 4500 , 1000,  50 );
    select * from emp_c10;
    

-- 7. dept_c10 테이블에서 4번문항의 부서번호 50의 HR 을 'PROGRAM' 으로 수정하는 저장프로시져를 생성하세요. 
--	<부서번호와 부서명을 인풋받아 수정하도록 하시오.> 
--	입력갑 : 50  PROGRAMMER 
    set serveroutput on
    create or replace procedure pro_5 (
        v_dno in dept_c10.dno%type,
        v_dname in dept_c10.dname%type
    )
    is
    
    begin 
        update dept_c10 
        set dname = v_dname where dno = v_dno;
        
    
    end;
    /
    desc dept_c10;
     exec pro_5 (50, 'PROGRAMMER');
     select * from dept_c10;

-- 8. emp_c10 테이블에서 사원번호를 인풋 받아 월급을 수정하는 저장 프로시져를 생성하시오. 
	-- 입력 값 : 8000  6000
    create or replace procedure pro_6 (
        v_eno in emp_c10.eno%type,
        v_salary in emp_c10.salary%type
    )
    is
        
    begin 
        update emp_c10
        set salary = v_salary where eno = v_eno;
    end;
    /
    
    exec pro_6 (8000, 6000);
    select * from emp_c10;

-- 9. 위의 두 테이블명을 인풋 받아 두 테이블을 삭제하는 저장프로시져를 생성 하시오. 
    set serveroutput on
    create or replace procedure pro7(
        v_emp in varchar2,              -- 주의 : ',' 넣으면 안됨, 자료형의 크기를 지정하면 안됨
        v_dept in varchar2
    )
    
    is 
        c1 integer; -- 커서 변수 선언 -> Integer 타입으로 선언
        v_sql1 varchar2(500);   -- 테이블 생성 쿼리를 담을 변수
        v_sql2 varchar2(500); -- 
    begin
        v_sql1 := 'drop table ' || v_emp;
        v_sql2 := 'drop table ' || v_dept;
        
        -- 커서 오픈
        c1 := DBMS_SQL.OPEN_CURSOR;
        -- 커서 적용
        DBMS_SQL.Parse (c1, v_sql1, dbms_sql.v7);
        DBMS_SQL.Parse (c1, v_sql2, dbms_sql.v7);
        -- 커서 닫기
        DBMS_SQL.close_cursor(c1);
        
    end;
    /
    
    exec pro_7 ('emp_c10', 'dept_c10');
    select * from emp_c10;

-- 10. 이름을 인풋 받아서 사원명, 급여, 부서번호, 부서명, 부서위치을 OUT 파라미터에 넘겨주는 프로시저를 
    --PL / SQL에서 호출
    
    create or replace procedure pro_8 (
        v_name in varchar2,
        v_ename out employee.ename%type,
        v_salary out employee.salary%type,
        v_dno out employee.dno%type,
        v_dname out department.dname%type,
        v_loc out department.loc%type
    )
    is
        
    begin 
        select ename, salary, e.dno, dname, loc into v_ename, v_salary, v_dno, v_dname, v_loc
        from employee e, department d
        where e.dno = d.dno and v_name = ename;
    end;
    /
    
    select * from user_source where name = 'PRO_8';
    
    -- PL / SQL에서 호출
    declare 
        vv_ename employee.ename%type;
        vv_salary employee.salary%type;
        vv_dno employee.dno%type;
        vv_dname department.dname%type;
        vv_loc department.loc%type;
    begin
        pro_8('KING',vv_ename, vv_salary,vv_dno, vv_dname, vv_loc );
        dbms_output.put_line('조회결과 : ' || vv_ename || '    ' || vv_salary || '   ' || vv_dno
        || '    ' || vv_dname || '    ' || vv_loc);
    end;
    /

-- 11. 사원번호를 받아서 사원명, 급여, 직책, 부서명, 부서위치을 OUT 파라미터에 넘겨주는 프로시저를 
    --PL / SQL에서 호출
    
    create or replace procedure pro_9 (
        v_eno in employee.eno%type,
        v_ename out employee.ename%type,
        v_salary out employee.salary%type,
        v_dno out employee.dno%type,
        v_dname out department.dname%type,
        v_loc out department.loc%type
    )
    is
    
    begin 
        select ename, salary, e.dno, dname, loc into v_ename, v_salary, v_dno, v_dname, v_loc
        from employee e, department d
        where e.dno = d.dno
        and eno = v_eno;
    end;
    /
    
    -- PL/SQL 구문으로 출력
    declare 
        vv_ename  employee.ename%type;
        vv_salary  employee.salary%type;
        vv_dno employee.dno%type;
        vv_dname department.dname%type;
        vv_loc department.loc%type;
    begin
        pro_9 (7788, vv_ename , vv_salary, vv_dno ,  vv_dname , vv_loc);
        dbms_output.put_line('조회결과 : ' || vv_ename || '    ' || vv_salary || '   ' || vv_dno
        || '    ' || vv_dname || '    ' || vv_loc);
    end;
    /
    
    

