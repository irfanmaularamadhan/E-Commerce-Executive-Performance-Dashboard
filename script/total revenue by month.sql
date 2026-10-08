select
	date_trunc('month', odc.order_purchase_timestamp):: date as bulan,
	round(sum(oidc.price):: numeric, 2) as total_revenue,
	count(distinct oidc.order_id) as total_transaksi
from
	order_items_dataset_clean oidc
inner join orders_dataset_clean odc on
	oidc.order_id = odc.order_id
group by
	date_trunc('month', odc.order_purchase_timestamp)
order by
total_revenue desc