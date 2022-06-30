select * from mp_board order by bno desc;

update mp_board set title = '�ȳ��ϼ���' where bno = 1;

delete mp_board where bno = 28;

commit;

insert into mp_board(bno, title, content, writer)
select mp_board_seq.nextval, title, content, writer from mp_board;

INSERT INTO MP_BOARD(BNO, TITLE, CONTENT, WRITER)
VALUES (MP_BOARD_SEQ.NEXTVAL, '�����Դϴ�.', '�����Դϴ�.', 'EUNBI');

CREATE SEQUENCE MP_BOARD_SEQ
START WITH 1
INCREMENT BY 1;

drop SEQUENCE mp_board_seq;
commit;

--�� ������ from������ rNum���� ��Ī�� row_number()�� ��ȣ�� �ű�ϴ�. ��ȣ�� ���������̸�,

--�̷��� ��ȸ�� from�� �����ͷ� �ٽ� select ��ȸ�� �մϴ�. 

--������ rNum�� 1~10���� �׸��� ������������ ��ȸ�Ѵٴ� ���Դϴ�.
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

-- ��ȸ���÷� �߰�
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
