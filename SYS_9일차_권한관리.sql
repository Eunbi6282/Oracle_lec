show user;

-- 최고 관리자 계정(SYS) : 계정을 생성할 수 있는 권한을 가지고 있다. 

Create user usertest01 IDENTIFIED by 1234; -- 사용자 계정 : usertest01 , 비밀번호 : 1234

-- 계정과 암호를 생성했다고 해서 오라클에 접속할 수 있는 권한을 부여받아야 접속 가능

-- System Privileges : 
    -- Create Session : 오라클에 접속할 수 있는 권한
    -- Create Table : 오라클에서 테이블을 생성할 수 있는 권한
    -- Create sequence : 시퀀스 생성할 수 있는 권한
    -- Create view : 뷰를 생성할 수 있는 권한
    


DDL : 객체 생성( Create, Alter, Drop )
DML : 레코드 조작 (Insert, Update, Delete)
DQL : 레코드 검색 (Select)
DTL : 트랜젝션 ( Begin transaction, rollback, commit)
DCL :  권한관리 ( Grant, Revoke, Deny)

-- 생성한 계정에게 오라클에 접속할 수 있는 Create Session 권한을 부여
    -- grant 부여할 권한 to 계정명
grant create session to usertest01;
        -- Run SQL
        --SQL> connect usertest01/1234
        --Connected.
        --SQL>
    
-- 오라클에 접속했다 라고 해서 테이블을 접근할 수 있는 권한은 없다. 
grant create table to usertest01;

/* 테이블 스페이스 (Table Space) : 객체(테이블, 뷰, 시퀀스, 인덱스, 트리거, 저장프로시저, 함수,,,,)를 저장할 수 있는 공간
    -- 관리자계정에서 각 사용자별 테이블 스페이스를 확인할 수 있다.
            SYSTEM : DBA (관리자 계정에서만 접근 가느)
*/

select * from dba_users; --  dba_ : sys(최고 관리자 계정)

select username, default_tablespace as DataFile, temporary_tablespace as LogFile
from dba_users
where username in ('HR', 'USERTEST01');

-- 계정의 테이블 스페이스 변경 (SYSTEM --> USERS)변경
alter user usertest01
default tablespace users    --DataFile 저장 : 객체가 저장되는 공간(테이블 ,뷰, 인덱스)
temporary tablespace temp; -- LOG를 저장 : DML (Insert, Update, Delete)
    -- Log롤 호칭할 때 transaction log라고 지칭  시스템의 문제 발생 시 백업 시점이 아닌 오류가 난 시점까지 복원하기 위해서 필요한 것 -> log
    
   

-- 계정에게 Users 테이블 스페이스를 사용할 수 있는 공간할당 (users table space에 2mb의 사용 공간 할당
alter user usertest01
quota 2m on users; --2mb 를 주겠다.

 -- 테이블 스페이스 : 객체와 Log를 저장하는 물리적인 파일
        -- 1. DataFile : 객체를 저장하고 있다 (테이블, 뷰, 인덱스....)
        -- 2. LogFile : Transaction Log를 저장(Begin Transaction, commit, rollback,,,,)
        
        -- DataFile 과 LogFile은 물리적으로 다른 하드 공간에 저장해야 성능을 높일 수 있다. 
            --Raid(하드를 그룹핑해서 성능을 빠르게 함)된 공간에 저장하면 성능을 높일 수 있다. 
    create table


==========================================================
문제 : usertest02 계정 생성 후, users tablespace에서 테이블(tbl2) 생성 후 insert.

create user usertest02 identified by 1234;

-- 생성한 계정에게 오라클에 접속할 수 있는 Create Session 권한을 부여
grant create session to usertest02;

-- 오라클에 접속했다 라고 해서 테이블을 접근할 수 있는 권한은 없다. 
grant create table to usertest02;

select username, default_tablespace as DataFile, temporary_tablespace as LogFile
from dba_users
where username in ('HR', 'USERTEST02');

-- 계정의 테이블 스페이스 변경 (SYSTEM --> USERS)변경
alter user usertest02
default tablespace users
temporary tablespace temp;

-- 계정에게 Users 테이블 스페이스를 사용할 수 있는 공간할당 (users table space에 2mb의 사용 공간 할당
alter user usertest02
quota 100m on users; --100mb 를 주겠다.

select * from all_tables  -- 테이블의 소유주를 출력해준다. 계정별로 소유한 테이블을 출력할 수 있다.
where owner in ('HR', 'USERTEST01' , 'USERTEST02');

