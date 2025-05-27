select
    p_partkey as part_id,
    substring(p_mfgr, 14) as manufacturer,
    substring(p_brand, 7) as brand,
    p_type as type,
    p_size as size,
    p_container as container,
    p_retailprice as retail_price

from
    {{ source('tpch_sf1', 'part') }}