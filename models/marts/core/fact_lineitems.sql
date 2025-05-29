with
order_lineitems as (
    select
        oli.order_id,
        oli.customer_id,
        oli.part_id,
        oli.supplier_id,
        oli.line_number,
        oli.order_date,
        oli.quantity,
        oli.extended_price,
        oli.discount,
        oli.tax,
        oli.net_price,
        oli.gross_price,
        oli.sales_amount
    from
        {{ ref('int_order_lineitems') }} oli
),
suppliers as (
    select
        supplier_id,
        supplier_name
    from
        {{ ref('stg_supplier') }}
) 

select
    oli.order_id,
    oli.customer_id,
    oli.part_id,
    oli.supplier_id,
    oli.line_number,
    oli.order_date,
    oli.quantity,
    oli.extended_price,
    oli.discount,
    oli.tax,
    oli.net_price,
    oli.gross_price,
    oli.sales_amount,
    s.supplier_name

from order_lineitems oli 
join suppliers s on oli.supplier_id = s.supplier_id