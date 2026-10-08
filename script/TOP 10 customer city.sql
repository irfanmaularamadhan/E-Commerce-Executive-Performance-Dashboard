select
	cdc.customer_city,
	round(sum(oidc.price):: numeric, 2) as total_revenue,
	count(distinct oidc.order_id) as total_transaksi
from
	order_items_dataset_clean oidc
inner join orders_dataset_clean odc on
	oidc.order_id = odc.order_id
inner join customer_dataset_clean cdc on
	odc.customer_id = cdc.customer_id
group by
	cdc.customer_city
order by
	total_revenue desc
limit 10;