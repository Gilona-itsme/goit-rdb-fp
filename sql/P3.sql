-- =====
-- 3. STATISTICS FOR NUMBER_RABIES --
-- =====

SELECT
    entity_id,
    AVG(CAST(Number_rabies AS DECIMAL(20, 2))) AS average_rabies,
    MIN(CAST(Number_rabies AS DECIMAL(20, 2))) AS min_rabies,
    MAX(CAST(Number_rabies AS DECIMAL(20, 2))) AS max_rabies,
    SUM(CAST(Number_rabies AS DECIMAL(20, 2))) AS sum_rabies
FROM infectious_data
WHERE Number_rabies IS NOT NULL
  AND Number_rabies <> ''
GROUP BY entity_id
ORDER BY average_rabies DESC
LIMIT 10;

SELECT
    Entity,
    Code,
    AVG(CAST(Number_rabies AS DECIMAL(20, 2))) AS average_rabies,
    MIN(CAST(Number_rabies AS DECIMAL(20, 2))) AS min_rabies,
    MAX(CAST(Number_rabies AS DECIMAL(20, 2))) AS max_rabies,
    SUM(CAST(Number_rabies AS DECIMAL(20, 2))) AS sum_rabies
FROM infectious_cases
WHERE Number_rabies IS NOT NULL
  AND Number_rabies <> ''
GROUP BY Entity, Code
ORDER BY average_rabies DESC
LIMIT 10;