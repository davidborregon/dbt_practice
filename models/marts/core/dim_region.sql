select
    id as region_id,
    name as region_name
from {{ ref('stg_region') }}