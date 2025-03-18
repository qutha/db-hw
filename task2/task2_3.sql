with class_stats as (
    select 
        c.class,
        avg(r.position) as class_avg_position
    from cars c
    join results r on c.name = r.car
    group by c.class
),
min_class as (
    select 
        class,
        class_avg_position 
    from class_stats 
    where class_avg_position = (select min(class_avg_position) from class_stats)
),
class_races as (
    select 
        c.class,
        count(distinct r.race) as total_races
    from cars c
    join results r on c.name = r.car
    group by c.class
)
select 
    c.name as car_name,
    c.class as car_class,
    avg(r.position) as average_position,
    count(r.race) as race_count,
    cl.country as car_country,
    cr.total_races
from cars c
join results r on c.name = r.car
join classes cl on c.class = cl.class
join min_class mc on c.class = mc.class
join class_races cr on c.class = cr.class
group by c.name, c.class, cl.country, cr.total_races
order by car_class, car_name;