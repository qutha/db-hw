with recursive subordinates as (
    select employeeid, name, managerid, departmentid, roleid
    from employees
    where managerid = 1
    union all
    select e.employeeid, e.name, e.managerid, e.departmentid, e.roleid
    from employees e
    join subordinates s on e.managerid = s.employeeid
)
select 
    s.employeeid,
    s.name,
    s.managerid,
    d.departmentname,
    r.rolename,
    (select string_agg(p.projectname, ', ') from projects p where p.departmentid = s.departmentid) as projects,
    (select string_agg(t.taskname, ', ') from tasks t where t.assignedto = s.employeeid) as tasks,
    (select count(*) from tasks t where t.assignedto = s.employeeid) as task_count,
    (select count(*) from employees e where e.managerid = s.employeeid) as subordinate_count
from subordinates s
left join departments d on s.departmentid = d.departmentid
left join roles r on s.roleid = r.roleid
order by s.name;