with customers as (
    select
        customer_id,
        customer_name,
        country_id,
        account_balance,
        market_segment
    from
        {{ ref("stg_customer") }}
    ),
location as (
    select
        country_id, 
        country_name
    from
        {{ ref("dim_location") }}
)

select
    c.customer_id,
    c.country_id,
    c.customer_name,
    l.country_name,
    c.account_balance,
    c.market_segment
from 
    customers c
join 
    location l on c.country_id = l.country_id
