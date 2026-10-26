-- =====
-- 4. DIFFERENCE COLUMN IN YEARS --
-- =====

SELECT
    Year,
    MAKEDATE(Year, 1) AS year_start,
    CURDATE() AS today,
    TIMESTAMPDIFF(
        YEAR,
        MAKEDATE(Year, 1),
        CURDATE()
    ) AS years_difference
FROM infectious_data;
