select
    part_id,
    type as part_type,
    retail_price,
    manufacturer,
    brand
from
    {{ ref('stg_part') }}