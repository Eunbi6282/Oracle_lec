
-- 기존 제약조건 
ALTER TABLE MP_BOARD
DROP CONSTRAINT SYS_C007279;

-- 제약조건추가(삭제 시 제약조건 연관된 모든 것 삭제)
ALTER TABLE mp_board
ADD CONSTRAINT fk_board_userid foreign KEY(userid) references users (userid) on delete cascade;

select * from users;
select * from mp_board order by bno desc;
delete from users where userid = 'eun6282';

commit;

