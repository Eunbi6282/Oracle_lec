-- 제약 조건 수정 (Alter Table : 기존의 테이블에 제약 조건을 수정)

create table emp_copy50
as
select * from employee;

create table dept_copy50
as
select * from department;

select * from user_constraints
where table_name in ('EMPLOYEE' , 'DEPARTMENT');

select * from user_constraints
where table_name in ('EMP_COPY50' , 'DEPT_COPY50'); -- 제약 조건은 복사되지 않는다.

-- 테이블을 복사하면 레코드만 복사가 된다. 테이블의 제약 조건은 복사되어 오지 않는다. Alter table을 사용해서 제약조건을 적용해줘야 함
select * from emp_copy50;
select * from dept_copy50;

    Alter Table emp_copy50
    add constraint PK_emp_copy50_eno primary key (eno);
    
    alter table dept_copy50
    add constraint PK_dept_copy50_dno Primary Key(dno);
    
    select * from user_constraints
    where table_name in ('EMP_COPY50' , 'DEPT_COPY50'); 
    
    
    -- Foreign Key 
    alter table emp_copy50
    add constraint FK_emp_copy50_dno_dept_copy50 Foreign Key (dno) REFERENCES dept_copy50 (dno);
    
    
    -- Not Null 제약조건 추가
    desc employee; -- PK컬럼은 반드시 Not Null로 지정되어야 한다. 
    desc emp_copy50; -- Not Null을 지정하지 않았지만 PK컬럼을 할당했음 -> not null 자동으로 할당 
    desc department;
    desc dept_copy50; -- Not Null을 지정하지 않았지만 PK컬럼을 할당했음 -> not null 자동으로 할당 
    
        -- 기존에 null이 들어가 있는 컬럼은 Not Null을 지정할 수 없다. 
        select ename from employee
        where ename is null; -- null이 있는지 확인
        alter table emp_copy50
        modify ename constraint NN_emp_copy50_ename not null;
        
        -- commisson 컬럼에 not null 할당하기 : null이 들어가 있는 경우 null을 처리 해야 함
        select commission from emp_copy50
        where commission is null;
        
        alter table emp_copy50
        modify commission constraint NN_emp_copy50_commission not null; -- null이 있어서 안됨
        
        -- null 처리
        update emp_copy50
        set commission = 0
        where commission is null;
        commit;
        
        alter table emp_copy50
        modify commission constraint NN_emp_copy50_commission not null;
        
    -- Unique 제약조건 추가 : 컬럼에 중복된 값이 있으면 할당하지 못한다. 
        -- 중복된 값이 있는지 확인
        select ename, count(*)
        from emp_copy50
        group by ename -- ename 컬럼을 그룹핑해서 수를 셈
        having count(*) > 2;
        
        alter table emp_copy50
        add constraint UK_emp_copy50_ename unique (ename);
        
    -- Check 제약조건 추가
    select * from emp_copy50;
    
        -- salary가 일억 미만인 값들만 컬럼에 올 수 있게
        alter table emp_copy50
        add constraint CK_emp_cpoy50_salary Check (salary > 0 and salary < 10000 );
        
    select * from user_constraints
    where table_name in ('EMP_COPY50' , 'DEPT_COPY50'); 
    
    -- default 제약조건 추가 < 제약 조건이 아님 : 제약 조건 이름을 할당할 수 없다 >
        -- 값을 넣지 않을 경우 default로 설정된 값이 들어간다. 
    alter table emp_copy50
    modify salary default 1000;
    
    desc emp_copy50;
    
    insert into emp_copy50(eno, ename, commission)
    values (9999, 'JULI', 100);
    
    alter table emp_copy50
    modify hiredate default sysdate;
    insert into emp_copy50
    values (8888, 'JULIA', null, null, DEFAULT, default,1500,null);
    
-- 제약 조건 제거 : alter table 테이블명 drop 

    -- Primary Key 제거 
    alter table emp_copy50  -- 오류 없음
    drop Primary Key;
    
    alter table dept_copy50  -- 오류 : emp_copy50에서 이 테이블의 Primary키를 참조하고 있기 때문에
    drop Primary Key;
    
    desc dept_copy50;
    
    alter table dept_copy50 --foreign 키를 먼저 제거하고  Primaty key제거
    drop primary key cascade;
    
    select * from user_constraints
    where table_name in ('EMP_COPY50' , 'DEPT_COPY50');
    
    -- nou null컬럼 제거하기 : 
    alter table emp_copy50
    drop constraint NN_EMP_Dopy5_ename;
    
    --unique, check 제약 조건 제거하기 (제약 조건 이름으로 삭제)
    alter table emp_copy50
    drop constraint UK_EMP_COPY50_ENAME;
    
    alter table emp_copy50
    drop constraint CK_EMP_COPY50_SALARY;
    
    alter table emp_copy50
    drop constraint NN_EMP_COPY50_COMMISSION;
    
    --default 값으로 설정된 null 허용 컬럼을 default null로 설정 : default 제약 조건을 제거
    alter table emp_copy50
    modify hiredate default null;
    
    --제약 조건 disable / enable
        --제약 조건을 잠시 중단시킴
        --대량(bulk insert)으로 값을 테이블에 추가할 때 부하가 많이 걸림. disable => enable
        --index를 생성 시 부하가 많이 걸린다. disable => enable
    
    alter table dept_copy50
    add constraint PK_dept_copy50_dno primary key(dno);
    
    alter table emp_copy50
    add constraint PK_emp_copy50_eno primary key(eno);
    
    alter table emp_copy50
    add constraint FK_emp_copy50_dno foreign key(dno) references dept_copy50(dno);
    
    select * from user_constraints
    where table_name in('EMP_COPY50','DEPT_COPY50');
    
    select * from emp_copy50;
    select * from dept_copy50;
    
    alter table emp_copy50
    disable constraint FK_emp_copy50_dno;
    
    insert into emp_copy50(eno,ename,dno)
    values (8989,'aaaa',50);
    
    insert into dept_copy50
    values (50,'HR','SEOUL');
    
    alter table emp_copy50
    enable constraint FK_emp_copy50_dno;

    







    
    -- Unique , check 제약조건 제거 <<제약조건 이름으로 네거>>
    alter table emp_copy50
    drop constraint UK_EMP_Copy50_ENAMKE;
    
     alter table emp_copy50
    drop constraint CK_EMP_Copy50_ENAMKE;
    
     alter table emp_copy50
    drop constraint NN_EMP_Copy50_commission;
    
    -- defaulkt는 j=ubll허ㅛㅇㅇ 컬럼은 defaultk nullㅗ로 세팅 ; defaultk 제약 조건드 애려오는
    alter table emp_copy50
    modify hiredate default null;
    
-- 제약조건 disalble, enable
    -- 제약 조건을 잠시 중지시킴
    -- 대량 (Bulk Insert)으로 값을 테이블에 추가할 때 부하가 많이 걸린다.  disable --> enable
    -- Index(를 생성시 부하가 많이 걸린다ㅏ. disable = >enable
    
    alter table dept_copy50
    add constraint PK_dept_copy50_dno Primary Key (dno);
    
    alter table emp_copy50
    add constraint PK_emp_copy50_eno Primary Key (eno);
    
    alter table emp_copy50
    add constraint FK_emp_copy50_dno_dept_copy50 Foreign Key (dno) references dept_copy50 (dno);
    
    select * from emp_copy50;
    select * from dept_copy50;
    
    insert into emp_copy50 (eno, ename, dno)
    values (8989, 'aaaa' ,50);
    
    alter table emp_copy50
    disable constraint FK_EMP_COPY50_DNO_DEPT_COPY50;
    
    insert into dept_copy50
    values (50, 'HR','seoul');
    
    
    
    alter table emp_copy50
    enable constraint FK_EMP_COPY50_DNO_DEPT_COPY50;
    