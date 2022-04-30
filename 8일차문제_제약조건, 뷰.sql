-- 8���� ���� ( ��������, ��)

    -- 1. employee ���̺��� ������ �����Ͽ� emp_sample �� �̸��� ���̺��� ����ÿ�. 
        --��� ���̺��� �����ȣ �÷��� ���̺� ������ primary key ���������� �����ϵ� �������� �̸��� my_emp_pk�� �����Ͻÿ�. 
        create table emp_sample
        as 
        select * from employee;
        
        select * from emp_sample;
        
        alter table emp_sample
        add constraint PK_emo_pk Primary Key (eno) ;
        
        desc emp_sample;
        
        select * from user_constraints
        where table_name = 'EMP_SAMPLE';
        
-- 2. department ���̺��� ������ �����Ͽ� dept_sample �� �̸��� ���̺��� ����ÿ�. 
    -- �μ� ���̺��� �μ���ȣ �÷��� ������ primary key ���� ������ �����ϵ� ���� �����̸��� my_dept_pk�� �����Ͻÿ�. 
    
    create table dept_sample
    as
    select * from department;
    
    -- ���̺��� ������ ����
    create table dept_sample
    as
    select * from department
    where 0 = 1;
    
    desc dept_sample;
    
    alter table dept_sample
    add constraint MY_DEPT_PK PRIMARY KEY (dno);
    
    select * from user_constraints
    where table_name = 'DEPT_SAMPLE';
    
    
-- 3. ��� ���̺��� �μ���ȣ �÷��� �������� �ʴ� �μ��� ����� �������� �ʵ��� �ܷ�Ű ���������� �����ϵ� ���� �����̸��� my_emp_dept_fk �� �����Ͻÿ�.
    -- [���� : �� ������ ���̺��� ����Ͻÿ�]
    
    alter table emp_sample
    add constraint MY_EMP_DEPT_FK Foreign Key (dno) REFERENCES dept_sample(dno);
    
    desc emp_sample;
    
    select * from user_constraints
    where table_name = 'EMP_SAMPLE';

-- 4. ������̺��� Ŀ�Լ� �÷��� 0���� ū ������ �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
   select * from emp_sample;
   
   -- null ó��..?
   update emp_sample
   set commission = 0
   where commission is null;
   rollback;
   commit;
    
    alter table emp_sample
    add constraint CK_emp_sample_commission check  (commission >= 0); 

-- 5. ������̺��� ���� �÷��� �⺻ ������ 1000 �� �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. 
    -- [���� : �� ������ ���̺��� ����Ͻÿ�]
    alter table emp_sample
    modify salary  default 1000;
    
    desc emp_sample;
    
    insert into emp_sample (eno, ename)
    values(999, 'eumvi');
    

-- 6. ������̺��� �̸� �÷��� �ߺ����� �ʵ���  ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
    -- �ߺ��� ���� �ִ��� Ȯ��
    select ename, count(*)
    from emp_sample
    group by ename
    having count(*) > 2;
    
    alter table emp_sample
    add constraint UK_emp_sample_ename Unique (ename);

-- 7. ������̺��� Ŀ�Լ� �÷��� null �� �Է��� �� ������ ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
    -- ������ null�� �� �ִ� �÷��� not null�� ������ �� ����. -> null���� �ִ��� Ȯ��
    select commission from emp_sample
    where commission is null;
    
    update emp_sample
    set commission = 0
    where commission is null;
    commit;
    
    alter table emp_sample
    modify commission constraint NN_emp_sample_commission Not null ;

-- 8. ���� ������ ��� ���� ������ ���� �Ͻÿ�. 

    -- ���� ������ ���Ž� : Foreign Ket �����ϸ� ���Ű� �ȵȴ�.
        -- 1. Foreign Key �� ���� ���� �� Primary Key����
        -- 2. Primary Key �� ���� �� �� cascade �ɼ��� ��� : Foreign Key���� ���� �ǰ� Primary Key�� ���ŵ�
    alter table emp_sample
    drop constraint PK_EMO_PK;
    
    alter table emp_sample
    drop constraint MY_EMP_DEPT_FK;
    
    alter table emp_sample
    drop constraint UK_EMP_SAMPLE_ENAME;
    
    alter table emp_sample
    drop constraint NN_EMP_SAMPLE_COMMISSION;
    
    alter table dept_sample
    drop constraint MY_DEPT_PK;
    


-- �� ���� 

-- 1. 20�� �μ��� �Ҽӵ� ����� �����ȣ�� �̸��� �μ���ȣ�� ����ϴ� select ���� �ϳ��� view �� ���� �Ͻÿ�.
	-- ���� �̸� : v_em_dno  
        -- �� : ������ ���̺�, select ���� �� �� �ִ�.
            -- ������ ���ؼ� ��� , ���� ���̺��� 
    
    create view v_em_dno
    as 
    select ename , dno
    from employee 
    where dno = 20;
    
    select * from v_em_dno;

-- 2. �̹� ������ ��( v_em_dno ) �� ���ؼ� �޿� ���� ��� �� �� �ֵ��� �����Ͻÿ�. 
        -- �̹� �ִ� �並 �����ϸ� �߰���
   create or replace view v_em_dno
   as 
   select ename , dno, salary 
   from employee;

-- 3. ������  �並 ���� �Ͻÿ�. 

    drop view v_em_dno;

-- 4. �� �μ��� �޿���  �ּҰ�, �ִ밪, ���, ������ ���ϴ� �並 ���� �Ͻÿ�. 
	-- ���̸� : v_sal_emp
        -- group by �ϸ� �� �÷� ��Ī �ݵ�� �����ֱ�
    
    create view v_sal_emp
    as
    select dno, min(salary) minS, max(salary) maxS, avg(salary) avgS, sum(salary) sumS
    from employee
    group by dno;
    
    create or replace view v_sal_emp
    as
    select dno, min(salary) minS, max(salary) maxS, round(avg(salary)) avgS, sum(salary) sumS
    from employee
    group by dno;
    
    select * from v_sal_emp;

-- 5. �̹� ������ ��( v_em_dno ) �� ���ؼ� <<�б� ���� ��>> �����Ͻÿ�. 
    create or replace view v_em_dno
    as 
    select *
    from employee
    with read only;
    
    update v_em_dno
    set dno = 20; -- read-only view