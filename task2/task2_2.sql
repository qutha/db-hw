with car_stats as (
    select 
        c.name as car_name,
        c.class as car_class,
        avg(r.position) as average_position,
        count(r.race) as race_count,
        cl.country as car_country,
        row_number() over (order by avg(r.position), c.name) as rn
    from cars c
    join results r on c.name = r.car
    join classes cl on c.class = cl.class
    group by c.name, c.class, cl.country
)
select car_name, car_class, average_position, race_count, car_country
from car_stats
where rn = 1;