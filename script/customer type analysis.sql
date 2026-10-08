with customer_order as(
select cdc.customer_unique_id,
count(distinct odc.order_id) as total_transaksi 
from orders_dataset_clean odc 
inner join customer_dataset_clean cdc on odc.customer_id = cdc.customer_id 
where odc.order_status = 'delivered' 
group by cdc.customer_unique_id)
select
	case
		when total_transaksi = 1 then 'one time customer'
		else 'repeat customer'
	end as customer_type,
	count(customer_unique_id) as total_customer,
	ROUND((COUNT(customer_unique_id)::numeric / SUM(COUNT(customer_unique_id)) over () * 100), 2) as percentage
from
	customer_order
group by
	customer_type;