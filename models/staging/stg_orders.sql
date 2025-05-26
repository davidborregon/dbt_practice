select
    o_orderkey as id,
    o_custkey as customer_id,
    o_orderstatus as order_status,
    o_totalprice as total_price,
    o_orderdate as order_date
from
    {{ source('tpch_sf1', 'orders') }}