select
    o_orderkey as order_id,
    o_custkey as customer_id,
    o_orderstatus as order_status,
    o_totalprice as total_price,
    o_orderdate as order_date,
    o_orderpriority as order_priority,
    substring(o_clerk, 7) as clerk_id,
    o_shippriority as ship_priority

from {{ source("tpch_sf1", "orders") }}
