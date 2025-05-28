select
    s.supplier_id,
    s.supplier_name,
    dn.country_name as supplier_nation,
    dr.region_name as supplier_region,
    round(sum(ips.supplier_cost * ips.supplier_available_quantity), 2) as total_inventory_cost,  -- Coste total de las partes disponibles
    round(sum(oli.quantity), 2) as total_parts_supplied_quantity,  -- Cantidad total vendida por este proveedor
    round(sum(oli.net_price), 2) as total_sales_from_supplier,  -- Ingresos generados por las partes de este proveedor
    count(distinct oli.order_id) as total_orders_with_supplier_parts,
    round(avg(datediff(day, oli.commit_date, oli.receipt_date)), 2) as avg_receipt_delay_days,  -- Retraso promedio en la recepción
    round(avg(datediff(day, oli.commit_date, oli.ship_date)), 2) as avg_shipping_delay_days,  -- Retraso promedio en el envío
    sum(
        case when oli.returned = 'Returned' then 1 else 0 end
    ) as total_returned_items_count,
    (
        sum(case when oli.returned = 'Returned' then 1 else 0 end)
        * 1.0
        / nullif(sum(oli.quantity), 0)
    ) as percentage_returned_items

from {{ ref("dim_supplier") }} s
join {{ ref("dim_nation") }} dn on s.country_id = dn.country_id
join {{ ref("dim_region") }} dr on dn.region_id = dr.region_id
left join {{ ref("int_order_lineitems") }} oli on s.supplier_id = oli.supplier_id -- LEFT JOIN para incluir proveedores que quizás no tengan órdenes todavía
left join {{ ref("int_part_supplier_costs") }} ips on s.supplier_id = ips.supplier_id

group by s.supplier_id, s.supplier_name, dn.country_name, dr.region_name
order by total_sales_from_supplier desc
