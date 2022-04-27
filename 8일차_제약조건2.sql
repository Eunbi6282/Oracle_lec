-- ���� ���� ���� (Alter Table : ������ ���̺� ���� ������ ����)

create table emp_copy50
as
select * from employee;

create table dept_copy50
as
select * from department;

select * from user_constraints
where table_name in ('EMPLOYEE' , 'DEPARTMENT');

select * from user_constraints
where table_name in ('EMP_COPY50' , 'DEPT_COPY50'); -- ���� ������ ������� �ʴ´�.

-- ���̺��� �����ϸ� ���ڵ常 ���簡 �ȴ�. ���̺��� ���� ������ ����Ǿ� ���� �ʴ´�. Alter table�� ����ؼ� ���������� ��������� ��
select * from emp_copy50;
select * from dept_copy50;

    Alter Table emp_copy50
    add constraint PK_emp_copy50_eno primary key (eno);
    
    alter table dept_copy50
    add constraint PK_dept_copy50_dno Primary Key(dno);
    
    select * from user_constraints
    where table_name in ('EMP_COPY50' , 'DEPT_COPY50'); 
    
    
    -- Foreign Key 
    alter table emp_copy50
    add constraint FK_emp_copy50_dno_dept_copy50 Foreign Key (dno) REFERENCES dept_copy50 (dno);
    
    
    -- Not Null �������� �߰�
    desc employee; -- PK�÷��� �ݵ�� Not Null�� �����Ǿ�� �Ѵ�. 
    desc emp_copy50; -- Not Null�� �������� �ʾ����� PK�÷��� �Ҵ����� -> not null �ڵ����� �Ҵ� 
    desc department;
    desc dept_copy50; -- Not Null�� �������� �ʾ����� PK�÷��� �Ҵ����� -> not null �ڵ����� �Ҵ� 
    
        -- ������ null�� �� �ִ� �÷��� Not Null�� ������ �� ����. 
        select ename from employee
        where ename is null; -- null�� �ִ��� Ȯ��
        alter table emp_copy50
        modify ename constraint NN_emp_copy50_ename not null;
        
        -- commisson �÷��� not null �Ҵ��ϱ� : null�� �� �ִ� ��� null�� ó�� �ؾ� ��
        select commission from emp_copy50
        where commission is null;
        
        alter table emp_copy50
        modify commission constraint NN_emp_copy50_commission not null; -- null�� �־ �ȵ�
        
        -- null ó��
        update emp_copy50
        set commission = 0
        where commission is null;
        commit;
        
        alter table emp_copy50
        modify commission constraint NN_emp_copy50_commission not null;
        
    -- Unique �������� �߰� : �÷��� �ߺ��� ���� ������ �Ҵ����� ���Ѵ�. 
        -- �ߺ��� ���� �ִ��� Ȯ��
        select ename, count(*)
        from emp_copy50
        group by ename -- ename �÷��� �׷����ؼ� ���� ��
        having count(*) > 2;
        
        alter table emp_copy50
        add constraint UK_emp_copy50_ename unique (ename);
        
    -- Check �������� �߰�
    select * from emp_copy50;
    
        -- salary�� �Ͼ� �̸��� ���鸸 �÷��� �� �� �ְ�
        alter table emp_copy50
        add constraint CK_emp_cpoy50_salary Check (salary > 0 and salary < 10000 );
        
    select * from user_constraints
    where table_name in ('EMP_COPY50' , 'DEPT_COPY50'); 
    
    -- default �������� �߰� < ���� ������ �ƴ� : ���� ���� �̸��� �Ҵ��� �� ���� >
        -- ���� ���� ���� ��� default�� ������ ���� ����. 
    alter table emp_copy50
    modify salary default 1000;
    
    desc emp_copy50;
    
    insert into emp_copy50(eno, ename, commission)
    values (9999, 'JULI', 100);
    
    alter table emp_copy50
    modify hiredate default sysdate;
    insert into emp_copy50
    values (8888, 'JULIA', null, null, DEFAULT, default,1500,null);
    
-- ���� ���� ���� : alter table ���̺�� drop 

    -- Primary Key ���� 
    alter table emp_copy50  -- ���� ����
    drop Primary Key;
    
    alter table dept_copy50  -- ���� : emp_copy50���� �� ���̺��� PrimaryŰ�� �����ϰ� �ֱ� ������
    drop Primary Key;
    
    desc dept_copy50;
    
    alter table dept_copy50 --foreign Ű�� ���� �����ϰ�  Primaty key����
    drop primary key cascade;
    
    select * from user_constraints
    where table_name in ('EMP_COPY50' , 'DEPT_COPY50');
    
    -- nou null�÷� �����ϱ� : 
    alter table emp_copy50
    drop constraint NN_EMP_Dopy5_ename;
    
    --unique, check ���� ���� �����ϱ� (���� ���� �̸����� ����)
    alter table emp_copy50
    drop constraint UK_EMP_COPY50_ENAME;
    
    alter table emp_copy50
    drop constraint CK_EMP_COPY50_SALARY;
    
    alter table emp_copy50
    drop constraint NN_EMP_COPY50_COMMISSION;
    
    --default ������ ������ null ��� �÷��� default null�� ���� : default ���� ������ ����
    alter table emp_copy50
    modify hiredate default null;
    
    --���� ���� disable / enable
        --���� ������ ��� �ߴܽ�Ŵ
        --�뷮(bulk insert)���� ���� ���̺� �߰��� �� ���ϰ� ���� �ɸ�. disable => enable
        --index�� ���� �� ���ϰ� ���� �ɸ���. disable => enable
    
    alter table dept_copy50
    add constraint PK_dept_copy50_dno primary key(dno);
    
    alter table emp_copy50
    add constraint PK_emp_copy50_eno primary key(eno);
    
    alter table emp_copy50
    add constraint FK_emp_copy50_dno foreign key(dno) references dept_copy50(dno);
    
    select * from user_constraints
    where table_name in('EMP_COPY50','DEPT_COPY50');
    
    select * from emp_copy50;
    select * from dept_copy50;
    
    alter table emp_copy50
    disable constraint FK_emp_copy50_dno;
    
    insert into emp_copy50(eno,ename,dno)
    values (8989,'aaaa',50);
    
    insert into dept_copy50
    values (50,'HR','SEOUL');
    
    alter table emp_copy50
    enable constraint FK_emp_copy50_dno;

    







    
    -- Unique , check �������� ���� <<�������� �̸����� �װ�>>
    alter table emp_copy50
    drop constraint UK_EMP_Copy50_ENAMKE;
    
     alter table emp_copy50
    drop constraint CK_EMP_Copy50_ENAMKE;
    
     alter table emp_copy50
    drop constraint NN_EMP_Copy50_commission;
    
    -- defaulkt�� j=ubll��ˤ��� �÷��� defaultk null�Ƿ� ���� ; defaultk ���� ���ǵ� �ַ�����
    alter table emp_copy50
    modify hiredate default null;
    
-- �������� disalble, enable
    -- ���� ������ ��� ������Ŵ
    -- �뷮 (Bulk Insert)���� ���� ���̺� �߰��� �� ���ϰ� ���� �ɸ���.  disable --> enable
    -- Index(�� ������ ���ϰ� ���� �ɸ��٤�. disable = >enable
    
    alter table dept_copy50
    add constraint PK_dept_copy50_dno Primary Key (dno);
    
    alter table emp_copy50
    add constraint PK_emp_copy50_eno Primary Key (eno);
    
    alter table emp_copy50
    add constraint FK_emp_copy50_dno_dept_copy50 Foreign Key (dno) references dept_copy50 (dno);
    
    select * from emp_copy50;
    select * from dept_copy50;
    
    insert into emp_copy50 (eno, ename, dno)
    values (8989, 'aaaa' ,50);
    
    alter table emp_copy50
    disable constraint FK_EMP_COPY50_DNO_DEPT_COPY50;
    
    insert into dept_copy50
    values (50, 'HR','seoul');
    
    
    
    alter table emp_copy50
    enable constraint FK_EMP_COPY50_DNO_DEPT_COPY50;
    