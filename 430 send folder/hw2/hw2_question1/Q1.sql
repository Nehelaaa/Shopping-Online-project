--Q1.part a
select distinct b.author 
from books b, customers c, orders o 
where c.cid = o.cid and b.bid = o.bid and o.quantity >= 50 and zipcode = '02125'; 

--Q1.part b

-- it wasnt workinhg the first way so i tried to do with an alternative way 
-- with not exixt as mentioned in slides.

--select c.cname
--from customers c, books b, orders o
--where c.cid = o.cid and (b.bid = o.bid and (b.price < 100)) and c.cid not in 
--(select c1.cid 
  --      FROM orders o1, books b1, customers c1
    --    where b1.price >=100 and b1.bid =o1.bid and c1.cid = o1.cid);
        

select c.cname
from customers c
where not exists(
        select *  
        from books b, orders o1
        where c.cid = o1.cid 
                and b.bid = o1.bid and b.price >= 100);


-- Q1. part c

--very similar ti the question 3 in the nested queries example.
-- i was trying to do thiby slides but the query wasnt working
--I left that solution as well in the solution to look at it


select c.cid, avg(b.price)
from books b, customers c, orders o
where b.bid = o.bid and c.cid = o.cid and b.price >= 20
GROUP BY c.cid
HAVING COUNT(DISTINCT b.bid) >=20;


--this solution not working right so i commnet that one out
--if you find anything good in it please consider it for extra credit.
--second solution
--select c.cid, c.cname, avg(b.price)
--from books b, customers c, orders o
--where b.bid = o.bid and c.cid = o.cid and b.price >= 20
--GROUP BY c.cid, c.cname
--HAVING 20<= (select count(*)
  --            from orders o1
    --          where o1.cid=c.cid);
        




 --Q1 part d

--I was trying to do with the excep but wasnt working .
-- so I used the alternate way to that from the slides.

select c.cname
from customers c
where not exists (select b.bid
                  from books b
                  where b.author = 'Edgar Codd' and
                                                not exists (select *
                                                from orders o
                                                where o.bid= b.bid and o.cid = c.cid)
);





--question 1 part e
-- this question is very similar to the last question in the aggretae slides
-- I try to used the temp in side where but wasbt working 
-- then I remenber that the query I wrote beofre right but the SQL want me to 
-- repeat the code in the where as mentioned by the instructor.

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

