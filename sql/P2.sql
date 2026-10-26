-- =====
-- 2. Normalize data --
-- =====

CREATE TABLE entities (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Entity VARCHAR(255) NOT NULL,
    Code VARCHAR(20) NOT NULL DEFAULT '',
    UNIQUE KEY unique_entity_code (Entity, Code)
);

INSERT INTO entities (Entity, Code)
SELECT DISTINCT Entity, Code
FROM infectious_cases;

SELECT COUNT(*) FROM entities;

CREATE TABLE infectious_data (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    entity_id INT NOT NULL,
    Year INT NOT NULL,
    Number_yaws VARCHAR(50),
    polio_cases VARCHAR(50),
    cases_guinea_worm VARCHAR(50),
    Number_rabies VARCHAR(50),
    Number_malaria VARCHAR(50),
    Number_hiv VARCHAR(50),
    Number_tuberculosis VARCHAR(50),
    Number_smallpox VARCHAR(50),
    Number_cholera_cases VARCHAR(50),
    CONSTRAINT fk_cases_entityFOREIGN FOREIGN KEY (entity_id) REFERENCES entities(id)
);

INSERT INTO infectious_data (
    entity_id,
    Year,
    Number_yaws,
    polio_cases,
    cases_guinea_worm,
    Number_rabies,
    Number_malaria,
    Number_hiv,
    Number_tuberculosis,
    Number_smallpox,
    Number_cholera_cases
)
SELECT
    e.id,
    CAST(ic.Year AS UNSIGNED),
    ic.Number_yaws,
    ic.polio_cases,
    ic.cases_guinea_worm,
    ic.Number_rabies,
    ic.Number_malaria,
    ic.Number_hiv,
    ic.Number_tuberculosis,
    ic.Number_smallpox,
    ic.Number_cholera_cases
FROM infectious_cases AS ic
JOIN entities AS e
    ON ic.Entity = e.Entity
   AND ic.Code <=> e.Code;
   
   
SELECT COUNT(*) FROM infectious_cases;
   