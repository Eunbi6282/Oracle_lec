
-- ���� �������� 
ALTER TABLE MP_BOARD
DROP CONSTRAINT SYS_C007279;

-- ���������߰�(���� �� �������� ������ ��� �� ����)
ALTER TABLE mp_board
ADD CONSTRAINT fk_board_userid foreign KEY(userid) references users (userid) on delete cascade;

select * from users;
select * from mp_board order by bno desc;
delete from users where userid = 'eun6282';

commit;

