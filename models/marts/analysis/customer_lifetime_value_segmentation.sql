select
    c.customer_id,
    c.customer_name,
    c.market_segment,
    nr.country_name,
    nr.region_name,
    round(sum(oli.net_price), 2) as total_lifetime_net_spend,
    round(sum(oli.gross_price), 2) as total_lifetime_gross_spend,
    count(distinct oli.order_id) as total_orders,
    min(oli.order_date) as first_order_date,
    max(oli.order_date) as last_order_date,
    datediff(day, min(oli.order_date), current_date()) as customer_age_days, -- Calcula la antigüedad del cliente en días
    case
        when sum(oli.net_price) >= 100000
        then 'High-Value'
        when sum(oli.net_price) >= 50000
        then 'Mid-Value'
        when sum(oli.net_price) >= 10000
        then 'Low-Value'
        else 'Entry-Level'
    end as cltv_segment,
    round(datediff(day, min(oli.order_date), max(oli.order_date)) / nullif(count(distinct oli.order_id), 0), 2) as avg_days_between_orders -- Frecuencia de compra

from {{ ref("int_order_lineitems") }} oli
join {{ ref("dim_customer") }} c on oli.customer_id = c.customer_id
join {{ ref("int_nation_region") }} nr on c.country_id = nr.country_id

group by
    c.customer_id,
    c.customer_name,
    c.market_segment,
    nr.country_name,
    nr.region_name
