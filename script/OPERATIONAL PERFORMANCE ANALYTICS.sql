select
	round(avg(extract(epoch from (order_delivered_carrier_date - order_approved_at))/ 86400):: numeric, 1) as _seller_processing_days,
	round(avg(extract(epoch from (order_delivered_customer_date - order_delivered_carrier_date))/ 86400):: numeric, 1) as avg_carrier_shipping_days,
	round(avg(extract(epoch from (order_delivered_customer_date - order_approved_at))/ 86400):: numeric, 1)as avg_fulfillment_days
from orders_dataset_clean where order_status = 'delivered' 
and order_delivered_carrier_date is not null 
and order_delivered_customer_date is not null;