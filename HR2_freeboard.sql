
Create or replace table freeboard (
    id number constraint PK_freeboard_id Primary Key,   -- 자동 증가 컬럼
    name varchar2(10) not null,
    password varchar2(100) null,
    email varchar2(100) null,
    subject varchar2(100) not null, -- 글 제목
    content varchar2(2000),  -- 글 내용
    inputdate varchar2(100) not null, -- 글쓴 날짜
        -- 질문답변형게시판 (masterid, readcount, step => 3개의 컬럼 필요)
    masterid  number default 0, -- 답변의 글들을 그룹핑할 때 사용
    readcount number default 0, -- 글 조회수 
    replynum number default 0,  
    step number default 0
    );
    
select * from freeboard
order by id desc;

Insert into freeboard (id, name, password, email, subject, content, inputdate, masterid, readcount, replynum , step) 
values (1,'ddddd','1234', 'ddd','dd','ddddd ddd d d d d','22-00-11 12:00 오후',1,0,0,0);

Insert into freeboard (id, name, password, email, subject, content, inputdate, masterid, readcount, replynum, step) 
values (?,?,?,?,?,?,?,?,?,?,?) ;
desc freeboard;

Insert into freeboard (id, name, password, email, subject, content, inputdate, masterid, readcount, replynum , step) 
values (43,'홍길동5','1234', 'eunbi628268@gmail.com','제목5','내용 1 ''내용2'' 내용 5 ','22-05-13 11:54 오전',34,0,0,1);

commit;

select * from freeboard 
where name like '%가나다%' or subject like '%가나다%' or content like '%가나다%' order by id desc;
-------------------------페이징 처리 쿼리---------------------------------------------

-- !! 답변글이 존재하는 테이블을 출력할 때 반드시 세 컬럼을 masterid desc, replynum, step, id 이렇게 가져와야 함!!
select * from freeboard 
order by masterid desc, replynum, step, id;
    -- 

select * from freeboard
order by id desc;
-- id 컬럼 : 새로운 글이 등록될 때 기존의 id컬럼의 최대값을 가져와서 +1 함 <= 새글 번호의 넘버링

-- 답변글을 처리하기 위한 컬럼 3개 (masterid, replynum, step)
    -- materid 컬럼 : 글의 답변에대한 그룹핑, id 컬럼의 값이 그대로 들어간 경우는 답변글이 아니라 처음글임
        -- 특정글에대한 답변글이라면 답변글들이 전부 masterid 값으로 들어감
    -- replynum : 답변글에 대한 넘버링 . 같은 글에대한 답변글이면 넘버링
    -- step : 답변글의 깊이
        -- 0 : 처음글( 자신의 글, 답변글 x)
        -- 1 : 답변글
        -- 2: 답변의 답변
        -- 3 : 답변의 답변의 답변