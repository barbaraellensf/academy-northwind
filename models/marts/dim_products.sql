with
    products as (
        select *
        from {{ ref('stg_erp__products') }}
    )
    , categories as (
        select *
        from {{ ref('stg_erp__categories') }}
    )
    , suppliers as (
        select *
        from {{ ref('stg_erp__suppliers') }}
    )
    , joined as (
        select 
            p.PK_PRODUCT
            , p.NM_PRODUCT
            , p.QUANTITY_PER_UNITY
            , p.UNIT_PRICE
            , p.UNITS_IN_STOCK
            , p.UNITS_ON_ORDER
            , p.ORDER_LEVEL
            , p.IS_DISCONTINUED
            , c.NM_CATEGORY
            , c.DS_CATEGORY
            , s.NM_SUPPLIER
            , s.CITY_SUPPLIER
            , s.COUNTRY_SUPPLIER
        from products p
        left join categories c on p.fk_category = c.pk_category
        left join suppliers s on p.fk_supplier = s.pk_supplier
    )

select *
from joined