with 
    source_customers as (
        select
            cast(ID as varchar) as pk_customer
            , cast(COMPANYNAME as varchar) as customer_company
            , cast(CONTACTNAME as varchar) as customer_name
            , cast(CITY as varchar) as customer_city
            , cast(REGION as varchar) as customer_region
            , cast(COUNTRY as varchar) as customer_country
        from {{ source('erp', 'customer') }}
    )

select *
from source_customers