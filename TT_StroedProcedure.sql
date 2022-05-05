���� ���ν��� ���� 

1. �� �μ����� �ּұ޿�, �ִ�޿�, ��ձ޿��� ����ϴ� �������ν����� �����Ͻÿ�. 
	[employee, department ] ���̺� �̿�
    
        create or replae procedure sp1
        is  -- ���� ����
        
        begin
        
        end;
        /

2.  �����ȣ, ����̸�, �μ���, �μ���ġ�� ����ϴ� �������ν����� �����Ͻÿ�.  
	[employee, department ] ���̺� �̿�
    set serveroutput on
        create or replace procedure sp2
    is
        v_eno employee.eno%type;
        v_ename employee.ename%type;
        v_dname department.dname%type;
        v_loc department.loc%type;
        
        cursor c1
        is 
        -- select �� ��� ���ڵ� ���� cursor ����
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

3. �޿��� �Է� �޾�  �Է¹��� �޿����� ���� ����� ����̸�, �޿�, ��å�� ��� �ϼ���.
	�������ν����� : sp_salary_b
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
            dbms_output.put_line (v_emp.ename || '�� �޿��� �Է��� �� ���� ����' || v_emp.salary || '�Դϴ�. ��å�� ' || v_emp.job);
        end loop;
        close c1;
    end;
    /
    
    exec sp3( 1500);
    
4. ��ǲ �Ű����� : emp_c10, dept_c10  �ΰ��� �Է� �޾� ���� employee, department ���̺��� �����ϴ� �������ν����� �����ϼ���. 
	�������ν����� : sp_copy_table
	-- PL/SQL ���ο��� �͸� ������� ���̺��� ���� : grant create table to public; <SYS�������� ����>
    -- ���� ���ν��� ���� �� : ���� ���� �ؾ� �� : revoke create table from public;
    set serveroutput on
    create or replace procedure sp4(
        v_emp in varchar2,              -- ���� : ',' ������ �ȵ�, �ڷ����� ũ�⸦ �����ϸ� �ȵ�
        v_dept in varchar2
    )
    
    is 
        c1 integer; -- Ŀ�� ���� ���� -> Integer Ÿ������ ����
        v_sql1 varchar2(500);   -- ���̺� ���� ������ ���� ����
        v_sql2 varchar2(500); -- 
    begin
        v_sql1 := 'Create table ' || v_emp || ' as select * from employee';
        v_sql2 := 'Create table ' || v_dept || ' as select * from department';
        
        -- Ŀ�� ����
        c1 := DBMS_SQL.OPEN_CURSOR;
        -- Ŀ�� ����
        DBMS_SQL.Parse (c1, v_sql1, dbms_sql.v7);
        DBMS_SQL.Parse (c1, v_sql2, dbms_sql.v7);
        -- Ŀ�� �ݱ�
        DBMS_SQL.close_cursor(c1);
        
    end;
    /
    
    exec sp4('emp_copy100', 'dept_copy100');
  
      select * from emp_copy100;
      select * from dept_copy100;


5. dept_c10 ���̺��� dno, dname, loc �÷��� ���� ��ǲ �޾� ��ǲ ���� ���� insert�ϴ� �������ν����� �����Ͻÿ�. 
	�Է� �� : 50  'HR'  'SEOUL'
	�Է� �� : 60  'HR2'  'PUSAN' 
    set serveroutput on
    create or replace procedure sp5(
        -- �Ű� ���� 3���� ���� �޾ƾ� ��
        v_dno in dept_copy100.dno%type,
        v_dname in dept_copy100.dname%type,
        v_loc in dept_copy100.loc%type
    )
    is
    
    begin 
        insert into dept_copy100
        values (v_dno, v_dname, v_loc);
        
        dbms_output.put_line ('�� �Է��� �Ǿ����ϴ�.');
        
    end;
    /
    
    exec sp5 ( 50 , 'HR' , 'SEOUL');
	exec sp5( 60 , 'HR2' , 'PUSAN' );

6. emp_c10 ���̺��� ��� �÷��� ���� ��ǲ �޾� ��ǲ ���� ���� insert�ϴ� �������ν����� �����Ͻÿ�. 
	�Է� �� : 8000  'SONG'    'PROGRAMMER'  7788  sysdate  4500  1000  50 

7. dept_c10 ���̺��� 4�������� �μ���ȣ 50�� HR �� 'PROGRAM' ���� �����ϴ� �������ν����� �����ϼ���. 
	<�μ���ȣ�� �μ����� ��ǲ�޾� �����ϵ��� �Ͻÿ�.> 
	�Է°� : 50  PROGRAMMER 

8. emp_c10 ���̺��� �����ȣ�� ��ǲ �޾� ������ �����ϴ� ���� ���ν����� �����Ͻÿ�. 
	�Է� �� : 8000  6000

9. ���� �� ���̺���� ��ǲ �޾� �� ���̺��� �����ϴ� �������ν����� ���� �Ͻÿ�. 

10. �̸��� ��ǲ �޾Ƽ� �����, �޿�, �μ���ȣ, �μ���, �μ���ġ�� OUT �Ķ���Ϳ� �Ѱ��ִ� ���ν����� PL / SQL���� ȣ��
    
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
    
    declare     -- out �Ķ��Ÿ ���� ����
        v_ename employee.ename%type;
        v_salary employee.salary%type;
        v_dno employee.dno%type;
        v_dname department.dname%type;
        v_loc department.loc%type;
    
    begin
        -- �͸� ��������� exec/ execute�� ���U����
        sp_ex10('SCOTT', v_ename, v_salary, v_dno, v_dname, v_loc);
        dbms_output.put_line('��ȸ��� : ' || v_ename || '    ' || v_salary || '   ' || v_dno
        || '    ' || v_dname || '    ' || v_loc);
    end;
    /

11. �μ���ȣ�� �޾Ƽ� �����, �޿�, ��å�� OUT �Ķ���Ϳ� �Ѱ��ִ� ���ν����� PL / SQL���� ȣ��
