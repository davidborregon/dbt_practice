select
    n_nationkey as country_id,
    n_name as country_name,
    n_regionkey as region_id
from {{ source('tpch_sf1', 'nation') }}