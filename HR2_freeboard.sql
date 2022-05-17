
Create or replace table freeboard (
    id number constraint PK_freeboard_id Primary Key,   -- �ڵ� ���� �÷�
    name varchar2(10) not null,
    password varchar2(100) null,
    email varchar2(100) null,
    subject varchar2(100) not null, -- �� ����
    content varchar2(2000),  -- �� ����
    inputdate varchar2(100) not null, -- �۾� ��¥
        -- �����亯���Խ��� (masterid, readcount, step => 3���� �÷� �ʿ�)
    masterid  number default 0, -- �亯�� �۵��� �׷����� �� ���
    readcount number default 0, -- �� ��ȸ�� 
    replynum number default 0,  
    step number default 0
    );
    
select * from freeboard
order by id desc;

Insert into freeboard (id, name, password, email, subject, content, inputdate, masterid, readcount, replynum , step) 
values (1,'ddddd','1234', 'ddd','dd','ddddd ddd d d d d','22-00-11 12:00 ����',1,0,0,0);

Insert into freeboard (id, name, password, email, subject, content, inputdate, masterid, readcount, replynum, step) 
values (?,?,?,?,?,?,?,?,?,?,?) ;
desc freeboard;

Insert into freeboard (id, name, password, email, subject, content, inputdate, masterid, readcount, replynum , step) 
values (43,'ȫ�浿5','1234', 'eunbi628268@gmail.com','����5','���� 1 ''����2'' ���� 5 ','22-05-13 11:54 ����',34,0,0,1);

commit;

select * from freeboard 
where name like '%������%' or subject like '%������%' or content like '%������%' order by id desc;
-------------------------����¡ ó�� ����---------------------------------------------

-- !! �亯���� �����ϴ� ���̺��� ����� �� �ݵ�� �� �÷��� masterid desc, replynum, step, id �̷��� �����;� ��!!
select * from freeboard 
order by masterid desc, replynum, step, id;
    -- 

select * from freeboard
order by id desc;
-- id �÷� : ���ο� ���� ��ϵ� �� ������ id�÷��� �ִ밪�� �����ͼ� +1 �� <= ���� ��ȣ�� �ѹ���

-- �亯���� ó���ϱ� ���� �÷� 3�� (masterid, replynum, step)
    -- materid �÷� : ���� �亯������ �׷���, id �÷��� ���� �״�� �� ���� �亯���� �ƴ϶� ó������
        -- Ư���ۿ����� �亯���̶�� �亯�۵��� ���� masterid ������ ��
    -- replynum : �亯�ۿ� ���� �ѹ��� . ���� �ۿ����� �亯���̸� �ѹ���
    -- step : �亯���� ����
        -- 0 : ó����( �ڽ��� ��, �亯�� x)
        -- 1 : �亯��
        -- 2: �亯�� �亯
        -- 3 : �亯�� �亯�� �亯