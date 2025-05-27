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
    dim_supplier.supplier_name

from {{ ref("int_order_lineitems") }} oli 
join {{ ref("dim_supplier") }} dim_supplier on oli.supplier_id = dim_supplier.supplier_id