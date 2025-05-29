with
order_lineitems as (
    select
        oli.order_id,
        oli.net_price,
        oli.gross_price
    from
        {{ ref('int_order_lineitems') }} oli
),
orders as (
    select
        o.order_id,
        o.customer_id,
        o.order_date as sales_date
    from
        {{ ref('stg_orders') }} o
)

select
    o.customer_id,
    o.sales_date,
    round(sum(oli.net_price), 2) as daily_net_spend,
    round(sum(oli.gross_price), 2) as daily_gross_spend,
    count(distinct o.order_id) as daily_orders_count
from
    order_lineitems oli
join
    orders o on oli.order_id = o.order_id
group by
    o.customer_id, o.sales_date
order by 
    o.customer_id, o.sales_date
