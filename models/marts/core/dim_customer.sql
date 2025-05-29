select
    c.customer_id,
    c.customer_name,
    n.country_id,
    n.country_name,
    c.account_balance,
    c.market_segment

from {{ ref('stg_customer') }} c
join {{ ref('int_nation_region') }} n
    on c.country_id=n.country_id