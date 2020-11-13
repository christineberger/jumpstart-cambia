with

payments as (
    
    select * from {{ ref('stg_stripe__payments') }}
    where status = 'success'
    
),

total as (
    
    select
    
        sum(amount_usd) as total_successful_payments
        
    from payments
    
)

select * from total