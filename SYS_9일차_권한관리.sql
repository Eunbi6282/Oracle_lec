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

