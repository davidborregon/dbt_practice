select
    s_suppkey as supplier_id,
    substring(s_name, 10) as supplier_name,
    s_nationkey as country_id,
    s_phone as phone_number,
    s_acctbal as account_balance

from {{ source('tpch_sf1', 'supplier') }}