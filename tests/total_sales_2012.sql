with 
    sales_2012 as (
        select sum(GROSS_VALUE) as total_gross
        from {{ ref('fct_sales') }}
        where ORDER_DATE between '2012-01-01' and '2012-12-31'
    )

select total_gross
from sales_2012 -- 226298.5 given value
where total_gross not between 226298 and 226299