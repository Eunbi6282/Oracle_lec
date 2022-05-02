select * from hr.employee; --권한 없으므로 접근 불가

    -- 권한 부여 <USER_TEST10으로 접속_USERT_TEsql 파일>
        -- user_test10이 권한 with frnat option 으로 부여받음
        select * from hr.employee;
        
        select * from HR.dept_copy10;