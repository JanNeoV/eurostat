SELECT
    DISTINCT idt_age,
    age
FROM
    {{ ref('employment_union') }}
