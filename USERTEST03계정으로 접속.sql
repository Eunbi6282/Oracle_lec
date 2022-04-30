create table testTbl(
    a number not null,
    b number null,
    c varchar2(10) null
    );
    
insert into testtbl
VALUES (1,1,'°¡³ª´Ù');

select * from testtbl;

create view v_b
as select * from testtbl;

create index idx_c
on testtbl (a);

create sequence testtbl.seq
        INCREMENT by 10
        start with 10
        NOCACHE;
        
 insert into testtbl
    values(idx_c.nextval, 2, 'SEOUL');
    commit;