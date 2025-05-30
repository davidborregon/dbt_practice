with
suppliers as (
    select
        s.supplier_id,
        s.supplier_name,
        s.country_id,
        s.account_balance
    from {{ ref('stg_supplier') }} s
),
location as (
    select
        n.country_id,
        n.country_name,
        r.region_id,
        r.region_name
    from
        {{ ref('stg_nation') }} n
    join
        {{ ref('stg_region') }} r on n.region_id=r.region_id

)

select
    s.supplier_id,
    s.supplier_name,
    s.account_balance,
    l.country_name,
    l.region_name
from
    suppliers s
join
    location l on s.country_id=l.country_id