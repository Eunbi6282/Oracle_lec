-- �پ��� �Լ� Ȯ��
-- ���� ���� �Լ�
    -- concat : ���ڿ� ���ڸ� �����ؼ� ���
    -- substr : ���ڸ� Ư�� ��ġ���� �߶���� �Լ� (����, �ѱ� ��� 1byte)
    -- substr :���ڸ� Ư����ġ���� �߶���� �Լ� (������ 1byte, �ѱ��� 3byte)
    -- instr : ������ Ư�� ��ġ�� �ε������� ��ȯ
    -- instrb : ������ Ư����ġ�� �ε������� ��ȯ( ������ 1byte, �ѱ��� 3byte)
    -- lpad, rpad : �Է¹��� ���ڿ����� Ư�����ڸ� ����
    -- trm : �߶󳻰� ���� ���ڸ� ��ȯ
select 'Oracle', 'maina', concat('Oracle' , 'mania') from dual;

-- concat 
select * from employee;
select '�̸���: ' || ename || '�̰�, ��å��: ' || job || '�Դϴ�' as ���
from employee;

select '�̸���: ' || ename || '�̰� , ���ӻ������� : ' || manager || '�Դϴ�' 
as ���ӻ�����
from employee;

select concat(ename, ' ' || job,hiredate) from employee;

-- substr(���, ������ġ, ������ ����) : Ư�� ��ġ���� ���ڸ� �߶�´�.
select 'Oracle maina', substr('Oracle maina',4,3), substr('����Ŭ �ŴϾ�' , 2,4) from dual;
select 'Oracle maina', substr('Oracle maina' ,-4,3) , substr('����Ŭ �ŴϾ�' , -6,4) from dual;

select ename, substr(ename,2,3) , substr(ename, -5,2) from employee;

-- ����ȯ �Լ�
-- to_char : ��¥�� �Ǵ� �������� ���������� ��ȯ
-- to_Date : �������� ��¥������ ��ȯ�ϴ� �Լ�
-- to_number : �������� ���������� ��ȯ�ϴ� �Լ�

-- ��¥�Լ� ����ϱ�
    -- to_char(date,'YYYYMMDD') DAY - ���� ��ü dy-> ������
    select ename, hiredate, to_char(hiredate,'YYYYMMDD'), to_char(hiredate, 'YYMM'),
    to_char(hiredate, 'YYYYMMDD DAY'), to_char(hiredate,'YYYYMMDD dy')
    from employee;
    
    select sysdate, to_char(sysdate, 'YYYY-MM-DD HH:MI:SS DY')
    from dual;
    
    select hiredate, to_char(hiredate, 'YYYY-MM-DD HH:MI:SS DY')
    from employee;
    
    -- to_char���� ���ڿ� ���õ� ����
/*
    0 :  �ڸ����� ��Ÿ���� �ڸ����� ���� ���� ��� 0���� ä���.
    9 : �ڸ����� ��Ÿ���� �ڸ����� ���� ���� ��� ä���� �ʴ´�.
    L : �� ������ ��ȭ ��ȣ�� ���
    . : �Ҽ������� ǥ��
    , : õ���� ������
*/
desc employee;
    --salary -> num
    select ename, salary, to_char(salary, 'L999,999'), to_char(salary,'L0000,0000')
    from employee;

-- to_date('char','format') : ��¥ �������� ��ȯ
    -- ���� �߻� : date- char (��¥���Ŀ��� ���������� ���� ����)
    select sysdate , sysdate - '20000101'
    from dual;
    
    select sysdate, trunc(sysdate - to_date('20000101','YYYYMMDD'))
    from dual;
    
    select sysdate, to_Date('02/10/10' , 'YY/MM/DD'),trunc( sysdate - to_Date('021010' , 'YYMMDD')) as ��¥����
    from employee;
