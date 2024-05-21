with
    employees as (
        select *
        from {{ ref('stg_erp__employees') }}
    )
    , joined as (
        select
            employees.pk_employee
            , employees.employee_name
            , employees.employee_title
            , employees.emp_birth_date
            , employees.emp_hire_date
            , managers.employee_name as manager_name
            , managers.employee_title as manager_title
        from employees
        left join employees managers on employees.fk_manager = managers.pk_employee
    )

select *
from joined