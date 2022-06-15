SELECT cart_id, p.p_id, c.id, name, pname, amount, price, downprice,
CASE WHEN p.downprice <> 0 and p.price >= p.downprice THEN p.downprice
       ELSE p.price END AS cart_price
, (cart_price*amount) as money 
FROM member m, cart c, product p 
WHERE m.id=c.id and c.p_id=p.p_id and c.id='rkskek' 
order by cart_id;

select * from member;
SELECT * FROM product where category = 'BOTTOM';
select cart_price from cart;

select 
    if(
    p.price<>0 and p.price >= p.downprice,  p.price
    )
from cart c, product p
where c.p_id=p.p_id;

CASE WHEN p.downprice <> 0 and p.price >= p.downprice THEN p.price
       ELSE p.price END AS c.cart_price
       
select p_id, pname, category, sname, price, downprice, description, pImg
from product p
where p_id = 'T6';

commit;
select * from cart;
select * from member;
select * from product;