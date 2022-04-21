-- �پ��� �Լ� ����ϱ�
/*
    1. ���ڸ� ó���ϴ� �Լ�
    - UPPER : �빮�ڷ� ��ȯ
    - LOWER : �ҹ��ڷ� ��ȯ
    - INITCAP : ù�ڴ� �빮�ڷ� �������� �ҹ��ڷ� ��ȯ
    
    dual ���̺� :�ϳ��� ����� ����ϵ��� �ϴ� ���̺�, �׳� ��¹����� (�������̺�)
*/

select '�ȳ��ϼ���' as �ȳ� from dual;

select 'Oracle mania', upper ('Oracle Mania'), lower ('Oracle Mania'), initcap   
('Oracle Mania')
from dual;

select * from employee;
select ename, lower (ename), INITCAP(ename), upper(ename) from employee;

select * from employee
where lower(ename) = 'allen';          -- �ҹ��ڿ��� �˻��� �ȵ�, lower�������ֱ�

select * from employee
where initcap(ename) = 'Allen';  --initcap(ename)�� �������� �� Allen�ΰ� ���

-- ���� ���̸� ����ϴ� �Լ�
    -- length : ������ ���̸� ��ȯ. �ѱ� ���� ������� ���ڼ� ����
    
    -- lengthb : ������ ���̸� ��ȯ, �ѱ��� 3byte�� ��ȯ, 
    
select length ('Oracle mania'), length ('����Ŭ �ŴϾ�') from dual;
select lengthb ('Oracle mania'), lengthb ('����Ŭ �ŴϾ�') from dual; --������ �ѹ���Ʈ

select * from employee ;

select ename, length(ename), job, length(job) from employee;

-- ���� ���� �Լ�
    -- concat : ���ڿ� ���ڸ� �����ؼ� ���
    -- substr : ���ڸ� Ư�� ��ġ���� �߶���� �Լ� (���� �ѱ� ��� 1byte)
    -- substrb :  ���ڸ� Ư�� ��ġ���� �߶���� �Լ� (������ 1byte, �ѱ��� 3byte)
    -- instr : ������ Ư�� ��ġ�� �ε������� ��ȯ 
    -- instrb : ������ Ư�� ��ġ�� �ε������� ��ȯ (������ 1byte, �ѱ��� 3byte)
    -- lpad, rpad : �Է¹��� ���ڿ����� Ư�����ڸ� ����.
    -- trm : �߶󳻰� ���� ���ڸ� ��ȯ
    
select 'Oracle', 'maina', concat('Oracle', 'mania') from dual;

-- concat
select * from employee;
select concat(ename , '  ' || job) from employee;   -- || : ������ �� ���
select '�̸���: ' || ename || '�̰� , ��å��: ' || job || '�Դϴ�' as ���
from employee;

select '�̸���: ' || ename || '�̰� , ���ӻ������� : ' || manager || '�Դϴ�.' as ���ӻ�����
from employee;


--substr(���,���� ��ġ, ������ ����) : Ư�� ��ġ���� ���ڸ� �߶�´�.  
select 'Oracle maina', substr('Oracle maina', 4,3), substr('����Ŭ �ŴϾ�',2,4) from dual;

select 'Oracle maina', substr('Oracle maina', -4,3), substr('����Ŭ �ŴϾ�',-6,4) from dual;

select ename , substr(ename, 2,3) , SUBSTR(ename, -5,2) from employee;

select substrb('Oracle maina',3,3), substrb('����Ŭ �ŴϾ�',3,6) from dual;  -- �ѱ� 3����Ʈ 

-- �̸��� M���� ������ ����� ����ϱ� (substr���)
select ename ����̸�, SUBSTR(ename,-1,1) ����������
from employee
where SUBSTR(ename,-1,1)  = 'N';

select ename ����̸�
from employee
where ename like '%N';

-- 87�⵵ �Ի��� ����� ����ϱ� (substr)���
select ename ����̸�, substr(hiredate,1,2)
from employee
where substr(hiredate,1,2) = '87';

select ename ����̸�
from employee
where hiredate like '87%';

-- instr(���, ã�� ����, ���� ��ġ, ���° �߰�) : ��󿡼� ã�� ������ index���� ���.
select 'Oracle maina' , instr('Oracle maina', 'O') from dual;   -- O�� ù��°�� �ִ�. 
select 'Oracle maina' , instr('Oracle maina', 'a' , 5 , 2) from dual; -- 5��° ���� a�� ã�� ����, 2��°�� �߰ߵǴ� a�� index��ȣ�� ���

select 'Oracle maina' , instr('Oracle maina', 'a' , -5 , 1) from dual; 


select distinct instr(job, 'A', 1,1) from employee
where lower(job) = 'manager';

-- lpad, rpad : Ư�����̸�ŭ ���ڿ��� �����ؼ� ���� Ȥ�� �����ʿ� ������ Ư�����ڷ� ó���ϴ� �Լ�
    --lpad(���, �÷��� ���ڿ� ũ��, Ư����������)  �������� �ø�
    --rpad(���, �÷��� ���ڿ� ũ��, Ư����������) ���������� �ø�
select lpad(1234, 10, '#') from dual;  -- ���ڿ� ���� 10�ڸ��� ����
select rpad(1234, 10, '#') from dual; 
select lpad (salary , 10,'*') from employee;
select rpad (salary , 10,'*') from employee;

-- trim : ��������, Ư�����ڵ� ���� 
    -- ltrim : ���� �������� 
    -- rtrim : ������ �������� 
    -- trim : ����, ������ ������ ����
select ltrim ('   Oracle maina   ') a, rtrim('   Oracle maina   ') b , trim ('   Oracle maina   ')  c
from dual;



    
    
