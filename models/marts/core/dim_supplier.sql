select
    s.supplier_id,
    s.supplier_name,
    n.country_id,
    n.country_name,
    s.account_balance

from {{ ref('stg_supplier') }} s
join {{ ref('int_nation_region') }} n
    on s.country_id=n.country_id