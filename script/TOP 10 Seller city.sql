select
	sdc.seller_city,
	round(sum(oidc.price):: numeric, 2) as total_revenue,
	count(distinct oidc.order_id) as total_transaksi
from
	order_items_dataset_clean oidc
inner join sellers_dataset_clean sdc on
	oidc.seller_id = sdc.seller_id
group by
	sdc.seller_city
order by
	total_revenue desc
limit 10;