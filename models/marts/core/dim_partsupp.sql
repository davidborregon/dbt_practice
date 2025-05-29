with
parts as (
    select
        part_id,
        type as part_type,
        retail_price,
        manufacturer,
        brand
    from
        {{ ref('stg_part') }}
),
suppliers as (
    select *
    from
        {{ ref('int_supplier_with_location') }}
),
partsupp as (
    select *
    from
        {{ ref('stg_partsupp') }}
)

select
    ps.part_id,
    ps.available_quantity,
    ps.supply_cost,
    p.part_type,
    p.retail_price,
    p.manufacturer,
    p.brand,
    s.supplier_id,
    s.supplier_name,
    s.account_balance as supplier_account_balance,
    s.country_name as supplier_country
from
    partsupp ps
join
    suppliers s on s.supplier_id=ps.supplier_id
join
    parts p on p.part_id=ps.part_id