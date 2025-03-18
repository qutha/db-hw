select 
    c.name as car_name, 
    c.class as car_class, 
    avg(r.position) as avg_position, 
    count(r.race) as races_participated, 
    cl.country as country, 
    total_races.total_races as total_races,
    low_position_count.low_position_count as low_position_count
from 
    cars c
join 
    classes cl on c.class = cl.class
join 
    results r on c.name = r.car
join 
    (select class, count(*) as total_races from cars join results on cars.name = results.car group by class) as total_races on c.class = total_races.class
join 
    (select class, count(*) as low_position_count 
     from cars 
     join results on cars.name = results.car 
     group by class 
     having avg(results.position) > 3.0) as low_position_count on c.class = low_position_count.class
group by 
    c.name, c.class, cl.country, total_races.total_races, low_position_count.low_position_count
having 
    avg(r.position) > 3.0
order by 
    low_position_count.low_position_count desc;