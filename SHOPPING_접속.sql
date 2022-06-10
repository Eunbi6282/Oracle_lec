
alter table product modify bbsdate varchar2(20);
select *from product;
select p_id, category, wname, pname, sname, price, downprice, stock, description, pImg from product;
select sysdate from product;


    
select * from member;
commit;


drop table board;
drop table member;
drop table product;

create sequence seq_board_peb
    increment by 1
    start with 1
    nocache;
drop sequence seq_board_peb;


select * from board;

alter table board
add constraint BOARD_ID_FK Foreign Key (id) REFERENCES member(id);

desc board;

select * from user_constraints
where table_name = 'BOARD';

select * from board;


delete from member where pass = '1234';
delete from board where num = '8';
commit;

ALTER TABLE board DROP CONSTRAINT BOARD_ID_FK CASCADE;
