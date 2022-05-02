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
==========================================================================================
    -- User_Test10 생성
    
        -- 1. 인증 (Authentication) : Credential (Identity + PassWord를 합침)
            create user user_test10 identified by 1234;
    
        -- 2. 허가 (Authorization) : 인증된 사용자에게 Oracle의 시스템 권한, 객체 (테이블, 뷰, 트리거, 함거)권한)
            -- System 권한을 할당함
            grant create session, create table, create view to user_test10;
        
        
        -- 3. 테이블 스페이스 바꾸기 (System -> Users)
            -- 계정을 생성하면 System Table Space를 사용하고 있다.  --> 관리자만 사용 가능한 테이블 스페이스
            -- > Users로 바꿔야 함
            Alter user user_test10
            default tablespace "USERS"  -- 대문자로 
            temporary tablespace "TEMP";
        
        -- 4. 테이블 스페이스 용량 할당.
            -- 보기-> DBA- > 사용자 -> 편집 -> 시스템권한 -> 할당향 -> USERS클릭
        
        -- 5. 
            -- sql command line
        connect user_test10/1234
        Connected.
        SQL> show user
        USER is "USER_TEST10"  -- 사용자 확인
        
        create table test10tbl(
          2  a number not null,
          3  b varchar2(50) null,
          4  c varchar2(50) null
          5  ); -- 테이블 생성
        
        -- 특정 계정에서 객체를 생성하면 그 계정이 그 객체를 소유하게 된다. 
        select * from dba_tables    --각 테이블의 소유자 보기
        where owner in ( 'HR', 'USER_TEST10');
        
        -- 다른 사용자의 테이블을 접근하려면 권한을 가져야 한다. 
        -- user_test10에서 HR이 소유주인 employee테이블을 접근할 때 -> 객체의 접근 권한 필요 <USER_TEST10으로 접속_USER_TE.sql 파일>
            --grant 권한 부여  grant 객체의 권한 on 객체명 to 사용자명
        grant select on hr.employee to user_test10; --user_test10에게 hr 계정의 employee테이블에 접근할 수 있는 권한을 부여해주게따
        grant select on hr.emp_copy10 to user_test10;
        
        grant insert on hr.emp_copy10 to user_test10;
        grant update on hr.emp_copy10 to user_test10;
        grant delete on hr.emp_copy10 to user_test10;
        
            -- revoke: 권한 해제
        revoke insert on hr.emp_copy10 from user_test10;
        
        /* with grant option  : 특정 계정에게 권한을 부여하면서 해당 권한을 다른 사용자에게도 부여할 수 있는 권한
            -- 부여 받은 권한을 다른사용자에게 부여할 수 있는 권한
        */
        grant select on hr.employee to user_test10 with grant option; 
            --usert_test10 계정은 hr.employee 테이블에 대해서 다른 사용자에게 select 권한을 부여할 수 있게 된다. 
            
        grant select on hr.dept_copy10 to user_test10; -- 부여 받은 권한을 다른사용자에게 부여할 수 있는 권한 X
        
        grant select on hr.dept_copy10 to user_test10 with grant option;
        
        /* pulic : 모든 사용자에게 권한 부여 */
        grant select, insert,update, delete on hr.dept_copy11 to public;
        -----------------------------------------------------------------------
        
        /* 롤 (role) : 자주 사용하는 여러개의 권한을 묶어 놓은 것 
            1. dba : 시스템의 모든 권한이 적용된 role -- sys (최고 관리자)
            2. connect :
            3. resource : 
         */
         
         
         --  사용자 정의롤 생성, 부여 : 자주 사용하는 권한들을 묶어서 롤을 생성
            -- 1. 롤 생성
         create role test1;
         
            -- 2. 자주 사용하는 권한 부여
            grant create session, create table, create view, create sequence, create trigger
            to  test1;
            
            -- 3. 생성된 롤을 계정에게 전송
            grant test1 to user_test10;
            
        /* 현재 사용자에게 부여된 롤 확인 */
        
        select * from user_role_privs;
        
        /* 롤에 할당된 권한 정보 확인 */
        select * from role_sys_privs
        where role like 'DBA';
        
        select * from role_sys_privs
        where role like 'TEST1';  -- 위에서 만든 role
        
        /* 객체 권한을 role에 부여하기 */
        
        create role roletest2;
        
        grant select on hr.employee to roletest2;  -- hr.employee를 select할 수 있는 롤 roletest2
            -- 계정에게 객체 권한을 적용한 것이 아니라 롤에 적용. 
            -- !!!!!! roletest2가 계정이 아닌 '롤'임 !!!!!
            
        -- 위에서 생성한 롤을 계정에게 적용한다.
        grant roletest2 to user_test10;
         
        -------------------------------------------------------------------
        -- 실습 : 
        
        hr.dept_copy12를 생성
        
        -- 롤 생성 : roletest3
        roletest3 : hr.dept_copy12을 (select, insert, delete) 하는 객체 롤 생성 ,
        
        user_test10에 적용
        
        -- 롤 생성
        create role roletest3;
        
        -- 객체 권한을 role에 부여
        grant select, insert, delete on HR.dept_copy12 to roletest3;
        
        -- user10에 적용
        grant roletest3 to user_test10;
        
         select * from role_sys_privs
        where role like 'ROLETEST3';
        
        
