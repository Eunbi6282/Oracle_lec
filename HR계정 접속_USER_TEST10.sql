
-- 객체 출력시 객체명 앞에 객체를 소유하고 있는 소유주명을 넣어줘야 함
select * from hr.employee;

    -- 자기 자신의 테이블일 때는 생략가능
    select * from employee;
    create table emp_copy10
    as 
    select * from employee;
    
    create table dept_copy10
    as
    select * from department;
    
    create table dept_copy11
    as
    select * from department;
    
    create table dept_copy12
    as
    select * from department;