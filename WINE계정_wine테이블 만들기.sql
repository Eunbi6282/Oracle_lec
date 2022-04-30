create table grade_pt_rade (
    mem_grade varchar2(20) not null constraint PK_grade_pt_rade_men_grade Primary Key,
    grade_pt_rate number(3,2)
    );

    insert into grade_pt_rade
    values ('Silver' , 0.01);
    
    insert into grade_pt_rade
    values ('Gold' , 0.05);
    
    insert into grade_pt_rade
    values ('VIP' , 0.1);
    
    select * from grade_pt_rade;


create table member(
    mem_id varchar2(6) not null constraint PK_member_mem_id Primary Key,
    mem_grade varchar2 (20),
    constraint FK_member_grade_grade_pt_rade Foreign Key (mem_grade) REFERENCES grade_pt_rade(mem_grade),
    mem_pw varchar2(20) not null,
    mem_birth date  default sysdate not null, 
    mem_tel varchar2(20),
    mem_pt varchar2(10) DEFAULT 0 not null
    );
    
    insert into member 
    values ('eun622', 'Silver', 'park1234', to_date('98-10-18', 'YY-MM-DD'),'010-2055-6282',DEFAULT);
    
    insert into member 
    values ('run622', 'Gold', 'park1234', to_date('98-10-18', 'YY-MM-DD'),'010-2055-6282',DEFAULT);
    
    insert into member 
    values ('pun622', 'VIP', 'park1234', to_date('98-10-18', 'YY-MM-DD'),'010-2055-6282',DEFAULT);
    
    select * from member;

create table today(
    today_code varchar2(6) not null constraint PK_today_today_code Primary Key,
    today_sens_value number(3),
    today_intell_value number(3),
    today_phy_value number(3)
    );
    
    insert into today
    values ('v_12', 5,4,7);
    
    insert into today
    values ('v_13', 5,4,7);
    
    insert into today
    values ('v_14', 5,4,7);
    
    select * from today;

create table nation (
    nation_code varchar2(26) not null constraint PK_nation_nation_code Primary Key,
    nation_name varchar2(50) not null
    );
    
    insert into nation
    values ('3300', 'France');
    
    insert into nation
    values ('3322', 'France');
    
    insert into nation
    values ('3333', 'Italy');
    
    update nation
    set nation_name = 'Italy'
    where nation_name = 'ITALY';
    commit;
    
    select * from nation;
    
create table theme (
    theme_code varchar2(6) not null constraint PK_theme_theme_code Primary Key,
    theme_name varchar2(50) not null
    );
    
    insert into theme
    values ('T_1' , 'bitters_1');
    
    insert into theme
    values ('T_2' , 'sweetness_1');
    
    insert into theme
    values ('T_3' , 'bitters_2');
    
    select * from theme;
    
create table wine_type (
    wine_type_code varchar2(6) not null constraint PK_wine_type_wine_type_code Primary Key,
    wine_type_name varchar2(50)
    );
    
    insert into wine_type
    values ('TW_1' , 'White');
    
    insert into wine_type
    values ('TW_2' , 'Red');
    
    insert into wine_type
    values ('TW_3' , 'Sparkling');
    
    select * from wine_type;
    

create table wine (
    wine_code varchar2(26) not null CONSTRAINT PK_wine_wine_code Primary Key,
    wine_name varchar2(100) not null,
    wine_url BLOB,
    nation_code varchar2(6),
    CONSTRAINT FK_wine_nation_code_nation Foreign Key (nation_code) REFERENCES nation(nation_code),
    wine_type_code varchar2(6),
    constraint FK_wine_wine_type_code_wtype Foreign Key (wine_type_code) REFERENCES wine_type (wine_type_code),
    wine_sugar_code number(2) ,
    wine_price number(15) DEFAULT 0 not null,
    wine_vintage date,
    theme_code varchar2(6),
    constraint FK_wine_theme_code_theme Foreign Key (theme_code) REFERENCES theme (theme_code),
    today_code varchar2(6),
    constraint FK_wine_today_code_today Foreign Key (today_code) references today (today_code)
    );
    
    insert into wine
    values ('wc_1' , 'AA' , null, '3300', 'TW_1',11 ,33000, to_Date('77-05-05','YY-MM-DD'),'T_1', 'v_12');
    
    insert into wine
    values ('wc_2' , 'BB' , null, '3322', 'TW_2',11 ,33000, to_Date('77-05-05','YY-MM-DD'),'T_1', 'v_12');
    
    insert into wine
    values ('wc_3' , 'CC' , null, '3333', 'TW_3',11 ,33000, to_Date('77-05-05','YY-MM-DD'),'T_1', 'v_12');
    
    select * from wine;

create table manager(
    manager_id varchar2(30) not null CONSTRAINT PK_manager_manager_id Primary Key,
    manager_pwd varchar2 (20) not null,
    manager_tel varchar2 (20)
    );
    
    insert into manager
    values(12345, 1234,null);
    
    insert into manager
    values(123456, 1234,null);
    
    insert into manager
    values(123457, 1234,null);
    
    select * from manager;

create table stock_mamagement (
    stock_code varchar2 (6) not null CONSTRAINT PK_stock_mamagement_stock_code Primary Key,
    wine_code varchar2(6),
    constraint FK_stock_mam_winecode_wine FOREIGN KEY (wine_code) REFERENCES wine (wine_code),
    manager_id varchar2(30),
    CONSTRAINT FK_stock_mam_managerid_manager FOREIGN KEY (manager_id) references manager (manager_id),
    ware_date date DEFAULT sysdate not null,
    stock_amount number(5) default 0 not null
    );
    
    -- 矫啮胶 积己
     create sequence stock_mamagement_seq
        increment by 10
        start with 10
        NOCACHE;
        
    insert into stock_mamagement
    values(stock_mamagement_seq.nextval, 'wc_1', 12345, default, 500);
    
    insert into stock_mamagement
    values(stock_mamagement_seq.nextval, 'wc_2', 123456, default, 1000);
    
    insert into stock_mamagement
    values(stock_mamagement_seq.nextval, 'wc_3', 123457, default, 5008);
    
    select * from stock_mamagement;
    
create table sale (
    sale_date date default sysdate not null constraint PK_sale_sale_date Primary key,
    wine_code varchar2(6) not null,
    constraint FK_sale_winecode_wine FOREIGN KEY (wine_code) REFERENCES wine (wine_code),
    mem_id varchar2(30) not null ,
    constraint FK_sale_memid_member FOREIGN KEY (mem_id) REFERENCES member (mem_id),
    sale_amount varchar2 (5) default 0 not null,
    sale_price varchar2(6) default 0 not null,
    sale_tot_price varchar2(15) default 0 not null
    );
    
    -- 矫啮胶 积己
    create sequence sale_seq_no
        increment by 1
        start with 1
        NOCACHE;
    
    insert into sale
    values(default, 'wc_1', 'eun622' , default, 300000, sale_seq_no.nextval);
    
    insert into sale
    values(default, 'wc_2', 'eun622' , default, 300000, sale_seq_no.nextval);
    
    insert into sale
    values(default, 'wc_3', 'eun622' , default, 300000, sale_seq_no.nextval);
    
    select * from sale;
    
    
select * from user_tables;

select * from user_constraints;



    