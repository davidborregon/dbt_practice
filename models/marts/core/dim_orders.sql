select
    o.order_id,
    c.customer_id,
    o.order_status,
    o.total_price,
    o.order_date

from {{ ref('stg_orders') }} o
join {{ ref('stg_customer') }} c
    on o.customer_id=c.customer_id
