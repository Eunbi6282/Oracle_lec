-- 3���� 

-- �����Լ� 
/*
    ROUND : Ư�� �ڸ������� �ݿø�.
    TRUNC : Ư���ڸ������� �߶󳽴�.(������.)
    MOD : �Է¹��� ���� ���� ������ ���� ���
*/

--round (���) : �Ҽ��� �Ʒ��ڸ����� �ݿø�! ex )98.7654-> 99
--round (���, �Ҽ��� �ڸ���) : 
        -- ��� : ����϶� �Ҽ��� ���������� �̵��Ѵ�. ���������� �ڸ�����ŭ�̵��ؼ� ���ڸ��� �ڿ��� �ݿø��Ѵ�. < 
        -- ���� : �����϶� �Ҽ��� �������� �������� �̵�. �������� �ڸ�����ŭ �̵��ϰ� �� �ڸ������� �ݿø��Ѵ�.
                                            -- ex)98.7654,2->98.77    -- 98�� 8���� �ݿø�ó��   
select 98.7654 as ����, Round(98.7654) round�Լ�����,round(98.7654,2),round(98.7654,-1),round(98.7654,-2)
        ,round(98.7654,-3) ,round(98.7654,3) 
from dual; 

select 12345.6789, round(12345.6789), round(12345.6789,-3), round(123678.123456,-3)
from dual;

--TRUNC : ����
select 98.7654, Trunc(98.7654), Trunc(98.7654,2), Trunc(98.7654,-1)
from dual;

--MOD (���, ������ �� ): ����� ����� �������� ����Ѵ�. 

select mod (31,2), mod(31,5),mod(31,8)
from dual;

select * from employee;

select salary, mod(salary, 300)
from employee;

--employee ���̺��� �����ȣ�� ¦���� ����鸸 ���
select *
FROM employee
where mod(eno,2)=0;

/* ��¥ �Լ� 
    sysdate : �ý��ۿ� ����� ���糯¥�� ����Ѵ�. < ���� ���� ���
    months_between : �� ��¥ ������ ������ ��ȯ
    add_months : Ư����¥�� ���� ���� ���Ѵ�.
    next_day : Ư����¥���� ���ʷ� �����ϴ� ���ڷ� ���� ������ ��¥�� ��ȯ.
    last_day : ���� ������ ��¥�� ��ȯ
    round : ���ڷ� ���� ��¥�� Ư�� �������� �ݿø�. 
    trunk : ���ڷ� ���� ��¥�� Ư���������� ����.
*/
--�ڽ��� �ý����� ���� ��¥ ���
select sysdate
from dual; 
--��¥�� ������ ������ �� �ִ�. 
select sysdate -1 as ������¥, sysdate ���ó�¥ , sysdate+1 ���ϳ�¥
from dual;

select * from employee
order by hiredate asc;

select hiredate, hiredate-1 , hiredate+10 
from employee;

--�ٹ��ϼ� : �Ի��Ͽ������� ��������� �ٹ��ϼ��� ����ض�
select ename �����, round(sysdate-hiredate) �ٹ��ϼ�,round((sysdate-hiredate)/365) �ٹ��⵵
from employee
order by round((sysdate-hiredate)/365) desc, round(sysdate-hiredate) desc;

select ename �����, round((sysdate-hiredate),2) �ٹ��ϼ�
from employee;

select ename �����, trunc(sysdate-hiredate) �ٹ��ϼ�
from employee;

--Ư����¥���� ��(month)�� �������� ������ ��¥ -> ���� �������� �߱� ������ ���� 01�� ���´�.
select hiredate, trunc (hiredate,'MONTH')
from employee;

--round ���� �������� �ݿø���. 15���� �������� 
select hiredate, round (hiredate,'MONTH')
from employee;

--months_between(date1,date2) : date1�� date2 ������ ���� ���� ���� ��� 
-- �� ������� �ٹ��� ���� �� ���ϱ� 
select ename ,sysdate , hiredate, trunc(months_between(sysdate , hiredate))�ٹ�������
from employee;

--add_months (date1 , ������) : date1 ��¥�� ���� ���� ���� ��¥�� �������.

-- �Ի��� �� 6������ ����������?
select ename ,hiredate, add_months(hiredate,6)
from employee;

--�Ի��� �� 100�� �� �ڳ� ����?
select ename ,hiredate, hiredate+100 as "100���� �Ǵ� ��¥"
from employee;

-- next_day(date,'����') : date �� �����ϴ� ���Ͽ� ���� ��¥�� ����ϴ� �Լ�
select sysdate, next_day(sysdate,'�����')"�̹��� ������� ��¥"
from dual;

--last_day (date) :date�� �� ���� ������ ��¥�� ���
select hiredate, last_day(hiredate) 
from employee;

--(�߿�!!!)�� ��ȯ �Լ�
/*
    TO_CHAR : ��¥�� �Ǵ� �������� ���������� ��ȯ�ϴ� �Լ� 
    RO_DATE : �������� ��¥ �Ǵ� ���������� ��ȯ�ϴ� �Լ� 
    RO_NUMBER : �������� ���������� ��ȯ�ϴ� �Լ�.
*/

--��¥�Լ� ����غ���! 
--TO_CHAR(date,'yyyymmdd') day �� ������ ��� �ٿ��� dy�� ��밡��

select ename , hiredate, to_char(hiredate,'yyyymmdd') , to_char(hiredate,'yymm'),
to_char(hiredate, 'yyyymmdd day'),to_char(hiredate ,'yyyymmdd dy')
from employee;

--���� ��¥�� ����ϰ� �ð� �ʱ��� ��� 
select sysdate ���ó�¥ , to_char(sysdate,'yyyy-mm-dd hh:mi:ss day')  
from dual;

select hiredate, to_char(hiredate,'yyyy_mm_dd hh:mi:ss day') 
from employee;


--to_char ���� ���ڿ� ���õ� ����
/*
 0 : �ڸ����� ��Ÿ���� �ڸ����� ���� ���� ��� 0���� ä��.
 9 : �ڸ����� ��Ÿ���� �ڸ����� ���� ���� ��� ä���� ����.
 L : �� ������ ��ȭ ��ȣ�� ���
 .: �Ҽ������� ǥ�� 
 ,: õ������ ������
*/

desc employee;
--salary�� number Ÿ���ε� ��ȯ��Ų��
select ename , salary , to_char(salary, 'L999,999'), to_char(salary, 'L0000,000')
from employee;

--to_date('char','format') :��¥�������� ��ȯ.

--�����߻� sysdate�� ��¥���̰� 20000101�� char���̶� ������ �ȵȴ�. (���� �������� ��ȯ���Ѿ��Ѵ�.)
select sysdate, sysdate-'20000101' 
from dual;

--20000101�� 'YYYYMMDD'�� ��¥�������� ��ȯ���� . 2000�� 1��1�Ͽ��� ���ñ����� �ϼ�  
select sysdate, trunc(sysdate - to_date(20000101,'YYYYMMDD'))
from dual ;

select sysdate, sysdate-to_date('021010)
