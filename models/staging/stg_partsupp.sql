select
    ps_partkey as part_id,
    ps_suppkey as supplier_id
from
    {{ source('tpch_sf1', 'partsupp') }}