/*
Combina la información de PART y PARTSUPP para que los datos de costes de suministro estén fácilmente disponibles junto con los detalles de la parte.
*/

select
    p.part_id,
    ps.supplier_id,
    p.manufacturer,
    p.brand,
    p.type,
    p.size,
    p.container,
    p.retail_price,
    ps.available_quantity as supplier_available_quantity,
    ps.supply_cost as supplier_cost

from {{ ref("stg_part") }} p
join {{ ref("stg_partsupp") }} ps on p.part_id = ps.part_id
