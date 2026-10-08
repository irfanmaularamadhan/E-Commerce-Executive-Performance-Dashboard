
select
	round(sum(price):: numeric,2) as total_revenue,
	count(distinct order_id) as total_transaksi,
	round(avg(price):: numeric, 2) as avg_harga_penjualan,
	round(sum(freight_value)::numeric,2)as total_freight,
	round((sum(price)/count(distinct order_id)):: numeric,2) as AOV,
	count(distinct seller_id) as total_seller
from
	order_items_dataset_clean