with

all_days as (
    
    select * from {{ ref('all_days') }}
    
),

payments as (
    
    select * from {{ ref('int_payment_methods__pivoted') }}
    
),

joined as (
    
    select

        all_days.date_day,
        count(order_id) as number_of_orders,
        sum(payments.bank_transfer_amount) as bank_transfer_amount,
        sum(payments.credit_card_amount) as credit_card_amount,
        sum(payments.gift_card_amount) as gift_card_amount,
        sum(payments.coupon_amount) as coupon_amount,
        sum(payments.total_payments) as total_payments
    
    from all_days
    left join payments
        on all_days.date_day = payments.payment_date
    group by 1
    
)

select * from joined