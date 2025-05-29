with
order_lineitems as (
    select
        oli.order_id,
        oli.customer_id,
        oli.order_date,
        oli.quantity,
        oli.net_price,
        oli.gross_price
    from
        {{ ref('int_order_lineitems') }} oli
),
customers as (
    select
        c.customer_id,
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
    l.region_name,
    l.country_name,
    c.market_segment,
    oli.order_date as sales_date,  -- Granularidad diaria
    sum(oli.quantity) as total_quantity_sold,
    round(sum(oli.net_price), 2) as total_net_sales,
    round(sum(oli.gross_price), 2) as total_gross_sales,
    count(distinct oli.order_id) as total_orders_count
from
    order_lineitems oli
join
    customers c on oli.customer_id = c.customer_id
join
    locations l on c.country_id = l.country_id
group by
    l.region_name,
    l.country_name, 
    c.market_segment, 
    oli.order_date
order by 
    l.region_name, 
    l.country_name, 
    c.market_segment, 
    sales_date
