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

insert into mp_reply (bno, rno, content, writer)
values(421, MP_REPLY_SEQ.NEXTVAL, '댓글입니다.', '은띠박');

select b.bno, rno, answertf
FROM mp_board b, mp_reply r
where b.bno = 421
and b.bno = r. bno;

drop sequence mp_reply_seq;

-- 답변완료 컬럼
alter table mp_reply add answertf number(1) default 0;
commit;

-- 답변완료 컬럼 타입 수정
ALTER TABLE mp_reply MODIFY(answertf varchar2(50) default '답변대기');

delete mp_reply where answertf = 0;
select * from mp_reply
where bno = 421;



-- 답변완료 join
SELECT B.BNO, B.TITLE, B.CONTENT, B.WRITER, B.REGDATE, B.HIT, R.RNO, R.CONTENT, R.ANSWERTF
FROM MP_BOARD B, MP_REPLY R
WHERE B.BNO = R.BNO(+)
and b.bno = 421
order by bno desc;

select * from mp_board b, mp_reply r
where b.bno = r.bno(+) ; 



select * from mp_board;
select * from mp_reply;

-- 답변완료 update
UPDATE MP_REPLY SET ANSWERTF = '답변완료'
WHERE BNO = 421;
(select bno
from mp_board
where bno = 421);


COMMIT;




