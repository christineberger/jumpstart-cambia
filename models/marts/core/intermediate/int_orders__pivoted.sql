{% set payment_methods = dbt_utils.get_column_values(
    ref('stg_stripe__payments'), 
    'payment_method'
) %}

with

payments as (
    
    select * from {{ ref('stg_stripe__payments') }}
    where status = 'success'
    
),

pivoted as (
    
    select
    
        order_id,
        
        {%- for method in payment_methods %}
        sum(case 
            when payment_method = '{{ method }}'
            then amount_usd
            else 0 
        end) as {{ method }}_amount
        {%- if not loop.last %},{% endif %}
        {%- endfor %}
    
    from payments
    group by 1
    
)

select * from pivoted