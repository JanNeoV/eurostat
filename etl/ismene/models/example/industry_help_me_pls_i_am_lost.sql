/* 
age     Alter
freq    nicht benötigt
geo     Länder (inkl EU)
nace_2r     KPI-Spalte -> Bildungsgrad @charlotte
sex     Geschlecht (nach heteronormativem Verständnis)
unit    Tausend Personen
wstatus Beschäftigungsstatus
time_period     Periode
obs_value       Wert in TSD
obs_flag        kA

   
WITH random AS(
SELECT  age,geo,sex,wstatus,time_period,obs_value,nace_2r AS kpi_value, CASE

WHEN nace_2r = 'A' THEN 'Agriculture, forestry and fishing'
WHEN nace_2r = 'B' THEN 'Mining and quarrying'
WHEN nace_2r = 'C' THEN 'Manufacturing'
WHEN nace_2r = 'D' THEN 'Electricity, gas, steam and air conditioning supply'
WHEN nace_2r = 'E' THEN 'Water supply; sewerage, waste management and remediation activities'
WHEN nace_2r = 'F' THEN 'Construction'
WHEN nace_2r = 'G' THEN 'Wholesale and retail trade; repair of motor vehicles and motorcycles'
WHEN nace_2r = 'H' THEN 'Transportation and storage'
WHEN nace_2r = 'I' THEN 'Accommodation and food service activities'
WHEN nace_2r = 'J' THEN 'Information and communication'
WHEN nace_2r = 'K' THEN 'Financial and insurance activities'
WHEN nace_2r = 'L' THEN 'Real estate activities'
WHEN nace_2r = 'M' THEN 'Professional, scientific and technical activities'
WHEN nace_2r = 'N' THEN 'Administrative and support service activities'
WHEN nace_2r = 'O' THEN 'Public administration and defence; compulsory social security'
WHEN nace_2r = 'P' THEN 'Education'
WHEN nace_2r = 'Q' THEN 'Human health and social work activities'
WHEN nace_2r = 'R' THEN 'Arts, entertainment and recreation'
WHEN nace_2r = 'S' THEN 'Other service activities'
WHEN nace_2r = 'T' THEN 'Activities of households as employers; undifferentiated goods- and services-producing activities of households for own use'
WHEN nace_2r = 'U' THEN 'Activities of extraterritorial organisations and bodies'
WHEN nace_2r = 'NRP' THEN 'No response'


ELSE NULL
 END AS kpi_label, 'industry' AS category FROM eurostat_stag.self_employment_by_industry_raw ) SELECT DISTINCT kpi_label FROM random

  */

  SELECT DISTINCT geo,nace_r2 FROM eurostat_stag.self_employment_by_industry_raw