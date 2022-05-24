create table pebboard(
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

select * from pebboard;

create sequence seq_board_peb
    increment by 1
    start with 1
    nocache;
    
drop sequence seq_board_peb;


drop table pebboard;
-- ���̵����� �Է�
-- ���� ������ �Է� (5���� �� �Է�)
insert into pebboard (idx, name, title, content, pass)
values( seq_board_peb.nextval, '������', '�ڷ�� ����1�Դϴ�.', '����1', '1234');
insert into pebboard (idx, name, title, content, pass)
values( seq_board_peb.nextval, '��̹�', '�ڷ�� ����2�Դϴ�.', '����2', '1234');
insert into pebboard (idx, name, title, content, pass)
values( seq_board_peb.nextval, '������', '�ڷ�� ����3�Դϴ�.', '����3', '1234');
insert into pebboard (idx, name, title, content, pass)
values( seq_board_peb.nextval, '�̵���', '�ڷ�� ����4�Դϴ�.', '����4', '1234');
insert into pebboard (idx, name, title, content, pass)
values( seq_board_peb.nextval, '�ڶ�', '�ڷ�� ����5�Դϴ�.', '����5', '1234');
commit;

