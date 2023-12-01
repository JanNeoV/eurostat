-- ### IMPORT EUROSTAT ###
WITH
    -- union education, industry, occupation
    UNION_TABLES AS (
        SELECT
            age,
            geo,
            sex,
            wstatus,
            time_period,
            obs_value AS kpi_value,
            isced11 AS kpi,
            'education' AS category
        FROM
            eurostat_stag.self_employment_by_education_raw
        UNION All
        SELECT
            age,
            geo,
            sex,
            wstatus,
            time_period,
            obs_value AS kpi_value,
            isco08 AS kpi,
            'occupation' AS category
        FROM
            eurostat_stag.self_employment_by_occupation_raw
        UNION All
        SELECT
            age,
            geo,
            sex,
            wstatus,
            time_period,
            obs_value AS kpi_value,
            nace_r2 AS kpi,
            'industry' AS category
        FROM
            eurostat_stag.self_employment_by_industry_raw
    ),
    -- add kpi_label
    ADD_KPI_LABEL AS (
        SELECT
            *,
            CASE
            -- education
                WHEN kpi = 'TOTAL' THEN 'All ISCED 2011 levels'
                WHEN kpi = 'ED0-2' THEN 'Less than primary, primary and lower secondary education (levels 0-2)'
                WHEN kpi = 'ED3_4' THEN 'Upper secondary and post-secondary non-tertiary education (levels 3 and 4)'
                WHEN kpi = 'ED3_4GEN' THEN 'Upper secondary and post-secondary non-tertiary education (levels 3 and 4) - general'
                WHEN kpi = 'ED3_4VOC' THEN 'Upper secondary and post-secondary non-tertiary education (levels 3 and 4) - vocational'
                WHEN kpi = 'ED5-8' THEN 'Tertiary education (levels 5-8)'
                WHEN kpi = 'NRP' THEN 'No response'
                -- industry
                WHEN kpi = 'A' THEN 'Agriculture, forestry and fishing'
                WHEN kpi = 'B' THEN 'Mining and quarrying'
                WHEN kpi = 'C' THEN 'Manufacturing'
                WHEN kpi = 'D' THEN 'Electricity, gas, steam and air conditioning supply'
                WHEN kpi = 'E' THEN 'Water supply; sewerage, waste management and remediation activities'
                WHEN kpi = 'F' THEN 'Construction'
                WHEN kpi = 'G' THEN 'Wholesale and retail trade; repair of motor vehicles and motorcycles'
                WHEN kpi = 'H' THEN 'Transportation and storage'
                WHEN kpi = 'I' THEN 'Accommodation and food service activities'
                WHEN kpi = 'J' THEN 'Information and communication'
                WHEN kpi = 'K' THEN 'Financial and insurance activities'
                WHEN kpi = 'L' THEN 'Real estate activities'
                WHEN kpi = 'M' THEN 'Professional, scientific and technical activities'
                WHEN kpi = 'N' THEN 'Administrative and support service activities'
                WHEN kpi = 'O' THEN 'Public administration and defence; compulsory social security'
                WHEN kpi = 'P' THEN 'Education'
                WHEN kpi = 'Q' THEN 'Human health and social work activities'
                WHEN kpi = 'R' THEN 'Arts, entertainment and recreation'
                WHEN kpi = 'S' THEN 'Other service activities'
                WHEN kpi = 'T' THEN 'Activities of households as employers; undifferentiated goods- and services-producing activities of households for own use'
                WHEN kpi = 'U' THEN 'Activities of extraterritorial organisations and bodies'
                WHEN kpi = 'NRP' THEN 'No response'
                -- occupation
                WHEN kpi = 'OC1' THEN 'Managers'
                WHEN kpi = 'OC2' THEN 'Professionals'
                WHEN kpi = 'OC3' THEN 'Technicians and associate professionals'
                WHEN kpi = 'OC4' THEN 'Clerical support workers'
                WHEN kpi = 'OC5' THEN 'Service and sales workers'
                WHEN kpi = 'OC6' THEN 'Skilled agricultural, forestry and fishery workers'
                WHEN kpi = 'OC7' THEN 'Craft and related trades workers'
                WHEN kpi = 'OC8' THEN 'Plant and machine operators and assemblers'
                WHEN kpi = 'OC9' THEN 'Elementary occupations'
                WHEN kpi = 'OC0' THEN 'Armed forces occupations'
                ELSE NULL
            END AS kpi_label
        FROM
            UNION_TABLES
    ),
    -- translate kpi_value from x1000 to real amount
    TRANSLATE_KPI AS (
        SELECT
            *,
            kpi_value * 1000 AS headcount
        FROM
            ADD_KPI_LABEL
    ),
    -- add idt-columns: DENSE_RANK() is used instead of ROW_NUMBER(). It assigns a rank starting from 1 to each unique value, and the same rank is assigned to identical values. The ORDER BY clause in DENSE_RANK() ensures that the IDs are assigned based on the order of values.
    TABLE_WITH_KEYS AS (
        SELECT
            *,
            DENSE_RANK() OVER (
                ORDER BY
                    age
            ) AS idt_age,
            DENSE_RANK() OVER (
                ORDER BY
                    geo
            ) AS idt_geo,
            DENSE_RANK() OVER (
                ORDER BY
                    sex
            ) AS idt_sex,
            DENSE_RANK() OVER (
                ORDER BY
                    wstatus
            ) AS idt_status,
            DENSE_RANK() OVER (
                ORDER BY
                    kpi
            ) AS idt_kpi,
            DENSE_RANK() OVER (
                ORDER BY
                    category
            ) AS idt_category
        FROM
            TRANSLATE_KPI
    )
SELECT
    *
FROM
    TABLE_WITH_KEYS