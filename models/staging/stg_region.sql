-- {{ config(materialized="view") }}

select
    r_regionkey as id,
    r_name as name
from
    {{ source('tpch_sf1', 'region') }}