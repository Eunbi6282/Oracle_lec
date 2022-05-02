
create table test10tbl (
    a number not null,
    b varchar2(50) null
    );
    
      -- user_test10에서 HR이 소유주인 employee테이블을 접근할 때 -> 객체의 접근 권한 필요
      
      select * from employee;
      
      
        -- 객체 출력시 객체명 앞에 객체를 소유하고 있는 소유주명을 넣어줘야 함
        select * from hr.employee; -- 권한 부여 필요 , SYS 계정에서 권한 부여<SYS_9일차_권한관리>
        
        --기본적으로 자신의 객체를 출력할 때는 생략가능
        
        show user;
        select * from test10tbl;
    
        -- 다른 사용자의 객체를 접근할 때는 소유주명, 객체명
        select * from employee; -- table or view does not exist
        select * from hr.employee; -- 다른 사용자의 객체를 접근할 때는 권한이 있어야 함
        
        -- 다른 사용자 테이블에서 insert권한
        select * from HR.emp_copy10;
        desc hr.emp_copy10;
        insert into hr.emp_copy10 (eno)
        values (3333);
        
        -- with grant option을 통해서 권한을 부여 받았음 <SYS_9일차_권한관리>
            -- usert_test10 계정은 hr.employee 테이블에 대해서 다른 사용자에게 select 권한을 부여할 수 있게 된다. 
        grant select on HR.employee to user_test11;
        
        ------------------------------------------------------------
        select * from dept_copy10; -- 권한 부여 전까지 select 불가
        select * from hr.dept_copy10; -- 권한 부여 전까지 select 불가
        
        --권한 부여 후
        select * from hr.dept_copy10;
        
         -- with grant option을 통해서 권한을 부여 받았음 <SYS_9일차_권한관리>
            -- usert_test10 계정은 hr.employee 테이블에 대해서 다른 사용자에게 select 권한을 부여할 수 있게 된다. 
        grant select on HR.dept_copy10 to user_test11;
        
        ------------------------------------------------------------------
        select * from hr.dept_copy11;   -- 권한 부여 전까지 select 불가
        
        -- 권한부여 후
        select * from hr.dept_copy11;
        
        ---------------------------------------------------------------------
        select * from HR.dept_copy12;
        
        select * from role_sys_privs
        where role like 'ROLETEST3';