/*part 1*/

select p.age, p.pname
from passengers
 p, tickets t, flights f
where p.pid = t.pid and f.fid = t.fid and f.aircraft = 'b787' and p.pid NOT IN 
                    (select t1.pid from tickets t1, flights f1
                    where f1.aircraft <> 'b787' and f1.fid = t1.fid);




/* part 2 */

select p.pname
from passengers
 p
where not exists (select f.fid
                  from flights f
                  where not exists(select * from tickets t
                  where t.pid= p.pid and t.fid= f.fid));
/* right version */
select temp.name
from (select p.pname as name, count(distinct f.aircraft) as allaircraft
      from passengers
       p, tickets t, flights f 
      where p.pid= t.pid and f.fid= t.fid
      group by p.pname)temp
where temp.allaircraft = (select count(distinct f1.aircraft) from flights f1);




select f.fid, avg(t.price)
from passengers p, flights f, tickets t
where p.pid = t.pid and f.fid=t.fid and p.age>30
group by f.fid
having count(p.pid) >=100;

/*part 4
select
    sum(Tickets.price)
from
    Flights
        JOIN Tickets ON Tickets.fid = Flights.fid
where
    Flights.miles = (select max(Flights.miles) maxmiles from Flights);





select sum(t.price)
from tickets t, flights f
where t.fid = f.fid and f.miles = (select max(f1.miles)
                    from flights f1); */

/*secodn version*/
select sum(t.price)
from tickets t, flights f,  (select max(f1.miles)as maxmiles from flights f1)temp
where t.fid = f.fid and f.miles = temp.maxmiles;



/* part 5 */

select  f.ffrom, count(p.pid), sum(t.price), avg(f.miles)
from flights f, tickets t, passengers
 p
where f.fid = t.fid and p.pid = t.pid
group by f.ffrom;




