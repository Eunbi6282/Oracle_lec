-- ȸ�� ������ �����ϴ� ���̺�
Create table mbTbl (
    idx number not null,  -- ������ ����, ���� �÷�
    id varchar2(100) not null,
    pass varchar2(100) not null,
    name varchar2(100) not null,
    email varchar2(100) not null,
    city varchar2(100) null,
    phone varchar2(100) null);
    
select * from mbtbl;

-- id �� primaryŰ ����
alter table mbTbl
add constraint mbTbl_id_PK PRIMARY KEY (id);

desc mbtbl;

-- idx�� ������ ����
create SEQUENCE seq_mbTbl_idx
    increment by 1
    start with 1
    nocache;
    
/* ���� ������ �Է� */
insert into mbTbl (idx, id, pass,name, email, city, phone)
values (seq_mbTbl_idx.nextval,'admin', '1234', '������' , 'kosmo@kosmo.com','Seoul','010-2055-6828');

Insert into mbTbl (idx ,id , pass, name, email) values (seq_mbTbl_idx.nextval, '" + id + "','" + passwd + "','" + name + "','" + email + "')";

Update mbTbl set name = '������', email = 'gyugyu@naver.com' where id = 'ABCD'



    