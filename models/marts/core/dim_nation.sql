select
    n.country_id,
    n.country_name,
    r.region_id,
    r.region_name
    
from {{ ref('stg_nation') }} n
join {{ ref('stg_region') }} r
    on n.region_id=r.region_id