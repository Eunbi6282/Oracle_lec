create table product (
    p_id number(10) primary key,
    category varchar2(10) not null,
    wname		varchar2(20) not null,
    pname		varchar2(20) not null,
    sname		varchar2(20) not null,
    price		number(10) default 0,
    downprice	number(10) default 0,
    inputdate	varchar2(20) default sysdate,
    stock		number(10) default 0,
    description	varchar2(2000),
    pImg		varchar2(20)
);
select *from product;
insert into product values (20170033,'TOP','������','��� ����', '���', 30000,25000,default, 33,'��� �ܵ� ���� T', '���_������T');

select sysdate from product;

-- ȸ�� ȸ������
create table member (
    id varchar2(10) not null primary key, 
    email varchar2(20) not null,
    name varchar2(20) not null,
    pass varchar2(20) not null,
    address varchar2(500) not null,
    tel varchar2(20) not null,
    regidate date default sysdate not null
    );
    
-- ������ �α�
select * from member;
insert into member
values ('qkrdmsql1','eun628268@gmail.com', '������','1234','����Ư����', '010-2055-6282' , default);
commit;
create table saleorder(
    id		number(10) primary key,
    name		varchar2(20) not null,
    orderdate	varchar2(20) not null,
    addr		varchar2(50) not null,
    tel		varchar2(20) not null,
    pay		varchar2(10) not null,
    cardno		varchar2(20) not null,
    prodcount	NUMBER(20) default 0,
    total		NUMBER(20) default 0
);

drop table board;
drop table member;
drop table product;

create sequence seq_board_peb
    increment by 1
    start with 1
    nocache;
    

create table board(
    num varchar2(10),
    id varchar2(10) ,
    name VARCHAR2(50) not null,
    title VARCHAR2(200) not null,
    content  VARCHAR2(2000) not null,
    postdate date DEFAULT sysdate not null,
    ofile VARCHAR2(200),
    sfile VARCHAR2(50),
    downcount number(5) DEFAULT 0 not null,
    pass VARCHAR2(50) not null,
    visitcount number DEFAULT 0 not null
);
select * from board;

alter table board
add constraint BOARD_ID_FK Foreign Key (id) REFERENCES member(id);

desc board;

select * from user_constraints
where table_name = 'BOARD';

insert into board ( num, id, name, title,content ,postdate, downcount, pass, visitcount)
values (seq_board_peb.nextval,'20170033','������', '�����ٶ�', '����' , default, default,'1234', default); 

insert into board ( num, id, name, title,content ,postdate, downcount, pass, visitcount)
values (seq_board_peb.nextval,'201700','����', '�����ٶ�', '����' , default, default,'1234', default); 

insert into member
values ('qkrdmsql','eun628268@gmail.com', '������','1234','����Ư����', '010-2055-6282' , default);

insert into member
values ('rkskek', '6282eun@naver.com', '������','1234','��⵵', '010-3333-6282' , default);

delete from member where pass = '1234';

commit;

ALTER TABLE board DROP CONSTRAINT BOARD_ID_FK CASCADE;
