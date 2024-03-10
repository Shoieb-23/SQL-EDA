select * from restaurants
select * from orders
select * from order_details
select * from users
select * from menu
select * from food


--which resturatnt earn high money based on paticular month , having sales more then X value

select r.r_name, sum(o.amount) as highest_sale from orders o
INNER JOIN restaurants r
on o.r_id=r.r_id
where MONTH(o.date)='06'
group by o.r_id , r.r_name
having sum(o.amount) > '500'
order by highest_sale desc


--All orders with order_details (hotel , amount , food , orders) for a paticular customer in a X range


select od.user_id ,sum(od.amount) total_amount,count(od.order_id) total_orders , r.r_name, u.name , odd.f_id , ff.f_name from orders od
inner join users u 
on u.user_id=od.user_id  
 join restaurants r
on r.r_id=od.r_id
join order_details odd
on od.order_id=odd.order_id
join food ff
on odd.f_id=ff.f_id
where u.name='nitish'  and od.date between '2022-06-10' and  '2022-07-10'
group by u.name , od.user_id ,r.r_name , odd.f_id , ff.f_name
order by total_amount desc


--select loyal customers

select r_id , user_id , count(*)  visti from orders
where r_id is not null
group by r_id , user_id
having count(*) > 1
order by visti desc

-- Month over Month revenvue growth

with ctte2 as (
select sum(amount) as Revenue, DATENAME(month, DATEADD(month, month(date) - 1, '1900-01-01')) AS dates
from orders
where month(date) is not null
group by month(date)
) 
SELECT *,
       LAG(Revenue) OVER (ORDER BY  Revenue) AS RunningTotal
FROM ctte2
ORDER BY dates DESC;
 



