-- ���̺� ���� ���� 

-- ���� ���� : ���̺��� �÷��� �Ҵ�Ǿ �������� ���Ἲ�� Ȯ��
    -- Primary Key : ���̺� �ѹ��� ����� �� �ִ�. �ϳ��� �÷�, �ΰ� �̻��� �׷����ؼ� ����
                -- �ߺ��� ���� ���� �� ����. NULL���� ���� �� ����. 
    -- UNIQUE : ���̺� ���� �÷��� �Ҵ��� �� �ִ�. �ߺ��� ���� ���� �� ����. 
                -- NULL�Է� ���� ��, �ѹ��� NULL ��� ����
    -- Foreign Key : �ٸ� ���̺��� Ư�� �÷��� ���� �����ؼ��� ���� �� �ִ�.
                -- �ڽ��� �÷��� ������ ���� �Ҵ����� ���Ѵ�.
    -- Not Null : NULL ���� �÷��� �Ҵ��� �� ����.
    -- Check : �÷��� ���� �Ҵ��� �� üũ�ؼ� (���ǿ� ����) ���� �Ҵ�
    -- Default : ���� ���� ���� �� �⺻���� �Ҵ�. 
    
    SELECT * FROM EMPLOYEE;
    SELECT * FROM DEPARTMENT;
    
    SELECT *
    FROM department, EMPLOYEE;   -- ī��þ� ��
    
    SELECT *
    FROM EMPLOYEE, DEPARTMENT
    WHERE EMPLOYEE.DNO = DEPARTMENT.DNO;
    
--1. EQUI ������ ����Ͽ� SCOTT ����� �μ� ��ȣ�� �μ� �̸��� ��� �Ͻÿ�. 
select ename, e.dno �μ���ȣ, dname �μ��̸�  --dno�� ���� ų
from employee e , department d
where e.dno = d.dno and ename = 'SCOTT';

--2. INNER JOIN�� ON �����ڸ� ����Ͽ� ����̸��� �Բ� �� ����� �Ҽӵ� �μ��̸��� �������� ����Ͻÿ�.
select * from department;

select ename ����̸�, dname �μ��̸�, loc ������ 
from employee e join department d
on e.dno = d.dno ;

-- 3. INNER JOIN�� USING �����ڸ� ����Ͽ� 10�� �μ��� ���ϴ� ��� ��� ������ ������ ���(�ѹ����� ǥ��)�� �μ��� �������� �����Ͽ� ��� �Ͻÿ�. 
-- Join���� using�� ����ϴ� ��� :
    -- natrual join : ���� Ű �÷��� Oracle���ο��� �ڵ�ó��, �ݵ�� �� ���̺��� ���� Ű �÷��� ������ Ÿ���� ���ƾ� �Ѵ�. 
    desc employee;
    desc department;
    -- �� ���̺��� ���� Ű �÷��� ������ Ÿ���� �ٸ� ��� using�� ����ؼ� ó��
    -- �� ���̺��� ���� Ű �÷��� �������� ��� using���
    
    select dno, job, loc
    from employee e inner join department d
    using (dno) 
    where dno = 10;
    


-- 4. NATUAL JOIN�� ����Ͽ� Ŀ�Լ��� �޴� ��� ����� �̸�, �μ��̸�, �������� ��� �Ͻÿ�. 
select ename, dname, loc
from employee e natural join department d
where commission is not null;


-- 5. EQUI ���ΰ� WildCard�� ����Ͽ� �̸��� A �� ���Ե� ��� ����� �̸��� �μ����� ��� �Ͻÿ�. 
select ename, dname
from employee e , department d
where e.dno = d.dno 
and ename like '%A%';

-- 6. NATURAL JOIN�� ����Ͽ� NEW YORK�� �ٹ��ϴ� ��� ����� �̸�, ����, �μ���ȣ �� �μ����� ����Ͻÿ�. 
select ename, job, dno, dname
from employee e NATURAL JOIN department d
where loc = 'NEW YORK';