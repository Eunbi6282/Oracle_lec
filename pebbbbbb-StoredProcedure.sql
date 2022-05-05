저장 프로시져 문제 

1. 각 부서별로 최소급여, 최대급여, 평균급여를 출력하는 저장프로시져를 생성하시오. 
	[employee, department ] 테이블 이용
    
        set serveroutput on
        create or replace procedure sp1
        is  -- 변수 선언
            v_dno employee.dno%type;
            v_min employee.salary%type;
            v_max employee.salary%type;
            v_avg employee.salary%type;
            
            -- 레코드 많기 때문에 커서 장착
            cursor c1
            is 
            select dno, min(salary), max(salary) ,round(avg(salary))
            from employee
            group by dno;
            
        begin
            dbms_output.put_line('부서번호      최소급여        최대급여        평균');
            dbms_output.put_line('----------------------------------------------');
            
            open c1;
            
            loop 
                fetch c1 into v_dno,v_min,v_max,v_avg; 
                exit when c1%notfound;
                dbms_output.put_line (v_dno || '부서의 최소 급여는 : ' || v_min || '이고 최대 급여는 ' || 
                v_max || ' 이고 평균 급여는 ' || v_avg || '입니다.'
                );
            end loop;
            
            close c1;
        end;
        /

2.  사원번호, 사원이름, 부서명, 부서위치를 출력하는 저장프로시져를 생성하시오.  
	[employee, department ] 테이블 이용
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
            fetch c1 into v_eno,v_ename, v_dname,  v_loc ;
            exit when c1%notfound;
            dbms_output.put_line ( v_eno || ' ' ||v_ename || ' ' || v_dname|| ' ' || v_loc
        );
        end loop;
        
        close c1;
    end;
    /


3. 급여를 입력 받아  입력받은 급여보다 높은 사원의 사원이름, 급여, 직책을 출력 하세요.
	저장프로시져명 : sp_salary_b

4. 인풋 매개변수 : emp_c10, dept_c10  두개를 입력 받아 각각 employee, department 테이블을 복사하는 저장프로시져를 생성하세요. 
	저장프로시져명 : sp_copy_table
	



5. dept_c10 테이블에서 dno, dname, loc 컬럼의 값을 인풋 받아 인풋 받은 값을 insert하는 저장프로시져를 생성하시요. 
	입력 값 : 50  'HR'  'SEOUL'
	입력 값 : 60  'HR2'  'PUSAN' 

6. emp_c10 테이블에서 모든 컬럼의 값을 인풋 받아 인풋 받은 값을 insert하는 저장프로시져를 생성하시요. 
	입력 값 : 8000  'SONG'    'PROGRAMMER'  7788  sysdate  4500  1000  50 

7. dept_c10 테이블에서 4번문항의 부서번호 50의 HR 을 'PROGRAM' 으로 수정하는 저장프로시져를 생성하세요. 
	<부서번호와 부서명을 인풋받아 수정하도록 하시오.> 
	입력갑 : 50  PROGRAMMER 

8. emp_c10 테이블에서 사원번호를 인풋 받아 월급을 수정하는 저장 프로시져를 생성하시오. 
	입력 값 : 8000  6000

9. 위의 두 테이블명을 인풋 받아 두 테이블을 삭제하는 저장프로시져를 생성 하시오. 

10. 이름을 인풋 받아서 사원명, 급여, 부서번호, 부서명, 부서위치을 OUT 파라미터에 넘겨주는 프로시저를 PL / SQL에서 호출

11. 부서번호를 받아서 사원명, 급여, 직책을 OUT 파라미터에 넘겨주는 프로시저를 PL / SQL에서 호출
