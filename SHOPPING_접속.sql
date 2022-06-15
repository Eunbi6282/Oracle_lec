
alter table product modify bbsdate varchar2(20);
select *from product;
select p_id, category, wname, pname, sname, price, downprice, stock, description, pImg from product;
select sysdate from product;


    
select * from member;
commit;


drop table board;
drop table member;
drop table product;
drop table cart;

create sequence seq_board_peb
    increment by 1
    start with 1
    nocache;
drop sequence seq_board_peb;


select * from board;
select * from cart;
select * from product;

alter table board
add constraint BOARD_ID_FK Foreign Key (id) REFERENCES member(id);

alter table board
add constraint BOARD_Pass_FK Foreign Key (pass) REFERENCES member(pass);

alter table board
add constraint BOARD_Pass_FK Foreign Key (pass) REFERENCES member(pass);


desc board;

select * from user_constraints
where table_name = 'CART';

select * from board;


delete from member where pass = '1234';
delete from board where num = '8';
commit;

ALTER TABLE board DROP CONSTRAINT BOARD_ID_FK CASCADE;
alter table cart drop constraint cart_p_id_FK cascade;
ALTER TABLE product MODIFY p_id VARCHAR2(10);
