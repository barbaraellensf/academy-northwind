with 
    source_categories as (
        select
            cast(ID as int) as pk_category
            , cast(CATEGORYNAME as varchar) as nm_category
            , cast(DESCRIPTION as varchar) as ds_category
        from {{ source('erp', 'category') }}
    )

select *
from source_categories