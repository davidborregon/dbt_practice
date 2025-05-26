select
    order_id,
    part_id,
    supplier_id,
    line_number,
    quantity,
    extended_price,
    discount,
    tax,
    ship_date,
    case
        when returned = 'R' then 'Returned' when returned = 'N' then 'Non-applicable' else 'Accepted'
    end as returned,
    case
        when status = 'O' then 'Open' when status = 'F' then 'Finalized' else status
    end as status

from {{ ref('stg_lineitem') }}
