--  9���� ������, �ε���
/*
    ������ : �ڵ� ��ȣ �߻���, Ư�� �÷� �ѹ��� �� ��
        -- ��ȣ�� �߻��� �Ǹ� �ڷ� �ǵ��� �� ����. (���� �� �ٽ� ������ ��)
        -- Primary Key �÷��� ��ȣ�� �ڵ����� �߻���Ű�� ���ؼ� ���
        -- Primary Key �÷��� ������ ���� �Ű� �Ƚᵵ �ȴ�. 
*/

Create sequence sample_seq
    increment by 10 -- ������
    start with 10;  -- �ʱⰪ
    
-- �������� ������ ����ϴ� ������ ����
    select * from user_sequences;
    
    select sample_seq.nextval from dual; -- �������� �������� ���
    select sample_seq.currval from dual; -- ���� �������� ��

-- �ʱⰪ : 2, ������ : 2
    create sequence sample_seq2
        INCREMENT by 2
        start with 2
        nocache;    -- ĳ���� ������� �ʰڴ�. (RAM) --������ ���ϸ� �ٿ��� �� �ִ�.
    
    select sample_seq2.nextval from dual; -- �������� �������� ���
    select sample_seq2.currval from dual; -- ���� �������� ��

-- �������� Primary Key�� �����ϱ�
    Create table dept_copy80
    as 
    select * 
    from department
    where 0 = 1;
    
    select * from dept_copy80;
    
    -- ������ ���� : �ʱⰪ 10, ������ 10
    create sequence dept_sep
        INCREMENT by 10
        start with 10
        NOCACHE;
        
        /* sequence�� cache�� ����ϴ� ��� 
            - cache : ������ ������ ����ϱ� ���ؼ� ���(�⺻�� : 20��)
            - ������ �ٿ�� ��� : ĳ���� �ѹ����� ��� ����. ���ο� ���� �Ҵ� �޴´�. 
            
            cache�� ������� �ʴ� ���
            
        */
        
        
    insert into dept_copy80(dno, dname, loc)
    values(DEPT_SEP.nextval, 'HR', 'SEOUL');
    commit;
    select * from dept_copy80;
    
    -- ������ ����
    create sequence emp_seq_no
        increment by 1
        start with 1
        NOCACHE;
        
    create table emp_copy80
    as
    select * from employee
    where 0 = 1; -- false (���̺� ������ ��������)
    
    select * from emp_copy80;
    
    -- �������� ���̺� �Ҵ�
    insert into emp_copy80
    values (emp_seq_no.nextval, 'eunbi','Student',2222,sysdate,2800,0,10);
     
     -- ������ ������ ����
    select * from user_sequences; -- ������� ��� ������ Ȯ�� ����
     
    alter SEQUENCE emp_seq_no
        maxvalue 1000 ;  -- �ִ밪�� 1000����
        
    alter sequence emp_seq_no
        cycle;   -- �ִ밪�� ����ǰ� �ٽ� ó������ ��ȯ  / nocycle :  cycle���� ��� 
        
    drop sequence emp_seq_no;
    
/* �ε��� : ���̺��� �÷��� ����, Ư�� �÷��� �˻��� ������ ����� �� �ֵ���
        - ����(index) : å�� ���ΰ� ����. ex) å ���� ������ �߿� Ű���带 �����ؼ� ��ġ�� �˷���
        - Index Page : �÷��� �߿� Ű���带 �ɷ��� ��ġ ������ ��� ���� ������ 
            - DB ������ 10% ������ ����
            - Primary, Unique Key �� ����� �÷��� �ڵ����� index �������� ������� �ִ�. 
            - where������ ���� �˻��� �ϴ� �÷��� index�� ����
            - ���̺��� �˻��� �����ϴ� �÷��� Index����, ���̺� ��ĵ�� �ƴ� index page�� �����Ǿ� �˻��� ������ �Ѵ�.
            - Index�� ���� �� �� ���ϰ� ���� �ɸ���. �ַ� ���� �ð��� ���ؼ� �߰��� ������. 
            - �� �����ؾ� ��!! 
            
            
        - ���̺� ��ĵ : ���ڵ��� ó�� ~ ������ ���� �˻� (�˻��ӵ��� ������.), �ε����� ������� �ʰ� �˻�.
            - Index�� �����Ǿ� ���� �ʴ� �÷��� ���̺� ��ĵ�� �Ѵ�. 
        -
*/

    -- �ε��� ������ ����Ǿ� �ִ� ������ ���� ���
    --user_tab_columns, user_ind_columns
    select * from user_tab_columns;
    select * from user_ind_columns;
    
     select * from user_tab_columns
     where table_name in ('EMPLOYEE', 'DEPARTMENT');
    
    select index_name , table_name, column_name
    from user_ind_columns
    where table_name in ('EMPLOYEE', 'DEPARTMENT' );
    
    select * from employee; -- eno�÷��� Primary Key�� �� �ִ�..�ڵ����� �ε����� �������

/*
    index �ڵ� ���� (Primary Ky, Uuique )�÷����� index page�� �ڵ����� �����ȴ�.
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
    where ename = 'KING'; -- ename�÷��� index�� ����, King�� �˻��ϱ� ���ؼ� <���̺� ��ĵ>
    
    -- ename �÷��� index �����ϱ� (�߰��� �۾��ؾ� �Ѵ�. ���ϰ� ���� �ɸ��� ������)
    create index id_emp_ename --id_emp_ename  �ε��� �̸�
    on emp_copy90(ename);
    
        -- �÷��� index�� �����Ǿ� ���� ������ ���̺� ��ĵ�� �Ѵ�.(ó������ �ϳ��ϳ� �˻��Ѵ�.)
        -- �÷��� index�� �����Ǿ� ������ Index Page(å�� ����)�� �˻��Ѵ�. 
    
    select * from emp_copy90
    where job = 'SALESMAN';
    
    drop index id_emp_ename;
    
/*
    index�� �ֱ������� REBUILD �� ��� �Ѵ�. 
        -> Index Page�� �������� �Ǿ� �ֱ� ����(Insert, Update, Delete)�� ����ϰ� �Ͼ�� 
*/

-- Index Rebuild�� �ؾ��ϴ� ���� ã�� : Index�� Tree���̰� 4�̻��� ��� ��ȸ�� �Ǹ� Rebuild �� �ʿ䰡 �ִ�. 
    SELECT I.TABLESPACE_NAME,I.TABLE_NAME,I.INDEX_NAME, I.BLEVEL,
           DECODE(SIGN(NVL(I.BLEVEL,99)-3),1,DECODE(NVL(I.BLEVEL,99),99,'?','Rebuild'),'Check') CNF
    FROM   USER_INDEXES I
    WHERE   I.BLEVEL > 4
    ORDER BY I.BLEVEL DESC;

-- Index Rebuild :
    Alter Index id_emp_ename REBUILD;
    
    select * from emp_copy90;
    
/*
    Index�� ����ؾ� �ϴ� ���
        1. ���̺��� ��(�ο� ,���ڵ�)�� ������ ���� ���
        2. where ������ ���� ����ϴ� ��� 
        3. join�� ���Ǵ� Ű �÷�
        4. �˻� ����� ���� ���̺� �������� 2~4%���� �Ǵ� ��� 
        5. �ش� �÷��� null�� ���ԵǴ� ��� (������ null�� ����)
        
    Index�� ����ϸ� ������ ���
        1. ���̺��� ���� ������ ���� ���
        2. �˻� ����� �������̺��� ���� ������ �����ϴ� ��� 
        3. Insert, Update, Delete �� ����ϰ� �Ͼ�� �÷�
*/

/*
    index ���� 
        1. ���� �ε���(Unique Index) : �÷��� �ߺ����� �ʴ� ������ ���� ���� index (Primary Key, Unique)
        2. ���� �ε��� (Single Index) : �� �÷��� �ο��Ǵ� index
        3. ���� �ε��� (Composite Index) : ���� �÷��� ��� ������ index
        4. �Լ� �ε��� (Function Base Index) : �Լ��� ������ �÷��� ������ Index
*/
    -- ���� �ε��� ����
    select * from emp_copy90;
    create index idx_emp_copy90_salary
    on emp_copy90(salary);
    
    -- ���� �ε��� ���� : ���÷� �̻��� �����ؼ� �ε��� ����
    create table dept_copy91
    as 
    select * from department;
    
    create index idx_dept_copy90_dname_loc
    on dept_copy91 (dname, loc);
    
     select index_name , table_name, column_name
    from user_ind_columns
    where table_name in ('DEPT_COPY91');
    
    -- �Լ� ��� �ε��� : �Լ��� ������ �÷��� �ο��Ǵ� �ε��� 
    Create table emp_copy91
    as 
    select * from employee;
    
    create index idx_emp_copy91_allsal
    on emp_copy91 (salary * 12);        -- �÷��� �Լ�, ������ ������ �ε��� / salary * 12 -> ���� �Ἥ index����
    
    -- �ε��� ����
    drop index IDX_DEPT_COPY90_DNAME_LOC;
    
    select index_name , table_name, column_name
    from user_ind_columns
    where table_name in ('DEPT_COPY91'); -- � �ε��� �ִ��� Ȯ��
    
    select index_name , table_name, column_name
    from user_ind_columns
    where table_name in ('EMP_COPY91');
    
     