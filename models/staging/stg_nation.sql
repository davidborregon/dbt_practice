select
    n_nationkey as id,
    n_name as name,
    n_regionkey as region_id
from {{ source('tpch_sf1', 'nation') }}