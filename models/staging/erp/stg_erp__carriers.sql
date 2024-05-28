with 
    source_carriers as (
        select
            cast(ID as int) as pk_shipper
            , cast(COMPANYNAME as varchar) as shipper_name
        from {{ source('erp', 'shipper') }}
    )

select *
from source_carriers