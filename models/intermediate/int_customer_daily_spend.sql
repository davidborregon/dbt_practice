/*
Cambia la granularidad y agrega datos para calcular el gasto total por cliente por día.
*/

select
    o.customer_id,
    o.order_date as sales_date,
    round(sum(oli.net_price), 2) as daily_net_spend,
    round(sum(oli.gross_price), 2) as daily_gross_spend,
    count(distinct o.order_id) as daily_orders_count

from {{ ref("int_order_lineitems") }} oli
join {{ ref("stg_orders") }} o on oli.order_id = o.order_id

group by o.customer_id, o.order_date
order by o.customer_id, o.order_date
