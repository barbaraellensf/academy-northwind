with
    carriers as (
        select *
        from {{ ref('stg_erp__carriers') }}
    )

select *
from carriers