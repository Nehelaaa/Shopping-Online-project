--Q2.a

select p.age, p.pname
from passengers p, tickets t, flights f
where p.pid = t.pid and f.fid = t.fid and f.aircraft = 'b787' and p.pid NOT IN 
                    (select t1.pid from tickets t1, flights f1
                    where f1.aircraft <> 'b787' and f1.fid = t1.fid);



--Q2.b


/*
--select p.pname
--from passengers p
--where not exists (select f.fid
  --                from flights f
  --              where not exists(select * from tickets t
    --              where t.pid= p.pid and t.fid= f.fid));*/
/*was trying ti the way done in slide not workimg properly
so use the group by use the example from the aggregate skide where nesting happned in the from.
*/
-- I was first tryong to do with the not exist exactly like the slide but the it wasnot working
-- so I used the group by and temp table to search for the  distict flights count.


select temp.name
from (select p.pname as name, count(distinct f.aircraft) as allaircraft
      from passengers
       p, tickets t, flights f 
      where p.pid= t.pid and f.fid= t.fid
      group by p.pname)temp
where temp.allaircraft = (select count(distinct f1.aircraft) from flights f1);



--Q2.c
/*part 3*/
-- very similar to the slides of exaample 3 in nestqueries.
-- I tried to do two difernt way fierst one was very similar wjat i did in Q1.c 
-- second one is just like the one we have on the slides. 
--solution 1.
select f.fid, avg(t.price)
from passengers p, flights f, tickets t
where p.pid = t.pid and f.fid=t.fid and p.age>30
group by f.fid
having count(p.pid) >=100;

--solution 2.
select f.fid, avg(t.price)
from passengers p, flights f, tickets t
where p.pid = t.pid and f.fid=t.fid and p.age>30
group by f.fid
having 100<=(select count(*)
             from tickets t1
             where f.fid = t1.fid);


--Q2.d
select sum(t.price)
from tickets t, flights f,  (select max(f1.miles)as maxmiles from flights f1)temp
where t.fid = f.fid and f.miles = temp.maxmiles;



-- Q2.e
/*

--select  f.ffrom, count(p.pid), sum(t.price), avg(f.miles)
--from flights f, tickets t, passengers p
--where f.fid = t.fid and p.pid = t.pid
--group by f.ffrom;
*/

-- doing one more group this example is very similar to the 
--aggregate query last question.

select f.ffrom, count(p.pid), sum(t.price), temp.avgmiles
from (select avg(f1.miles) as avgmiles, f1.ffrom as departairport
      from flights f1
      group by f1.ffrom)temp, tickets t, flights f, passengers p
where t.pid = p.pid and t.fid = f.fid and f.ffrom = temp.departairport
group by f.ffrom, temp.avgmiles;






