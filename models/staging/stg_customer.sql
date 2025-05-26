select
    c_custkey as id,
    c_nationkey as country_id,
    c_acctbal as account_balance,
    c_mktsegment as market_segment

from {{ source('tpch_sf1', 'customer') }}
