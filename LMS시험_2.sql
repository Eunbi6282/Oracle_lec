-- 1. EQUI 조인을 사용하여 SCOTT 사원의 사원번호, 사원이름, 직책, 부서번호,  부서이름을 출력 하시오
    select eno 사원번호, ename 사원이름, job 직책, e.dno 부서번호, dname 부서이름
    from employee e , department d
    where e.dno = d.dno
    and ename = 'SCOTT';
    
-- 2. ANSI 호환인 INNER 조인을 사용하여 SCOTT 사원의 사원번호, 사원이름, 직책, 부서번호,  부서이름을 출력 하시오 .
    select eno 사원번호, ename 사원이름, job 직책, e.dno 부서번호, dname 부서이름
    from employee e join department d
    on e.dno = d.dno
    where ename = 'SCOTT';
    
-- 3. employee 테이블을 복사해서 emp_copy 테이블을 생성 하시오, department 테이블을 복사해서 dept_copy 테이블을 생성하시오.
    create table emp_copy
    as
    select * from employee;
    
    drop table emp_copy;
    drop table dept_copy;
    
    create table dept_copy
    as select * from department;
    
    select * from emp_copy;
    
    -- 4. Alter Table 을 사용해서 3번 문항의 emp_copy, dept_copy 테이블의 제약 조건을 추가 하시오.

    -- emp_copy 테이블의 eno 컬럼에 Primary Key 제약 조건을 추가하시오. ( 제약조건이름: emp_copy_eno_pk )
        -- dept_copy 테이블의 dno 컬럼에 Primary Key 제약조건을 추가하시오 ( 제약조건이름: dept_copy_don_pk )
    -- emp_copy 테이블의 dno 컬럼에 Foreign Key 제약 조건을 추가 하시오 ( 제약조건이름: emp_copy_dno_fk )
    
    alter table emp_copy
    add constraint emp_copy_eno_pk Primary key (eno);
    
    alter table dept_copy
    add CONSTRAINT dept_copy_dno_pk Primary Key (dno);
    
    alter table emp_copy
    add constraint emp_copy_dno_fk Foreign Key (dno) REFERENCES dept_copy (dno);
    
    select * from user_constraints
    where table_name in ('EMP_COPY', 'DEPT_COPY');
    
    -- 5. employee 테이블에서 직책이 ’SALESMAN’ 인 사원의 사원번호, 사원이름, 부서번호, 직책 을 출력하는 뷰를 생성하시오 (뷰이름 : v_emp_job) ??생성한 뷰를 출력하는 구문을 작성하시오.
    
    create view v_emp_job
    as 
    select eno 사원번호, ename 사원이름, dno 부서번호, job 직책
    from employee
    where job = 'SALESMAN';
    
    drop view v_emp_job;
    
    -- 6. v_auto_join 뷰 이름으로  1번 문항의 JOIN 구문을 생성하는 뷰를 만드시오. 뷰를 출력하는 구문을 작성하시오.
    create view v_auto_join 
    as
    select eno 사원번호, ename 사원이름, job 직책, e.dno 부서번호, dname 부서이름
    from employee e , department d
    where e.dno = d.dno
    and ename = 'SCOTT'; 
    
    select * from v_auto_join;
    
    -- 7.  employee 테이블의 ename 컬럼은 검색에 자주 사용하는 컬럼입니다. 이컬럼에 index 를 생성하시오. ?
        --( 인덱스 이름 : idx_employee_ename )
        
    create index idx_employee_ename
    on employee (ename);
    
    -- 인덱스 확인
    select index_name , table_name, column_name
    from user_ind_columns
    where table_name in ('EMPLOYEE');
    
    -- 8. NVL2 함수를 사용하여 각 사원의 연봉을 출력하는 쿼리를 작성하시오. 출력 컬럼은 [사원이름], [연봉] 으로 별칭 이름을 사용하여 출력 하시오.
    
    select ename 사원이름, nvl2(salary * 12,salary * 12, 0) 연봉
    from employee;
    
    select * from employee;
    
    -- 9. 초기값 1 증가값 1씩 증가하는 시퀀스를 생성하시오. 단 cache는 생성하지 않도록 설정하시오.
        -- department 테이블의 구조만 복사하여 dept_copy 테이블을 생성하여 dno 컬럼에 생성된 시퀀스를 적용 하시오.
        
    drop table dept_copy cascade constraints;
    
    create table dept_copy
    as 
    select * from department
    where 0 = 1;
    
    select * from dept_copy;
    -- 시퀀스 생성
    create sequence dept_seq
    increment by 1
    start with 1
    nocache;
    
    -- 테이블에 시퀀스 할당
    insert into dept_copy
    values (dept_seq.nextval, '박은비' , 'SEOUL');
    
    insert into dept_copy
    values (dept_seq.nextval, '정재현' , 'SEOUL');
    
    -- 10. self 조인을 사용해서 Employee 테이블의  직급상사번호에 해당 하는 직급 상사명을 출력하시오. 
        --출력 컬럼은 [사원번호], [사원이름], [직급상사번호],[직급상사명] 으로 별칭이름으로 출력하시오.
    select e.eno 사원번호, e.ename 사원이름, e.manager 직급상사번호, m.ename 직급상사명
    from employee e, employee m
    where e.manager = m.eno;
    
    select * from employee;
    
    