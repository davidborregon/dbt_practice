select
    l_orderkey as order_id,
    l_partkey as part_id,
    l_suppkey as supplier_id,
    l_linenumber as line_number,
    l_quantity as quantity,
    l_extendedprice as extended_price, -- quantity * unit_price
    l_discount as discount, -- 0.05 for 5% discount
    l_tax as tax, -- 0.08 for 8% tax
    l_returnflag as returned, -- replace R with 'yes' and N with 'no'
    l_linestatus as status, -- replace O with 'open' and F with 'finalized'
    l_shipdate as ship_date
from
    {{ source('tpch_sf1', 'lineitem') }}