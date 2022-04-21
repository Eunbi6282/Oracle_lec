-- 2���� : DQL : Select

-- desc ���̺� �� : ���̺��� ������ Ȯ��

desc department;

select * from department;

/*
SQL : ����ȭ�� ���� ���
Select ������ ��ü �ʵ� ����
!!!������ �ٲٸ� �ȵ�!!!

Select  <== �÷���
Destinct <== �÷����� ���� �ߺ��� �����ض� 
From <== ���̺��,���
Where <== ����
Group by <== Ư������ �׷���
Having <== �׷����� ���� ����
Order by <== ���� �����ؼ� ���
*/

desc employee;
select *
from employee;

-- Ư�� �÷��� ����ϱ�
select eno, ename from employee;

-- Ư�� �÷��� ������ ����� �� �ִ�.
select eno, ename, eno, ename, ename from employee;

select eno, ename, salary from employee;

-- �÷��� ������ ������ �� �ִ�. 
select eno,ename,salary,salary * 12 from employee;

-- �÷��� �˸��(Alias) : �÷��� �̸��� ����, 
    -- �÷��� ������ �ϰų� �Լ��� ����ϸ� �÷����� ��������. 
select eno, ename, salary, salary * 12 as ���� from employee; -- �÷����� �������� �ٲ����
select eno as �����ȣ, ename as �����, salary as ����, salary * 12 as ���� from employee;
select eno  �����ȣ, ename  �����, salary  ����, salary * 12  ���� from employee;  -- as������ ����
    -- �÷��� �˸���� �����̳� Ư�����ڰ� �� ���� ""���� ó��
-- select eno  ��� ��ȣ, ename  ���*��, salary  ����, salary * 12  ���� from employee; 
select eno  "��� ��ȣ", ename  "���*��", salary  "��?��", salary * 12  ���� from employee;

-- nvl �Լ� : ����ÿ� null�� ó���ϴ� �Լ�
select * from employee;

-- nvl �Լ��� ������� �ʰ� ��ü ������ ���. (null�� �� �÷��� ������ �����ϸ� null�� ǥ�õ�) -> nulló�� �ʿ�
    -- null�� 0���� ó���ؼ� �����ؾ� ��. : NVL
select eno �����ȣ, ename �����, salary ����, commission ���ʽ� ,
salary * 12 ����,  -- null���� ���ԵǾ� ���� �ʱ� ������ ���� ����
(salary * 12 ) + commission "��ü����(���ʽ�����)"        -- ��ü ����(null�� ����)
from employee;

-- nvl�Լ��� ����ؼ� ����
select eno �����ȣ, ename �����, salary ����, commission ���ʽ� ,
salary * 12 ����,  -- null���� ���ԵǾ� ���� �ʱ� ������ ���� ����
(salary * 12 ) + NVL(commission, 0) "��ü����(���ʽ�����)"        -- ��ü ����(null�� ����)
                -- commission �÷���null�� 0���� ó���ض�
from employee;

--Distinct : Ư�� �÷��� ������ �ߺ������� ���
select * from employee;
select dno from employee;
select distinct dno from employee;

select ename, dno from employee;
-- select  ename, distinct dno from employee;  --���� : distinct�� ������ �ϳ��� �÷��� �����ͼ� ����ϱ� , �ٸ� �÷������� ������ �� �� �ִ�.

-- ������ ����ؼ� �˻�(Where)
select * from employee;
select eno �����ȣ, ename �����, job ��å, manager ���, hiredate �Ի糯¥ ,
salary ����, commission ���ʽ�, dno �μ���ȣ 
from employee;

-- �����ȣ�� 7788�� ����� �̸��� �˻�. 
select * from employee
where eno = 7788;

-- �����ȣ�� 7788�� ����� �̸���
select ename from employee 
where eno = 7788; 

-- �����ȣ�� 7788�� ����� �μ���ȣ, ���ް� �Ի糯¥�� �˻�
select dno �μ���ȣ, salary ����, hiredate �Ի糯¥ from employee
where eno = 7788;

-- ���� ������ �� ���̺� ������ ���ڵ��� �ڷ��� Ȯ���ؾ� ��
desc employee;

select * from employee
where ename = 'SMITH';

-- ���ڵ�(�ο�)�� ������ ��
    -- number �� ���� ''�� ������ �ʴ´�.
    -- ���� ������(char, varchar2)�� ��¥(date)�� ������ ���� ''�� ó��. ��ҹ��ڸ� ������
    
-- �Ի糯¥�� '81/12/03'�� ��� ��� <date����>
select ename, hiredate
from employee
where hiredate = '81/12/03';

-- �μ��ڵ尡 10�� ��� ������� ����ض�
select ename, dno
from employee
where dno = 10;

select * from employee;

-- ������ 3000�̻��� ����� �̸��� �μ��� �Ի糯¥�� �⤩
select ename, job, hiredate
from employee
where salary >= 3000;

-- null �˻�: is Ű���� ���. null�� �˻��Ҷ� =null�� ����ϸ� �ȵȴ�. 
select *
from employee
where commission is null;

-- Ŀ�̼��� 300�̻��� ��̿� �̸��� ��å, ���� ���
select *
from employee
where commission >= 300;

-- Ŀ�̼��� ���� ������� �̸��� ���
select ename, commission
from employee
where commission is null;

-- ���ǿ��� and, or, not

-- ������ 500�̻� 2500 �̸��� ������� �̸�, �����ȣ, �Ի糯¥�� ���
select ename �̸�,eno �����ȣ, hiredate �Ի糯¥
from employee
where salary >= 500 and salary < 2500;

-- 1. ��å�� SALESMAN�̰ų� �μ��ڵ尡 20�� ����̸�, ��å, ����, �μ��ڵ�
select ename ����̸�, job ��å, salary ����, dno �μ��ڵ� 
from employee
where job = 'SALESMAN' or dno = 20;

-- 2. Ŀ�̼��� ���� ������߿� �μ��ڵ尡 20�λ������ �̸�, �μ��ڵ�� �Ի糯¥�� ���
select ename ����̸�, dno �μ��ڵ�, hiredate �Ի糯¥, commission ���ʽ�
from employee
where commission is null and dno = 20;

-- 3. Ŀ�̼��� null�� �ƴ� ������� �̸�, �Ի糯¥, ����
select ename ����̸�, hiredate �Ի糯¥, salary ����, commission ���ʽ�
from employee
where commission is not null;

-- ��¥ �˻� :
select * from employee;

-- 1982/1/1 ~ 1983/12/31 ���̿� �Ի��� ����� �̸�, ��å, �Ի糯¥
select ename ����̸�, job ��å, hiredate �Ի糯¥
from employee
where hiredate >= '1982/1/1' and hiredate < '1983/12/31';

-- 1981�⵵�� �Ի��� ����� ����� �̸�, ��å, �Ի糯¥
select ename ����̸�, job ��å, hiredate �Ի糯¥
from employee
where hiredate >= '1981/1/1' and hiredate < '1981/12/31';

-- Betwwen A and B �� ����Ͽ� ó��
select ename ����̸�, job ��å, hiredate �Ի糯¥
from employee
where hiredate between '1981/1/1' and '1981/12/31';

-- In ������
select * from employee;

    -- Ŀ�̼��� 300, 500, 1400�� ����� �̸�, ��å, �Ի����� ���
    select ename ����̸�, job ��å, hiredate �Ի���
    from employee
    where commission =300 or commission = 500 or commission = 1400;
    
    -- In ������ ���
    select ename ����̸�, job ��å, hiredate �Ի���
    from employee
    where commission In (300,500,1400) ;
    
    -- like : �÷����� Ư���� ���ڿ��� �˻�      <= �� �˻������ ����� �� like���
        --  % : �ڿ� � ���ڰ� �͵� ����� ����. 
        --  _ : �ѱ��ڰ� � ���� �͵� �������. 
        
    -- F�� �����ϴ� �̸��� ���� ����ڰ˻��ϱ�
    select * from employee
    where ename like 'F%';
    
    -- �̸��� ES�� ������ ��� �˻�
    select ename from employee
    where ename like '%ES';
    
    -- J�� ���۵ǰ� J�ڿ� �α��ڰ� ����� �͵� �������. �ڿ��� es�� ������
    select ename from employee
    where ename like 'J__ES';
    
    -- ������ ���ڰ� R�� ������ ��� ���
    select ename from employee
    where ename like '%R';
    
    -- MAN �ܾ �� ��åã��
    select * from employee
    where job like '%MAN%';
    
    -- 81�⵵�� �Ի��� ����� ����ϱ�
    select *
    from employee
    where hiredate >= '81/1/1'  and hiredate <= '81/12/31';
    
    -- 81�� 2���� �Ի��� ����� ���
    select *
    from employee
    where hiredate like '81/02%';
    
    -- ���� : order by , asc(������������) : default, desc (�������� ����)
       
    select * 
    from employee
    order by eno; -- asc ������
        
        -- �̸��� ����
    select * 
    from employee
    order by ename desc;
    
    --��¥ ����
    select *
    from employee
    order by hiredate desc;
    
 -- �����亯�� �Խ��ǿ��� �ַλ��. �ΰ��̻��� �÷��� ������ �� 
     -- �ΰ��� �÷��� ���� : ���� ó�� �÷��� ������ �ϰ� ������ ��(�ߺ��� ��)�� ���ؼ� �ι�° �÷��� ����.
     
     select dno, ename from employee
     order by dno , ename ; -- �ΰ� �� asc����
     
     select dno, ename from employee
     order by dno desc, ename1 desc ;-- asc����
     
-- where ���� order by���� ���� ���� ��
    --order by�� ���� �������� �;� ��
select *
from employee
where commission is null
order by ename desc;
     



