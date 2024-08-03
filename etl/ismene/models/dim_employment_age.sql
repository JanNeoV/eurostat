SELECT 
    DISTINCT idt_age,
    age
    FROM
{{ref('self_employment_by_education')}}