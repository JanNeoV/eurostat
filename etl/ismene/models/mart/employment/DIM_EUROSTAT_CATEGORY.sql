SELECT 
    DISTINCT idt_category,
    category
     FROM {{ref('raw_import_erurostat_selfemployment')}}