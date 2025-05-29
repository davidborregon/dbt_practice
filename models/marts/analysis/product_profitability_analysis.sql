with
order_lineitems as (
    select
        oli.part_id,
        oli.quantity,
        oli.net_price,
        oli.supplier_id
    from
        {{ ref('int_order_lineitems') }} oli
),
partsupp as (
    select
        ps.part_id,
        ps.supplier_id,
        ps.supply_cost,
        ps.manufacturer,
        ps.brand,
        ps.part_type,
        ps.retail_price,
    from
        {{ ref('dim_partsupp') }} ps
)

select
    ps.part_id,
    ps.manufacturer,
    ps.brand,
    ps.part_type,
    ps.retail_price,
    sum(oli.quantity) as total_quantity_sold,
    round(sum(oli.net_price), 2) as total_revenue,
    round(sum(ps.supply_cost * oli.quantity), 2) as total_cost_of_goods_sold,  -- cada unidad vendida incurrió en este coste
    round(sum(oli.net_price) - sum(ps.supply_cost * oli.quantity), 2) as total_profit,
    round(sum(oli.net_price) - sum(ps.supply_cost * oli.quantity) / nullif(sum(oli.net_price), 0), 2) as profit_margin_percentage
from
    order_lineitems oli
join
    partsupp ps on oli.part_id = ps.part_id and oli.supplier_id = ps.supplier_id
group by 
    ps.part_id, 
    ps.manufacturer, 
    ps.brand, 
    ps.part_type, 
    ps.retail_price
order by 
    total_profit desc