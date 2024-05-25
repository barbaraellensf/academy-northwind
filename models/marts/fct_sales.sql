   with
        order_by_items as (
            select *
            from {{ ref('int_order_by_items') }}
        )
        , dim_products as (
            select *
            from {{ ref('dim_products') }}
        )
        , dim_employees as (
            select *
            from {{ ref('dim_employees') }}
        )
        , joined as (
            select
                fct.SK_SALES
                , fct.PK_ORDER as INVOICE_NUMBER
                , fct.FK_PRODUCT          
                , fct.FK_CUSTOMER
                , fct.FK_EMPLOYEE
                , fct.FK_SHIPBY
                , fct.ORDER_DATE
                , fct.REQUIRED_DELIVERY_DATE
                , fct.SHIPPING_DATE
                , fct.FREIGHT
                , fct.NM_RECIPIENT
                , fct.CITY_RECIPIENT
                , fct.REGION_RECIPIENT
                , fct.REGION_COUNTRY
                , fct.UNIT_PRICE
                , fct.QUANTITY
                , fct.DISCOUNT
                , dim_products.NM_PRODUCT
                , dim_products.IS_DISCONTINUED
                , dim_products.NM_CATEGORY
                , dim_products.DS_CATEGORY
                , dim_products.NM_SUPPLIER
                , dim_products.CITY_SUPPLIER
                , dim_products.COUNTRY_SUPPLIER
                , dim_employees.EMPLOYEE_NAME
                , dim_employees.EMPLOYEE_TITLE
                , dim_employees.EMP_HIRE_DATE
                , dim_employees.MANAGER_NAME
            from order_by_items as fct
            left join dim_products on fct.FK_PRODUCT = dim_products.PK_PRODUCT
            left join dim_employees on fct.FK_EMPLOYEE = dim_employees.PK_EMPLOYEE
        )
        , metrics as (
            select
                SK_SALES
                , FK_PRODUCT          
                , FK_CUSTOMER
                , FK_EMPLOYEE
                , FK_SHIPBY
                , INVOICE_NUMBER
                , ORDER_DATE
                , REQUIRED_DELIVERY_DATE
                , SHIPPING_DATE
                , NM_RECIPIENT
                , CITY_RECIPIENT
                , REGION_RECIPIENT
                , REGION_COUNTRY
                , UNIT_PRICE
                , QUANTITY
                , DISCOUNT
                , NM_PRODUCT
                , IS_DISCONTINUED
                , NM_CATEGORY
                , DS_CATEGORY
                , NM_SUPPLIER
                , CITY_SUPPLIER
                , COUNTRY_SUPPLIER
                , EMPLOYEE_NAME
                , EMPLOYEE_TITLE
                , EMP_HIRE_DATE
                , MANAGER_NAME
                , QUANTITY * UNIT_PRICE as GROSS_VALUE
                , QUANTITY * (1 - DISCOUNT) * UNIT_PRICE as NET_VALUE
                , cast(
                    (EMP_HIRE_DATE - ORDER_DATE) / 365
                    as numeric (18,2)
                ) as SENIORITY_IN_YEARS
                , cast(
                    FREIGHT/count(INVOICE_NUMBER) over (partition by INVOICE_NUMBER) 
                    as numeric (18,2)
                ) as PRORATED_SHIPPING
            from joined
        )

select *
from metrics