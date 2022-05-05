저장 프로시져 문제 

1. 각 부서별로 최소급여, 최대급여, 평균급여를 출력하는 저장프로시져를 생성하시오. 
	[employee, department ] 테이블 이용
    
        create or replae procedure sp1
        is  -- 변수 선언
        
        begin
        
        end;
        /

2.  사원번호, 사원이름, 부서명, 부서위치를 출력하는 저장프로시져를 생성하시오.  
	[employee, department ] 테이블 이용
    set serveroutput on
        create or replace procedure sp2
    is
        v_eno employee.eno%type;
        v_ename employee.ename%type;
        v_dname department.dname%type;
        v_loc department.loc%type;
        
        cursor c1
        is 
        -- select 한 결과 레코드 값에 cursor 장착
        select eno, ename, dname, loc
        from employee e, department d
        where e.dno = d.dno
    begin
        open c1;
        
        loop
            fetch c1 into v_eno,v_ename, v_dname, v_loc ;
            exit when c1%notfound;
            dbms_output.put_line ( v_eno || ' ' ||v_ename || ' ' || v_dname|| ' ' || v_loc
        );
        end loop;
        
        close c1;
    end;
    /

3. 급여를 입력 받아  입력받은 급여보다 높은 사원의 사원이름, 급여, 직책을 출력 하세요.
	저장프로시져명 : sp_salary_b
    set serveroutput on
    create or replace procedure sp3(
        v_salary in employee.salary%type
    )
    is
        v_emp employee%rowtype;
        
        cursor c1
        is 
        select ename, salary, job
        from employee
        where salary > v_salary;
    begin
        open c1;
        loop
            fetch c1 into v_emp.ename, v_emp.salary, v_emp.job;
            exit when c1%notfound;
            dbms_output.put_line (v_emp.ename || '의 급여는 입력한 값 보다 높은' || v_emp.salary || '입니다. 직책은 ' || v_emp.job);
        end loop;
        close c1;
    end;
    /
    
    exec sp3( 1500);
    
4. 인풋 매개변수 : emp_c10, dept_c10  두개를 입력 받아 각각 employee, department 테이블을 복사하는 저장프로시져를 생성하세요. 
	저장프로시져명 : sp_copy_table
	-- PL/SQL 내부에서 익명 블락에서 테이블을 생성 : grant create table to public; <SYS계정으로 접속>
    -- 저장 프로시저 실행 후 : 권한 제거 해야 함 : revoke create table from public;
    set serveroutput on
    create or replace procedure sp4(
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
    
    exec sp4('emp_copy100', 'dept_copy100');
  
      select * from emp_copy100;
      select * from dept_copy100;


5. dept_c10 테이블에서 dno, dname, loc 컬럼의 값을 인풋 받아 인풋 받은 값을 insert하는 저장프로시져를 생성하시요. 
	입력 값 : 50  'HR'  'SEOUL'
	입력 값 : 60  'HR2'  'PUSAN' 
    set serveroutput on
    create or replace procedure sp5(
        -- 매개 변수 3개를 각각 받아야 함
        v_dno in dept_copy100.dno%type,
        v_dname in dept_copy100.dname%type,
        v_loc in dept_copy100.loc%type
    )
    is
    
    begin 
        insert into dept_copy100
        values (v_dno, v_dname, v_loc);
        
        dbms_output.put_line ('잘 입력이 되었습니다.');
        
    end;
    /
    
    exec sp5 ( 50 , 'HR' , 'SEOUL');
	exec sp5( 60 , 'HR2' , 'PUSAN' );

6. emp_c10 테이블에서 모든 컬럼의 값을 인풋 받아 인풋 받은 값을 insert하는 저장프로시져를 생성하시요. 
	입력 값 : 8000  'SONG'    'PROGRAMMER'  7788  sysdate  4500  1000  50 

7. dept_c10 테이블에서 4번문항의 부서번호 50의 HR 을 'PROGRAM' 으로 수정하는 저장프로시져를 생성하세요. 
	<부서번호와 부서명을 인풋받아 수정하도록 하시오.> 
	입력갑 : 50  PROGRAMMER 

8. emp_c10 테이블에서 사원번호를 인풋 받아 월급을 수정하는 저장 프로시져를 생성하시오. 
	입력 값 : 8000  6000

9. 위의 두 테이블명을 인풋 받아 두 테이블을 삭제하는 저장프로시져를 생성 하시오. 

10. 이름을 인풋 받아서 사원명, 급여, 부서번호, 부서명, 부서위치을 OUT 파라미터에 넘겨주는 프로시저를 PL / SQL에서 호출
    
    create or replace procedure sp_ex10(
        v_ename in employee.ename%type,
        v_o_ename out employee.ename%type,
        v_salary out employee.salary%type,
        v_dno out employee.dno%type,
        v_dname out department.dname%type,
        v_loc out department.loc%type
    )
    is 
    begin   
        select ename, salary, e.dno, dname,  loc into v_o_ename, v_salary, v_dno, v_dname, v_loc
        from employee e, department d
        where e.dno = d.dno
        and ename = v_ename;
    end;
    /
    
    declare     -- out 파라메타 변수 선언
        v_ename employee.ename%type;
        v_salary employee.salary%type;
        v_dno employee.dno%type;
        v_dname department.dname%type;
        v_loc department.loc%type;
    
    begin
        -- 익명 블락에서는 exec/ execute를 생랼갛ㅁ
        sp_ex10('SCOTT', v_ename, v_salary, v_dno, v_dname, v_loc);
        dbms_output.put_line('조회결과 : ' || v_ename || '    ' || v_salary || '   ' || v_dno
        || '    ' || v_dname || '    ' || v_loc);
    end;
    /

11. 부서번호를 받아서 사원명, 급여, 직책을 OUT 파라미터에 넘겨주는 프로시저를 PL / SQL에서 호출
