-- 6���� CRUD(Crate, Read, Update, Delete)

-- Object (��ü) : DataBase�� ����(XE, <= Express Edtion(�������), 
--                                      Standard Edtion (����), EnterPrise Edtion (����) )
        -- 1. ���̺� , 2. ��, 3. �������ν���, 4. Ʈ����, 5. �ε���, 6. �Լ�, 7. ������  <- DDL(Crete, Alter, Drop)
-- ���̺� ����(Create)
/*
    Create Table ���̺��(
    
        �÷��� �ڷ��� Null��뿩�� [��������],
        �÷��� �ڷ��� Null��뿩�� [��������],
        �÷��� �ڷ��� Null��뿩�� [��������]
    );
*/
Create Table dept(
    dno number (2) not null, -- ���� 2�ڸ��� �� �� �ִ�. �ݵ�� �� �־�� ��
    dname varchar2(14) not null,
    loc varchar2(13) null);
    
select * from dept;

-- DML : ���̺��� ���� �ְ�(insert) ����(update), ����(delete)�ϴ� ����
    -- Ʈ������� �߻� ��Ŵ : log�� ����� �����ϰ� Database�� �����Ѵ�.
    
    begin transaction ;  --Ʈ������ ����( insert, update, delete ������ ���۵Ǹ� �ڵ����� ����)
    rollback;           -- Ʈ������� �ѹ�(RAM�� ����� Ʈ�� ����� ����_
    commit ;            -- Ʈ�� ����� ����( ���� DB�� ������ ����)
/*
    Insert into ���̺�� (�÷Ÿ�1, �÷���2, �÷���3)
    values (��1, ��2, ��3)
*/

    -- insert , update, delete ������ �ڵ����� Ʈ������� ����(begin transacion) - RAM���� ����Ǿ� �ִ� ����
    insert into dept (dno, dname, loc)  -- Insert�ϴ� ���� begin transartion ����
    values (10, 'MANAGER' , 'SEOUL');
    
/* 
    insert �� �÷Ÿ� ����
    insert into dept
    values ( ��1, ��2, ��3)
*/
    select * from dept;
    insert into dept
    values (20, 'ACCOUNTING', 'BUSAN'); 
    commit;  -- insert , update, delete�ϰ� commit�� �ؾ� �޸𸮿� ������ �����
    
    /* Null ��� �÷��� ���� ���� �ʱ� */
    insert into dept (dno, dname)
    values (30,'RESEARCH'); -- loc null ���

    /* ������ ������ ���� �ʴ� ���� ������ �����߻�*/
--    insert into dept(dno, dname, loc)
--    values (300, 'SALES' ,'TAEGUE'); -- �����߻� (Number(2))
    
--    insert into dept(loc, dname, dno)
--    values ('TAEGUE', 'SALESSSSSSSSSS' , 60); -- �����߻� (dname varchar2(14))
    
-- �ڷ��� (�����ڷ���)
    -- char (10) : ����ũ�� 10 ����Ʈ , 3����Ʈ�� ���� ��� ����� 7����Ʈ�� ����
        -- ������ ������(����). but �ϵ� ���� ���� ����(����)
        -- �ڸ����� �� �� �ִ� ���� ũ�⿡ ��� (�ֹι�ȣ, ��ȭ��ȣ)
    -- varchar(10) : ����ũ�� 10����Ʈ, 3����Ʈ�� ���� ��� 3����Ʈ�� ���� �Ҵ�
        -- ������ ����(����), �ϵ� ���� ���� ����(����)
        -- �ڸ����� ����ũ���� ���( �ּ�, �����ּ�..)
    -- Nchar(10) : �����ڵ� 10�� (�ѱ�, �߱���, �Ϻ���), byte�� �ƴ� �ڸ�����
    -- Nvarchar2(10) : �����ڵ� 10�� (�ѱ�, �߱���, �Ϻ���), byte�� �ƴ� �ڸ�����
    
-- �ڷ��� (������ )
    -- Number (2) : ���� 2�ڸ��� �Է°���
    -- Number (7,3) : ��ü 7�ڸ�, �Ҽ��� 3�ڸ����� �����. 
    -- Number (8,5) : ��ü 8�ڸ�, �Ҽ��� 5�ڸ����� �����
    
 Create Table test1_tbl(
    a number (3, 2) not null, -- ��ü 3�ڸ��� �Ҽ� 2�ڸ�
    b number (5, 2) not null,
    c char (6) null,
    d varchar2 (10) null,
    e Nchar(6) null,
    f Nvarchar2 (10) null
    );
    
    Create Table test3_tb3(
    a number (3,2) not null,  -- ��ü 3�ڸ��� �Ҽ� 2�ڸ�����
    b number ( 7, 5) not null,
    c char(6) null,
    d varchar2 (10) null,
    e Nchar (6) null,  
    f Nvarchar2 (10) null);

insert into test3_tb3(a,b,c,d,e,f)
values (3.22, 5.2, 'aaaaaa', 'bbbbbbbbbb', '�ѱۿ�������','�ѱۿ��ڱ�����������');

insert into test3_tb3(a,b,c,d,e,f)
values (3.22, 5.2, '�ѱ�', '�ѱۼ�', '�ѱۿ�������','�ѱۿ��ڱ�����������');
commit;

-- 

create table member1 (
    no number (10) not null,
    id varchar2 (50) not null,
    passwd varchar2 (50) not null,
    name Nvarchar2 (6) not null,
    phone varchar2(50) null,
    address varchar2 (100) null,
    mdate date not null,
    email varchar2(50) null);
    
drop table member1;
    
    select * from member1;
    desc member1;
    
    insert into member1 (no,id,passwd,name,phone,address,mdate,email)
    values( 1, 'aaa','password','ȫ�浿', '010-1111-2222', '���� �߱� ���굿', sysdate, 'aaa@aaa.com');
    -- �÷����� �������� �ʴ� ��� -> �÷� ������� �����ϱ�
    insert into member1 
    values( 2, 'bbb','password','������', '010-2055-6282', '���� ��õ�� ���굿', sysdate, 'eunbi628268@gmail.com');
    
    -- Null ��� �÷��� null�� ���� �Ҵ�
    insert into member1 (no,id,passwd,name,phone,address,mdate,email)
    values( 3, 'ccc','password','����', null,null, sysdate, null);
    
    -- Null ��� �÷��� null�� ���� ���� ���� ��� null���� ��
    insert into member1 (no,id,passwd,name, mdate)
    values( 4, 'ccc','password','������' , sysdate);
    
    select * from member1;
    commit; --!!!!!!!!!!!!!!!!!!!!!!!!!!!!--
    
-- ������ ���� (update : ������ ���� �� commit; �ؾ���!!!!!!!!!!!!!!!!!!!)
        -- �ݵ�� where������ ����ؾ� ��!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
/*
    update ���̺�� 
    set �÷��� = ������ ��
    where �÷��� = ��   
    
*/
    -- no �÷��� 3���� name �÷��� �Ż��Ӵ����� �ٲܰ���
    update member1
    set name = '�Ż��Ӵ�'
    where no = 3;
    commit;
    
    select * from member1;
    
    -- where������ ���ָ� ��� ������ �ٲ�� ��
    update member1
    set name = '��������'
    where no = 4;
    
    rollback;
    select * from member1;
    
    update member1
    set Id = 'abcd'
    where no = 3;
    
    select * from member1;
    
    update member1
    set name = '������'
    where no = 1;
    
    update member1
    set mdate = '2022.01.01'
    where no = 4;
    
    update member1
    set email = 'abcd@abcd.com'
    where no = 1;
    commit;
    
    -- �ϳ��� ���ڵ忡�� �����÷� ���ÿ� �����ϱ�
    update member1
    set name = '������', email = 'kkk@kkk.com', phone = '010-7777-7777'
    where no = 1;
    
    select * from member1;
    commit;
    
    update member1
    set mdate = to_date('2022-01-01','YYYY-MM-DD')
    where no = 3;
    select * from member1;
    commit;
    
-- ���ڵ� (�ο�) ���� (delete : �ݵ�� where ������ ����ؾ� ��)

/*
    delete ���̺�� 
    where �÷��� = ��
*/
    delete member1
    where no = 3;
    select * from member1;
    commit;
    
/*
    !!!!!!!!!!!!!!! update, delete�� �ݵ�� where ������ ����ؾ� �Ѵ�. transaction�� �����ؾ� �Ѵ�. (rollback or commit) !!!!!!!!!!!!
*/

/*
    update, delete �� where ���� ���Ǵ� �÷��� ������ �÷��̾�� �Ѵ�.
    (Primary key, unique �÷��� ����ؾ� �Ѵ�.)
    �׷��� ������ ���� �÷��� ������Ʈ �ǰų� ������ �� �ִ�. 
*/
    update member1
    set name = '��ʶ�'
    where no = 4;


-- �������� �����: �÷��� ���Ἲ�� Ȯ���ϱ� ���ؼ� ����Ѵ�. , ���Ἲ : ���Ծ��� ������(��, ���ϴ� �����͸� ����)
    -- Primary Key, 
         -- �ϳ��� ���̺� �ѹ��� ����� �� ����., �ߺ��� �����͸� ���� ���ϵ��� ����.
         -- null ���� �Ҵ��� �� ����.

create table member2 (
    no number (10) not null Primary Key,
    id varchar2 (50) not null,
    passwd varchar2 (50) not null,
    name Nvarchar2 (6) not null,
    phone varchar2(50) null,
    address varchar2 (100) null,
    mdate date not null,
    email varchar2(50) null);
    
    select * from member2;
    
    drop table member2;
    
    insert into member2 (no,id,passwd,name,phone,address,mdate,email)
    values( 1, 'aaa','password','ȫ�浿', '010-1111-2222', '���� �߱� ���굿', sysdate, 'aaa@aaa.com');
    -- �÷����� �������� �ʴ� ��� -> �÷� ������� �����ϱ�
    insert into member2
    values( 2, 'bbb','password','������', '010-2055-6282', '���� ��õ�� ���굿', sysdate, 'eunbi628268@gmail.com');
    
    -- Null ��� �÷��� null�� ���� �Ҵ�
    insert into member2 (no,id,passwd,name,phone,address,mdate,email)
    values( 3, 'ccc','password','����', null,null, sysdate, null);
    
    -- Null ��� �÷��� null�� ���� ���� ���� ��� null���� ��
    insert into member2 (no,id,passwd,name, mdate)
    values( 4, 'ccc','password','������' , sysdate);
    
    commit;
    
    select * from member2;
    
    update member2 
    set name = '������'
    where no = 4;  -- ���̺��� �ߺ����� �ʴ� ������ �÷��� �������� ����ؾ� �Ѵ�. 
    select * from member2;
    commit;
    
-- �������� : UNIQUE
        -- �ߺ����� �ʴ� ������ ���� ����. �ϳ��� ���̺��� �����÷��� ������ �� �ִ�. 
        -- null ��� ���� , null�� �ѹ��� ������ �� �ִ�. 
create table member3 (
    no number (10)  not null Primary Key,
    id varchar2 (50) not null Unique,
    passwd varchar2 (50) not null,
    name Nvarchar2 (6) not null,
    phone varchar2(50) null,
    address varchar2 (100) null,
    mdate date not null,
    email varchar2(50) null);
    
     insert into member3 (no,id,passwd,name,phone,address,mdate,email)
    values( 1, 'aaa','password','ȫ�浿', '010-1111-2222', '���� �߱� ���굿', sysdate, 'aaa@aaa.com');
    -- �÷����� �������� �ʴ� ��� -> �÷� ������� �����ϱ�
    insert into member3
    values( 2, 'bbb','password','������', '010-2055-6282', '���� ��õ�� ���굿', sysdate, 'eunbi628268@gmail.com');
    
    -- Null ��� �÷��� null�� ���� �Ҵ�
    insert into member3 (no,id,passwd,name,phone,address,mdate,email)
    values( 3, 'ccc','password','����', null,null, sysdate, null);
    
    -- Null ��� �÷��� null�� ���� ���� ���� ��� null���� ��
    insert into member3 (no,id,passwd,name, mdate)
    values( 4, 'dddd','password','������' , sysdate);
    
    select * from member3;
    commit;
    

