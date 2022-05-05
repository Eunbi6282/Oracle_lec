12일차 - PL/SQL : 오라클에서 프로그래밍 요소를 적용한 SQL, 유연하게 처리해서 적용
    SQL : 구조화된 질의언어, but <단점> 유연한 프로그래밍 기능을 적용할 수 없다. 
    MSSQL : T-SQL 
    
set serveroutput on -- PL/SQL의 출력을 활성화 

/* PL SQL의 기본 작성 구문 

        set serveroutput on
        begin 
            --PL SQL구문
        end ;
        /
*/

-- PL SQL 기본 출력
set serveroutput on
begin
    dbms_output.put_line ('Welcome to Oracle');
end;
/

-- PL SQL 변수 선언
 변수명   := 값
 
 -- 자료형 선언
    -- 1. Oracle의 자료형을 사용
    -- 2. 참조 자료형 : 테이블의 컬럼의 선언된 자료형을 참조해서 사용
        -- %type : 테이블의 특정 컬럼의 자료형을 참조해서 사용 (테이블의 컬럼 1개 참조)
        -- %rowtype : 테이블 전체 컬럼의 자료형을 모두 참조해서 사용. 
        
 
 
 
SET SERVEROUTPUT ON 

declare -- 변수 선언시 사용 (변수 선언구)
    v_eno number(4);    -- 오라클의 자료형
    v_ename employee.ename%type; -- 참조 자료형 : 테이블의 컬럼을 자료형을 참조해서 적용하겠다. 
        -- employee테이블의 ename컬럼의 자료형을 가지고 오겠다. 
begin
    v_eno := 7788;              -- := 변수의 값 할당할 때 사용
    v_ename := 'SCOTT';
    
    dbms_output.put_line('사원번호       사원이름');
    dbms_output.put_line('--------------------');
    dbms_output.put_line(v_eno || '      ' || v_ename);
end;
/
    -- 사원번호, 이름 출력하기
    set serveroutput on
    declare
        v_eno employee.eno%type;
        v_ename employee.ename%type;
    
    begin 
        dbms_output.put_line('사원번호       사원이름');
        dbms_output.put_line('--------------------');
        
        select eno, ename into v_eno, v_ename -- select에서 가져온 값을 변수에 할당 
            -- eno -> v_eno, ename -> v_ename
        from employee
        where ename = 'SCOTT';
        
        dbms_output.put_line(v_eno || '      ' || v_ename);
    end;
    /
    
/* PL SQL 에서 제어문 사용     
    - If ~ End if 문 사용하기
    
    */
    
    -- 연봉계산
    set serveroutput on
    declare   
        v_employee employee%rowtype;    -- %rowtype : 테이블의 모든 컬럼의 자료형을 참조해서 사용. 
            -- v_employee 변수는 employee테이블의 모든 컬럼을 참조
        annsal number (7 ,2);   -- 총 연봉을 담는 변수 
    begin 
        select * into v_employee   -- employee의 모든 값중 where ename = 'SCOTT' 에 해당하는 값을 employee에서 모두 가져와서 v_employee에 할당
        from employee
        where ename = 'SCOTT';
        
        if(v_employee.commission is null) then 
            v_employee.commission := 0;
        end if;
        
        annsal := v_employee.salary * 12 + v_employee.commission;
        
        dbms_output.put_line('사원번호      사원이름        연봉');
        dbms_output.put_line('-------------------------------');
        dbms_output.put_line(v_employee.eno || '        ' || v_employee.ename || '      ' || annsal);
    
    end;
    /
    
    set serveroutput on
    declare   
        v_employee employee%rowtype;    -- %rowtype : 테이블의 모든 컬럼의 자료형을 참조해서 사용. 
            -- v_employee 변수는 employee테이블의 모든 컬럼을 참조
       
    begin 
        select * into v_employee   -- employee의 모든 값중 where ename = 'SCOTT' 에 해당하는 값을 employee에서 모두 가져와서 v_employee에 할당
        from employee;
      
        
        dbms_output.put_line('사원번호      사원이름        연봉');
        dbms_output.put_line('-------------------------------');
        dbms_output.put_line(v_employee.eno || '        ' || v_employee.ename);
    
    end;
    /
    
    /* PL SQL을 사용해서 department테이블을 조건 dno = 20을 변수에 담아서 출력*/
    select * from department;
    
    set serveroutput on
    declare 
        v_dno department.dno%type;
        v_dname department.dname%type;
        v_loc department.loc%type;
    begin 
        select dno, dname, loc into v_dno,v_dname,v_loc
        from department
        where dno = 20;
        
        dbms_output.put_line('부서번호      부서이름        지역');
        dbms_output.put_line('-------------------------------');
        dbms_output.put_line(v_dno || '        ' || v_dname || '      ' || v_loc);
    end;
    /
    
    set serveroutput on
    declare 
        v_department department%rowtype;
    begin 
        select * into v_department
        from department
        where dno = 20;
        
        dbms_output.put_line('부서번호      부서이름        지역');
        dbms_output.put_line('-------------------------------');
        dbms_output.put_line(v_department.dno || '        ' || v_department.dname || '      ' || v_department.loc);
    end;
    /
    
    --if ~ Elsif ! Endif
    
    set serveroutput on
    declare
        v_eno employee.eno%type;
        v_ename employee.ename%type;
        v_dno employee.dno%type;
        v_dname department.dname%type;
    begin
        select eno, ename, dno into v_eno, v_ename, v_dno
        from employee
        where ename = 'SCOTT';
        
        if (v_dno = 10) then 
            v_dname := 'Account';
        elsif (v_dno = 20) then
            v_dname := 'RESEARCH';
        elsif (v_dno = 30) then
            v_dname := 'SALES';
        elsif (v_dno = 40) then
            v_dname := 'Operation';
        end if;
        
        DBMS_OUTPUT.PUT_LINE('사원번호      사원명         부서명');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        DBMS_OUTPUT.PUT_LINE(v_eno || '     ' ||v_ename || '        ' || v_dname);
    end;
    /
    
    /* employee ->  조건 : 보너스 1400인것에 대해서*/
    
    set serveroutput on
    declare 
        v_eno employee.eno%type;
        v_ename employee.ename%type;
        v_salary employee.salary%type;
        v_dno employee.dno%type;
        
    begin
        select eno, ename, salary , dno into v_eno, v_ename, v_salary, v_dno
        from employee
        where commission = 1400;
        
        dbms_output.put_line('사원번호      사원명     월급      부서번호');
        dbms_output.put_line('---------------------------------------');
        dbms_output.put_line(v_eno || '     ' || v_ename || '       ' || v_salary || '      ' || v_dno);
    end;
    /
    
    set serveroutput on
    declare 
        v_employee employee%rowtype;
        
    begin
        select * into v_employee
        from employee
        where commission = 1400;
        
        dbms_output.put_line('사원번호      사원명     월급      부서번호');
        dbms_output.put_line('---------------------------------------');
        dbms_output.put_line(v_employee.eno || '     ' || v_employee.ename || '       ' || v_employee.salary || '      ' || v_employee.dno);
    end;
    /
    
    --------------------------------------------------------------------------------------
        
/* 커서(cursor) : PL SQL에서 select한 결과가 단일 레코드가 아니라 레코드 셋인 경우에 커서가 필요하다. 

        declare
            cursor 커서명      1. 커서 선언
            is 
            커서를 부착할 select 구문;
        
        begin
            open 커서명;        2. 커서오픈 
            loop
                fetch 구문       3. 커서를 이동하고 출력
                
        end loop;              4. 커서를 종료
        close 커서명;
        /
*/
        -- 커서를 사용해서 department 테이블의 모든 내용을 출력하기
    set serveroutput on
    declare 
        v_dept department%rowtype;      -- 변수 선언
        
        -- 1. 커서 선언
        cursor c1   -- 커서c1이 작동할 테이블 department
        is 
        select * from department;
    
    begin
        dbms_output.put_line ('부서번호     부서명     부서위치');
        dbms_output.put_line ('------------------------------');
        
        --2. 커서 오픈
        open c1;  
        loop
            fetch c1 into v_dept.dno , v_dept.dname, v_dept.loc;
            exit when c1%notfound;
            dbms_output.put_line(v_dept.dno || '        ' || v_dept.dname || '      ' || v_dept.loc);
        end loop;
        
        -- 4. 커서종료
        close c1;
    end;
    
/* 커서의 속성을 나타내는 속성 값
    커서명%notfound : 커서영역 내의 모든 자료가 fetch되었다면 true
    커서명%fount : 커서영역 내의 fetch되지 않는 자료가 존재하면 true
    커서명%isopen : 커서가 오픈되었더라면 true
    커서명%rowcount : 커서가 얻어온 레코드 개수 

*/
------------------------------------------------------------------------
/*
        문제
        사원명, 부서명, 부서위치, 월급을 출력하는 PL-SQL사용 cursor사용
        
*/
-- 개별 타입
     set serveroutput on
     declare 
        v_ename employee.ename%type;
        v_dname department.dname%type;
        v_loc department.loc%type;
        v_salary employee.salary%type;
        
        cursor c1
        is
        select ename, dname, loc,salary
        from employee e, department d
        where e.dno = d.dno;
    begin
        dbms_output.put_line ('사원명      부서명     위치      월급');
        dbms_output.put_line ('------------------------------');
        
        -- 커서 오픔
        open c1;
        loop 
            fetch c1 into v_ename, v_dname, v_loc, v_salary;
            exit when c1%notfound;
            dbms_output.put_line(v_ename || '        ' || v_dname || '      ' || v_loc || '     ' || v_salary);
        end loop;
        -- 커서종료
        close c1;
    end;
    /

-- row type
    set serveroutput on
    declare
        v_emp employee%rowtype;
        v_dept department%rowtype;
        
        cursor c2
        is
        select ename, dname, loc, salary
        from employee e, department d
        where e.dno = d.dno;
    
    begin
        dbms_output.put_line ('사원명      부서명     위치      월급');
        dbms_output.put_line ('------------------------------');
        
        open c2;
        
        loop
            fetch c2 into v_emp.ename, v_dept.dname, v_dept.loc, v_emp.salary;
            exit when c2%notfound;
            dbms_output.put_line(v_emp.ename || '        ' || v_dept.dname || '      ' ||  v_dept.loc || '     ' || v_emp.salary);
        end loop;
        
        close c2;
    end;
    /

/* cursor for loop 문으로 커서를 사용해서 여러 레코드셋 출력하기 
    - opne과 close를 생략해서 사용
    - 한 테이블의 전체 내용을 출력할 때 사용
    
*/
    set serveroutput on
    declare
        v_dept department%rowtype;
        cursor c1
        is 
        select * from department;
    begin
        dbms_output.put_line ('부서번호     부서명     지역명');
        dbms_output.put_line ('------------------------------');
        for v_dept in c1 loop       --for in loop <open, close 필요 없음>
            dbms_output.put_line(v_dept.dno || '        ' || v_dept.dname || '      ' ||  v_dept.loc);
        end loop;
    end;
    /
    select * from employee;
    
    -- empoloyee 테이블의 모든 내용을 cursor for loop를 사용해서 출력
    set serveroutput on 
    declare
        v_emp employee%rowtype;
        
        cursor c2
        is 
        select * from employee;
    begin
        for v_emp in c2 loop
            dbms_output.put_line(v_emp.eno || '        ' || v_emp.ename || '      ' || v_emp.job || '       ' || v_emp.manager
            || '       ' || v_emp.hiredate || '       ' || v_emp.salary || '       ' || v_emp.commission|| '       ' || v_emp.dno);
        end loop;
    end;
    /
    
    -- employee 테이블의 사원번호, 사원명, 월급을 출력.월급이 2000인 사람 and 부서가 20번, 30번인 사원들 출력/ cursor for loop
    set serveroutput on
    declare
        v_emp employee%rowtype;
        
        cursor c3
        is 
        select eno, ename, salary
        from employee
        where salary >= 2000 and dno in( 20, 30);
    begin
        dbms_output.put_line ('사원번호      사원명        월급');
        dbms_output.put_line ('------------------------------');
        for v_emp in c3 loop
            dbms_output.put_line (v_emp.eno || '      ' || v_emp.ename || '       ' || v_emp.salary);
        end loop;
    end;
    /

    
            