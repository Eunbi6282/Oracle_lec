-- Oracle ù��° �� ���� ����

-- SQL �� ���� �ּ�
/*
���� ���� �ּ�
*/

select * from employees;

select * from abc;
insert into abc values ( 1, 2);
insert into abc values ( 3 ,4);
insert into abc values ( 5 ,6);
commit;
select * from abc;

select * from departments;

select * from countries;

-- ���̺� ���� ����
desc abc;
desc employees;

-- ���̺� ���
    -- * =>��� �÷� �� �������� 
select * from employees;
select * from departments;
    -- Ư�� �÷� �����ͼ� ���
select department_id,department_name from departments;

/*
�ǽ� ��ũ��Ʈ ���캸�� - 
select * from EMPLOYEE;
select * from DEPARTMENT;
select * from SALGRADE;
*/




