{{ config(materialized="incremental", unique_key=["order_id", "line_number"]) }}

select
    src.l_orderkey as order_id,
    src.l_partkey as part_id,
    src.l_suppkey as supplier_id,
    src.l_linenumber as line_number,
    src.l_quantity as quantity,
    src.l_extendedprice as extended_price,  -- quantity * unit_price
    src.l_discount as discount,  -- 0.05 for 5% discount
    src.l_tax as tax,  -- 0.08 for 8% tax
    src.l_returnflag as returned,  -- replace R with 'yes' and N with 'no'
    src.l_linestatus as status,  -- replace O with 'open' and F with 'finalized'
    src.l_shipdate as ship_date,
    src.l_commitdate as commit_date,
    src.l_receiptdate as receipt_date,
    src.l_shipinstruct as ship_instructions,
    src.l_shipmode as ship_mode

from {{ source("tpch_sf1", "lineitem") }} src

{% if is_incremental() %}
    -- Esto solo se ejecuta en modo incremental
    -- Filtramos por la columna de fecha más reciente para cargar solo los nuevos
    -- registros
    where l_shipdate > (select max(ship_date) from {{ this }})
{% endif %}
