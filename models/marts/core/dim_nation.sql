select
    n.id as nation_id,
    n.name as nation_name,
    r.name as region_name
    
from {{ ref('stg_nation') }} n
join {{ ref('stg_region') }} r
    on n.region_id=r.id