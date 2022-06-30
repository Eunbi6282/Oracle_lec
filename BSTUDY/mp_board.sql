select * from mp_board order by bno desc;

update mp_board set title = '안녕하세요' where bno = 1;

delete mp_board where bno = 28;

commit;

insert into mp_board(bno, title, content, writer)
select mp_board_seq.nextval, title, content, writer from mp_board;

INSERT INTO MP_BOARD(BNO, TITLE, CONTENT, WRITER)
VALUES (MP_BOARD_SEQ.NEXTVAL, '제목입니다.', '내용입니다.', 'EUNBI');

CREATE SEQUENCE MP_BOARD_SEQ
START WITH 1
INCREMENT BY 1;

drop SEQUENCE mp_board_seq;
commit;

--이 쿼리는 from절에서 rNum으로 약칭한 row_number()에 번호를 매깁니다. 번호는 내림차순이며,

--이렇게 조회된 from절 데이터로 다시 select 조회를 합니다. 

--조건은 rNum이 1~10까지 그리고 내림차순으로 조회한다는 뜻입니다.
select bno, 
      title,
      content,
      writer,
      regdate
from (
        select bno,
                title, 
                content,
                writer,
                regdate,
                row_number() over(order by bno desc) as rNum
        from mp_board
                        ) mp
where rNum between 1 and 10
order by bno desc;

-- 조회수컬럼 추가
alter table mp_board add(hit number default 0);
commit;


SELECT  BNO, 
		        TITLE, 
		        CONTENT,
		        WRITER, 
		        REGDATE,
		        HIT
		 FROM ( 
		        SELECT BNO, 
		               TITLE, 
		               CONTENT, 
		               WRITER, 
		               REGDATE,
		               HIT, 
                       
		               ROW_NUMBER() OVER(ORDER BY BNO DESC) AS RNUM
		         FROM MP_BOARD
		         WHERE 1=1 
		         	<include refid="search"></include>
		                       ) MP
		WHERE RNUM BETWEEN #{rowStart} AND #{rowEnd}
		ORDER BY BNO DESC
