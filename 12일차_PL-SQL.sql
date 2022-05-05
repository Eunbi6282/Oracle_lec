12���� - PL/SQL : ����Ŭ���� ���α׷��� ��Ҹ� ������ SQL, �����ϰ� ó���ؼ� ����
    SQL : ����ȭ�� ���Ǿ��, but <����> ������ ���α׷��� ����� ������ �� ����. 
    MSSQL : T-SQL 
    
set serveroutput on -- PL/SQL�� ����� Ȱ��ȭ 

/* PL SQL�� �⺻ �ۼ� ���� 

        set serveroutput on
        begin 
            --PL SQL����
        end ;
        /
*/

-- PL SQL �⺻ ���
set serveroutput on
begin
    dbms_output.put_line ('Welcome to Oracle');
end;
/

-- PL SQL ���� ����
 ������   := ��
 
 -- �ڷ��� ����
    -- 1. Oracle�� �ڷ����� ���
    -- 2. ���� �ڷ��� : ���̺��� �÷��� ����� �ڷ����� �����ؼ� ���
        -- %type : ���̺��� Ư�� �÷��� �ڷ����� �����ؼ� ��� (���̺��� �÷� 1�� ����)
        -- %rowtype : ���̺� ��ü �÷��� �ڷ����� ��� �����ؼ� ���. 
        
 
 
 
SET SERVEROUTPUT ON 

declare -- ���� ����� ��� (���� ����)
    v_eno number(4);    -- ����Ŭ�� �ڷ���
    v_ename employee.ename%type; -- ���� �ڷ��� : ���̺��� �÷��� �ڷ����� �����ؼ� �����ϰڴ�. 
        -- employee���̺��� ename�÷��� �ڷ����� ������ ���ڴ�. 
begin
    v_eno := 7788;              -- := ������ �� �Ҵ��� �� ���
    v_ename := 'SCOTT';
    
    dbms_output.put_line('�����ȣ       ����̸�');
    dbms_output.put_line('--------------------');
    dbms_output.put_line(v_eno || '      ' || v_ename);
end;
/
    -- �����ȣ, �̸� ����ϱ�
    set serveroutput on
    declare
        v_eno employee.eno%type;
        v_ename employee.ename%type;
    
    begin 
        dbms_output.put_line('�����ȣ       ����̸�');
        dbms_output.put_line('--------------------');
        
        select eno, ename into v_eno, v_ename -- select���� ������ ���� ������ �Ҵ� 
            -- eno -> v_eno, ename -> v_ename
        from employee
        where ename = 'SCOTT';
        
        dbms_output.put_line(v_eno || '      ' || v_ename);
    end;
    /
    
/* PL SQL ���� ��� ���     
    - If ~ End if �� ����ϱ�
    
    */
    
    -- �������
    set serveroutput on
    declare   
        v_employee employee%rowtype;    -- %rowtype : ���̺��� ��� �÷��� �ڷ����� �����ؼ� ���. 
            -- v_employee ������ employee���̺��� ��� �÷��� ����
        annsal number (7 ,2);   -- �� ������ ��� ���� 
    begin 
        select * into v_employee   -- employee�� ��� ���� where ename = 'SCOTT' �� �ش��ϴ� ���� employee���� ��� �����ͼ� v_employee�� �Ҵ�
        from employee
        where ename = 'SCOTT';
        
        if(v_employee.commission is null) then 
            v_employee.commission := 0;
        end if;
        
        annsal := v_employee.salary * 12 + v_employee.commission;
        
        dbms_output.put_line('�����ȣ      ����̸�        ����');
        dbms_output.put_line('-------------------------------');
        dbms_output.put_line(v_employee.eno || '        ' || v_employee.ename || '      ' || annsal);
    
    end;
    /
    
    set serveroutput on
    declare   
        v_employee employee%rowtype;    -- %rowtype : ���̺��� ��� �÷��� �ڷ����� �����ؼ� ���. 
            -- v_employee ������ employee���̺��� ��� �÷��� ����
       
    begin 
        select * into v_employee   -- employee�� ��� ���� where ename = 'SCOTT' �� �ش��ϴ� ���� employee���� ��� �����ͼ� v_employee�� �Ҵ�
        from employee;
      
        
        dbms_output.put_line('�����ȣ      ����̸�        ����');
        dbms_output.put_line('-------------------------------');
        dbms_output.put_line(v_employee.eno || '        ' || v_employee.ename);
    
    end;
    /
    
    /* PL SQL�� ����ؼ� department���̺��� ���� dno = 20�� ������ ��Ƽ� ���*/
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
        
        dbms_output.put_line('�μ���ȣ      �μ��̸�        ����');
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
        
        dbms_output.put_line('�μ���ȣ      �μ��̸�        ����');
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
        
        DBMS_OUTPUT.PUT_LINE('�����ȣ      �����         �μ���');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        DBMS_OUTPUT.PUT_LINE(v_eno || '     ' ||v_ename || '        ' || v_dname);
    end;
    /
    
    /* employee ->  ���� : ���ʽ� 1400�ΰͿ� ���ؼ�*/
    
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
        
        dbms_output.put_line('�����ȣ      �����     ����      �μ���ȣ');
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
        
        dbms_output.put_line('�����ȣ      �����     ����      �μ���ȣ');
        dbms_output.put_line('---------------------------------------');
        dbms_output.put_line(v_employee.eno || '     ' || v_employee.ename || '       ' || v_employee.salary || '      ' || v_employee.dno);
    end;
    /
    
    --------------------------------------------------------------------------------------
        
/* Ŀ��(cursor) : PL SQL���� select�� ����� ���� ���ڵ尡 �ƴ϶� ���ڵ� ���� ��쿡 Ŀ���� �ʿ��ϴ�. 

        declare
            cursor Ŀ����      1. Ŀ�� ����
            is 
            Ŀ���� ������ select ����;
        
        begin
            open Ŀ����;        2. Ŀ������ 
            loop
                fetch ����       3. Ŀ���� �̵��ϰ� ���
                
        end loop;              4. Ŀ���� ����
        close Ŀ����;
        /
*/
        -- Ŀ���� ����ؼ� department ���̺��� ��� ������ ����ϱ�
    set serveroutput on
    declare 
        v_dept department%rowtype;      -- ���� ����
        
        -- 1. Ŀ�� ����
        cursor c1   -- Ŀ��c1�� �۵��� ���̺� department
        is 
        select * from department;
    
    begin
        dbms_output.put_line ('�μ���ȣ     �μ���     �μ���ġ');
        dbms_output.put_line ('------------------------------');
        
        --2. Ŀ�� ����
        open c1;  
        loop
            fetch c1 into v_dept.dno , v_dept.dname, v_dept.loc;
            exit when c1%notfound;
            dbms_output.put_line(v_dept.dno || '        ' || v_dept.dname || '      ' || v_dept.loc);
        end loop;
        
        -- 4. Ŀ������
        close c1;
    end;
    
/* Ŀ���� �Ӽ��� ��Ÿ���� �Ӽ� ��
    Ŀ����%notfound : Ŀ������ ���� ��� �ڷᰡ fetch�Ǿ��ٸ� true
    Ŀ����%fount : Ŀ������ ���� fetch���� �ʴ� �ڷᰡ �����ϸ� true
    Ŀ����%isopen : Ŀ���� ���µǾ������ true
    Ŀ����%rowcount : Ŀ���� ���� ���ڵ� ���� 

*/
------------------------------------------------------------------------
/*
        ����
        �����, �μ���, �μ���ġ, ������ ����ϴ� PL-SQL��� cursor���
        
*/
-- ���� Ÿ��
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
        dbms_output.put_line ('�����      �μ���     ��ġ      ����');
        dbms_output.put_line ('------------------------------');
        
        -- Ŀ�� ����
        open c1;
        loop 
            fetch c1 into v_ename, v_dname, v_loc, v_salary;
            exit when c1%notfound;
            dbms_output.put_line(v_ename || '        ' || v_dname || '      ' || v_loc || '     ' || v_salary);
        end loop;
        -- Ŀ������
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
        dbms_output.put_line ('�����      �μ���     ��ġ      ����');
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

/* cursor for loop ������ Ŀ���� ����ؼ� ���� ���ڵ�� ����ϱ� 
    - opne�� close�� �����ؼ� ���
    - �� ���̺��� ��ü ������ ����� �� ���
    
*/
    set serveroutput on
    declare
        v_dept department%rowtype;
        cursor c1
        is 
        select * from department;
    begin
        dbms_output.put_line ('�μ���ȣ     �μ���     ������');
        dbms_output.put_line ('------------------------------');
        for v_dept in c1 loop       --for in loop <open, close �ʿ� ����>
            dbms_output.put_line(v_dept.dno || '        ' || v_dept.dname || '      ' ||  v_dept.loc);
        end loop;
    end;
    /
    select * from employee;
    
    -- empoloyee ���̺��� ��� ������ cursor for loop�� ����ؼ� ���
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
    
    -- employee ���̺��� �����ȣ, �����, ������ ���.������ 2000�� ��� and �μ��� 20��, 30���� ����� ���/ cursor for loop
    set serveroutput on
    declare
        v_emp employee%rowtype;
        
        cursor c3
        is 
        select eno, ename, salary
        from employee
        where salary >= 2000 and dno in( 20, 30);
    begin
        dbms_output.put_line ('�����ȣ      �����        ����');
        dbms_output.put_line ('------------------------------');
        for v_emp in c3 loop
            dbms_output.put_line (v_emp.eno || '      ' || v_emp.ename || '       ' || v_emp.salary);
        end loop;
    end;
    /

    
            