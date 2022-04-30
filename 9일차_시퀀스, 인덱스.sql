--  9일차 시퀀스, 인덱스
/*
    시퀀스 : 자동 번호 발생기, 특정 컬럼 넘버링 할 때
        -- 번호가 발생이 되면 뒤로 되돌릴 수 없다. (삭제 후 다시 만들어야 함)
        -- Primary Key 컬럼에 번호를 자동으로 발생시키기 위해서 사용
        -- Primary Key 컬럼은 고유한 값을 신경 안써도 된다. 
*/

Create sequence sample_seq
    increment by 10 -- 증가값
    start with 10;  -- 초기값
    
-- 시퀀스의 정보를 출력하는 데이터 사전
    select * from user_sequences;
    
    select sample_seq.nextval from dual; -- 시퀀스의 다음값을 출력
    select sample_seq.currval from dual; -- 현재 시퀀스의 값

-- 초기값 : 2, 증가값 : 2
    create sequence sample_seq2
        INCREMENT by 2
        start with 2
        nocache;    -- 캐쉬를 사용하지 않겠다. (RAM) --서버의 부하를 줄여줄 수 있다.
    
    select sample_seq2.nextval from dual; -- 시퀀스의 다음값을 출력
    select sample_seq2.currval from dual; -- 현재 시퀀스의 값

-- 시퀀스를 Primary Key에 적용하기
    Create table dept_copy80
    as 
    select * 
    from department
    where 0 = 1;
    
    select * from dept_copy80;
    
    -- 시퀀스 생성 : 초기값 10, 증가값 10
    create sequence dept_sep
        INCREMENT by 10
        start with 10
        NOCACHE;
        
        /* sequence에 cache를 사용하는 경우 
            - cache : 서버의 성능을 향상하기 위해서 사용(기본값 : 20개)
            - 서버가 다운된 경우 : 캐쉬된 넘버링이 모두 날라감. 새로운 값을 할당 받는다. 
            
            cache를 사용하지 않는 경우
            
        */
        
        
    insert into dept_copy80(dno, dname, loc)
    values(DEPT_SEP.nextval, 'HR', 'SEOUL');
    commit;
    select * from dept_copy80;
    
    -- 시퀀스 생성
    create sequence emp_seq_no
        increment by 1
        start with 1
        NOCACHE;
        
    create table emp_copy80
    as
    select * from employee
    where 0 = 1; -- false (테이블 구조만 가져오기)
    
    select * from emp_copy80;
    
    -- 시퀀스를 테이블에 할당
    insert into emp_copy80
    values (emp_seq_no.nextval, 'eunbi','Student',2222,sysdate,2800,0,10);
     
     -- 기존의 시퀀스 수정
    select * from user_sequences; -- 사용자의 모든 시퀀스 확인 가능
     
    alter SEQUENCE emp_seq_no
        maxvalue 1000 ;  -- 최대값을 1000으로
        
    alter sequence emp_seq_no
        cycle;   -- 최대값이 적용되고 다시 처음부터 순환  / nocycle :  cycle적용 취소 
        
    drop sequence emp_seq_no;
    
/* 인덱스 : 테이블의 컬럼에 생성, 특정 컬럼의 검색을 빠르게 사용할 수 있도록
        - 색인(index) : 책의 색인과 같음. ex) 책 안의 내용의 중요 키워드를 수집해서 위치를 알려줌
        - Index Page : 컬럼의 중요 키워드를 걸러서 위치 정보를 담아 놓은 페이지 
            - DB 공간의 10% 정도를 차지
            - Primary, Unique Key 가 적용된 컬럼은 자동으로 index 페이지가 만들어져 있다. 
            - where절에서 자주 검색을 하는 컬럼에 index를 생성
            - 테이블의 검색을 자주하는 컬럼에 Index생성, 테이블 스캔이 아닌 index page가 생성되어 검색을 빠르게 한다.
            - Index를 생설 할 때 부하가 많이 걸린다. 주로 업무 시간을 피해서 야간에 생성함. 
            - 잘 생성해야 함!! 
            
            
        - 테이블 스캔 : 레코드의 처음 ~ 마지막 까지 검색 (검색속도가 느리다.), 인덱스를 사용하지 않고 검색.
            - Index가 생성되어 있지 않는 컬럼은 테이블 스캔을 한다. 
        -
*/

    -- 인덱스 정보가 저장되어 있는 데이터 사전 출력
    --user_tab_columns, user_ind_columns
    select * from user_tab_columns;
    select * from user_ind_columns;
    
     select * from user_tab_columns
     where table_name in ('EMPLOYEE', 'DEPARTMENT');
    
    select index_name , table_name, column_name
    from user_ind_columns
    where table_name in ('EMPLOYEE', 'DEPARTMENT' );
    
    select * from employee; -- eno컬럼에 Primary Key가 들어가 있다..자동으로 인덱스가 만들어짐

/*
    index 자동 생성 (Primary Ky, Uuique )컬럼에는 index page가 자동으로 생성된다.
*/
 
 create table tbll(
    a number (4) constraint PK_tbll_a PRIMARY key,
    b number(4),
    c number 
    );
    
 select index_name , table_name, column_name
    from user_ind_columns
    where table_name in ('EMPLOYEE', 'DEPARTMENT','TBL1');
    
create table tbl2(
    a number(4) CONSTRAINT PK_tb12_1 Primary Key,
    b number(4) CONSTRAINT UK_tb12_b Unique,
    c number (4) CONSTRAINT UK_tbl2_c unique
    );
    
    select index_name , table_name, column_name
    from user_ind_columns
    where table_name in ('EMPLOYEE', 'DEPARTMENT','TBL2');
    
    select * from tbl2;
    
Create table emp_copy90
as 
select * from employee;

    select index_name , table_name, column_name
    from user_ind_columns
    where table_name in ('EMP_COPY90');
    
    select * from emp_copy90
    where ename = 'KING'; -- ename컬럼에 index가 없음, King을 검색하기 위해서 <테이블 스캔>
    
    -- ename 컬럼에 index 생성하기 (야간에 작업해야 한다. 부하가 많이 걸리기 때문에)
    create index id_emp_ename --id_emp_ename  인덱스 이름
    on emp_copy90(ename);
    
        -- 컬럼에 index가 생성되어 있지 않으면 테이블 스캔을 한다.(처음부터 하나하나 검색한다.)
        -- 컬럼에 index가 생성되어 있으면 Index Page(책의 목차)를 검색한다. 
    
    select * from emp_copy90
    where job = 'SALESMAN';
    
    drop index id_emp_ename;
    
/*
    index는 주기적으로 REBUILD 해 줘야 한다. 
        -> Index Page는 조각나게 되어 있기 때문(Insert, Update, Delete)가 빈번하게 일어나면 
*/

-- Index Rebuild를 해야하는 정보 찾기 : Index의 Tree깊이가 4이상인 경우 조회가 되면 Rebuild 할 필요가 있다. 
    SELECT I.TABLESPACE_NAME,I.TABLE_NAME,I.INDEX_NAME, I.BLEVEL,
           DECODE(SIGN(NVL(I.BLEVEL,99)-3),1,DECODE(NVL(I.BLEVEL,99),99,'?','Rebuild'),'Check') CNF
    FROM   USER_INDEXES I
    WHERE   I.BLEVEL > 4
    ORDER BY I.BLEVEL DESC;

-- Index Rebuild :
    Alter Index id_emp_ename REBUILD;
    
    select * from emp_copy90;
    
/*
    Index를 사용해야 하는 경우
        1. 테이블의 행(로우 ,레코드)의 개수가 많은 경우
        2. where 절에서 자주 사용하는 경우 
        3. join시 사용되는 키 컬럼
        4. 검색 결과가 원본 테이블 데이터의 2~4%정도 되는 경우 
        5. 해당 컬럼이 null이 포함되는 경우 (색인은 null은 제외)
        
    Index를 사용하면 안좋은 경우
        1. 테이블의 행의 개수가 적은 경우
        2. 검색 결과가 원본테이블의 많은 비중을 차지하는 경우 
        3. Insert, Update, Delete 가 빈번하게 일어나는 컬럼
*/

/*
    index 종류 
        1. 고유 인덱스(Unique Index) : 컬럼의 중복되지 않는 고유한 값을 갖는 index (Primary Key, Unique)
        2. 단일 인덱스 (Single Index) : 한 컬럼에 부여되는 index
        3. 결합 인덱스 (Composite Index) : 여러 컬럼을 묶어서 생성한 index
        4. 함수 인덱스 (Function Base Index) : 함수를 적용한 컬럼에 생성한 Index
*/
    -- 단일 인덱스 생성
    select * from emp_copy90;
    create index idx_emp_copy90_salary
    on emp_copy90(salary);
    
    -- 결함 인덱스 생성 : 두컬럼 이상을 결합해서 인덱스 생성
    create table dept_copy91
    as 
    select * from department;
    
    create index idx_dept_copy90_dname_loc
    on dept_copy91 (dname, loc);
    
     select index_name , table_name, column_name
    from user_ind_columns
    where table_name in ('DEPT_COPY91');
    
    -- 함수 기반 인덱스 : 함수를 적용한 컬럼에 부여되는 인덱스 
    Create table emp_copy91
    as 
    select * from employee;
    
    create index idx_emp_copy91_allsal
    on emp_copy91 (salary * 12);        -- 컬럼에 함수, 계산식을 적용한 인덱스 / salary * 12 -> 자주 써서 index설정
    
    -- 인덱스 삭제
    drop index IDX_DEPT_COPY90_DNAME_LOC;
    
    select index_name , table_name, column_name
    from user_ind_columns
    where table_name in ('DEPT_COPY91'); -- 어떤 인덱스 있는지 확인
    
    select index_name , table_name, column_name
    from user_ind_columns
    where table_name in ('EMP_COPY91');
    
     