-- =====
-- 1. Download data --
-- =====

CREATE SCHEMA IF NOT EXISTS pandemic;

DROP SCHEMA IF EXISTS pandemic;

USE pandemic;

SELECT COUNT(*)
FROM infectious_cases;

SELECT *
FROM infectious_cases
LIMIT 20;

