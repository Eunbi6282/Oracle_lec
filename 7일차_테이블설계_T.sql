/*
    Foreign Key로 참조되는 테이블 생성, 삭제 시 
        1. 자식 테이블 먼저 삭제 후 부모 테이블 삭제
        2. Foreign Key 제약조건을 모두 제거 후 테이블 삭제 
        3. cascade constraints 옵션으로 테이블 강제 삭제
*/

--1.순서대로 삭제
    -- 테이블 순서대로 삭제해야 함 : 테이블 삭제 시 주의사항 : 다른 테이블에서 foreign key로 자신의 테이블을 참조하고 있으면 삭제가 안된다.
        -- 다른 테이블이 참조하고 있더라도 삭제하는 옵션 : cascade constraints 
    drop table orders;
    drop table member; -- 오류발생 : Orders 테이블의 id컬럼이 member 테이블의 id 컬럼을 참조하고 있다. 
    drop table tb_zipcode; -- 오류발생 : member 테이블의 zipcode컬럼이 tb_zipcode 테이블의 zipcode컬럼을 참조하고 있다. 
    drop table products;

-- 2.제약조건 제거 후에 테이블 삭제 (Foreign Key 삭제)
        
    Alter table member
    drop constraint FK_MEMBER_ZIPCODE_TB_ZIPCODE;
    
    alter table orders
    drop constraint FK_ORDERS_ID_MEMBER; -- orders 테이블의 member 를 참조하고 있는 제약조건을 제거해야 member테이블 삭제 가능
        
    drop table member; 
    drop table tb_zipcode;  --tb_zipcode 도 삭제 가능 , member 테이블의 제약 조건을 제거해줬기 때문
    
    alter table orders
    drop constraint FK_ORDERS_PRODUCT_CODE; 
    
    drop table products;
    
    
    -- 제약조건 확인
    select * from user_constraints
    where table_name = 'MEMBER';

    select * from user_constraints
    where table_name = 'ORDERS';  
    
-- 3. cascade constraints 옵션 사용해서 삭제 <== (Foreign Key 제약조건을 우선 제거 후 삭제)
    rollback;
    drop table member cascade constraints;
    drop table products CASCADE CONSTRAINTS;
    drop table tb_zipcode cascade constraints;
    drop table orders;
    
-- 테이블 생성시(Foreign Key 가 존재할 때 ) : 부모 테이블(Foreign 키가 참조하는 테이블)을 먼저 생성해야 한다. 
    -- 자식 테이블을 생성할 때 Foreign Key를 넣지 않고, 부모 테이블 생성 후 Alter Table을 사용해서 나중에 Foreign Key를 넣어준다. 

---------- 테이블 설계-----------

CREATE TABLE tb_zipcode(
    zipcode VARCHAR2(7) NOT NULL CONSTRAINT PK_tb_zipcode_zipcode PRIMARY KEY,
    sido VARCHAR2(30),
    gugum VARCHAR2(30),
    dong VARCHAR2(30),
    bungi VARCHAR2(30)
    );
    
    
CREATE TABLE member(
    id VARCHAR(20) NOT NULL CONSTRAINT PK_member_id PRIMARY KEY,
    pwd VARCHAR(20),
    name VARCHAR(20),
    zipcode VARCHAR(7), CONSTRAINT FK_member_zipcode_tb_zipcode FOREIGN KEY (zipcode) REFERENCES tb_zipcode(zipcode)
    );

CREATE TABLE products (
    product_code VARCHAR2(20) NOT NULL CONSTRAINT PK_products_product_code PRIMARY KEY,
    product_name VARCHAR2(100),
    product_kind CHAR(1),
    product_price1 VARCHAR2(10),
    product_price2 VARCHAR2(10),
    product_content VARCHAR2(1000),
    product_image VARCHAR2(50),
    sizeSt VARCHAR2(5),
    sizeEt VARCHAR2(5),
    product_quantity VARCHAR2(5),
    useyn CHAR(1),
    indate DATE
    );
   
CREATE TABLE orders(
    o_seq NUMBER(10) NOT NULL CONSTRAINT PK_orders_o_seq PRIMARY KEY,
    product_code VARCHAR2(20), CONSTRAINT FK_orders_product_code FOREIGN KEY (product_code) REFERENCES products(product_code),
    id VARCHAR2(16), CONSTRAINT FK_orders_id_member FOREIGN KEY (id) REFERENCES member(id),
    product_size VARCHAR2(5),
    quantity VARCHAR2(5),
    result CHAR(1),
    indate DATE
    );
    
-- zip.sql 적용시 실제 테이블과 다른 점을 수정 해서 insert 하시오
    
    -- 트랜잭션 발생 : DML(Insert, Update, Delete) <= commit 필요
    select * from tb_zipcode;
    
     -- 누락 컬럼 추가 (zip_seq)
        alter table tb_zipcode
        add zip_seq varchar2(30) ; 
        commit;

    -- 컬럼이름 변경. (bungi  ==> bunji) 수정
        alter table tb_zipcode
        rename column bungi to bunji; 
        
        alter table tb_zipcode
        rename column gugum to gugun; 
    
    -- 부족한 자리수 늘려주기
        Alter Table tb_zipcode
        modify ZIPCODE varchar2 (100);
    
        Alter Table tb_zipcode
        modify DONG varchar2 (100);
        
        select * from tb_zipcode;  -- 불안정함
        truncate table tb_zipcode; -- 기존의 레코드만 모두 제거 (빠르게 모든 레코드 삭제)
        
        delete tb_zipcode;  -- 기존의 레코드만 모두 제거(DML => commit필요)
        commit;
        
    
    --제약 조건 잠시 비활성화 하기 . (잠시 비활성화 하기) <= Bulk Insert(대량으로 Insert 할 시) : 제약 조건을 disable 시켜야 함
        alter table tb_zipcode
        disable constraint PK_tb_zipcode_zipcode;  -- 오류발생: member 테이블의 zipcode컬럼이 참조하고 있기 때문에 
    
        alter table tb_zipcode
        disable constraint PK_tb_zipcode_zipcode cascade; -- Member 테이블의 PK가 적용된 제약 조건도 함께 disable
        
        select * from user_constraints
        where table_name in( 'MEMBER', 'TB_ZIPCODE'); -- 'status 확인'
        
        select constraint_name, table_name, status from user_constraints 
        where table_name in ('MEMBER', 'TB_ZIPCODE');
        
     -- 제약 조건 활성화 하기  
        alter table member
        enable novalidate constraint FK_member_zipcode_tb_zipcode;      --테이블에 이미 중복된 값이 들어있음, 제약조건 없애고 다른 컬럼으로 이동
        
        alter table tb_zipcode
        enable novalidate constraint PK_tb_zipcode_zipcode;
        
        select count(*) from tb_zipcode;
        
        -- zip_seq 컬럼의 정렬이 제대로 되지 않은 이유, 제대로 정렬되도록
            -- 문자 정렬 형식으로 출력됨, 형변환 시켜줘야 함(숫자형으로 형 변환 후 정렬)
        select * from tb_zipcode
        order by zip_seq;
        
        select * from tb_zipcode
        order by to_number(zip_seq, 999999); --문자형 변환이 아닌 문자형으로 가져와서 정렬하라는 거임 (오류안남)
        
        truncate table tb_zipcode;
        
        desc tb_zipcode;
        
        alter table tb_zipcode
        modify zip_seq number(30); -- 이거 왜 안됑
        
        select * from tb_zipcode
        where zip_seq = 7;
        
        alter table tb_zipcode
        modify zip_seq varchar2(50); 
        
        
       
       
    
