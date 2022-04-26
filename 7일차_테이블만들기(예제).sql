Create table member(
    id varchar2(20) not null constraint PK_member_id Primary Key,
    pwd varchar2(20),
    name varchar2(50),
    zipcode varchar2(7),
    CONSTRAINT FK_member_id_tb_zipcode Foreign key (zipcode) references tb_zipcode (zipcode),
    address varchar2(20),
    tel varchar2(13),
    indate date default sysdate
    );
    
    insert into member
    values ('eunbi', 'eun1234', '박은비', 56971, '서울' , '010-0000-0000',DEFAULT);
    
    insert into member
    values ('hyun', 'hyun1234', '현', 11111, '서울' , '010-0000-0000',DEFAULT);
    
    insert into member
    values ('jae', 'jae1234', '재', null, '서울' , '010-0000-0000',DEFAULT);
    select * from member;
    commit;
    
Create table tb_zipcode(
    zipcode varchar2(7) not null CONSTRAINT PK_tb_zipcode_zipcode Primary key,
    sido varchar2(30), 
    gugum varchar2(30),
    dong varchar2(30),
    bungi varchar2(30)
    );
    
    -- 1. 컬럼 이름 변경
    alter table tb_zipcode
    rename column gugum to gugun;
    
    -- 2.컬럼 이름 변경
    alter table tb_zipcode
    rename column bungi to bunji;
    
    -- 3. 컬럼 추가
    alter table tb_zipcode
    add (Zip_seq varchar2 (10));
    
    select * from tb_zipcode;
    
    -- 4. 컬럼 자료형 수정
    alter table tb_zipcode
    modify dong Nvarchar2(100);
    
    -- 5. 컬럼 primary key 수정
   
    commit;
    
    
    
    
    insert into tb_zipcode
    values (56971, '서울특별시', '금천구', '가산동', '12번지');
    
    insert into tb_zipcode
    values (11111, '서울특별시', '강서구', '동동동', '56번지');
    
    insert into tb_zipcode
    values (22222, '서울특별시', '강동구', '동동', '72번지');
    
    select * from tb_zipcode;
    commit;

Create table products(
    product_code varchar2(20) not null constraint PK_products_product_code Primary Key,
    product_name varchar2(100),
    product_kind char(1),
    product_price1 varchar2(10),
    product_price2 varchar2(10),
    product_content varchar2(1000),
    product_image varchar2(50),
    sizeSt varchar2(5),
    sizeEt varchar2(5),
    product_quantity varchar2(5),
    useyn char(1),
    indate date
    );
    
    insert into products
    values (1111, '장난감' , 'A', 3000, 10000, '아이들 장난감', '뽀로로', 30 , 50, 300, 'T', sysdate);
    
    insert into products
    values (2222, '문구류' , 'B', 3000, 10000, '아이들 문구류', '짱구', 30 , 50, 300, 'T', sysdate);
    
    insert into products
    values (3333, '점토' , 'C', 3000, 10000, '아이들 점토', '포켓몬', 30 , 50, 300, 'T', sysdate);
    
    
    select * from products;
    commit;

Create table orders(
    o_seq number(10) not null CONSTRAINT PK_orders_o_seq Primary key,
    product_code varchar2(20),
    CONSTRAINT FK_orders_p_code_products Foreign key (product_code) REFERENCES products(product_code),
    id varchar2(16),
    CONSTRAINT FK_orders_id_member Foreign Key (id) REFERENCES member (id),
    product_size varchar2(5),
    quantity varchar2(5),
    result char(1),
    indate date
    );
    
    insert into orders
    values (2233, 1111, 'eunbi', 50, 3, 'F' , to_date('22-04-24','YY-MM-DD'));
    
    insert into orders
    values (3344, 1111, 'hyun', 50, 3, 'F' , to_date('22-04-25','YY-MM-DD'));
    
    insert into orders
    values (4455, 1111, 'jae', 50, 3, 'F' ,sysdate);
    
    select * from orders;
    
    delete orders
    where id = 'jae';
    
    commit;
    
    create table member2(
    id varchar2(20) not null constraint PK_member_id PRIMARY Key,
    pwd varchar2(20),
    name varchar2(50),
    zipcode varchar2(7),
    CONSTRAINT FK_member_id_tb_zipcode Foreign key (zipcode) references tb_zipcode(zipcode),
    address varchar2(20),
    tel varchar2(13),
    indate date default sysdate
    );
