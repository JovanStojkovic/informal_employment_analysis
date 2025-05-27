USE labour_force;

CREATE TABLE informal_employment_eu AS
SELECT e.*, w.value AS labour_force_value, gdp.gdp_per_capita
FROM (
		SELECT *
		FROM Europe
		WHERE sex = 'Total'
	) e
LEFT JOIN World_Labour_Force w
	ON e.country = w.country_name
LEFT JOIN Europe_GDP_per_capita gdp
	ON e.country = gdp.country_name;

ALTER TABLE informal_employment_eu
ADD COLUMN informal_percentage FLOAT;

UPDATE informal_employment_eu
SET informal_percentage = CASE 
    WHEN value_tsd IS NULL OR labour_force_value = 0 THEN NULL
    ELSE value_tsd / labour_force_value * 100
END;

		





