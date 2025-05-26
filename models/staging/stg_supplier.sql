select
    s_suppkey as id,
    s_nationkey as country_id,
    s_acctbal as account_balance

from {{ source('tpch_sf1', 'supplier') }}