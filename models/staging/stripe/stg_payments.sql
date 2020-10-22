with

source as (

    select * from raw.stripe.payment

),

renamed as (

    select

        id as payment_id,
        orderid as order_id,
        paymentmethod as payment_method,
        status,
        amount as amount_cents,
        created as created_at,
        _batched_at

    from source

)

select * from renamed