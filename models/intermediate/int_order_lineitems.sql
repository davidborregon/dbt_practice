with
lineitems as(
    select
        li.order_id,
        li.part_id,
        li.supplier_id,
        li.line_number,
        li.quantity,
        li.extended_price,
        li.discount,
        li.tax,
        case
            when li.returned = 'R'
            then 'Returned'
            when li.returned = 'N'
            then 'Non-applicable'
            else 'Accepted'
        end as returned,
        case
            when li.status = 'O'
            then 'Open'
            when li.status = 'F'
            then 'Finalized'
            else li.status
        end as line_status,
        li.ship_date,
        li.commit_date,
        li.receipt_date,
        li.ship_instructions,
        li.ship_mode
    from
        {{ ref("stg_lineitem") }} li
),
orders as (
    select
        o.order_id,
        o.customer_id,
        o.order_date,
        case
            when o.order_status = 'O'
            then 'Open'
            when o.order_status = 'F'
            then 'Fully Shipped'
            else 'Partially Shipped'
        end as order_status,
        o.order_priority,
        o.clerk_id,
        o.ship_priority
    from
        {{ ref("stg_orders") }} o
)

select
    li.part_id,
    li.supplier_id,
    li.line_number,
    li.quantity,
    li.extended_price,
    li.discount,
    li.tax,
    li.returned,
    li.line_status,
    li.ship_date,
    li.commit_date,
    li.receipt_date,
    li.ship_instructions,
    li.ship_mode,
    o.order_id,
    o.customer_id,
    o.order_date,
    o.order_status,
    o.order_priority,
    o.clerk_id,
    o.ship_priority,
    (li.extended_price * (1 - li.discount)) as net_price,
    (li.extended_price * (1 - li.discount) * (1 + li.tax)) as gross_price,
    (li.extended_price * li.quantity) as sales_amount
from
    lineitems li
join 
    orders o on li.order_id = o.order_id