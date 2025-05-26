select
    id as part_id,
    manufacturer,
    brand
from
    {{ ref('stg_part') }}