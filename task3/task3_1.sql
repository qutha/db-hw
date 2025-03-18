select 
    c.name,
    c.email,
    c.phone,
    count(b.id_booking) as total_bookings,
    string_agg(distinct h.name, ', ') as hotels,
    round(avg(b.check_out_date - b.check_in_date)::numeric, 4) as avg_duration
from customer c
join booking b on c.id_customer = b.id_customer
join room r on b.id_room = r.id_room
join hotel h on r.id_hotel = h.id_hotel
group by c.id_customer
having count(b.id_booking) > 2 and count(distinct h.id_hotel) >= 2
order by total_bookings desc;