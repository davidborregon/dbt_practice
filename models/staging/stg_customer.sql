with customers as (
    select
        c_custkey as customer_id,
        substring(c_name, 10) as customer_name,
        c_nationkey as country_id,
        c_phone as phone_number,
        c_acctbal as account_balance,
        c_mktsegment as market_segment

    from {{ source('tpch_sf1', 'customer') }}
)

select *
from customers