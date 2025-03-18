with class_agg as (
    select 
        c.class,
        avg(r.position) as class_avg_position,
        count(distinct c.name) as cars_in_class
    from cars c
    join results r on c.name = r.car
    group by c.class
    having count(distinct c.name) >= 2
),
car_agg as (
    select 
        c.name as car_name,
        c.class as car_class,
        avg(r.position) as average_position,
        count(r.race) as race_count,
        cl.country as car_country
    from cars c
    join results r on c.name = r.car
    join classes cl on c.class = cl.class
    group by c.name, c.class, cl.country
)
select 
    ca.car_name,
    ca.car_class,
    ca.average_position,
    ca.race_count,
    ca.car_country
from car_agg ca
join class_agg cla on ca.car_class = cla.class
where ca.average_position < cla.class_avg_position
order by ca.car_class, ca.average_position;