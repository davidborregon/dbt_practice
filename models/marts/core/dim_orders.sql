with
orders as (
    select
        order_id,
        customer_id,
        order_status,
        total_price,
        order_date
    from
        {{ ref('stg_orders') }}
),
customers as (
    select
        customer_id
    from
        {{ ref('stg_customer') }}
)

select 
    o.order_id,
    o.customer_id,
    o.order_status,
    o.total_price,
    o.order_date
from
    orders o
join
    customers c on o.customer_id=c.customer_id
