with suppliers as (
    select
        s.supplier_id,
        s.supplier_name,
        s.country_id,
        s.account_balance
    from {{ ref('stg_supplier') }} s
),
location as (
    select
        l.country_id,
        l.country_name,
        l.region_id,
        l.region_name
    from
        {{ ref('dim_location') }} l
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