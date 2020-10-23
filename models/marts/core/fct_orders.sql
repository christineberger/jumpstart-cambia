with

orders as (

    select * from {{ ref('stg_orders') }}

),

customers as (

    select * from {{ ref('stg_customers') }}

),

payments as (

    select * from {{ ref('stg_payments') }}

),

joined as (

    select

        orders.order_id,
        orders.customer_id,
        order_date,

        sum(payments.amount_cents)/100 as amount
        
    from orders
    left join payments
        on orders.order_id = payments.order_id
    group by 1, 2, 3

)

select * from joined

