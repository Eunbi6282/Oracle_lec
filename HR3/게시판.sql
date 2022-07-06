--게시판 테이블 생성
CREATE TABLE MP_BOARD(
    BNO NUMBER NOT NULL,
    TITLE VARCHAR2(100)     NOT NULL,
    CONTENT VARCHAR2(2000)  NOT NULL,
    WRITER VARCHAR2(100)    NOT NULL,
    REGDATE DATE            DEFAULT SYSDATE,
    PRIMARY KEY(BNO)
);

--게시판 번호 시퀀스 생성
CREATE SEQUENCE MP_BOARD_SEQ
START WITH 1
INCREMENT BY 1;

--게시판 더미 데이터 생성
INSERT INTO MP_BOARD(BNO, TITLE, CONTENT, WRITER)
     VALUES (MP_BOARD_SEQ.NEXTVAL, '제목입니다', '내용입니다', 'BTS');
INSERT INTO MP_BOARD(BNO, TITLE, CONTENT, WRITER)
     VALUES (MP_BOARD_SEQ.NEXTVAL, '안녕하세요', '호이', '뷔');
INSERT INTO MP_BOARD(BNO, TITLE, CONTENT, WRITER)
     VALUES (MP_BOARD_SEQ.NEXTVAL, '고기줘', '배고파', '정국');

--2배수 게시물 증가 쿼리
insert into mp_board(bno, title, content, writer)
select mp_board_seq.nextval, title, content, writer from mp_board;

--조회수 컬럼 추가
ALTER TABLE MP_BOARD ADD(HIT NUMBER DEFAULT 0);
COMMIT;

--답변 완료 컬럼 추가
ALTER TABLE MP_BOARD ADD(answer varchar(20) DEFAULT '답변대기');

--답변 완료 컬럼 삭제
ALTER TABLE MP_BOARD DROP COLUMN replyCom;

SELECT * FROM MP_BOARD order by bno desc;
COMMIT;

--댓글 테이블 생성
create table mp_reply (
    bno number not null,
    rno number not null,
    content varchar2(1000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    primary key(bno, rno)
);

drop table mp_reply;

--외래키 설정
alter table mp_reply add constraint mp_reply_bno foreign key(bno)
references mp_board(bno) on delete cascade;

SELECT * FROM mp_reply;
COMMIT;

--댓글 번호 시퀀스 생성
create sequence mp_reply_seq START WITH 1 MINVALUE 0;
drop sequence mp_reply_seq;
--댓글 더미 데이터 생성
insert into mp_reply(bno, rno, content, writer)
    values(418, mp_reply_seq.nextval, '테스트댓글', '테스트 작성자');

select rno, content, writer, regdate
  from mp_reply
 where bno = 418;


--SID번호 확인
select name from v$database;

-----------------------------------------------------

UPDATE
    MP_BOARD A
SET
    ANSWER = '답변완료'
WHERE EXISTS (
    SELECT
        RNO
    FROM
        MP_REPLY B
    WHERE
        A.BNO = B.BNO
    );
--------------------------------------------------------
update MP_BOARD A
SET
    ANSWER = (
case
when exists
( select rno from MP_REPLY B where A.BNO = B.BNO) 
then '답변완료' else '답변대기' end);


--------------------------------------------------------
SELECT * FROM MP_BOARD order by bno desc;
commit;

-------------------------------------------------------------------------------------------