select
    part_id,
    supplier_id
from
    {{ ref('stg_partsupp') }}