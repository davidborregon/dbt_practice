select
    dp.part_id,
    dp.manufacturer,
    dp.brand,
    dp.part_type,
    dp.retail_price,
    sum(oli.quantity) as total_quantity_sold,
    round(sum(oli.net_price), 2) as total_revenue,
    round(sum(ips.supplier_cost * oli.quantity), 2) as total_cost_of_goods_sold,  -- Se asume que cada unidad vendida incurrió en este coste
    round(sum(oli.net_price) - sum(ips.supplier_cost * oli.quantity), 2) as total_profit,
    round(sum(oli.net_price) - sum(ips.supplier_cost * oli.quantity) / nullif(sum(oli.net_price), 0), 2) as profit_margin_percentage

from {{ ref("int_order_lineitems") }} oli
join {{ ref("dim_part") }} dp on oli.part_id = dp.part_id
join {{ ref("int_part_supplier_costs") }} ips on oli.part_id = ips.part_id and oli.supplier_id = ips.supplier_id

group by dp.part_id, dp.manufacturer, dp.brand, dp.part_type, dp.retail_price
order by total_profit desc
