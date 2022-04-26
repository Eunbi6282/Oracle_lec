-- 6일차 CRUD(Crate, Read, Update, Delete)

-- Object (객체) : DataBase의 존재(XE, <= Express Edtion(무료버전), 
--                                      Standard Edtion (유료), EnterPrise Edtion (유료) )
        -- 1. 테이블 , 2. 뷰, 3. 저장프로시저, 4. 트리거, 5. 인덱스, 6. 함수, 7. 시퀀스  <- DDL(Crete, Alter, Drop)
-- 테이블 생성(Create)
/*
    Create Table 테이블명(
    
        컬럼명 자료형 Null허용여부 [제약조건],
        컬럼명 자료형 Null허용여부 [제약조건],
        컬럼명 자료형 Null허용여부 [제약조건]
    );
*/
Create Table dept(
    dno number (2) not null, -- 정수 2자리만 올 수 있다. 반드시 값 있어야 함
    dname varchar2(14) not null,
    loc varchar2(13) null);
    
select * from dept;

-- DML : 테이블의 값을 넣고(insert) 수정(update), 삭제(delete)하는 구문
    -- 트랜잭션을 발생 시킴 : log에 기록을 먼저하고 Database에 적용한다.
    
    begin transaction ;  --트랜젹션 시작( insert, update, delete 구문이 시작되면 자동으로 시작)
    rollback;           -- 트랜잭션을 롤백(RAM에 적용된 트랜 잭션을 삭제_
    commit ;            -- 트랜 잭션을 적용( 실제 DB에 여원히 적용)
/*
    Insert into 테이블명 (컬렴명1, 컬럼명2, 컬럼명3)
    values (값1, 값2, 값3)
*/

    -- insert , update, delete 구문은 자동으로 트랜잭션이 시작(begin transacion) - RAM에만 적용되어 있는 상태
    insert into dept (dno, dname, loc)  -- Insert하는 순간 begin transartion 실행
    values (10, 'MANAGER' , 'SEOUL');
    
/* 
    insert 시 컬렴명 생략
    insert into dept
    values ( 값1, 값2, 값3)
*/
    select * from dept;
    insert into dept
    values (20, 'ACCOUNTING', 'BUSAN'); 
    commit;  -- insert , update, delete하고 commit을 해야 메모리에 영구히 적용됨
    
    /* Null 허용 컬럼에 값을 넣지 않기 */
    insert into dept (dno, dname)
    values (30,'RESEARCH'); -- loc null 허용

    /* 데이터 유형에 맞지 않는 값을 넣으면 오류발생*/
--    insert into dept(dno, dname, loc)
--    values (300, 'SALES' ,'TAEGUE'); -- 오류발생 (Number(2))
    
--    insert into dept(loc, dname, dno)
--    values ('TAEGUE', 'SALESSSSSSSSSS' , 60); -- 오류발생 (dname varchar2(14))
    
-- 자료형 (문자자료형)
    -- char (10) : 고정크기 10 바이트 , 3바이트만 넣을 경우 빈공간 7바이트가 생김
        -- 성능이 빠르다(장점). but 하드 공간 낭비가 생김(단점)
        -- 자릿수를 알 수 있는 고정 크기에 사용 (주민번호, 전화번호)
    -- varchar(10) : 가변크기 10바이트, 3바이트만 넣을 경우 3바이트만 공간 할당
        -- 성능이 느림(단점), 하드 공간 낭비가 없음(장점)
        -- 자릿수가 가변크기인 경우( 주소, 메일주소..)
    -- Nchar(10) : 유니코드 10자 (한글, 중국어, 일본어), byte가 아닌 자릿수임
    -- Nvarchar2(10) : 유니코드 10자 (한글, 중국어, 일본어), byte가 아닌 자릿수임
    
-- 자료형 (숫자형 )
    -- Number (2) : 정수 2자리만 입력가능
    -- Number (7,3) : 전체 7자리, 소숫점 3자리까지 저장됨. 
    -- Number (8,5) : 전체 8자리, 소숫점 5자리까지 저장됨
    
 Create Table test1_tbl(
    a number (3, 2) not null, -- 전체 3자리중 소수 2자리
    b number (5, 2) not null,
    c char (6) null,
    d varchar2 (10) null,
    e Nchar(6) null,
    f Nvarchar2 (10) null
    );
    
    Create Table test3_tb3(
    a number (3,2) not null,  -- 전체 3자리중 소수 2자리까지
    b number ( 7, 5) not null,
    c char(6) null,
    d varchar2 (10) null,
    e Nchar (6) null,  
    f Nvarchar2 (10) null);

insert into test3_tb3(a,b,c,d,e,f)
values (3.22, 5.2, 'aaaaaa', 'bbbbbbbbbb', '한글여섯까지','한글열자까지넣을수있');

insert into test3_tb3(a,b,c,d,e,f)
values (3.22, 5.2, '한글', '한글셋', '한글여섯까지','한글열자까지넣을수있');
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
    values( 1, 'aaa','password','홍길동', '010-1111-2222', '서울 중구 남산동', sysdate, 'aaa@aaa.com');
    -- 컬럼명을 지정하지 않는 경우 -> 컬럼 순서대로 지정하기
    insert into member1 
    values( 2, 'bbb','password','박은비', '010-2055-6282', '서울 금천구 가산동', sysdate, 'eunbi628268@gmail.com');
    
    -- Null 허용 컬럼에 null로 값을 할당
    insert into member1 (no,id,passwd,name,phone,address,mdate,email)
    values( 3, 'ccc','password','김김김', null,null, sysdate, null);
    
    -- Null 허용 컬럼에 null로 값을 넣지 않을 경우 null값이 들어감
    insert into member1 (no,id,passwd,name, mdate)
    values( 4, 'ccc','password','이이이' , sysdate);
    
    select * from member1;
    commit; --!!!!!!!!!!!!!!!!!!!!!!!!!!!!--
    
-- 데이터 수정 (update : 데이터 수정 후 commit; 해야함!!!!!!!!!!!!!!!!!!!)
        -- 반드시 where조건을 사용해야 함!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
/*
    update 테이블명 
    set 컬럼명 = 수정할 값
    where 컬럼명 = 값   
    
*/
    -- no 컬럼이 3번에 name 컬럼을 신사임당으로 바꿀거임
    update member1
    set name = '신사임당'
    where no = 3;
    commit;
    
    select * from member1;
    
    -- where조건을 안주면 모든 정보가 바뀌게 됨
    update member1
    set name = '을지문덕'
    where no = 4;
    
    rollback;
    select * from member1;
    
    update member1
    set Id = 'abcd'
    where no = 3;
    
    select * from member1;
    
    update member1
    set name = '김유신'
    where no = 1;
    
    update member1
    set mdate = '2022.01.01'
    where no = 4;
    
    update member1
    set email = 'abcd@abcd.com'
    where no = 1;
    commit;
    
    -- 하나의 레코드에서 여러컬럼 동시에 수정하기
    update member1
    set name = '김유신', email = 'kkk@kkk.com', phone = '010-7777-7777'
    where no = 1;
    
    select * from member1;
    commit;
    
    update member1
    set mdate = to_date('2022-01-01','YYYY-MM-DD')
    where no = 3;
    select * from member1;
    commit;
    
-- 레코드 (로우) 삭제 (delete : 반드시 where 조건을 사용해야 함)

/*
    delete 테이블명 
    where 컬럼명 = 값
*/
    delete member1
    where no = 3;
    select * from member1;
    commit;
    
/*
    !!!!!!!!!!!!!!! update, delete는 반드시 where 조건을 사용해야 한다. transaction을 종료해야 한다. (rollback or commit) !!!!!!!!!!!!
*/

/*
    update, delete 시 where 절에 사용되는 컬럼은 고유한 컬럼이어야 한다.
    (Primary key, unique 컬럼을 사용해야 한다.)
    그렇지 않으면 여러 컬럼이 업데이트 되거나 삭제될 수 있다. 
*/
    update member1
    set name = '김똘똘'
    where no = 4;


-- 제약조건 만들기: 컬럼의 무결성을 확보하기 위해서 사용한다. , 무결성 : 결함없는 데이터(즉, 원하는 데이터만 저장)
    -- Primary Key, 
         -- 하나의 테이블에 한번만 사용할 수 있음., 중복된 데이터를 넣지 못하도록 설정.
         -- null 값을 할당할 수 없다.

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
    values( 1, 'aaa','password','홍길동', '010-1111-2222', '서울 중구 남산동', sysdate, 'aaa@aaa.com');
    -- 컬럼명을 지정하지 않는 경우 -> 컬럼 순서대로 지정하기
    insert into member2
    values( 2, 'bbb','password','박은비', '010-2055-6282', '서울 금천구 가산동', sysdate, 'eunbi628268@gmail.com');
    
    -- Null 허용 컬럼에 null로 값을 할당
    insert into member2 (no,id,passwd,name,phone,address,mdate,email)
    values( 3, 'ccc','password','김김김', null,null, sysdate, null);
    
    -- Null 허용 컬럼에 null로 값을 넣지 않을 경우 null값이 들어감
    insert into member2 (no,id,passwd,name, mdate)
    values( 4, 'ccc','password','이이이' , sysdate);
    
    commit;
    
    select * from member2;
    
    update member2 
    set name = '김유신'
    where no = 4;  -- 테이블에서 중복되지 않는 고유한 컬럼을 조건으로 사용해야 한다. 
    select * from member2;
    commit;
    
-- 제약조건 : UNIQUE
        -- 중복되지 않는 고유한 값을 저장. 하나의 테이블에서 여러컬럼에 지정할 수 있다. 
        -- null 사용 가능 , null은 한번만 저장할 수 있다. 
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
    values( 1, 'aaa','password','홍길동', '010-1111-2222', '서울 중구 남산동', sysdate, 'aaa@aaa.com');
    -- 컬럼명을 지정하지 않는 경우 -> 컬럼 순서대로 지정하기
    insert into member3
    values( 2, 'bbb','password','박은비', '010-2055-6282', '서울 금천구 가산동', sysdate, 'eunbi628268@gmail.com');
    
    -- Null 허용 컬럼에 null로 값을 할당
    insert into member3 (no,id,passwd,name,phone,address,mdate,email)
    values( 3, 'ccc','password','김김김', null,null, sysdate, null);
    
    -- Null 허용 컬럼에 null로 값을 넣지 않을 경우 null값이 들어감
    insert into member3 (no,id,passwd,name, mdate)
    values( 4, 'dddd','password','이이이' , sysdate);
    
    select * from member3;
    commit;
    

