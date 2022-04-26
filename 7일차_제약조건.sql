/*
    제약조건 : 테이블의 무결성을 확보하기 위해서 컬럼에 부여하는 규칙
        1. Primary Key
        2. Unique
        3. Not Null
        4. Check
        5. Foreign Key
        6. Default
*/

-- 1. Primary Key : 중복된 값을 넣을 수 없다.
    -- (1) 테이블 생성시 컬럼에 부여하는 방법
        -- 제약 조건 이름 : 지정하지 않을 경우 -> 오라클에서 랜덤한 이름으로 생성,
            -- 제약조건을 수정할 때 제약조건 이름을 사용해서 수정. 
            -- PK_customer01_id : Primary Key제약 조건이고 customer01 테이블의 id(컬럼명)제약컬럼
            -- NN_customer01_pwd : NOT Null 제약조건이고 customer01 테이블에 부여된 pwd(컬럼명)제약컬럼
    create table customer01(
        id varchar2(20) not null constraint PK_customer01_id Primary Key , -- PK_customer01_id 제약조건 이름
        pwd varchar2(20) CONSTRAINT NN_customer01_pwd not null ,
        name varchar2(20) constraint NN_customer01_name not null ,
        phone varchar2(30) null,
        address varchar2(100) null);
    
    select * from user_constraints
    where table_name = 'CUSTOMER01'; -- 대문자로 처리
    
    create table customer02(
        id varchar2(20) not null Primary Key , -- PK_customer01_id 제약조건 이름
        pwd varchar2(20) not null ,
        name varchar2(20) not null ,
        phone varchar2(30) null,
        address varchar2(100) null);
        
    select * from user_constraints
    where table_name = 'CUSTOMER02'; -- 대문자로 처리
    
    -- 테이블의 컬럼 생성 후 제약 조건 할당
        create table customer03(
            id varchar2(20) not null , -- PK_customer01_id 제약조건 이름
            pwd varchar2(20)  CONSTRAINT NN_customer03_pwd not null ,
            name varchar2(20)  CONSTRAINT NN_customer03_name not null,
            phone varchar2(30) null,
            address varchar2(100) null,
            constraint PK_customer03_id Primary Key(id));

-- Foreign Key (참조키) : 다른 테이블 (부모)의 Primary KEy, Unique 컬럼을 참조해서 값을 할당.
-- Check : 컬럼에 값을 할당할 때 check 에 맞는 값을 할당

    --  부모 테이블
    create table ParentTbl(
    name varchar2(20),
    age number(3) constraint CK_ParentTbl_age check (AGE > 0 and AGE < 200), --check 제약조건 이름
    gender varchar2(3) constraint CK_ParentTbl_gender check (gender In ('M','W')),
    infono number constraint PK_ParentTbl_infono Primary Key
    )
    
    desc ParentTbl;
    select * from user_constraints
    where table_name = 'PARENTTBL';
    
    -- 자식 테이블
    Create table ChildTbl(
        id varchar2(40) constraint PK_ChildTbl_id Primary Key not null,
        pw varchar2(40) ,
        infono number,
        constraint FK_ChildTbl_infono Foreign Key (infono) REFERENCES ParentTbl(infono) --infono에 foreign 키를 넣었음
        );
    
    -- 부모테이블에 값 insert 시키기
    insert into ParentTbl
    values ('홍길동' , 30, 'M', 1);
    
     insert into ParentTbl
    values ('박은비' , 300, 'K', 1); -- 오류 : 300 과 K 는 check제약 조건 위반, 1은 중복하여 넣었으므로 Primary Key 위반
    
    insert into ParentTbl
    values ('박은비' , 25, 'W', 2);
    
    select * from parenttbl;
    
    -- 자식 테이블 값 insert
    insert into ChildTbl
    values ('aaa' , '1234', 3);  -- 오류 : ChildTbl의 infono은 ParentTbl의 infono를 참조해서 만들게 됨, ParentTbl의 infono에 3이 없으므로 오류
    
    insert into ChildTbl
    values ('aaa' , '1234', 1);
    
    insert into ChildTbl
    values ('bbb' , '1234', 2);
    
    select * from ChildTbl;
    commit;

---------------------------------------------------------------------
    -- 부모 테이블
    create table ParentTbl2(
        dno number(2) not null Primary KEy,
        dname varchar2(50),
        loc varchar2(50)
        );
        
    insert into parenttbl2 
    values (10, 'SALES' , 'SEOUL');
    commit;
    
    -- 자식 테이블
    create table ChildTbl2(
        no number not null,
        ename varchar2(50),
        dno number(2) not null,
        foreign key (dno) references ParentTbl2(dno)
        );
        
    insert into ChildTbl2
    values (1, 'PARK', 10);
    
    select * from ChildTbl2;
    commit;
 
 -- default 제약 조건 : 값을 할당하지 않으면  default값이 할당
 Create Table emp_sample01(
    eno number(4) Primary Key not null,
    ename varchar(50),
    salary number(7,2) default 1000);

    -- default 컬럼에 값을 할당한 경우
    insert into emp_sample01
    values ( 1111, '홍길동', 1500);
    
    -- default 컬럼에 값을 할당하지 않는 경우 -> default에 할당된 값이 적용
    insert into emp_sample01 (eno, ename)
    values ( 2222, '박은비');
    
    insert into emp_sample01 (eno, ename)
    values ( 3333, '김유신');
    
    select * from emp_sample01;
    commit;
    
    Create Table emp_sample02(
    eno number(4) Primary Key not null,
    ename varchar(50) default '홍홍홍',
    salary number(7,2) default 1000);
    
    -- default 컬럼에 값을 할당하지 않는 경우 -> default에 할당된 값이 적용
    insert into emp_sample02(eno)
    values(10);
    
    insert into emp_sample02(eno)
    values(20);
    
     select * from emp_sample02;
     commit;
     
-- Primary Key , Foreign Key, Unique, Check, Default, Not null
    
    Create table member10(
        no number not null constraint PK_memember10_no Primary Key,
        name varchar2(50) constraint NN_member10_name Not null,
        birthday date default sysdate,
        age number(3) check (age > 0 and age < 150),
        gender char(1) check (gender in ('M' , 'W')),
        dno number(2) Unique
    );
    
    insert into member10
    values (1, '박은비', default, 25, 'W', 10);
    
    insert into member10
    values (2, '박은띠', default, 25, 'W', 20);
    
    select * from member10;
    
    Create table order10(
        no number not null Primary Key,
        p_no varchar2(100) not null,
        price number check (price > 10),
        phone varchar2(100) default '010-0000-0000',
        dno number(2) not null,
        foreign key (dno) references member10(dno)
        );
    
    insert into order10  
    values (1, '박은비', 5000,default, 10);
    commit;
    
    drop table member;