-- 1. SUBSTR �Լ��� ����Ͽ� ������� �Ի��� �⵵�� �Ի��� �޸� ��� �Ͻÿ�.
select * from employee;
select SUBSTR(hiredate,1,5) "�Ի�⵵ ,��"
from employee;

-- 2. SUBSTR �Լ��� ����Ͽ� 4���� �Ի��� ����� ��� �Ͻÿ�. 
select *
from employee
where substr(hiredate,4,2) = 4;

-- 3. MOD �Լ��� ����Ͽ� ���ӻ���� Ȧ���� ����� ����Ͻÿ�. 
select *
from employee
where mod(manager,2) = 1;

-- 3-1. MOD �Լ��� ����Ͽ� ������ 3�� ����� ����鸸 ����ϼ���.
select *
from employee
where mod(salary,3) = 0;

-- 4. �Ի��� �⵵�� 2�ڸ� (YY), ���� (MON)�� ǥ���ϰ� ������ ��� (DY)�� �����Ͽ� ��� �Ͻÿ�. 
select to_char(hiredate, 'YY/MON/DD DY')
from employee;

-- 5. ���� �� ���� �������� ��� �Ͻÿ�. ���� ��¥���� ���� 1�� 1���� �� ����� ����ϰ� TO_DATE �Լ��� ����Ͽ� ������ ������ ��ġ ��Ű�ÿ�. 
select trunc(SYSDATE - to_date(220101,'YYMMDD'))
from dual;

-- 5-1. �ڽ��� �¾ ��¥���� ������� �� ���� �������� ��� �ϼ���.
select trunc(sysdate - to_Date(19981018,'YYYYMMDD'))
from dual;

-- 5-2. �ڽ��� �¾ ��¥���� ������� �� ������ �������� ��� �ϼ���. 
select trunc(MONTHS_BETWEEN(SYSDATE,to_date(19981018,'YYYYMMDD')))
from dual;

-- 6. ������� ��� ����� ����ϵ� ����� ���� ����� ���ؼ��� null ����� 0���� ��� �Ͻÿ�. 
select ename, nvl(manager,0)
from employee;

-- 7.  DECODE �Լ��� ���޿� ���� �޿��� �λ��ϵ��� �Ͻÿ�. ������ 'ANAIYST' ����� 200 , 'SALESMAN' ����� 180,
    --'MANAGER'�� ����� 150, 'CLERK'�� ����� 100�� �λ��Ͻÿ�. 
select ename ����̸�, eno �����ȣ, job ����,decode(job, 'ANALYST', salary + 200,
                                                        'SALESMAN', salary + 180,
                                                        'MANAGER' , salary + 150,
                                                        'CLERK' , salary + 100, 
                                                        salary) AS "���޺� �����λ�"
from employee;    

-- 8. �����ȣ, [�����ȣ 2�ڸ��� ���, �������� * ����] as "������ȣ", �̸�,[�̸��� ù�ڸ� ��� �ѳ��ڸ�, ���ڸ��� * ����] as "�����̸�"
select eno, rpad(substr(eno,1,2),length(eno),'*') "������ȣ", ename, rpad(substr(ename,1,1),4,'*') "�����̸�"
from employee;

-- 9.  �ֹι�ȣ:   �� ����ϵ� 801210-1*******   ��� �ϵ��� , ��ȭ ��ȣ : 010-11******* dual ���̺� ���
select rpad(substr('801210-1234567',1,8),length('801210-1234567'),'*') �ֹι�ȣ,
rpad(substr('010-1111-2222',1,6),length('010-1111-2222'),'*') ��ȭ��ȣ
from dual;

-- 10. �����ȣ, �����, ���ӻ��, 
--	[���ӻ���� �����ȣ�� ���� ��� : 0000
--	 ���ӻ���� �����ȣ��  �� 2�ڸ��� 75�� ��� : 5555
--	���ӻ���� �����ȣ��  �� 2�ڸ��� 76�� ��� : 6666
--	���ӻ���� �����ȣ��  �� 2�ڸ��� 77�� ��� : 7777
--	���ӻ���� �����ȣ��  �� 2�ڸ��� 78�� ��� : 8888
--	�׿ܴ� �״�� ���. 

select eno �����ȣ, ename �����, manager ���ӻ��, 
case when manager is null then 0000
    when substr(manager,1,2) = 75 then 5555
    when substr(manager,1,2) = 76 then 6666
    when substr(manager,1,2) = 77 then 7777
    when substr(manager,1,2) = 78 then 8888
    else manager end  as ���ӻ��
from employee;

select eno �����ȣ, ename �����, manager ���ӻ��, 
case when manager is null then '0000'
    when substr(manager,1,2) = 75 then '5555'
    when substr(manager,1,2) = 76 then '6666'
    when substr(manager,1,2) = 77 then '7777'
    when substr(manager,1,2) = 78 then '8888'
    else to_char(manager, '9999') end  as ���ӻ��  -- '9999' -> �ǹ� ���� ����
from employee;