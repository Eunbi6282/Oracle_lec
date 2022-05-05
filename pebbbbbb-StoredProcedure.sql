���� ���ν��� ���� 

1. �� �μ����� �ּұ޿�, �ִ�޿�, ��ձ޿��� ����ϴ� �������ν����� �����Ͻÿ�. 
	[employee, department ] ���̺� �̿�
    
        set serveroutput on
        create or replace procedure sp1
        is  -- ���� ����
            v_dno employee.dno%type;
            v_min employee.salary%type;
            v_max employee.salary%type;
            v_avg employee.salary%type;
            
            -- ���ڵ� ���� ������ Ŀ�� ����
            cursor c1
            is 
            select dno, min(salary), max(salary) ,round(avg(salary))
            from employee
            group by dno;
            
        begin
            dbms_output.put_line('�μ���ȣ      �ּұ޿�        �ִ�޿�        ���');
            dbms_output.put_line('----------------------------------------------');
            
            open c1;
            
            loop 
                fetch c1 into v_dno,v_min,v_max,v_avg; 
                exit when c1%notfound;
                dbms_output.put_line (v_dno || '�μ��� �ּ� �޿��� : ' || v_min || '�̰� �ִ� �޿��� ' || 
                v_max || ' �̰� ��� �޿��� ' || v_avg || '�Դϴ�.'
                );
            end loop;
            
            close c1;
        end;
        /

2.  �����ȣ, ����̸�, �μ���, �μ���ġ�� ����ϴ� �������ν����� �����Ͻÿ�.  
	[employee, department ] ���̺� �̿�
    create or replace procedure sp2
    is
        v_eno employee.eno%type;
        v_ename employee.ename%type;
        v_dname department.dname%type;
        v_loc department.loc%type;
        
        cursor c1
        is 
        -- select �� ��� ���ڵ� ���� cursor ����
        select eno, ename, dname, loc
        from employee e, department d
        where e.dno = d.dno
    begin
        open c1;
        
        loop
            fetch c1 into v_eno,v_ename, v_dname,  v_loc ;
            exit when c1%notfound;
            dbms_output.put_line ( v_eno || ' ' ||v_ename || ' ' || v_dname|| ' ' || v_loc
        );
        end loop;
        
        close c1;
    end;
    /


3. �޿��� �Է� �޾�  �Է¹��� �޿����� ���� ����� ����̸�, �޿�, ��å�� ��� �ϼ���.
	�������ν����� : sp_salary_b

4. ��ǲ �Ű����� : emp_c10, dept_c10  �ΰ��� �Է� �޾� ���� employee, department ���̺��� �����ϴ� �������ν����� �����ϼ���. 
	�������ν����� : sp_copy_table
	



5. dept_c10 ���̺��� dno, dname, loc �÷��� ���� ��ǲ �޾� ��ǲ ���� ���� insert�ϴ� �������ν����� �����Ͻÿ�. 
	�Է� �� : 50  'HR'  'SEOUL'
	�Է� �� : 60  'HR2'  'PUSAN' 

6. emp_c10 ���̺��� ��� �÷��� ���� ��ǲ �޾� ��ǲ ���� ���� insert�ϴ� �������ν����� �����Ͻÿ�. 
	�Է� �� : 8000  'SONG'    'PROGRAMMER'  7788  sysdate  4500  1000  50 

7. dept_c10 ���̺��� 4�������� �μ���ȣ 50�� HR �� 'PROGRAM' ���� �����ϴ� �������ν����� �����ϼ���. 
	<�μ���ȣ�� �μ����� ��ǲ�޾� �����ϵ��� �Ͻÿ�.> 
	�Է°� : 50  PROGRAMMER 

8. emp_c10 ���̺��� �����ȣ�� ��ǲ �޾� ������ �����ϴ� ���� ���ν����� �����Ͻÿ�. 
	�Է� �� : 8000  6000

9. ���� �� ���̺���� ��ǲ �޾� �� ���̺��� �����ϴ� �������ν����� ���� �Ͻÿ�. 

10. �̸��� ��ǲ �޾Ƽ� �����, �޿�, �μ���ȣ, �μ���, �μ���ġ�� OUT �Ķ���Ϳ� �Ѱ��ִ� ���ν����� PL / SQL���� ȣ��

11. �μ���ȣ�� �޾Ƽ� �����, �޿�, ��å�� OUT �Ķ���Ϳ� �Ѱ��ִ� ���ν����� PL / SQL���� ȣ��
