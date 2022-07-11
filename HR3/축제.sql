drop table festival;

select * from festival order by f_code, f_startdate;
-- f_code primary키 추가
alter table festival add constraint pk_f_code primary key (f_code);

delete festival where f_ny is null or  f_nx is null;
select count(*) from festival;

commit;

SELECT F_CODE, F_NAME, F_PLACE, F_STARTDATE, F_ENDDATE, F_TEL, F_ADMIN, F_NY, F_NX FROM ( SELECT 
F_CODE, F_NAME, F_PLACE, F_STARTDATE, F_ENDDATE, F_TEL, F_ADMIN, F_NY, F_NX, ROW_NUMBER() OVER(ORDER 
BY F_CODE) AS RNUM FROM FESTIVAL WHERE 1 = 1 
) FE 
WHERE RNUM BETWEEN 1 AND 10 
AND F_ADMIN = '경기도'
ORDER BY F_CODE ;

select * from festival where  '2022-05-01' < F_STARTDATE ORDER BY F_STARTDATE ;

