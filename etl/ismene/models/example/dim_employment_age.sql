SELECT 
    DISTINCT idt_age,
    age
    FROM
{{ref('raw_import_erurostat_selfemployment')}}