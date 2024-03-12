create database Project_Olist_Ecommerse;
use project_olist_ecommerse;

 # Total Customers --
Select count(distinct(customer_unique_id)) as Total_Customers from customers_dataset;

# Total Products --
select count( distinct(product_id)) as Total_Products from order_items_dataset;

# Total Sellers -- 
select   count(distinct(seller_id)) as Total_sellers from sellers_dataset;

# Sum of payment value --
select concat(round(sum(Payment_value)/1000000),"M") as total_payment_value from payments_dataset;

#Total Sales --
select concat(round((sum(price)+sum(freight_value))/1000000,2),'M') as Total_Sales from Order_items_dataset;


# KPI-1 --  Weekday Vs Weekend (order_purchase_timestamp) Payment Value in millions.
select case 
when weekday(order_purchase_timestamp) in (5,6) then 'WeekEnd'
else 'Weekday'
end as "Day_Status" , concat(round(sum(payment_value)/1000000),'M')as total_value from orders_dataset as od 
join 
payments_dataset as pd using(order_id) group by day_status ;
select weekday(curdate());
# KPI-2 -- Number of Orders with review score 5 and payment type . 
select  distinct pd.payment_type,count(od.order_id) as Total_ordes from payments_dataset as pd
join
orders_dataset as od using(order_id) 
join 
reviews_dataset using(order_id) where review_score=5 
group by payment_type;


#KPI-3 -- Average number of days taken for order_delivered_customer_date for pet_shop.
select  pd.product_category_name,
round(avg(datediff(order_delivered_customer_date,order_purchase_timestamp))) as deliverd_Days
from products_dataset as pd 
join
order_items_dataset using(product_id)
 join
orders_dataset using(order_id) 
where  product_category_name='pet_shop' group by product_category_name;



# KPI-4 --  Average price and payment values from customers of sao paulo city
select cd.customer_city,round(avg(pd.payment_value)) as avg_payment_value,round(avg(oid.price)) as avg_price from payments_dataset as pd 
 join 
order_items_dataset as oid using(order_id) 
 join
orders_dataset using(order_id)
 join
customers_dataset as cd using(customer_id) where customer_city='sao paulo' group by customer_city;



# KPI-5 -- Relationship between shipping days (order_delivered_customer_date - order_purchase_timestamp) Vs review scores
select distinct review_score,round(avg(datediff(order_delivered_customer_date,order_purchase_timestamp))) as avg_Shipping_Days from 
orders_dataset 
join 
reviews_dataset using(order_id) 
group by review_score order by review_score;


# KPI-6 -- Top 5 Products based on orders.
select distinct product_category_name_english,count(order_id) as total_orders from 
order_items_dataset 
join
products_dataset as pd using(product_id) 
join
product_category_name as pcn on pd.product_category_name=pcn.ï»¿product_category_name 
group by 
product_category_name_english 
order by  total_orders 
desc limit 5;


# KPI-7 -- Bottom 5 products based on orders.
select distinct product_category_name_english,count(order_id) as total_orders from 
order_items_dataset join
products_dataset as pd using(product_id) join
product_category_name as pcn on pd.product_category_name=pcn.ï»¿product_category_name 
group by 
product_category_name_english 
order by  total_orders
limit 5;
select












