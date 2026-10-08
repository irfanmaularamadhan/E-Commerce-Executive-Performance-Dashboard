select
	pdc.product_category_name_english as product_category_name,
	round(sum(oidc.price):: numeric, 2) as total_revenue,
	count(distinct oidc.order_id) as total_transaksi
from
	order_items_dataset_clean oidc
inner join products_dataset_clean pdc on
	oidc.product_id = pdc.product_id
group by
	pdc.product_category_name_english
order by
	total_revenue desc
limit 10;