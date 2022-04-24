-- 7. SELF JOIN�� ����Ͽ� ����� �̸� �� �����ȣ�� ������ �̸� �� ������ ��ȣ�� �Բ� ��� �Ͻÿ�. 
 	-- ������ ��Ī���� �ѱ۷� �����ÿ�. 
    
    select * from employee;
    select ��.ename ����̸�, ��.eno �����ȣ ,��.ename �������̸� , ��.eno �����ڻ��
    from employee ��, employee ��
    where ��.manager = ��.eno;

-- 8. OUTER JOIN, SELF JOIN�� ����Ͽ� �����ڰ� ���� ����� �����Ͽ� �����ȣ�� �������� �������� �����Ͽ� ��� �Ͻÿ�.
    -- Outer Join
    select ��.ename ����̸�, ��.eno �����ȣ ,��.ename �������̸� , ��.eno �����ڻ��
    from employee �� join employee ��
    on ��.manager  = ��.eno (+)
    order by ��.eno desc; 
    
    -- Self Join
    


-- 9. SELF JOIN�� ����Ͽ� ������ ���('SCOTT')�� �̸�, �μ���ȣ, ������ ����� ������ �μ����� �ٹ��ϴ� ����� ����Ͻÿ�. 
   --��, �� ���� ��Ī�� �̸�, �μ���ȣ, ����� �Ͻÿ�. 
   
   select e.ename �̸�, e.dno �μ���ȣ , m.dno ,m.ename ���� 
   from employee e, employee m
   where e.dno = m.dno  --SCOTT 20�� �μ��� �ٴ�, 20�� �μ��� �ٴϴ� ����� ���
   and e.ename = 'SCOTT';

-- 10. SELF JOIN�� ����Ͽ� WARD ������� �ʰ� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�. 
    select m.ename ����̸�, m.hiredate �Ի���
    from employee e, employee m
    where e.hiredate = m.hiredate
    and m.hiredate > (select hiredate from employee where ename = 'WARD')
    order by m.hiredate;
   

-- 11. SELF JOIN�� ����Ͽ� ������ ���� ���� �Ի��� ��� ����� �̸� �� �Ի����� ������ �̸� �� �Ի��ϰ� �Բ� ����Ͻÿ�. 
    -- ��, �� ���� ��Ī�� �ѱ۷� �־ ��� �Ͻÿ�. 
    select ��.ename , ��.hiredate, ��.ename, ��.hiredate
    from employee ��, employee ��
    where ��.manager = ��.eno
    and ��.hiredate < ��.hiredate;
    
 -- <<�Ʒ� ������ ��� Subquery�� ����Ͽ� ������ Ǫ����.>>

-- 1. �����ȣ�� 7788�� ����� ��� ������ ���� ����� ǥ��(����̸� �� ������) �Ͻÿ�.  
    select ename ����̸�, job ������, eno
    from employee
    where job  = (select job from employee where eno = 7788);

-- 2. �����ȣ�� 7499�� ������� �޿��� ���� ����� ǥ�� (����̸� �� ������) �Ͻÿ�.
    select ename ����̸�, job ������, salary �޿�
    from employee
    where salary > (select salary from employee where eno = 7499)
    order by salary;

-- 3. �ּ� �޿��� �޴� ���޺��� ����� �̸�, ��� ���� �� �޿��� ǥ�� �Ͻÿ�(�׷� �Լ� ���)
    select job , min(salary) 
    from employee
    group by job; 
    
    select ename ����̸�, job ������, salary ����
    from employee
    where
    salary = any (select min(salary) from employee  group by job)
    order by job;  

-- 4. ���޺��� ��ձ޿��� ���ϰ�, ���� ���� ���� ��տ��� ���� ���� ����� ���ް� �޿��� ǥ���Ͻÿ�
    select job, round(avg(salary))
    from employee 
    group by job;
    
    select ename ����̸�, job ����, salary �޿�
    from employee
    where job = 'CLERK' and salary = (select min(salary) from employee where job = 'CLERK');
    

-- 5. �� �μ��� �ּ� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ�� ǥ���Ͻÿ�.
    select ename ����̸�, salary �޿�, dno �μ���ȣ
    from employee
    where salary = any ( select min(salary)
    from employee
    group by dno);
    
    -- �� �μ���ȣ �� �ּҰ�
    select min(salary)
    from employee
    group by dno;

-- 6. ��� ������ �м���(ANALYST) �� ������� �޿��� �����鼭 ������ �м����� �ƴ� ������� ǥ�� (�����ȣ, �̸�, ������, �޿�) �Ͻÿ�.
    select eno �����ȣ, ename �̸�, job ������ , salary �޿�
    from employee
    where salary < all (select salary  from employee where job = 'ANALYST')
                    and job <> 'ANALYST'
    order by salary desc;

-- 7. ���������� ���� ����� �̸��� ǥ�� �Ͻÿ�. 
    select ename, job, manager , eno
    from employee
    where eno not in (select manager
    from employee
    group by manager);
    
    -- manager �� ����ִ� �����ȣ�� �ƴ� ��� ã��
    select manager
    from employee
    group by manager;
    
    select eno 
    from employee
    group by eno
    having eno not in manager;

-- 8. ���������� �ִ� ����� �̸��� ǥ�� �Ͻÿ�. 
    select ename
    from employee
    where eno in (select manager
    from employee
    group by manager);

-- 9. BLAKE �� ������ �μ��� ���� ����� �̸��� �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�(��, BLAKE �� ����). 
    select ename �����ȣ ,hiredate �Ի���, dno �μ���ȣ
    from employee
    where dno = (select dno from employee where ename = 'BLAKE') 
                and ename <> 'BLAKE';

-- 10. �޿��� ��պ��� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ����� �޿��� ���ؼ� ���� �������� ���� �Ͻÿ�. 
    select eno �����ȣ, ename ����̸�, salary �޿�
    from employee
    where salary > all (select round(avg(salary)) from employee)
    order by salary;
    

-- 11. �̸��� K �� ���Ե� ����� ���� �μ����� ���ϴ� ����� �����ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. 
    select eno �����ȣ, ename ����̸�, dno �μ�
    from employee
    where  dno in (select distinct dno from employee where ename like '%K%') -- dno = 10, 30
    order by ename ;
    
    -- Ȯ�ο� ( %k%���� �μ� 10,30 -> �μ���ȣ 10,30 ����� ���)
    select eno, ename, dno
    from employee
    where dno = 10 or dno = 30
    order by ename;

-- 12. �μ� ��ġ�� DALLAS �� ����� �̸��� �μ� ��ȣ �� ��� ������ ǥ���Ͻÿ�. 
    select * from department;
    
    select ename ����̸�, e.dno �μ���ȣ, dname ������
    from employee e, department d
    where e.dno = d.dno
    and d.dname = (select dname from department where loc = 'DALLAS');

-- 13. KING���� �����ϴ� ����� �̸��� �޿��� ǥ���Ͻÿ�. 
    select ename ����̸� , salary �޿�
    from employee e
    where manager in (select eno from employee where ename = 'KING') -- ������ �����ȣ�� king�� ��� 
    order by salary;
 
-- 14. RESEARCH �μ��� ����� ���� �μ���ȣ, ����̸� �� ��� ������ ǥ�� �Ͻÿ�. 
    select e.dno �μ���ȣ, ename ����̸� , job ������
    from employee e , department d
    where e.dno = d.dno
    and dname = (select dname from department where dname = 'RESEARCH');

-- 15. ��� �޿����� ���� �޿��� �ް� �̸��� M�� ���Ե� ����� ���� �μ����� �ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ǥ���Ͻÿ�. 

   select eno �����ȣ, ename ����̸�, salary �޿�, dno �μ���ȣ
    from employee
    where salary > (select round(avg(salary)) from employee)   
          and dno = any (select dno from employee where ename like '%M%')
    order by salary;

-- 16. ��� �޿��� ���� ���� ������ ã���ÿ�.  

    select job ����, round(avg(salary)) ��տ���
    from employee
    group by job
    having round(avg(salary)) in (select min(round(avg(salary))) from employee group by job);
    
    
    -- �� �μ��� ��� <Ȯ�ο�>
    select round(avg(salary)), job
    from employee
    group by job;
    
    -- �μ��� ����� �ּҰ� <Ȯ�ο�>
    select min(round(avg(salary))) 
    from employee
    group by job;

-- 17. �������� MANAGER�� ����� �Ҽӵ� �μ��� ������ �μ��� ����� ǥ���Ͻÿ�. 
    select * from department;
    
    select ename ����̸�, job ������ , e.dno �μ���ȣ, d.dname �μ��̸�
    from employee e, department d
    where e.dno = d.dno
    and dname = any(select distinct dname from employee e, department d where job = 'MANAGER');

    