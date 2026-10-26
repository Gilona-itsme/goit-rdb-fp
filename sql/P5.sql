-- =====
-- 5. CREATING OWN SQL FUNCTION --
-- =====

DROP FUNCTION IF EXISTS calculate_year_difference;

DELIMITER //

CREATE FUNCTION calculate_year_difference(input_year INT)
RETURNS INT
NOT DETERMINISTIC
NO SQL
BEGIN
    RETURN TIMESTAMPDIFF(
        YEAR,
        MAKEDATE(input_year, 1),
        CURDATE()
    );
END //
calculate_year_difference
DELIMITER ;


SELECT
    Year,
    calculate_year_difference(Year) AS years_difference
FROM infectious_data;