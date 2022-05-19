create table mvcboard(
    idx number PRIMARY key,
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
select * from mvcboard;

alter table mvcboard
rename column vistitcount to visitcount;
create sequence seq_board_num
    increment by 1
    start with 1
    nocache;
    
-- ���� ������ �Է� (5���� �� �Է�)
insert into mvcboard (idx, name, title, content, pass)
values( seq_board_num.nextval, '������', '�ڷ�� ����1�Դϴ�.', '����1', '1234');
insert into mvcboard (idx, name, title, content, pass)
values( seq_board_num.nextval, '�庸��', '�ڷ�� ����2�Դϴ�.', '����2', '1234');
insert into mvcboard (idx, name, title, content, pass)
values( seq_board_num.nextval, '�̼���', '�ڷ�� ����3�Դϴ�.', '����3', '1234');
insert into mvcboard (idx, name, title, content, pass)
values( seq_board_num.nextval, '������', '�ڷ�� ����4�Դϴ�.', '����4', '1234');
insert into mvcboard (idx, name, title, content, pass)
values( seq_board_num.nextval, '������', '�ڷ�� ����5�Դϴ�.', '����5', '1234');

commit;
