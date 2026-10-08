select*from olist_customers_dataset ocd;
select*from olist_geolocation_dataset ogd;
select*from olist_order_items_dataset ooid;
select*from olist_order_payments_dataset oopd;
select*from olist_order_reviews_dataset oord;
select*from olist_orders_dataset ood;
select*from olist_products_dataset;
select*from olist_sellers_dataset osd;
select*from product_category_name_translation pcnt 

create view customer_dataset_clean as
select
	trim(customer_id) as customer_id,
	trim(customer_unique_id) as customer_unique_id,
	customer_zip_code_prefix,
	trim(customer_city) as customer_city,
	trim(customer_state) as customer_state
from
	olist_customers_dataset ocd
where
	customer_id is not null;

create view geolocation_dataset_clean as
select
	geolocation_zip_code_prefix,
	geolocation_lat,
	geolocation_lng,
	trim(geolocation_city) as geolocation_city,
	trim(geolocation_state) as geolocation_state
from
	olist_geolocation_dataset
	
create view order_items_dataset_clean as
select
	trim(order_id) as order_id,
	order_item_id,
	trim(product_id) as product_id, 
	trim(seller_id) as seller_id,
	shipping_limit_date,
	price,
	freight_value
from
	olist_order_items_dataset
where
	order_id is not null;

create view order_payments_dataset_clean as
select
	trim(order_id) as order_id,
	payment_sequential,
	trim(payment_type) as payment_type,
	payment_installments,
	payment_value
from
	olist_order_payments_dataset oopd 
where
	order_id is not null;

create view order_reviews_dataset_clean as
select
	trim(review_id) as review_id,
	trim(order_id) as order_id,
	review_score,
	trim(review_comment_title) as review_comment_title,
	trim(review_comment_message) as review_comment_message,
	review_creation_date,
	review_answer_timestamp
from
	olist_order_reviews_dataset oord 
where
	review_id is not null;

create view orders_dataset_clean as
select
	trim(order_id)as order_id,
	trim(customer_id) as customer_id,
	trim(order_status) as order_status,
	order_purchase_timestamp,
	order_approved_at,
	order_delivered_carrier_date,
	order_delivered_customer_date,
	order_estimated_delivery_date
from
	olist_orders_dataset ood
where
	order_id is not null;

create view products_dataset_clean as
select
	trim(opd.product_id) as product_id,
	trim(opd.product_category_name) as product_category_name,
	opd.product_name_lenght,
	opd.product_description_lenght,
	opd.product_photos_qty,
	opd.product_weight_g,
	opd.product_length_cm,
	opd.product_height_cm,
	opd.product_width_cm,
	coalesce (trim(pcnt.product_category_name_english), 'uncategorized') as product_category_name_english
from
	olist_products_dataset opd left join product_category_name_translation pcnt on opd.product_category_name = pcnt.product_category_name
where
	product_id is not null;

create view sellers_dataset_clean as
select
	trim(seller_id) as seller_id,
	seller_zip_code_prefix,
	trim(seller_city) as seller_city,
	trim(seller_state) as seller_state
from
	olist_sellers_dataset
where
	seller_id is not null;

create view product_category_name_translation_clean as
select
	trim(product_category_name) as product_category_name,
	trim(product_category_name_english) as product_category_name_english
from
	product_category_name_translation;
