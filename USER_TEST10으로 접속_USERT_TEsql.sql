
create table test10tbl (
    a number not null,
    b varchar2(50) null
    );
    
      -- user_test10���� HR�� �������� employee���̺��� ������ �� -> ��ü�� ���� ���� �ʿ�
      
      select * from employee;
      
      
        -- ��ü ��½� ��ü�� �տ� ��ü�� �����ϰ� �ִ� �����ָ��� �־���� ��
        select * from hr.employee; -- ���� �ο� �ʿ� , SYS �������� ���� �ο�<SYS_9����_���Ѱ���>
        
        --�⺻������ �ڽ��� ��ü�� ����� ���� ��������
        
        show user;
        select * from test10tbl;
    
        -- �ٸ� ������� ��ü�� ������ ���� �����ָ�, ��ü��
        select * from employee; -- table or view does not exist
        select * from hr.employee; -- �ٸ� ������� ��ü�� ������ ���� ������ �־�� ��
        
        -- �ٸ� ����� ���̺��� insert����
        select * from HR.emp_copy10;
        desc hr.emp_copy10;
        insert into hr.emp_copy10 (eno)
        values (3333);
        
        -- with grant option�� ���ؼ� ������ �ο� �޾��� <SYS_9����_���Ѱ���>
            -- usert_test10 ������ hr.employee ���̺� ���ؼ� �ٸ� ����ڿ��� select ������ �ο��� �� �ְ� �ȴ�. 
        grant select on HR.employee to user_test11;
        
        ------------------------------------------------------------
        select * from dept_copy10; -- ���� �ο� ������ select �Ұ�
        select * from hr.dept_copy10; -- ���� �ο� ������ select �Ұ�
        
        --���� �ο� ��
        select * from hr.dept_copy10;
        
         -- with grant option�� ���ؼ� ������ �ο� �޾��� <SYS_9����_���Ѱ���>
            -- usert_test10 ������ hr.employee ���̺� ���ؼ� �ٸ� ����ڿ��� select ������ �ο��� �� �ְ� �ȴ�. 
        grant select on HR.dept_copy10 to user_test11;
        
        ------------------------------------------------------------------
        select * from hr.dept_copy11;   -- ���� �ο� ������ select �Ұ�
        
        -- ���Ѻο� ��
        select * from hr.dept_copy11;
        
        ---------------------------------------------------------------------
        select * from HR.dept_copy12;
        
        select * from role_sys_privs
        where role like 'ROLETEST3';