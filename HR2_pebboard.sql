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
-- 더미데이터 입력
-- 더미 데이터 입력 (5개로 값 입력)
insert into pebboard (idx, name, title, content, pass)
values( seq_board_peb.nextval, '박은비', '자료실 제목1입니다.', '내용1', '1234');
insert into pebboard (idx, name, title, content, pass)
values( seq_board_peb.nextval, '김미미', '자료실 제목2입니다.', '내용2', '1234');
insert into pebboard (idx, name, title, content, pass)
values( seq_board_peb.nextval, '정재현', '자료실 제목3입니다.', '내용3', '1234');
insert into pebboard (idx, name, title, content, pass)
values( seq_board_peb.nextval, '이도현', '자료실 제목4입니다.', '내용4', '1234');
insert into pebboard (idx, name, title, content, pass)
values( seq_board_peb.nextval, '자라', '자료실 제목5입니다.', '내용5', '1234');
commit;

