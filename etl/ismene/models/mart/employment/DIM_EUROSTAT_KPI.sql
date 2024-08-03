SELECT 
    DISTINCT idt_kpi,
    kpi,
    kpi_label
     FROM {{ref('employment_union')}}