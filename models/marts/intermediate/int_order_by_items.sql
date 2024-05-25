    with
        orders as (
            select *
            from {{ ref('stg_erp__orders') }}
        )
        , order_details as (
            select *
            from {{ ref('stg_erp__order_details') }}
        )
        , joined as (
            select
                orders.PK_ORDER
                , order_details.FK_PRODUCT
                , orders.FK_CUSTOMER
                , orders.FK_EMPLOYEE
                , orders.FK_SHIPBY
                , orders.ORDER_DATE
                , orders.REQUIRED_DELIVERY_DATE
                , orders.SHIPPING_DATE
                , orders.FREIGHT
                , orders.NM_RECIPIENT
                , orders.CITY_RECIPIENT
                , orders.REGION_RECIPIENT
                , orders.REGION_COUNTRY
                , order_details.UNIT_PRICE
                , order_details.QUANTITY
                , order_details.DISCOUNT
            from order_details
            left join orders on order_details.FK_ORDER = orders.PK_ORDER
        )
        , create_pk as (
            select
                cast(PK_ORDER as varchar) || '-' || cast(FK_PRODUCT as varchar) as sk_sales
                , *
            from joined
        )

select *
from create_pk