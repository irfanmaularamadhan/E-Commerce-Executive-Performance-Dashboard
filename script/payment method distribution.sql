select
	payment_type,
	count(distinct order_id) as total_transaksi,
	round(sum(payment_value):: numeric, 2) as total_payment
from
	order_payments_dataset_clean
group by
	payment_type
order by
	total_payment desc