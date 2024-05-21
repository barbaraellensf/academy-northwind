with 
    source_order_details as (
        select
             cast(ORDERID as int) as fk_order
            , cast(PRODUCTID as int) as fk_product
            , cast(UNITPRICE as numeric(18,2)) as unit_price
            , cast(QUANTITY as int) as quantity
            , cast(DISCOUNT as numeric(18,2)) as discount
        from {{ source('erp', 'orderdetail') }}
    )

select *
from source_order_details