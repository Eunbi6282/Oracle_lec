drop table my_route;
drop sequence myroute_seq;
create table my_route(
    mr_id number primary key,
    title varchar2(200) not null,
    dp_name varchar2(100) not null,
    dp_ny number(38,8) not null,
    dp_nx number(38,8) not null,
    
    t_name1 varchar2(100), 
    t_ny1 number(38,8), 
    t_nx1 number(38,8), 
    
    t_name2 varchar2(100),
    t_ny2 number(38,8),
    t_nx2 number(38,8),
    
    t_name3 varchar2(100),
    t_ny3 number(38,8),
    t_nx3 number(38,8),
    
    ep_name varchar2(100),
    ep_ny number(38,8),
    ep_nx number(38,8),
    
    contents varchar2(2400),
    userid varchar2(50)
);

create sequence myroute_seq
    minvalue 1
    maxvalue 99999
    increment by 1
    start with 1    
    nocache
    noorder
    nocycle;


commit;

select * from my_route;
select * from my_tourroute;
INSERT INTO MY_ROUTE(MR_ID, TITLE, dp_name, dp_ny, dp_nx)
		VALUES(MYROUTE_SEQ.NEXTVAL, '°¡³ª´Ù', 'rkskek', 1.22, 2.33);
rollback;