--4����
/*
    �׷��Լ� : ������ ���� ���ؼ� �׷����ؼ� ó���ϴ� �Լ� 
            group by ���� Ư���÷��� ������ ���, �ش� �÷��� ������ ������ �׷����ؼ� ������ ����.
            
    �����Լ� : 
        -sum : �׷��� �հ�
        -AVG : �׷��� ���
        -MAX : �׷��� �ִ밪         
        -MIN : �׷��� �ִ밪 
        -COUNT : �׷��� �Ѱ���(���ڵ�� record, �ο�� row )
*/


select  sum(salary),round(avg(salary),2),max(salary),min(salary)
from employee;

--���� : �����Լ��� ó���� �� , ��� �÷��� ���ϰ����� ������ �÷��� ����
--sum�� ���� ���Ϸγ����µ� �ٸ� ���� ���� ���� �ƴѰ�� �����߻�
select sum (salary),ename from employee;
select sum (salary) from employee;

select *
from employee;

--�����Լ��� null ���� ó���ؼ� �����Ѵ�.
select sum (commission),avg(commission),max(commission),min(commission)
from employee;

--count() : ���ڵ� ��, �ο� �� 
    --null�� ó������ �ʴ´�.
    --���̺��� ��ü ���ڵ� ���� �����ð��  : count(*) �Ǵ� not null �÷��� count())
select eno from employee; --���ڵ� 14�� 
select count (eno)from employee;

select commission from employee;
select count(commission) from employee;

select count(*) from employee;
--��ü ���ڵ� ī��Ʈ
select count(*) from employee;
select count (eno)from employee;
 
-- �ߺ����� �ʴ� ������ ����

select job from employee;

select count(distinct job) from employee;

--�μ��� ���� (dno)
select count( distinct dno) from employee;

-- Group by : Ư�� �÷��� ���� �׷���. �ַ� ���� �Լ��� select ������ ���� ����Ѵ�. 
/*
    select �÷���, �����Լ�ó���� �÷�
    from ���̺�
    where ����
    group by �÷���
    having ���� (group by�� ����� ����)
    order by ����
*/

--�μ��� ��� �޿�
select dno as �μ���ȣ, avg(salary) as ��ձ޿�
from employee
group by dno; -- dno �÷��� �ߺ��� ���� �׷���



select dno from employee order by dno;

-- ��ü ��� �޿�
select avg(salary) as ��ձ޿�
from employee;

-- group by�� ����ϸ鼭 select ���� ������ �÷��� �� �����ؾ� �Ѵ�. 
select dno ,count(dno) ,sum(salary), ename  --ename(���ڵ� 14��)�÷��� ���� ���� �߻�, �������� �׷��� �� �Ϳ� ���� �Լ��� ���;� ��
from employee
group by dno;

select dno ,count(dno) ,sum(salary), avg(salary), max(commission), min(commission)  --ename(���ڵ� 14��)�÷��� ���� ���� �߻�, �������� �׷��� �� �Ϳ� ���� �Լ��� ���;� ��
from employee
group by dno; --!! �μ��� !!�� ���, �հ�, �ִ밪, �ּҰ�

-- 
select job from employee;

-- ��å�� ���� �׷��� , ������ ��å�� �׷����ؼ� ������ ���, �հ�, �ִ밪, �ּҰ�
select job,count(job) ,trunc(avg(salary)), sum(salary), min(salary), max(salary)
from employee
group by job;

-- ���� �÷��� �׷����ϱ�
    -- �׷����� �÷��� select���� �� �� �ִ�. 
select dno, job,  count(*), sum(salary) 
from employee
group by dno, job;      -- �� �÷� ��� ��ġ�ϴ� ���� �׷���

select dno, job
from employee
where dno = 20 and job = 'CLERK';

-- having : group by���� ���� ����� �������� ó���� �� , group by�� �־�� ����� �� �ִ�. 
    -- having���� ��Ī �̸��� �������� ����ϸ� �ȵȴ�. 
    
    -- �μ��� ������ �հ谡 9000�̻��� �͸� ���
    select dno, count(*), sum(salary) as "�μ��� �հ�", round(avg(salary),2) as "�μ��� ���"
    from employee
    group by dno
    having sum(salary) >= 9000;  -- �׷캰�� ���� �Ϳ� ������ �� �� having ���
    
    -- �μ��� ������ ����� 2000�̻��ΰ͸� ���
    select dno, count(*), sum(salary) as "�μ��� �հ�", round(avg(salary),2) as "�μ��� ���"
    from employee
    group by dno
    having round(avg(salary),2) >= 2000.00;  -- �׷캰�� ���� �Ϳ� ������ �� �� having ���
    
    -- where �� having���� ���� ���Ǵ� ���
        -- where : ���� ���̺��� �������� �˻�
        -- having : group by ����� ���ؼ� ������ ó���� �� ���
    select * from employee;
    
    -- ������ 1500���ϴ� �����ϰ� �� �μ����� ������ ����� ���ϵ� ������ ����� 2000�̻��ΰ͸� ���
    select dno , round(avg(salary))
    from employee
    where salary > 1500
    group by dno
    having avg(salary) >= 2500;
    
-- ROLLUP
-- CUBE
    -- Group by ������ ����ϴ� Ư���� �Լ�
    -- ���� �÷��� ������ �� �ִ�. 
    -- group by���� �ڼ��� ������ ���

    -- 1. rollup�� cube�� ������� �ʴ� ���
    SELECT dno, count(*), sum(salary), round(avg(salary))
    FROM employee
    GROUP BY dno
    order by dno;
    
    -- rollup : �μ��� �հ�� ����� �����, ���������ο� ��ü�հ�, ���
    SELECT dno, count(*), sum(salary), round(avg(salary))
    FROM employee
    GROUP BY rollup(dno)
    order by dno;
    
    -- cube : �μ��� �հ�� ����� �����, ���������ο� ��ü�հ�, ���
    SELECT dno, count(*), sum(salary), round(avg(salary))
    FROM employee
    GROUP BY cube(dno)
    order by dno;
    
    -- rollup: �� �÷��̻�
    select dno ,  job, count(*), max(salary), sum(salary), round(avg(salary))
    from employee 
    group by rollup(dno, job); -- �ΰ��� �÷��� �����, �� �÷��� ���ļ� ������ �� �׷���.
    --10		3	5000	8750	2917 <rollup>
                --3�������� �ִ밪     -- 3�������� ��  -3�������� ���
    select dno ,  job, count(*), max(salary), sum(salary), round(avg(salary))
    from employee 
    group by dno, job
    order by dno;             
    
    select dno ,  job, count(*), max(salary), sum(salary), round(avg(salary))
    from employee 
    group by cube(dno, job)
    order by dno, job;
    
   
    
    
    
    


