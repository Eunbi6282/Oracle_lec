-13���� - ���� ���ν��� (Stored Procedure) ,�Լ� (Function), Ʈ���� (Trigger)

/*
    ���� ���ν����� ����
        1. PL/SQL �� ��� �����ϴ�. �ڵ�ȭ
        2. ������ ������
            �Ϲ����� SQL : �����м� -> ��ü�̸�Ȯ�� -> ������ Ȯ�� -> ����ȭ -> ������ - ����
            ���� ���ν��� ó�� ���� : �����м� -> ��ü�̸�Ȯ�� -> ������ Ȯ�� -> ����ȭ -> ������ - ����
            ���� ���ν��� �ι�° ������� : ������(�޸𸮿� �ε��) �� �ٷ� �����
        3. �Է� �Ű����� , ��� �Ű������� ����� �� �ִ�.
        5. �Ϸ��� �۾��� ��� ����(���ȭ �� ���α׷����� �����ϴ�.)
*/

1 . ���� ���ν��� ���� 
    -- ���� ����� ������ ����ϴ� ���� ���ν���
    Create procedure sp_salary 
    is 
        v_salary employee.salary%type;  -- ���� ���ν����� is ������� ������ ����
    begin
        select salary into v_salary 
        from employee
        where ename = 'SCOTT';
        
        dbms_output.put_line ('SCOTT�� �޿��� : ' || v_salary || '�Դϴ�.');
        
    end;
    /
    
    drop procedure sp_salary;
2. ���� ���ν����� ������ Ȯ���ϴ� ������ ����
    select  *from user_source
    where name = 'SP_SALARY';
    
3. ���� ���ν��� ����
    execute sp_salary; -- ��ü�̸�
    exec sp_salary; -- ����̸�
    
4. ���� ���ν��� ����, ����
   Create or replace procedure sp_salary -- sp_salary�� �������� ������ ����, �����ϸ� ����
    is 
        v_salary employee.salary%type;  -- ���� ���ν����� is ������� ������ ����
        v_commission employee.commission%type;
    begin
        select salary, commission into v_salary , v_commission
        from employee
        where ename = 'SCOTT';
        
        dbms_output.put_line ('SCOTT�� �޿��� : ' || v_salary || '�Դϴ�. ���ʽ��� '
                              || v_commission  || '�Դϴ�.');
        
    end;
    /
    
    drop procedure sp_salary;
    
--------------------------<��ǲ �Ű������� ó���ϴ� ���� ���ν���>--------------------
    Create or replace procedure sp_salary_ename (       --()�ȿ� �Է¸Ű�����, ��¸Ű������� ���� 
        v_ename in  employee.ename%type -- !!!!!! ������ in  �ڷ��� =>  in (�Է¸Ű�����) !!!!!!!
            -- ���� : ���� �ڷ��� �����ϰ� ; ó�� �ϴµ� ���⼱  ; �ϸ� �ȵ�!!!! �Է�, ��� �Ű������� ������ �ϰ�� , �� ó��
    )
    is 
        -- ���� ���� (���� ���ν������� ����� ���� ������)
        v_salary employee.salary%type;
    begin
        select salary into v_salary
        from employee
        where ename = v_ename;  -- ��ǲ �Ű����� v_ename
        
    
    end;
    /

    exec sp_salary_ename('SCOTT');
    exec sp_salary_ename('SMITH');
    exec sp_salary_ename('KING');
    
    /* �μ� ��ȣ�� ��ǲ�޾Ƽ� �̸�, ��å, �μ���ȣ�� ����ϴ� ���� ���ν��� ���� . Ŀ�� ���*/
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
            dbms_output.put_line (v_ename || '�� ��å�� ' ||v_job || '�̰� �μ���ȣ�� ' || v_dno || '�Դϴ�.');
        end loop;
        
        close c1;
    end;
    /
    drop procedure sp_emp;
    select * from employee
    where dno = 10;
    exec sp_emp(10);
    
    select * from user_tables;
    
    /* ���̺� �̸��� ��ǲ�޾Ƽ� employee ���̺��� �����ؼ� �����ϴ� ���� ���ν����� ����  ��ǲ�� -> emp_copy33*/
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
    
    ---------------------- <������>
    create or replace procedure sp_createTable (
        v_name in varchar2
    )
    is 
        cursor1 integer;    -- Ŀ�� ��� ����
        dbsql varchar2(200); -- sql ������ �����ϴ� ����
        
    begin
        -- Create table ! ������ �ϳ� ����Ǿ� �־�� ��!
        dbsql := 'Create table ' || v_name || ' as select * from employee'; -- ���̺� ���� ������ ������ �Ҵ�
        cursor1 := DBMS_SQL.OPEN_CURSOR;    -- Ŀ�����
        DBMS_SQL.parse (cursor1, dbsql, dbms_sql.v7);   -- Ŀ�� ����ؼ� sql ������ ����
        DBMS_SQL.close_cursor (cursor1);  -- Ŀ�� ����
        
    end;
    /
    
    grant create table to public;  --<<sys>> �������� ����, ������ �ο� �޾ƾ� ��
    
    exec sp_createTable('emp_copy773');
    select * from emp_copy33;
    select * from emp_copy773;
    
------------------------<< ��� �Ű����� ���>>-----------------------------
/*
    ���� ���ν��� : ��� �Ű����� ����(��������), �Լ� : ��� �Ű������� �ϳ��� ����
        -- OUT Ű���带 ���
        -- ���� ���ν����� ȣ��� ���� ���. �Ű����� ���� ���� �� ȣ���� ����
        -- ȣ��� ��� �Ű����� �̸��տ� ' :������(��¸Ű�������)'
        -- ��� �Ű������� ����ϱ� ���ؼ� Print ��ɹ��̳� PL/SQL�� ����ؼ� ����� �� �ִ�. 
*/
    create or replace procedure sp_salary_ename2 (  -- �Է�/ ��� �Ű����� ����� 
        v_ename in employee.ename%type,     -- �Է� �Ű� ���� 
        v_salary out employee.salary%type   -- ��� �Ű� ���� 
    )
    is
    
    begin
        select salary into v_salary 
        from employee
        where ename = v_ename;
    end;
    /
       
    
    -- ������ �������� Ȯ��
    select * from user_source where name = 'SP_SALARY_ENAME2'
    
    -- ��ǲ���� ������ v_salary�� ��´�. v_salary�� �ƿ�ǲ �Ű����� -> ȣ���ϴ� �� (varsalry)�� ��
    -- �ּ�ó�� ����
    variable var_salary varchar2(50); 
    exec sp_salary_ename2 ('SCOTT' , :var_salary); -- SCOTT�� ������ ����ؼ� ��� 
    print var_salary;
    
    -- ȣ��ο��� �ƿ�ǲ �Ű������� ��������� ��
    -- :�ƿ�ǲ�Ű������� :var_salary !! : ���� !!
    
-- OUT �Ķ���͸� ������ ������ ���� ���ν��� ���� �� ��� (PL/SQL)
-- ��� ��ȣ input, ����̸�, �޿�, ��å�� out �Ķ���Ϳ� �Ѱ��ִ� ���ν����� pl/sql�� ����ؼ� ���
    create or replace procedure sel_empo (  -- In, Out: �ڷ����� �����ڷ��� (%type) , �⺻ �ڷ����� ��� ����Ʈ�� ����
        v_eno in number,
        v_ename out varchar2,
        v_sal out number,
        v_job out varchar2
    )
    is
    
    begin
        select ename, salary , job into v_ename, v_sal, v_job  -- ȣ���ϴ� ������ �ٽ� ������
        from employee
        where eno = v_eno;
    end;
    /
    -- ��� �Ķ���� (PL/SQL���)/ ��� ����
    declare -- ���� ����
        var_ename varchar2(50);
        var_sal number;
        var_job varchar2(50);
    begin
    -- �͸� ��Ͽ����� ���� ���ν��� ȣ�� �� exec�� ������ �ʴ´�. 
        -- ���ν��� ȣ��
        sel_empo (7788 , var_ename, var_sal, var_job); -- ���� ���ν��� ȣ�� / ���� �̸��տ� �ݷ� �Ⱥ���
 
        
    end;
    /
    
-----------------------------------------------------------------------------
/* �Լ� (Function) : ���� �־ �ϳ��� ���� ��ȯ, �޾ƿ´�. <= SQL���� ������ ��� �Ұ� ����
    -- �� => ���� ���ν����� out �Ű� ������ ������ ��ȯ �޾ƿ� �� �ִ�. <= SQL���� �������� ��� �Ұ�
*/

    create or replace function fn_salary_ename (  --()�ȿ� ��ǲ �Ű�����
            v_ename in employee.ename%type  -- ��ǲ �Ű������� ������ �ƿ�ǲ�� ����
    )
    return number   -- ȣ���ϴ� ������ ���� ������
    is
        v_salary number(7,2);
    begin 
        select salary into v_salary
        from employee
        where ename = v_ename;  
        
        return v_salary; 
    end;
    /
    
    /* �Լ��� ������ ���� */
    select * from user_source
    where name = 'FN_SALARY_ENAME';
    
    -- 1. �Լ���� 
        -- var_salary : ������ ���� ���� ����
        -- ���Ϲ��� �� ���� �տ� : �� �ִ´�. 
    variable var_salary number;
    exec :var_salary := fn_salary_ename('SCOTT'); 
    print var_salary;
    
    -- 2. �Լ���� (SQL���������� �Լ� ���)
    select ename, fn_salary_ename('SCOTT') as ����
    -- scott�� ������ ��µ�
    from employee
    where ename = 'SCOTT';
    
    -- 3. �Լ� ����
    drop function fn_salary_ename;
    
    