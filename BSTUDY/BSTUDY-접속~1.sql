create table mp_reply (
    bno number not null,
    rno number not null,
    content varchar2(1000) not null,
    writer VARCHAR2(50) not null,
    regdate date default sysdate,
    primary key (bno, rno)
);

alter table mp_reply add CONSTRAINT mp_reply_bno foreign key(bno)
references mp_board(bno);

create SEQUENCE mp_reply_seq 
start with 1
MINVALUE 0;

commit;