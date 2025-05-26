select
    s.id as supplier_id,
    n.name as country_name,
    s.account_balance

from {{ ref('stg_supplier') }} s
join {{ ref('stg_nation') }} n
    on s.country_id=n.id