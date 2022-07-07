select * from festival order by f_code;
-- f_code primary≈∞ √ﬂ∞°
alter table festival add constraint pk_f_code primary key (f_code);

delete festival where f_ny is null or  f_nx is null;
select count(*) from festival;

commit;

