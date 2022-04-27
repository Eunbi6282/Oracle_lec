/*
    Foreign Key�� �����Ǵ� ���̺� ����, ���� �� 
        1. �ڽ� ���̺� ���� ���� �� �θ� ���̺� ����
        2. Foreign Key ���������� ��� ���� �� ���̺� ���� 
        3. cascade constraints �ɼ����� ���̺� ���� ����
*/

--1.������� ����
    -- ���̺� ������� �����ؾ� �� : ���̺� ���� �� ���ǻ��� : �ٸ� ���̺��� foreign key�� �ڽ��� ���̺��� �����ϰ� ������ ������ �ȵȴ�.
        -- �ٸ� ���̺��� �����ϰ� �ִ��� �����ϴ� �ɼ� : cascade constraints 
    drop table orders;
    drop table member; -- �����߻� : Orders ���̺��� id�÷��� member ���̺��� id �÷��� �����ϰ� �ִ�. 
    drop table tb_zipcode; -- �����߻� : member ���̺��� zipcode�÷��� tb_zipcode ���̺��� zipcode�÷��� �����ϰ� �ִ�. 
    drop table products;

-- 2.�������� ���� �Ŀ� ���̺� ���� (Foreign Key ����)
        
    Alter table member
    drop constraint FK_MEMBER_ZIPCODE_TB_ZIPCODE;
    
    alter table orders
    drop constraint FK_ORDERS_ID_MEMBER; -- orders ���̺��� member �� �����ϰ� �ִ� ���������� �����ؾ� member���̺� ���� ����
        
    drop table member; 
    drop table tb_zipcode;  --tb_zipcode �� ���� ���� , member ���̺��� ���� ������ ��������� ����
    
    alter table orders
    drop constraint FK_ORDERS_PRODUCT_CODE; 
    
    drop table products;
    
    
    -- �������� Ȯ��
    select * from user_constraints
    where table_name = 'MEMBER';

    select * from user_constraints
    where table_name = 'ORDERS';  
    
-- 3. cascade constraints �ɼ� ����ؼ� ���� <== (Foreign Key ���������� �켱 ���� �� ����)
    rollback;
    drop table member cascade constraints;
    drop table products CASCADE CONSTRAINTS;
    drop table tb_zipcode cascade constraints;
    drop table orders;
    
-- ���̺� ������(Foreign Key �� ������ �� ) : �θ� ���̺�(Foreign Ű�� �����ϴ� ���̺�)�� ���� �����ؾ� �Ѵ�. 
    -- �ڽ� ���̺��� ������ �� Foreign Key�� ���� �ʰ�, �θ� ���̺� ���� �� Alter Table�� ����ؼ� ���߿� Foreign Key�� �־��ش�. 

---------- ���̺� ����-----------

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
    
-- zip.sql ����� ���� ���̺�� �ٸ� ���� ���� �ؼ� insert �Ͻÿ�
    
    -- Ʈ����� �߻� : DML(Insert, Update, Delete) <= commit �ʿ�
    select * from tb_zipcode;
    
     -- ���� �÷� �߰� (zip_seq)
        alter table tb_zipcode
        add zip_seq varchar2(30) ; 
        commit;

    -- �÷��̸� ����. (bungi  ==> bunji) ����
        alter table tb_zipcode
        rename column bungi to bunji; 
        
        alter table tb_zipcode
        rename column gugum to gugun; 
    
    -- ������ �ڸ��� �÷��ֱ�
        Alter Table tb_zipcode
        modify ZIPCODE varchar2 (100);
    
        Alter Table tb_zipcode
        modify DONG varchar2 (100);
        
        select * from tb_zipcode;  -- �Ҿ�����
        truncate table tb_zipcode; -- ������ ���ڵ常 ��� ���� (������ ��� ���ڵ� ����)
        
        delete tb_zipcode;  -- ������ ���ڵ常 ��� ����(DML => commit�ʿ�)
        commit;
        
    
    --���� ���� ��� ��Ȱ��ȭ �ϱ� . (��� ��Ȱ��ȭ �ϱ�) <= Bulk Insert(�뷮���� Insert �� ��) : ���� ������ disable ���Ѿ� ��
        alter table tb_zipcode
        disable constraint PK_tb_zipcode_zipcode;  -- �����߻�: member ���̺��� zipcode�÷��� �����ϰ� �ֱ� ������ 
    
        alter table tb_zipcode
        disable constraint PK_tb_zipcode_zipcode cascade; -- Member ���̺��� PK�� ����� ���� ���ǵ� �Բ� disable
        
        select * from user_constraints
        where table_name in( 'MEMBER', 'TB_ZIPCODE'); -- 'status Ȯ��'
        
        select constraint_name, table_name, status from user_constraints 
        where table_name in ('MEMBER', 'TB_ZIPCODE');
        
     -- ���� ���� Ȱ��ȭ �ϱ�  
        alter table member
        enable novalidate constraint FK_member_zipcode_tb_zipcode;      --���̺� �̹� �ߺ��� ���� �������, �������� ���ְ� �ٸ� �÷����� �̵�
        
        alter table tb_zipcode
        enable novalidate constraint PK_tb_zipcode_zipcode;
        
        select count(*) from tb_zipcode;
        
        -- zip_seq �÷��� ������ ����� ���� ���� ����, ����� ���ĵǵ���
            -- ���� ���� �������� ��µ�, ����ȯ ������� ��(���������� �� ��ȯ �� ����)
        select * from tb_zipcode
        order by zip_seq;
        
        select * from tb_zipcode
        order by to_number(zip_seq, 999999); --������ ��ȯ�� �ƴ� ���������� �����ͼ� �����϶�� ���� (�����ȳ�)
        
        truncate table tb_zipcode;
        
        desc tb_zipcode;
        
        alter table tb_zipcode
        modify zip_seq number(30); -- �̰� �� �ȉ�
        
        select * from tb_zipcode
        where zip_seq = 7;
        
        alter table tb_zipcode
        modify zip_seq varchar2(50); 
        
        
       
       
    
