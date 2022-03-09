--q3 (a)

create view ManagerSummary(DeptName, MgrName, MgrID, 
    MgrSalary, EmpCount) AS
select d.name, e.ename, d.managerid, e.salary, COUNT(w.eid)
from department d, employee e, works w
where e.eid = d.managerid and w.did = d.did
group by d.did, d.dname, d.managerid, e.ename, e.salary;


--q3(b)
select distinct ms.MgrSalary
from ManagerSummary ms
where ms.DeptName = 'Sales'; 


--q3(c)

select ms.MgrName
from ManagerSummary ms 
where ms.EmpCount = (select max(EmpCount)
                    from ManagerSummary);