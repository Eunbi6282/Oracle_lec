create table guestboard2 (
	name varchar2(100),
	email varchar2(100),
	inputdate varchar2(100) primary key,
	subject varchar2(100),
	content varchar2(2000)
);

select * from guestboard2 order by inputdate desc;
desc guestboard2;

insert into guestboard2 (name, email, inputdate, subject, content) values( '이름', 'Email', '2022. 5. 16. 오전 11:28:57', '제목', '내용 ');
commit;

delete  guestboard2 
where name = 'dlfma';

cre