--- hier habe ich die faktentabelle f ü r die einnahmen gebaut --- ich f ü hre dich bei gelegenheit mal da durch --- grunds ä tzlich haben wir drei faktentabellen --- eine faktentabelle hat nur drei kategorien: einnahmen,
--ausgaben,
--differenz --- eine andere faktentabelle hat nur die unterkategorien der einnahmen --- eine faktentabelle hat nur die unterkategorie der ausgaben --- die Raw hat alle (!) kategorien: also die hauptkategorien sowie deren unterkategorien sowie die unterkategorien der unterkategorien ---- darum muss pro unterkategorie eine faktentabelle gebaut werden
 WITH main AS(
    SELECT
        geo,
        na_item,
        time_period,
        unit,
        obs_value :: numeric AS VALUE
    FROM
        eurostat_stag.gov_10a_main_table
    WHERE
        sector = 'S13'
        AND unit IN (
            'MIO_EUR',
            'PC_GDP'
        )
        AND na_item IN (
            'TE',
            'TR',
            'B9'
        )
        AND obs_value IS NOT NULL
),
main_revenue AS(
    SELECT
        geo,
        na_item,
        time_period,
        unit,
        obs_value :: numeric AS VALUE
    FROM
        eurostat_stag.gov_10a_main_table
    WHERE
        sector = 'S13'
        AND unit IN (
            'MIO_EUR',
            'PC_GDP'
        )
        AND na_item IN (
            'D2REC',
            'D5REC',
            'D61REC',
            'P11_P12_P131',
            'D91REC',
            'D92_D99REC' -- es fehlt noch capital revenue
        )
),
main_ AS (
    SELECT
        geo,
        na_item,
        time_period,
        unit,
        obs_value :: numeric AS VALUE
    FROM
        eurostat_stag.gov_10a_main_table
    WHERE
        sector = 'S13'
        AND unit IN (
            'MIO_EUR',
            'PC_GDP'
        )
        AND na_item IN (
            'TE',
            'TR',
            'B9'
        )
        AND obs_value IS NOT NULL
),
other_categories AS (
    SELECT
        geo,
        na_item,
        time_period,
        unit,
        obs_value :: numeric AS VALUE
    FROM
        eurostat_stag.gov_10a_main_table
    WHERE
        sector = 'S13'
        AND unit IN (
            'MIO_EUR',
            'PC_GDP'
        )
        AND na_item IN (
            'D2REC',
            'D5REC',
            'D61REC',
            'P11_P12_P131',
            'D91REC',
            'D92_D99REC'
        )
),
other_category_ AS (
    SELECT
        m.geo,
        'other_revenue' AS na_item,
        m.time_period,
        m.unit,
        (m.value - COALESCE(o.value, 0)) AS VALUE
    FROM
        main_ m
        LEFT JOIN (
            SELECT
                geo,
                'other_revenue' AS na_item,
                time_period,
                unit,
                SUM(
                    VALUE :: numeric
                ) AS VALUE
            FROM
                other_categories
            GROUP BY
                geo,
                time_period,
                unit
        ) o
        ON m.geo = o.geo
        AND m.time_period = o.time_period
        AND m.unit = o.unit
    WHERE
        m.na_item = 'TR'
),
everything_combined AS(
    SELECT
        *
    FROM
        main_revenue
    UNION ALL
    SELECT
        *
    FROM
        other_category_
)
SELECT
    *
FROM
    everything_combined
WHERE
    geo NOT IN (
        'EA19',
        'EA20',
        'EU27_2020'
    )
