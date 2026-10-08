with delivery_summary as(
select odc.order_id,
ordc.review_score,
date(odc.order_delivered_customer_date) - date(odc.order_estimated_delivery_date)as delay_day,
case 
	when date(odc.order_delivered_customer_date) > date(odc.order_estimated_delivery_date) then 'Late' 
	else 'On Time' end as delivery_status 
	from orders_dataset_clean odc 
	inner join order_reviews_dataset_clean ordc on odc.order_id = ordc.order_id 
	where order_status = 'delivered' 
	and odc.order_delivered_customer_date is not null )
	
select
	delivery_status,
	count(distinct order_id) as total_transaksi,
	round(avg(review_score):: numeric, 2) as rata_rata_rating,
	round(avg(case when delay_day > 0 then delay_day else 0 end),1) as avg_delay_day
from
	delivery_summary group by delivery_status;

