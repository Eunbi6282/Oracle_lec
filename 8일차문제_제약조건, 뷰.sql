-- 8일차 문제 ( 제약조건, 뷰)

    -- 1. employee 테이블의 구조를 복사하여 emp_sample 란 이름의 테이블을 만드시오. 
        --사원 테이블의 사원번호 컬럼에 테이블 레벨로 primary key 제약조건을 지정하되 제약조건 이름은 my_emp_pk로 지정하시오. 
        create table emp_sample
        as 
        select * from employee;
        
        select * from emp_sample;
        
        alter table emp_sample
        add constraint PK_emo_pk Primary Key (eno) ;
        
        desc emp_sample;
        
        select * from user_constraints
        where table_name = 'EMP_SAMPLE';
        
-- 2. department 테이블의 구조를 복사하여 dept_sample 란 이름의 테이블을 만드시오. 
    -- 부서 테이블의 부서번호 컬럼에 레벨로 primary key 제약 조건을 지정하되 제약 조건이름은 my_dept_pk로 지정하시오. 
    
    create table dept_sample
    as
    select * from department;
    
    -- 테이블의 구조만 복사
    create table dept_sample
    as
    select * from department
    where 0 = 1;
    
    desc dept_sample;
    
    alter table dept_sample
    add constraint MY_DEPT_PK PRIMARY KEY (dno);
    
    select * from user_constraints
    where table_name = 'DEPT_SAMPLE';
    
    
-- 3. 사원 테이블의 부서번호 컬럼에 존재하지 않는 부서의 사원이 배정되지 않도록 외래키 제약조건을 지정하되 제약 조건이름은 my_emp_dept_fk 로 지정하시오.
    -- [주의 : 위 복사한 테이블을 사용하시오]
    
    alter table emp_sample
    add constraint MY_EMP_DEPT_FK Foreign Key (dno) REFERENCES dept_sample(dno);
    
    desc emp_sample;
    
    select * from user_constraints
    where table_name = 'EMP_SAMPLE';

-- 4. 사원테이블의 커밋션 컬럼에 0보다 큰 값만을 입력할 수 있도록 제약 조건을 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]
   select * from emp_sample;
   
   -- null 처리..?
   update emp_sample
   set commission = 0
   where commission is null;
   rollback;
   commit;
    
    alter table emp_sample
    add constraint CK_emp_sample_commission check  (commission >= 0); 

-- 5. 사원테이블의 웝급 컬럼에 기본 값으로 1000 을 입력할 수 있도록 제약 조건을 지정하시오. 
    -- [주의 : 위 복사한 테이블을 사용하시오]
    alter table emp_sample
    modify salary  default 1000;
    
    desc emp_sample;
    
    insert into emp_sample (eno, ename)
    values(999, 'eumvi');
    

-- 6. 사원테이블의 이름 컬럼에 중복되지 않도록  제약 조건을 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]
    -- 중복된 값이 있는지 확인
    select ename, count(*)
    from emp_sample
    group by ename
    having count(*) > 2;
    
    alter table emp_sample
    add constraint UK_emp_sample_ename Unique (ename);

-- 7. 사원테이블의 커밋션 컬럼에 null 을 입력할 수 없도록 제약 조건을 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]
    -- 기존에 null이 들어가 있는 컬럼은 not null을 지정할 수 없다. -> null값이 있는지 확인
    select commission from emp_sample
    where commission is null;
    
    update emp_sample
    set commission = 0
    where commission is null;
    commit;
    
    alter table emp_sample
    modify commission constraint NN_emp_sample_commission Not null ;

-- 8. 위의 생성된 모든 제약 조건을 제거 하시오. 

    -- 제약 조건을 제거시 : Foreign Ket 참조하면 제거가 안된다.
        -- 1. Foreign Key 를 먼저 제거 후 Primary Key제거
        -- 2. Primary Key 를 제거 할 떄 cascade 옵션을 사용 : Foreign Key먼저 제거 되고 Primary Key가 제거됨
    alter table emp_sample
    drop constraint PK_EMO_PK;
    
    alter table emp_sample
    drop constraint MY_EMP_DEPT_FK;
    
    alter table emp_sample
    drop constraint UK_EMP_SAMPLE_ENAME;
    
    alter table emp_sample
    drop constraint NN_EMP_SAMPLE_COMMISSION;
    
    alter table dept_sample
    drop constraint MY_DEPT_PK;
    


-- 뷰 문제 

-- 1. 20번 부서에 소속된 사원의 사원번호과 이름과 부서번호를 출력하는 select 문을 하나의 view 로 정의 하시오.
	-- 뷰의 이름 : v_em_dno  
        -- 뷰 : 가상의 테이블, select 문만 올 수 있다.
            -- 보안을 위해서 사용 , 실제 테이블의 
    
    create view v_em_dno
    as 
    select ename , dno
    from employee 
    where dno = 20;
    
    select * from v_em_dno;

-- 2. 이미 생성된 뷰( v_em_dno ) 에 대해서 급여 역시 출력 할 수 있도록 수정하시오. 
        -- 이미 있는 뷰를 생성하면 추가됨
   create or replace view v_em_dno
   as 
   select ename , dno, salary 
   from employee;

-- 3. 생성된  뷰를 제거 하시오. 

    drop view v_em_dno;

-- 4. 각 부서의 급여의  최소값, 최대값, 평균, 총합을 구하는 뷰를 생성 하시오. 
	-- 뷰이름 : v_sal_emp
        -- group by 하면 각 컬럼 별칭 반드시 정해주기
    
    create view v_sal_emp
    as
    select dno, min(salary) minS, max(salary) maxS, avg(salary) avgS, sum(salary) sumS
    from employee
    group by dno;
    
    create or replace view v_sal_emp
    as
    select dno, min(salary) minS, max(salary) maxS, round(avg(salary)) avgS, sum(salary) sumS
    from employee
    group by dno;
    
    select * from v_sal_emp;

-- 5. 이미 생성된 뷰( v_em_dno ) 에 대해서 <<읽기 전용 뷰>> 수정하시오. 
    create or replace view v_em_dno
    as 
    select *
    from employee
    with read only;
    
    update v_em_dno
    set dno = 20; -- read-only view