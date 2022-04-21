-- ���� �Լ�
/*
Round : Ư�� �ڸ������� �ݿø�
Trunc : Ư�� �ڸ������� �߶󳽴�. (������.)
MOD : �Է¹��� ���� ���� ������ ���� ���
*/

-- round (���) : �Ҽ��� ���ڸ����� �ݿø�
-- round (���, �Ҽ����ڸ���) : 
    -- �Ҽ��� �ڸ��� : ����� �� �Ҽ��� ���������� �ڸ�����ŭ �̵��ؼ� �� �ڸ��� �ڿ��� �ݿø� <==!!����!!
    -- �Ҽ��� �ڸ��� : ������ �� �Ҽ��� �������� �ڸ�����ŭ �̵��ϰ� �� �ڸ������� �ݿø���
        -- ������ �ݿø�
        -- �Ҽ��� �ڸ��� ��� ����
select 98.7654 , Round (98.7564), Round(98.7654,2), round(98.7654,-1), round (98.7654,-2),
    round(98.7654,-3), round(98.7654,3)
from dual ;

select 1235.6789, round(12345.6789), round(12345.6789, -3), round(123678.123456, -3)
from dual;

-- trunc
select 98.7654, Trunc(98.7654),trunc(98.7654 ,2), trunc(98.7654,-1) 
from dual;

-- mod (���, ������ ��) : ����� ����� �������� ���
select mod(31,2) , mod(31,5), mod(31,8)
from dual;

select * from employee;

select salary, mod(salary , 300) from employee;

-- employee���̺��� �����ȣ�� ¦���� ����ڸ� 
select ename ����̸�, eno �����ȣ from employee
where mod(eno,2) = 0;

/*
    sysdate : �ý��ۿ� ����� ���� ��¥�� ���
    months_between : �� ��¥ ������ ��� ������ ��ȯ
    add_months : Ư����¥�� �������� ���Ѵ�. 
    next_day : Ư����¥���� ���ʷ� �����ϴ� ���ڷ� ���� ������ ��¥�� ��ȯ
    last_day : ���� ������ ��¥�� ��ȯ
    round : ���ڷ� ���� ��¥�� Ư�� �������� �ݿø� ����
    trunc : ���ڷ� ���� ��¥�� Ư�� �������� ����.
*/
-- �ڽ��� �ý����� ��¥ ���
select sysdate
from dual;

select sysdate -1 as ������¥, sysdate as ���ó�¥, sysdate +1 ���ϳ�¥
from dual;

select * from employee 
order by hiredate asc;

select hiredate, hiredate - 1 , hiredate + 10 from employee;

desc employee

-- �Ի��Ͽ������� ��������� �ٹ��ϼ��� ���
select round(sysdate - hiredate) as "�� �ٹ� �ϼ�", trunc(sysdate - hiredate) as "�� �ٹ� �ϼ�"
from employee;
select sysdate - hiredate, round((sysdate - hiredate), 2) as "�� �ٹ� �ϼ�"
from employee;

-- Ư����¥���� ��(Month)�� �������� ������ ��¥ ���ϱ�  -- �� ����
select hiredate, trunc(hiredate,'MONTH')
from employee;

-- Ư����¥���� ��(Month)�� �������� �ݿø��� ��¥ ���ϱ� : 16��(day) �̻��� ��� ���� �ݿø�
select hiredate, round(hiredate,'MONTH')  --
from employee;

-- months_between(date1, date2) : date1�� date2 ������ ���� �������� ���

    -- �Ի��Ͽ��� ������� �� ������� �ٹ��� ���� �� ���ϱ�
    select ename, sysdate, hiredate, MONTHS_BETWEEN(SYSDATE,hiredate) as "�ٹ� ������"
    from employee;
    select ename, sysdate, hiredate, trunc(MONTHS_BETWEEN(SYSDATE,hiredate)) as "�ٹ� ������"
    from employee;

-- add_months(date1, ������) : date1��¥�� �������� ���� ��¥�� ���

    -- �Ի��� �� 6������ ���� ���� ���
    select hiredate, add_months(hiredate, 6)
    from employee;
    
    -- �Ի��� �� 100���� ���� ������ ��¥ 
    select hiredate, hiredate + 100 as "�Ի��� 100��"
    from employee;

-- next_day (date, '����') : date�� �����ϴ� ���Ͽ� ���� ��¥�� ����ϴ� �Լ�
select sysdate, next_day(sysdate, '�����') as "�̹��� ������� ��¥"
from dual;

-- last_Day(date) : date�� �� ���� ������ ��¥
select hiredate, last_day(hiredate)
from employee;

-- !!!!!!! ����ȯ �Լ� !!!!!!!! <== �߿�
/*
    TO_CHAR : ��¥�� �Ǵ� �������� ���������� ��ȯ
    TO_DATE : �������� ��¥������ ��ȯ�ϴ� �Լ�
    TO_NUMBER : �������� ���������� ��ȯ�ϴ� �Լ�
*/

-- ��¥ �Լ� ����ϱ�
    -- TO_CHAR (date, 'YYYYMMDD')
    select ename, hiredate, to_char(hiredate, 'YYYYMMDD'), to_char(hiredate, 'YYMM'),
    to_char(hiredate, 'YYYYMMDD DAY'), to_char(hiredate, 'YYYYMMDD dy')
    from employee;
    
    -- ���� ��¥�� ����ϰ� �ð� �� (HH:MI:SS)���� ���.
    select sysdate, to_char(sysdate, 'YYYY-MM-DD HH:MI:SS DY') 
    from dual;
    
    desc employee;
    
    select hiredate, to_char(hiredate, 'YYYY-MM-DD HH:MI:SS DY' )
    from employee;
    
    -- to_char ���� ���ڿ� ���õ� ����
    /*
        0 : �ڸ����� ��Ÿ���� �ڸ����� ���� ���� ��� 0���� ä���.
        9 : �ڸ����� ��Ÿ���� �ڸ����� ���� ���� ��� ä���� �ʴ´�.
        L : �� ������ ��ȭ ��ȣ�� ���
        . : �Ҽ������� ǥ��
        , : õ������ ������
    */
    desc employee;
        -- salay -> num
        select ename, salary,to_char(salary, 'L999,999'), to_char(salary,'L0000,0000')
        from employee;
    
-- to_date( 'char', 'format') : ��¥ �������� ��ȯ

    --�����߻� : date - char (��¥���Ŀ��� ���������� ���� ����)
    --select sysdate, sysdate - '20000101'
    --from dual;
    
    -- 200000101���� ���ñ����� �ϼ��� �� (��¥ - ��¥)
    select sysdate , Trunc(sysdate - to_date(20000101, 'YYYYMMDD'))
    from dual;
    
    select sysdate,to_date('02/10/10', 'YY/MM/DD') ,trunc(sysdate - to_date('021010' , 'YYMMDD') ) as "��¥�� ��"
     -- YY/MM/DD �������� ���ǵ� ���� ��¥ Ÿ������ ��ȯ ������
    from dual;
    
    select hiredate
    from employee;
    
    -- 81/02/22�� �Ի��� ��� ���
    select ename, hiredate 
    from employee
    where hiredate = '81/02/22';
    
    -- �����߻�
    --select ename, hiredate 
    --from employee
    --where hiredate = 19810222; --num Ÿ���� hiredate�� ���� ������ Ÿ������ ��ȯ������� ��
    
    select ename, hiredate 
    from employee
    where hiredate = to_date(19810222,'YYYYMMDD'); 
    
    -- �����߻�
    --select ename, hiredate
    --from employee
    --where hiredate = 1981-02-22; -- ���ڿ� ��ȯ �ʿ�
    
    select ename, hiredate
    from employee
    where hiredate = to_date('1981-02-22','YYYY-MM-DD');
    
    -- 2000�� 12�� 25�� ���� ���ñ��� �� �������
    select trunc(months_between(sysdate, to_date('2000-12-25','YYYY-MM-DD'))) AS ������
    from dual;
    
    select trunc(months_between(sysdate, '2000-12-25')) 
    from dual;
    
-- to_number : number������ Ÿ������ ��ȯ
    select 100000 - 50000
    from dual;
    
    -- �����߻�
    select '100,000' - '50,000'
    from dual;
    
    -- '999,999' �� ������ '100,000'�� numŸ������ ��ȯ�ض�
    select to_number('100,000' , '999,999') - to_number('50,000','999,999')
    from dual;
    
-- NVL �Լ� : null�� �ٸ������� ġȯ���ִ� �Լ�
    -- nvl (expr1, expr2) : expr1���� null�� expr2�� ġȯ
select commission
from employee;

select commission, NVL(commission , 0)
from employee;

select manager, NVL(manager, 1111)
from employee;

-- NVL2 
    -- nvl2(expr1, expr2, expr3) : expr1�� null�� �ƴϸ� expr2�� ���, expr1�� null�̸� expr3���
select salary, commission
from employee;

    -- NVL1�Լ��� ���� ����ϱ�
    select salary, salary * 12, commission, nvl (commission,0), salary * 12 + nvl(commission,0) as ����
    from employee;
    
    -- NVL2 �Լ��� ����ؼ� ���� ����ϱ�
    select salary, commission , nvl2(commission, salary * 12 + commission, salary * 12) as ����
    from employee;
    
-- nullif : �� ǥ������ ���ؼ� ������ ��� Null�� ��ȯ�ϰ� �������� ���� ��� ù��° ǥ������ ��ȯ
select nullif('A','A') , nullif('A','B')
from dual;

-- coalesce�Լ�
coalesce (expr1, expr2, expr3, ....,expr-n) : 
    --  expr1�� null�� �ƴϸ� expr1�� ��ȯ�ϰ�, 
    -- expr1�� null �̰� expr2�� null�� �ƴϸ� expr2 ��ȯ
    -- expr1 �� null, expr2�� null, expr2 �� null�� �ƴϸ� expr3 ��ȯ
    
select coalesce ('abc','bcd','efg','ghi')
from  dual;
select coalesce ('','bcd','efg','ghi')
from  dual;
select coalesce ('',null,'efg','ghi')
from  dual;

select ename, salary, commission, coalesce(commission, salary,0)
from employee;

-- decode �Լ�
/*
    decode (ǥ����,  ����1, ���1,
                    ����2, ���2,
                    ����3, ���3,
                    �⺻���
            )
*/

select ename, dno, decode (dno, 10, 'ACCOUNTING',  -- dno�÷��� 10 �̸� ACCOUNTING���
                                20, 'RESEARCH',
                                30, 'SALES',
                                40, 'OPERATIONS',
                                'DEFAULT') AS DNAME
from employee;                            

-- dno �÷��� 10�� �μ��� ��� ���� + 300, 20�� �μ��� ��� ���� + 500 , 30�� ��� ���� + 700/ �̸�, ����, �μ��� ���� �÷����� ��� ���

select * from employee;

select ename ����̸�, salary ����, dno �μ�,decode(dno, 10, salary + 300,
                                             20, salary + 500,
                                             30, salary + 700)
                                             as "�μ��� ����"
from employee
order by dno;

-- case : if ~ else, else if~
    /*
    case ǥ���� when ����1 then ���1
               when ����2 then ���2
               when ����3 then ���3
               else ���n
     END
    */
select ename, dno, case when dno = 10 then 'Accounting'
                        when dno = 20 then 'Research'
                        when dno = 30 then 'Sales'
                        else 'Default'
end as �μ���
from employee
order by dno;

                        

