with 
    source_employees as (
        select
            cast(ID as int) as pk_employee
            , cast(REPORTSTO as int) as fk_manager
            , cast(FIRSTNAME as string) || ' ' || cast(LASTNAME as string) as employee_name
            , cast(TITLE as string) as employee_title
            , cast(BIRTHDATE as date) as emp_birth_date
            , cast(HIREDATE as date) as emp_hire_date
        from {{ source('erp', 'employee') }}
    )

select *
from source_employees