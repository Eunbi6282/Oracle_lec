-- 8���� - ��, ������, �ε���
/*
    �� (view) : ������ ���̺�
        -- ���̺��� ������ ���� ������ �ִ�.
        - ��� ������ ���� ������ �ʴ´�. ���� �ڵ常 �� �ִ�. 
        -- �並 ����ϴ� ���� : 
            (1) ����: ���� ���̺��� Ư�� �÷��� �����ͼ� ���� ���̺��� �߿� �÷��� ���� �� �ִ�.
            (2) ������ ������ �並 �����ؼ� ���ϰ� ����� �� �ִ�. (������ JOIN ����)
        -- ��� �Ϲ������� select ������ �´�. 
        -- ��� insert, update, delete ������ �� �� ����. 
        -- �信 ���� insert�ϸ� ���� ���̺� ����ȴ�. ���� ���̺��� ���������� �� �����ؾ� �Ѵ�. 
        -- �信 ���� insert �� ��� ���� ���̺��� �������ǿ� ���� insert �� ���� �ְ� �׷��� ���� ���� �ִ�. 
*/
    Create table dept_copy60
    as
    select * from department;
    
    create table emp_copy60
    as
    select * from employee;
    
-- �� ����
    create view v_emp_job
    as 
    select eno, ename, dno, job
    from emp_copy60
    where job like 'SALESMAN';
    
-- �� ���� Ȯ��
    select * from user_views;

-- ���� ���� (select * from ���̸�)
    select * from v_emp_job;

-- ������ ���� ������ �信 �����ϱ�

    create view v_join
    as
    select e.dno, ename, job, dname, loc
    from employee e, department d
    where e.dno = d.dno
    and job = 'SALESMAN';
    
    Select * from v_join;
    
-- �並 ����ؼ� ���� ���̺��� �߿��� ���� ����� (������ ���ؼ� �߿��÷��� ���� �� ����)
    select * from emp_copy60;
    
    create view simple_emp
    as
    select ename, job, dno
    from emp_copy50;
    
    select * from simple_emp;  -- view�� ����ؼ� ���� ���̺��� �߿� �÷��� �����. 
    
    select * from user_views;
    
-- �並 ������ �� �ݵ�� ��Ī �̸��� ����ؾ� �ϴ� ��� , group by �� ��
    create view v_groupping
    as 
    select dno , count(*) groupCount, avg(salary) Avg, sum (salary) Sum
    from emp_copy60
    group by dno;
    
    select * from v_groupping;

-- ��� insert, update, delete ������ �� �� ����. / ��� ������ �� as ������ select ������ �;� ��
create view v_error
as 
insert into dno
values (60, 'HR' ,' BUSAN');  -- ���� 
    
    -- view �� ���� insert �� �� ���� ��? -> ����. �÷��� ���� ������ �����ϸ� view���� ���� ���� �� �ִ�.
        -- ���� ���̺� ���� insert �ȴ�. 
        
    create view v_dept
    as 
    select dno, dname
    from dept_copy60;
    
    select * from v_dept;
    
    insert into v_dept  -- �信 ���� insert(���̺� ���� insert ��), ���� ������ ��ġ�� �� �� insert�ȴ�. 
    values( 70, 'HR') 
    
    select * from dept_copy60;
    
    create or replace view v_dept -- v_dept�� �������� ���� ��� : create, ������ ��� : replace(����)
    as 
    select dname , loc
    from dept_copy60;
    
    select * from v_dept;
    
    insert into v_dept
    values ('HR2' , 'BUASN');
    
    select * from dept_copy60;
    
    update dept_copy60
    set dno = 80
    where dno is null;
    commit;
    
    drop  table dept_copy60;
    
    alter table dept_copy60
    add constraint PK_dept_copy60 Primary Key (dno);
    
    select * from user_constraints
    where table_name = 'DEPT_COPY60';
    
    select * from v_dept;
    
    insert into v_dept
    values('HR3', 'Busan2'); -- ���� : �������� �ȸ���. dept_copy60�� �������� PK_dept_copy60 �� ���� �Ǿ����Ƿ� "DNO" �� �;� ��
    
------------------------------------------------------------------------
select * from user_views;
    
select * from v_groupping;  -- �׷��� �� �信�� insert �� �� ����. // �����ؼ� ���� �÷���

    -- �� �����ϱ�
    create or replace view v_groupping     
    as 
    select dno , count(*) groupCount, round(avg(salary),2) Avg, sum (salary) Sum
    from emp_copy60
    group by dno;
    
    drop view v_groupping;

-- �׳� ���縸 �ؿ°Ŷ� ���������� ���� -> insert, update, delete �� ������ ��
create view v_dept10
as 
select dno , dname, loc
from dept_copy60;

select * from dept_copy60;

insert into v_dept10
values (90, 'HR4' ,'Busan4');

select * from v_dept10;

update  v_dept10
set dname = 'HR5' , loc = 'Busan5'
where dno = 90;

delete v_dept10
where dno = 90;
commit;

-- �б⸸ ������ �並 ���� : insert, update,  delete ���ϵ��� ����
    create view v_readOnly
    as 
    select dno, dname, loc 
    from dept_copy60
    with read only;
    
    select * from v_readOnly;
    
    insert into v_readOnly
    values (88, 'HR7', 'Busan7');   -- ���� : read-only view
    
    update v_readOnly
    set dname = 'HR77' , loc = 'Busan77';  -- ���� : read-only view
    
    commit;
    
    







