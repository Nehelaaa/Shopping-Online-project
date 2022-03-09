/*1
select distinct b.author 
from books b, customers c, orders o 
where (c.cid = o.cid and zipcode = '02125') 
        and(b.bid = o.bid and (o.quantity >= 50) ); 



select c.cname
from customers c, books b, orders o
where c.cid = o.cid and (b.bid = o.bid and (b.price < 100)) and c.cid not in 
(select c1.cid 
        FROM orders o1, books b1, customers c1
        where b1.price >=100 and b1.bid =o1.bid and c1.cid = o1.cid);
        */

select distinct b.author 
from books b, customers c, orders o 
where c.cid = o.cid and b.bid = o.bid and o.quantity >= 50 and zipcode = '02125'; 

select c.cname
from customers c
where not exists(
        select *  
        from books b, orders o1
        where c.cid = o1.cid 
                and b.bid = o1.bid and b.price >= 100
);

/* part 3 */
select c.cid, avg(b.price)
from books b, customers c, orders o
where b.bid = o.bid and c.cid = o.cid and b.price >= 20
GROUP BY c.cid
HAVING COUNT(DISTINCT b.bid) >=20;


/* question1 part 4 

*/

select c.cname
from customers c
where not exists (select b.bid
                  from books b
                  where b.author = 'Edgar Codd' and
                                                not exists (select *
                                                from orders o
                                                where o.bid= b.bid and o.cid = c.cid)
);





/* question 1 part 5*/

select temp.author
from (select o.bid, sum(o.quantity) as best, b.author
      from orders o, books b
      where o.bid = b.bid
      group by o.bid, b.author)temp
where temp.best = (select max(best)
                from (select o.bid, sum(o.quantity) as best
                        from orders o, books b
                        where o.bid = b.bid
                        group by o.bid, b.author));

