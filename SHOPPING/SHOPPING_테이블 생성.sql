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

create table member (
    id varchar2(10) not null primary key, 
    email varchar2(20) not null,
    name varchar2(20) not null,
    pass varchar2(20) not null,
    address varchar2(500) not null,
    tel varchar2(20) not null,
    regidate date default sysdate not null
    );

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

create table board(
    num varchar2(10) primary key,
    id varchar2(10) not null,
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