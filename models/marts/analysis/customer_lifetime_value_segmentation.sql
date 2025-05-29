with
order_lineitems as (
    select
        oli.customer_id,
        oli.net_price,
        oli.gross_price,
        oli.order_id,
        oli.order_date
    from
        {{ ref('int_order_lineitems') }} oli
),
customers as (
    select
        c.customer_id,
        c.customer_name,
        c.market_segment,
        c.country_id
    from
        {{ ref('dim_customer') }} c
),
locations as (
    select
        l.country_id,
        l.country_name,
        l.region_name
    from
        {{ ref('dim_location') }} l
)

select
    c.customer_id,
    c.customer_name,
    c.market_segment,
    l.country_name,
    l.region_name,
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
from
    order_lineitems oli
join
    customers c on oli.customer_id = c.customer_id
join
    locations l on c.country_id = l.country_id

group by
    c.customer_id,
    c.customer_name,
    c.market_segment,
    l.country_name,
    l.region_name