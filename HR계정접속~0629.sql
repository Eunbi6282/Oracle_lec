-- 1. 부모테이블 : spring_department TABLE 생성 및 INSERT

CREATE TABLE spring_department(
	deptno  NUMBER        PRIMARY KEY,
	dname   VARCHAR2(100) NOT NULL,
	loc     VARCHAR2(100) NOT NULL
)
select * from spring_department;
select * from spring_employment;
INSERT INTO spring_department VALUES(10, '전략기획', '판교');
INSERT INTO spring_department VALUES(20, '해양수산', '부산');
INSERT INTO spring_department VALUES(30, '공공사업', '판교');

--2. 자식테이블 : spring_employmentTABLE 생성 및 INSERT

CREATE TABLE spring_employment(
    empno   number        PRIMARY KEY,
    ename   VARCHAR2(100) NOT NULL,
    sal     NUMBER        NOT NULL,
    deptno  NUMBER        NOT NULL,
    CONSTRAINT fk_spring_deptno FOREIGN KEY(deptno) REFERENCES spring_department(deptno)
)
INSERT INTO spring_employment VALUES(1, '제임슨', 300, 40);
INSERT INTO spring_employment VALUES(1,'제임슨',300,10);
INSERT INTO spring_employment VALUES(2,'앨리사',500,10);
INSERT INTO spring_employment VALUES(3,'크림슨',400,20);

commit;


select * from spring_department;

-- 조인 쿼리 
SELECT E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME, D.LOC
FROM SPRING_EMPLOYMENT E, SPRING_DEPARTMENT D
WHERE E.DEPTNO = D.DEPTNO
