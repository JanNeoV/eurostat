WITH RECURSIVE date_table AS (
    SELECT 
        1 AS dummy_column,
        MIN(EXTRACT(YEAR FROM TO_DATE(time_period, 'YYYY'))::INTEGER) AS min_year,
        MAX(EXTRACT(YEAR FROM TO_DATE(time_period, 'YYYY'))::INTEGER) AS max_year
    FROM eurostat_stag.gov_10a_main_table
    UNION ALL
    SELECT
        1 AS dummy_column,
        min_year + 1, max_year
    FROM date_table
    WHERE min_year + 1 <= max_year
)
SELECT min_year AS year_value
FROM date_table --- es geht 10/10 besser hahahah --- nicht meine sternstunde