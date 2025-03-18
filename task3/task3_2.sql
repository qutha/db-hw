select 
    c.id_customer,
    c.name,
    count(b.id_booking) as total_bookings,
    sum(r.price) as total_spent,
    count(distinct h.id_hotel) as unique_hotels
from customer c
join booking b on c.id_customer = b.id_customer
join room r on b.id_room = r.id_room
join hotel h on r.id_hotel = h.id_hotel
group by c.id_customer, c.name
having 
    count(b.id_booking) > 2 
    and count(distinct h.id_hotel) >= 2 
    and sum(r.price * (b.check_out_date - b.check_in_date)) > 500
order by total_spent asc;