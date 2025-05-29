with
nations as (
    select
        country_id,
        country_name,
        region_id
    from
        {{ ref('stg_nation') }}
),
regions as (
    select
        region_id,
        region_name
    from
        {{ ref('stg_region') }}
)

select 
    n.country_id,
    n.country_name,
    r.region_id,
    r.region_name
from
    nations n
join
    regions r on n.region_id=r.region_id