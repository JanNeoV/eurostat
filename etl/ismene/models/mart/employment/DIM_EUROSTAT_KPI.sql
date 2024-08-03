SELECT 
    DISTINCT idt_kpi,
    kpi,
    kpi_label
     FROM {{ref('raw_import_erurostat_selfemployment')}}