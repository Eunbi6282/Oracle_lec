
-- Sub Query : select �� ���� select���� �ִ� ����
    -- where ������ : sub query
    -- having ������ : sub query
select ename, salary from employee;
select salary from employee where ename = 'SCOTT';

    -- SCOTT�� ���޺��� ���� ����ڸ� ����϶� (���� ���� ���� - ��������)
    select ename, salary from employee where salary >= 3000;
    select ename, salary from employee 
    where salary >= (select salary from employee where ename = 'SCOTT'); --select ���� ���ϰ��� �¾ƾ� ��
    
    -- SCOTT�� ������ �μ��� �ٹ��ϴ� ����� ����ϱ�
    select * from department;
    
    select ename as ����̸�, e.dno as �μ� ,dname as �μ��̸�
    from employee e , department d
    where e.dno = d.dno
    and e.dno = (select dno from employee where ename = 'SCOTT');
    
    -- �ּ� �޿��� �޴� ����� �̸�, ������, �޿� ����ϱ� (sub query)
    select ename ����̸�, job ������, salary �޿�
    from employee
    where salary = (select min(salary) from employee);
    
    -- 30�� �μ��� �ּ� ���޺��� ���� �޴� ����� ���

    select ename ����̸�, dno �μ���, salary ����
    from employee
    where dno = 30;
    
    select ename ����̸�, dno �μ���, salary ����
    from employee
    where salary > ( select min(salary) from employee where dno = 30);
    
    -- Having���� sub query����ϱ�
        -- �� �μ��� �ּ� ������ ������ -> �� �߿����� 30�� �μ��� �ּ� ���޺��� ū ����
    select dno, min(salary), count(dno)
    from employee 
    group by dno
    having min(salary) > (select min(salary) from employee where dno = 30);
    
-- ������ �������� : sub query�� ��� ���� �� �ϳ��� ���
        -- ������ �� ������ : > ,  < ,= , >= , <= , <>
-- ������ �������� : sub query�� ������� ������ ���
        -- ������ �������� ������ : In, Any, Some, All, Exists
            -- In : ���� ������ ������(' = ' �����ڷ� ���� ���) �� ���������� ������߿� �ϳ��� ��ġ�ϸ� ��
            -- Any, Some : ���������� �� ������ ���� ������ �˻������ �ϳ� �̻� ��ġ�ϸ� ��
            -- All : ���������� �������� ���������� �˻������ ��� ���� ��ġ�ϸ� ��
            -- Exist: ���������� �������� ���������� ������߿��� �����ϴ� ���� �ϳ��� �����ϸ� ��
            
    -- In ������ ���
    select ename, eno, dno ,salary
    from employee 
    order by dno asc;
    
        -- �μ����� �ּ� ������ �޴� ����ڵ� ����ϱ�(Sub Query ����ؼ� ���)
        select dno, min(salary), count(*)
        from employee
        group by dno; -- 1. �� �μ��� �ּ� ���ް�
        
        select dno , min(salary), coun(*)
        from employee
        group by dno
        having min(salary) = (select min(salary) from employ ee);  -- group�� ���� �����ֱ�!! ���� �ٶ����� �׷�Ÿ�� ���߱�
        
        select ename , dno, salary 
        from employee
        where salary in(950,800,1300); -- 2. ���� �� (�������� ��� x)
        
        select ename , dno, salary 
        from employee
        where salary in( select min(salary) from employee group by dno); -- 1+2 -> �������� ���
        
-- Any ������ ���
    -- ���� ������ ��ȯ�ϴ� ������ ���� ����
    -- ' < any'�� �ִ밪���� ������ ��Ÿ��
    -- ' > any' �� �ּҰ����� ŭ�� ��Ÿ��
    -- ' == any'�� in �� ������
    
        -- ������ salesman �̾ƴϸ鼭 �޿��� ������ salesman�� �ִ밪(1600)���� ���� ����� ���
        select eno, ename, job , salary 
        from employee
        where salary < any (select salary from employee where job = 'SALESMAN') 
                and job <> 'SALESMAN';
                
       -- ������ salesman �̾ƴϸ鼭 �޿��� ������ salesman�� �ּҰ�(1250)���� ū ����� ���
        select eno, ename, job , salary 
        from employee
        where salary > any (select salary from employee where job = 'SALESMAN') 
                and job <> 'SALESMAN';         
        
        select eno, ename, job , salary from employee order by job, salary;
        
-- All ������
    --Sub query�� ��ȯ�ϴ� ��� ���� ��
    -- ' > all' : �ִ밪���� ŭ�� ��Ÿ��
    -- ' < all' : �ּҰ����� ������ ��Ÿ��
        
        -- ������ salesman�� �ƴϸ鼭 salesman ���� ������ ���� ��� ����� ��� ���
        select eno, ename, job, salary
        from employee
        where salary < all (select salary from employee where job = 'SALESMAN')
                     and job <> 'SALESMAN';  -- �ּҰ��� 1250���� ���� ���� ���
                     
        -- ��� ������ �м����� ������� �޿��� �����鼭 ������ �м����� �ƴ� ����� ���
        select ename, salary, job
        from employee e
        where salary < all (select salary from employee where job = 'ANALYST')
                    and job <> 'ANALYST';
        
        -- �޿��� ��ձ޿����� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ��� �޿��� ���ؼ� �������� �Ͻÿ�.
        select eno �����ȣ, ename ����̸�, salary ����
        from employee
        where salary > all (select avg(salary) from employee)
        order by salary asc;
        
