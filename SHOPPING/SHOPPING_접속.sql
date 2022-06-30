select * from member;

select * from board;

select * from cart;

SELECT id, email, name, address, tel FROM member where id = 'admin';

select m.id, p.p_id, c.cart_id
from member m, product p, cart c
where m.id = c.id and p.p_id = c.p_id and c.cart_id = '1';