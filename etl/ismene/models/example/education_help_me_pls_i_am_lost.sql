/* 
age     Alter
freq    nicht benötigt
geo     Länder (inkl EU)
isced11     KPI-Spalte -> Bildungsgrad @charlotte
sex     Geschlecht (nach heteronormativem Verständnis)
unit    Tausend Personen
wstatus Beschäftigungsstatus
time_period     Periode
obs_value       Wert in TSD
obs_flag        kA

     
SELECT  age,CASE WHEN geo = 'EL' THEN 'Greece'
WHEN geo = 'ES' THEN 'Spain'
WHEN geo = 'IT' THEN 'Italy'
WHEN geo = 'NL' THEN 'Netherlands'
WHEN geo = 'PT' THEN 'Portugal'
WHEN geo = 'UK' THEN 'United Kingdom'
WHEN geo = 'FR' THEN 'France'
WHEN geo = 'CH' THEN 'Switzerland'
WHEN geo = 'CZ' THEN 'Czechia'
WHEN geo = 'EA20' THEN 'EA20'
WHEN geo = 'EU27_2020' THEN 'EU27'
WHEN geo = 'TR' THEN 'Turkey'
WHEN geo = 'RO' THEN 'Romania'
WHEN geo = 'PL' THEN 'Poland'
WHEN geo = 'BE' THEN 'Belgium'
WHEN geo = 'DE' THEN 'Germany'
WHEN geo = 'FI' THEN 'Finland'
WHEN geo = 'NO' THEN 'Norway'
WHEN geo = 'RS' THEN 'Serbia'
WHEN geo = 'CY' THEN 'Cyprus'
WHEN geo = 'SE' THEN 'Sweden'
WHEN geo = 'SK' THEN 'Slovakia'
WHEN geo = 'HR' THEN 'Croatia'
WHEN geo = 'HU' THEN 'Hungary'
WHEN geo = 'LT' THEN 'Lithuania'
WHEN geo = 'AT' THEN 'Austria'
WHEN geo = 'BG' THEN 'Belgium'
WHEN geo = 'LU' THEN 'Luxembourg'
WHEN geo = 'LV' THEN 'Latvia'
WHEN geo = 'MK' THEN 'North Macedonia'
WHEN geo = 'MT' THEN 'Malta'
WHEN geo = 'SI' THEN 'Slovenia'
WHEN geo = 'DK' THEN 'Denmark'
WHEN geo = 'IE' THEN 'Ireland'
WHEN geo = 'EE' THEN 'Estonia'
WHEN geo = 'IS' THEN 'Iceland'
WHEN geo = 'ME' THEN 'Montenegro'
ELSE NULL END AS country,sex,wstatus,time_period,obs_value AS kpi_value, CASE

WHEN isced11 = 'TOTAL' THEN 'All ISCED 2011 levels'
WHEN isced11 = 'ED0-2' THEN 'Less than primary, primary and lower secondary education (levels 0-2)'
WHEN isced11 = 'ED3_4' THEN 'Upper secondary and post-secondary non-tertiary education (levels 3 and 4)'
WHEN isced11 = 'ED3_4GEN' THEN 'Upper secondary and post-secondary non-tertiary education (levels 3 and 4) - general'
WHEN isced11 = 'ED3_4VOC' THEN 'Upper secondary and post-secondary non-tertiary education (levels 3 and 4) - vocational'
WHEN isced11 = 'ED5-8' THEN 'Tertiary education (levels 5-8)'
WHEN isced11 = 'NRP' THEN 'No response'

ELSE NULL
 END AS kpi_label, 'education' AS category FROM eurostat_stag.self_employment_by_education_raw 

  */
SELECT DISTINCT isced11 FROM eurostat_stag.self_employment_by_education_raw 