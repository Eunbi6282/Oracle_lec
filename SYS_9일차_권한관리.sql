show user;

-- �ְ� ������ ����(SYS) : ������ ������ �� �ִ� ������ ������ �ִ�. 

Create user usertest01 IDENTIFIED by 1234; -- ����� ���� : usertest01 , ��й�ȣ : 1234

-- ������ ��ȣ�� �����ߴٰ� �ؼ� ����Ŭ�� ������ �� �ִ� ������ �ο��޾ƾ� ���� ����

-- System Privileges : 
    -- Create Session : ����Ŭ�� ������ �� �ִ� ����
    -- Create Table : ����Ŭ���� ���̺��� ������ �� �ִ� ����
    -- Create sequence : ������ ������ �� �ִ� ����
    -- Create view : �並 ������ �� �ִ� ����
    


DDL : ��ü ����( Create, Alter, Drop )
DML : ���ڵ� ���� (Insert, Update, Delete)
DQL : ���ڵ� �˻� (Select)
DTL : Ʈ������ ( Begin transaction, rollback, commit)
DCL :  ���Ѱ��� ( Grant, Revoke, Deny)

-- ������ �������� ����Ŭ�� ������ �� �ִ� Create Session ������ �ο�
    -- grant �ο��� ���� to ������
grant create session to usertest01;
        -- Run SQL
        --SQL> connect usertest01/1234
        --Connected.
        --SQL>
    
-- ����Ŭ�� �����ߴ� ��� �ؼ� ���̺��� ������ �� �ִ� ������ ����. 
grant create table to usertest01;

/* ���̺� �����̽� (Table Space) : ��ü(���̺�, ��, ������, �ε���, Ʈ����, �������ν���, �Լ�,,,,)�� ������ �� �ִ� ����
    -- �����ڰ������� �� ����ں� ���̺� �����̽��� Ȯ���� �� �ִ�.
            SYSTEM : DBA (������ ���������� ���� ����)
*/

select * from dba_users; --  dba_ : sys(�ְ� ������ ����)

select username, default_tablespace as DataFile, temporary_tablespace as LogFile
from dba_users
where username in ('HR', 'USERTEST01');

-- ������ ���̺� �����̽� ���� (SYSTEM --> USERS)����
alter user usertest01
default tablespace users    --DataFile ���� : ��ü�� ����Ǵ� ����(���̺� ,��, �ε���)
temporary tablespace temp; -- LOG�� ���� : DML (Insert, Update, Delete)
    -- Log�� ȣĪ�� �� transaction log��� ��Ī  �ý����� ���� �߻� �� ��� ������ �ƴ� ������ �� �������� �����ϱ� ���ؼ� �ʿ��� �� -> log
    
   

-- �������� Users ���̺� �����̽��� ����� �� �ִ� �����Ҵ� (users table space�� 2mb�� ��� ���� �Ҵ�
alter user usertest01
quota 2m on users; --2mb �� �ְڴ�.

 -- ���̺� �����̽� : ��ü�� Log�� �����ϴ� �������� ����
        -- 1. DataFile : ��ü�� �����ϰ� �ִ� (���̺�, ��, �ε���....)
        -- 2. LogFile : Transaction Log�� ����(Begin Transaction, commit, rollback,,,,)
        
        -- DataFile �� LogFile�� ���������� �ٸ� �ϵ� ������ �����ؾ� ������ ���� �� �ִ�. 
            --Raid(�ϵ带 �׷����ؼ� ������ ������ ��)�� ������ �����ϸ� ������ ���� �� �ִ�. 
    create table



==========================================================
���� : usertest02 ���� ���� ��, users tablespace���� ���̺�(tbl2) ���� �� insert.

create user usertest02 identified by 1234;

-- ������ �������� ����Ŭ�� ������ �� �ִ� Create Session ������ �ο�
grant create session to usertest02;

-- ����Ŭ�� �����ߴ� ��� �ؼ� ���̺��� ������ �� �ִ� ������ ����. 
grant create table to usertest02;

select username, default_tablespace as DataFile, temporary_tablespace as LogFile
from dba_users
where username in ('HR', 'USERTEST02');

-- ������ ���̺� �����̽� ���� (SYSTEM --> USERS)����
alter user usertest02
default tablespace users
temporary tablespace temp;

-- �������� Users ���̺� �����̽��� ����� �� �ִ� �����Ҵ� (users table space�� 2mb�� ��� ���� �Ҵ�
alter user usertest02
quota 100m on users; --100mb �� �ְڴ�.

select * from all_tables  -- ���̺��� �����ָ� ������ش�. �������� ������ ���̺��� ����� �� �ִ�.
where owner in ('HR', 'USERTEST01' , 'USERTEST02');
==========================================================================================
    -- User_Test10 ����
    
        -- 1. ���� (Authentication) : Credential (Identity + PassWord�� ��ħ)
            create user user_test10 identified by 1234;
    
        -- 2. �㰡 (Authorization) : ������ ����ڿ��� Oracle�� �ý��� ����, ��ü (���̺�, ��, Ʈ����, �԰�)����)
            -- System ������ �Ҵ���
            grant create session, create table, create view to user_test10;
        
        
        -- 3. ���̺� �����̽� �ٲٱ� (System -> Users)
            -- ������ �����ϸ� System Table Space�� ����ϰ� �ִ�.  --> �����ڸ� ��� ������ ���̺� �����̽�
            -- > Users�� �ٲ�� ��
            Alter user user_test10
            default tablespace "USERS"  -- �빮�ڷ� 
            temporary tablespace "TEMP";
        
        -- 4. ���̺� �����̽� �뷮 �Ҵ�.
            -- ����-> DBA- > ����� -> ���� -> �ý��۱��� -> �Ҵ��� -> USERSŬ��
        
        -- 5. 
            -- sql command line
        connect user_test10/1234
        Connected.
        SQL> show user
        USER is "USER_TEST10"  -- ����� Ȯ��
        
        create table test10tbl(
          2  a number not null,
          3  b varchar2(50) null,
          4  c varchar2(50) null
          5  ); -- ���̺� ����
        
        -- Ư�� �������� ��ü�� �����ϸ� �� ������ �� ��ü�� �����ϰ� �ȴ�. 
        select * from dba_tables    --�� ���̺��� ������ ����
        where owner in ( 'HR', 'USER_TEST10');
        
        -- �ٸ� ������� ���̺��� �����Ϸ��� ������ ������ �Ѵ�. 
        -- user_test10���� HR�� �������� employee���̺��� ������ �� -> ��ü�� ���� ���� �ʿ� <USER_TEST10���� ����_USER_TE.sql ����>
            --grant ���� �ο�  grant ��ü�� ���� on ��ü�� to ����ڸ�
        grant select on hr.employee to user_test10; --user_test10���� hr ������ employee���̺� ������ �� �ִ� ������ �ο����ְԵ�
        grant select on hr.emp_copy10 to user_test10;
        
        grant insert on hr.emp_copy10 to user_test10;
        grant update on hr.emp_copy10 to user_test10;
        grant delete on hr.emp_copy10 to user_test10;
        
            -- revoke: ���� ����
        revoke insert on hr.emp_copy10 from user_test10;
        
        /* with grant option  : Ư�� �������� ������ �ο��ϸ鼭 �ش� ������ �ٸ� ����ڿ��Ե� �ο��� �� �ִ� ����
            -- �ο� ���� ������ �ٸ�����ڿ��� �ο��� �� �ִ� ����
        */
        grant select on hr.employee to user_test10 with grant option; 
            --usert_test10 ������ hr.employee ���̺� ���ؼ� �ٸ� ����ڿ��� select ������ �ο��� �� �ְ� �ȴ�. 
            
        grant select on hr.dept_copy10 to user_test10; -- �ο� ���� ������ �ٸ�����ڿ��� �ο��� �� �ִ� ���� X
        
        grant select on hr.dept_copy10 to user_test10 with grant option;
        
        /* pulic : ��� ����ڿ��� ���� �ο� */
        grant select, insert,update, delete on hr.dept_copy11 to public;
        -----------------------------------------------------------------------
        
        /* �� (role) : ���� ����ϴ� �������� ������ ���� ���� �� 
            1. dba : �ý����� ��� ������ ����� role -- sys (�ְ� ������)
            2. connect :
            3. resource : 
         */
         
         
         --  ����� ���Ƿ� ����, �ο� : ���� ����ϴ� ���ѵ��� ��� ���� ����
            -- 1. �� ����
         create role test1;
         
            -- 2. ���� ����ϴ� ���� �ο�
            grant create session, create table, create view, create sequence, create trigger
            to  test1;
            
            -- 3. ������ ���� �������� ����
            grant test1 to user_test10;
            
        /* ���� ����ڿ��� �ο��� �� Ȯ�� */
        
        select * from user_role_privs;
        
        /* �ѿ� �Ҵ�� ���� ���� Ȯ�� */
        select * from role_sys_privs
        where role like 'DBA';
        
        select * from role_sys_privs
        where role like 'TEST1';  -- ������ ���� role
        
        /* ��ü ������ role�� �ο��ϱ� */
        
        create role roletest2;
        
        grant select on hr.employee to roletest2;  -- hr.employee�� select�� �� �ִ� �� roletest2
            -- �������� ��ü ������ ������ ���� �ƴ϶� �ѿ� ����. 
            -- !!!!!! roletest2�� ������ �ƴ� '��'�� !!!!!
            
        -- ������ ������ ���� �������� �����Ѵ�.
        grant roletest2 to user_test10;
         
        -------------------------------------------------------------------
        -- �ǽ� : 
        
        hr.dept_copy12�� ����
        
        -- �� ���� : roletest3
        roletest3 : hr.dept_copy12�� (select, insert, delete) �ϴ� ��ü �� ���� ,
        
        user_test10�� ����
        
        -- �� ����
        create role roletest3;
        
        -- ��ü ������ role�� �ο�
        grant select, insert, delete on HR.dept_copy12 to roletest3;
        
        -- user10�� ����
        grant roletest3 to user_test10;
        
         select * from role_sys_privs
        where role like 'ROLETEST3';
        
        
