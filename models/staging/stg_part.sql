-- {{ config(materialized="view") }}

select
    p_partkey as id,
    substring(p_mfgr, 14) as manufacturer,
    substring(p_brand, 7) as brand
from
    {{ source('tpch_sf1', 'part') }}