select
    c.id as customer_id,
    n.name,
    c.account_balance,
    c.market_segment
    -- add account_balance_status (positive/negative) column

from {{ ref('stg_customer') }} c
join {{ ref('stg_nation') }} n
    on c.country_id=n.id