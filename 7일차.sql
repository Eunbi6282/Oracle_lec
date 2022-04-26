-- 7일차
    -- 데이블 복사 : 테이블 전체를 복사함
        -- 테이블을 복사하면, 컬럼과 레코드만 복사가 됨
        -- 테이블 할당된 제약조건은 복사되지 않는다. (alter table을 통해서 넣어줘야 함)
        -- 제약조건 : 컬럼에 할당되어 있다. 무결성을 체크
            -- not null, primary key, unique, foreign key, , check , default
create table dept_copy
as 
select * from department;

desc department;
desc dept_copy;
select * from dept_copy;

create table emp_copy
as 
select * from employee;

desc emp_copy;
desc employee;

    -- 테이블 복사 : 특정 컬럼만 복사하기 
    create table emp_second
    as 
    select eno,ename,salary,dno from employee;
    
    -- 테이블 복사 : 조건을 사용해서 복사. 
    create table emp_third
    as select eno,ename,salary from employee 
    where salary >= 2000;
    select * from emp_third;
    
    -- 테이블 복사 : 컬럼명을 바꾸어서 복사
    create table emp_forth
    as 
    select eno 사원번호, ename 사원명, salary 월급 -- 테이블명, 컬럼명 <= 영문사용 권장
    from employee;
    
    -- 테이블 복사 : 계산식을 이용해서 테이블 복사 : 반드시 알리아스 시켜줘야 함
    create table emp_fifth
    as
    select eno, ename, salary * 12 as salary from employee;
    
    select * from emp_fifth;
    
    -- 테이블복사 : 테이블 구조만 복사, 레코드는 복사하지 않는다.
    create table emp_sixth
    as select * from employee
    where 0 = 1;        -- where조건 : false를 리턴
    
    select * from emp_sixth;
    desc emp_sixth;
    
    -- 테이블 수정 : alter table
    create table dept20
    as
    select * from department;
    
    desc dept20;
    select * from dept20;
    
    -- 기존의 테이블에서 컬럼 추가 : 주의!! 반드시 추가할 컬럼에 null을 허용해야 한다.
    alter table dept20
    add (birth date);
    
    alter table dept20 
    add (email varchar2 (100));
    
    alter table dept20
    add (address varchar2 (200));
    
    -- 컬럼의 자료형을 수정 : 
    desc dept20;
    
    alter table dept20
    modify dname varchar2 (100);
    
    alter table dept20
    modify dno NUMBER(4);
    
    alter table dept20
    modify address Nvarchar2 (200); -- 한글 200자 넣을 수 있도록 처리
    
-- 특정 컬럼 삭제 : 업무시간 외에 작업( 부하가 많이 걸릴 수 있다.)
    alter table dept20
    drop column birth;
    
    select * from dept20;
    
    alter table dept20
    drop column email;
    
    -- 컬럼을 삭제 시 부하가 많이 발생 됨 ->>  
        -- SET UNUSED : 특정 컬럼 사용 중지(업무중), 야간에 삭제
        alter table dept20
        set UNUSED (address);  -- drop하기 위해서 unused 사용, 업무중일 때 특정 컬럼을 사용중지
        
        desc dept20;
        
        alter table dept20 -- 야간에 사용 중지된 컬럼을 삭제
        drop unused COLUMN;  -- 사용하지 않는 컬럼을 삭제함.
        
/* 컬럼 이름 변경 */
    alter table dept20
    rename column loc to locations;
    
    desc dept20;
    
    alter table dept20
    rename column dno to D_number;
    
/* 테이블 이름 변경 */
    rename dept20 to dept30;
    desc dept30;
    
/* 테이블 삭제*/
drop table dept30;

/*
    DDL : Create (생성) , Alter (수정), Drop( 삭제)
        테이블, 뷰 ,인덱스, 트리거, 시퀀스, 함수, 저장프로시저.... 
        
    DML : Insert (레코드추가) , Update(레코드수정) , Delete (레코드 삭제)
        << 테이블의 값 (레코드 , 로우) >>
        
    DQL : Select 
    
    -- 테이블의 전체 내용이나 테이블을 삭제 시 --
    (1) delete : 테이블의 레코드를 삭제, where을 사용하지 않을 시 모든 레코드 삭제 <<포멧>>
    (2) truncate : 테이블의 레코드를 삭제, 속도가 굉장히 빠름 <<빠른포멧>>
    (3) drop : 테이블 자체를 삭제
*/

    create table emp10
    as select * from employee;
    
    create table emp20
    as select * from employee;
    
    create table emp30
    as select * from employee;
    
    select * from emp10;
    
    -- delete   !!commit!!필요 -> insert, update, delete
        delete emp10;
        commit;
        
        rollback;
        
        select * from emp10;
        
    -- truncate
        truncate table emp20;
        
        select * from emp20;
        
    -- drop
        drop table emp30;
        
drop table emp;
drop table emp_copy;
------------------------------------------------------------------------------------
/*
    데이터 사전 : 시스템의 각종 정보를 출력해 주는 테이블
        USER_ : 자신의 계정에 속한 객체 정보를 출력
        ALL_ : 자신의 계정이 소유한 객체나 권한을 부여받은 객체정보를 출력
        DBA_ : 데이터 베이스 관리자만 접근 가능한 객체 정보를 출력
*/
    show user;
    select * from user_tables;  --hr계정에서 만들어 놓은 테이블 모두 출력
    select table_name from user_tables;
    select * from user_views;   -- 사용자가 생성한 뷰에 대한 정보 출력
    select * from user_indexs;  -- 사용자가 생성한 인덱스 정보
    select * from user_constraints -- 제약조건 확인
    select * from user_constraints
    where table_name = 'EMPLOYEE'
    select * from user_sequences;
    
    select * from all_tables; -- 모든 테이블정보ㅡ 권한을 부여받은 테이블만 출력
    select * from all_views;
    
    select * from dba_tables; -- dba 로시작되는 관리자 계정에서만 실행 가능
    

    
    
    
    