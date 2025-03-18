with recursive manager_subordinates as (
    select employeeid as managerid, employeeid as subordinateid
    from employees
    union all
    select ms.managerid, e.employeeid
    from employees e
    join manager_subordinates ms on e.managerid = ms.subordinateid
)
select 
    e.employeeid,
    e.name,
    e.managerid,
    d.departmentname,
    r.rolename,
    (select string_agg(p.projectname, ', ') from projects p where p.departmentid = e.departmentid) as projects,
    (select string_agg(t.taskname, ', ') from tasks t where t.assignedto = e.employeeid) as tasks,
    (count(ms.subordinateid) - 1) as total_subordinates
from manager_subordinates ms
join employees e on ms.managerid = e.employeeid
left join departments d on e.departmentid = d.departmentid
left join roles r on e.roleid = r.roleid
where ms.managerid != ms.subordinateid
group by e.employeeid, d.departmentname, r.rolename
having (count(ms.subordinateid) - 1) > 0
order by e.name;