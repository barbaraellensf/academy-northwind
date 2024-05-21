with 
    source_orders as (
        select
            cast(ID as int) as pk_order
            , cast(CUSTOMERID as string) as fk_customer
            , cast(EMPLOYEEID as int) as fk_employee
            , cast(SHIPVIA as int) as fk_shipby
            , cast(ORDERDATE as date) as order_date
            , cast(REQUIREDDATE as date) as required_delivery_date
            , cast(SHIPPEDDATE as date) as shipping_date
            , cast(FREIGHT as numeric) as freight
            , cast(SHIPNAME as string) as nm_recipient
            , cast(SHIPCITY as string) as city_recipient
            , cast(SHIPREGION as string) as region_recipient
            , cast(SHIPCOUNTRY as string) as region_country
            --, cast(SHIPADDRESS as string) as
            --, cast(SHIPPOSTALCODE as string) as
        from {{ source('erp', '_order_') }}
    )

select *
from source_orders