with car_stats as (
    select 
        c.name as car_name,
        c.class as car_class,
        avg(r.position) as average_position,
        count(r.race) as race_count,
        rank() over (partition by c.class order by avg(r.position)) as rank
    from cars c
    join results r on c.name = r.car
    group by c.name, c.class
)
select car_name, car_class, average_position, race_count
from car_stats
where rank = 1
order by average_position;