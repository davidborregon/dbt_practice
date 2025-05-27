select
    c.customer_id,
    c.customer_name,
    n.country_id,
    n.country_name,
    c.account_balance,
    c.market_segment
    -- add account_balance_status (positive/negative) column

from {{ ref('stg_customer') }} c
join {{ ref('stg_nation') }} n
    on c.country_id=n.country_id