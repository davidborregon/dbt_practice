select
    dr.region_name,
    dn.country_name,
    dc.market_segment,
    oli.order_date as sales_date,  -- Granularidad diaria
    sum(oli.quantity) as total_quantity_sold,
    round(sum(oli.net_price), 2) as total_net_sales,
    round(sum(oli.gross_price), 2) as total_gross_sales,
    count(distinct oli.order_id) as total_orders_count

from {{ ref("int_order_lineitems") }} oli
join {{ ref("dim_customer") }} dc on oli.customer_id = dc.customer_id
join {{ ref("dim_nation") }} dn on dc.country_id = dn.country_id
join {{ ref("dim_region") }} dr on dn.region_id = dr.region_id

group by dr.region_name, dn.country_name, dc.market_segment, oli.order_date
order by dr.region_name, dn.country_name, dc.market_segment, sales_date
