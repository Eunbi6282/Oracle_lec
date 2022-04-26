-- 7����
    -- ���̺� ���� : ���̺� ��ü�� ������
        -- ���̺��� �����ϸ�, �÷��� ���ڵ常 ���簡 ��
        -- ���̺� �Ҵ�� ���������� ������� �ʴ´�. (alter table�� ���ؼ� �־���� ��)
        -- �������� : �÷��� �Ҵ�Ǿ� �ִ�. ���Ἲ�� üũ
            -- not null, primary key, unique, foreign key, , check , default
create table dept_copy
as 
select * from department;

desc department;
desc dept_copy;
select * from dept_copy;

create table emp_copy
as 
select * from employee;

desc emp_copy;
desc employee;

    -- ���̺� ���� : Ư�� �÷��� �����ϱ� 
    create table emp_second
    as 
    select eno,ename,salary,dno from employee;
    
    -- ���̺� ���� : ������ ����ؼ� ����. 
    create table emp_third
    as select eno,ename,salary from employee 
    where salary >= 2000;
    select * from emp_third;
    
    -- ���̺� ���� : �÷����� �ٲپ ����
    create table emp_forth
    as 
    select eno �����ȣ, ename �����, salary ���� -- ���̺��, �÷��� <= ������� ����
    from employee;
    
    -- ���̺� ���� : ������ �̿��ؼ� ���̺� ���� : �ݵ�� �˸��ƽ� ������� ��
    create table emp_fifth
    as
    select eno, ename, salary * 12 as salary from employee;
    
    select * from emp_fifth;
    
    -- ���̺��� : ���̺� ������ ����, ���ڵ�� �������� �ʴ´�.
    create table emp_sixth
    as select * from employee
    where 0 = 1;        -- where���� : false�� ����
    
    select * from emp_sixth;
    desc emp_sixth;
    
    -- ���̺� ���� : alter table
    create table dept20
    as
    select * from department;
    
    desc dept20;
    select * from dept20;
    
    -- ������ ���̺��� �÷� �߰� : ����!! �ݵ�� �߰��� �÷��� null�� ����ؾ� �Ѵ�.
    alter table dept20
    add (birth date);
    
    alter table dept20 
    add (email varchar2 (100));
    
    alter table dept20
    add (address varchar2 (200));
    
    -- �÷��� �ڷ����� ���� : 
    desc dept20;
    
    alter table dept20
    modify dname varchar2 (100);
    
    alter table dept20
    modify dno NUMBER(4);
    
    alter table dept20
    modify address Nvarchar2 (200); -- �ѱ� 200�� ���� �� �ֵ��� ó��
    
-- Ư�� �÷� ���� : �����ð� �ܿ� �۾�( ���ϰ� ���� �ɸ� �� �ִ�.)
    alter table dept20
    drop column birth;
    
    select * from dept20;
    
    alter table dept20
    drop column email;
    
    -- �÷��� ���� �� ���ϰ� ���� �߻� �� ->>  
        -- SET UNUSED : Ư�� �÷� ��� ����(������), �߰��� ����
        alter table dept20
        set UNUSED (address);  -- drop�ϱ� ���ؼ� unused ���, �������� �� Ư�� �÷��� �������
        
        desc dept20;
        
        alter table dept20 -- �߰��� ��� ������ �÷��� ����
        drop unused COLUMN;  -- ������� �ʴ� �÷��� ������.
        
/* �÷� �̸� ���� */
    alter table dept20
    rename column loc to locations;
    
    desc dept20;
    
    alter table dept20
    rename column dno to D_number;
    
/* ���̺� �̸� ���� */
    rename dept20 to dept30;
    desc dept30;
    
/* ���̺� ����*/
drop table dept30;

/*
    DDL : Create (����) , Alter (����), Drop( ����)
        ���̺�, �� ,�ε���, Ʈ����, ������, �Լ�, �������ν���.... 
        
    DML : Insert (���ڵ��߰�) , Update(���ڵ����) , Delete (���ڵ� ����)
        << ���̺��� �� (���ڵ� , �ο�) >>
        
    DQL : Select 
    
    -- ���̺��� ��ü �����̳� ���̺��� ���� �� --
    (1) delete : ���̺��� ���ڵ带 ����, where�� ������� ���� �� ��� ���ڵ� ���� <<����>>
    (2) truncate : ���̺��� ���ڵ带 ����, �ӵ��� ������ ���� <<��������>>
    (3) drop : ���̺� ��ü�� ����
*/

    create table emp10
    as select * from employee;
    
    create table emp20
    as select * from employee;
    
    create table emp30
    as select * from employee;
    
    select * from emp10;
    
    -- delete   !!commit!!�ʿ� -> insert, update, delete
        delete emp10;
        commit;
        
        rollback;
        
        select * from emp10;
        
    -- truncate
        truncate table emp20;
        
        select * from emp20;
        
    -- drop
        drop table emp30;
        
drop table emp;
drop table emp_copy;
------------------------------------------------------------------------------------
/*
    ������ ���� : �ý����� ���� ������ ����� �ִ� ���̺�
        USER_ : �ڽ��� ������ ���� ��ü ������ ���
        ALL_ : �ڽ��� ������ ������ ��ü�� ������ �ο����� ��ü������ ���
        DBA_ : ������ ���̽� �����ڸ� ���� ������ ��ü ������ ���
*/
    show user;
    select * from user_tables;  --hr�������� ����� ���� ���̺� ��� ���
    select table_name from user_tables;
    select * from user_views;   -- ����ڰ� ������ �信 ���� ���� ���
    select * from user_indexs;  -- ����ڰ� ������ �ε��� ����
    select * from user_constraints -- �������� Ȯ��
    select * from user_constraints
    where table_name = 'EMPLOYEE'
    select * from user_sequences;
    
    select * from all_tables; -- ��� ���̺������� ������ �ο����� ���̺� ���
    select * from all_views;
    
    select * from dba_tables; -- dba �ν��۵Ǵ� ������ ���������� ���� ����
    

    
    
    
    