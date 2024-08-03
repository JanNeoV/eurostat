SELECT 
    DISTINCT idt_status,
    wstatus,
    CASE
    WHEN wstatus = 'SELF' THEN 'Self employed'
    WHEN wstatus = 'SELF_NS' THEN 'Self employed with employees'
    WHEN wstatus = 'SELF_S' THEN 'Self employed without employees'
    ELSE NULL END AS status_label

    
     FROM {{ref('employment_union')}}