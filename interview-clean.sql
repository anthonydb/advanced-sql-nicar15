-- 1: Backup a Table

-- Method one:
CREATE TABLE meat_poultry_inspect_backup AS
SELECT * FROM meat_poultry_inspect;

-- Method two:
SELECT * INTO meat_poultry_inspect_backup
FROM meat_poultry_inspect;

-- Check number of records:
SELECT COUNT(*) FROM meat_poultry_inspect;
-- Check number of records:
SELECT COUNT(*) FROM meat_poultry_inspect_backup;


-- 2: Using MIN() and MAX()

SELECT MIN(company) AS "Min", MAX(company) AS "Max"
FROM meat_poultry_inspect;

SELECT MIN(GrantDate) AS "MinDate", MAX(GrantDate) AS "MaxDate"
FROM meat_poultry_inspect;


-- 3a: SELECT with LIMIT to return just five records

SELECT GrantDate
FROM meat_poultry_inspect
ORDER BY GrantDate ASC
LIMIT 5;


-- 3b: SELECT with LIMIT and exclude NULL values

SELECT GrantDate
FROM meat_poultry_inspect
WHERE GrantDate IS NOT NULL
ORDER BY GrantDate DESC
LIMIT 5;


-- 4: SELECT with GROUP BY to show unique values
-- Displays unique states

SELECT State
FROM meat_poultry_inspect
GROUP BY State
ORDER BY State;


-- 5a: SELECT with COUNT() to count unique values

-- Group and count states
SELECT State, COUNT(State) AS "ct"
FROM meat_poultry_inspect
GROUP BY State
ORDER BY COUNT(State) DESC;


-- 5b: SELECT with COUNT() to find inconsistencies

-- Group and count company names to find inconsistencies
SELECT Company, COUNT(Company) AS "ct"
FROM meat_poultry_inspect
GROUP BY Company
ORDER BY Company ASC;


-- 6: Use GROUP BY on multiple columns

SELECT Company, Street, City, COUNT(Company)
FROM meat_poultry_inspect
GROUP BY Company, Street, City
ORDER BY Company, Street, City;


-- 7: Using LENGTH() and COUNT() to test the ZIP field

SELECT LENGTH(ZIP), COUNT(LENGTH(ZIP))
FROM meat_poultry_inspect
GROUP BY LENGTH(ZIP)
ORDER BY LENGTH(ZIP) ASC;


-- 8: Using LENGTH() to find short ZIP fields

SELECT Company, City, State, ZIP
FROM meat_poultry_inspect
WHERE LENGTH(ZIP) < 5
GROUP BY Company, City, State, ZIP
ORDER BY State, City, Company ASC;

SELECT Company, City, State, ZIP
FROM meat_poultry_inspect
WHERE LENGTH(ZIP) < 4
GROUP BY Company, City, State, ZIP
ORDER BY State, City, Company ASC;


-- 9: Add a column with ALTER TABLE

ALTER TABLE meat_poultry_inspect ADD COLUMN Company_copy varchar(50);


-- 10: View the added column

SELECT Company, Company_copy 
FROM meat_poultry_inspect 
ORDER BY Company;


-- 11 Copy field values with UPDATE

UPDATE meat_poultry_inspect
SET Company_copy = Company;

-- To view the results:
SELECT Company, Company_copy 
FROM meat_poultry_inspect 
ORDER BY Company;

-- 12: UPDATE field values that match a string

UPDATE meat_poultry_inspect
SET Company = 'Armour-Eckrich Meats'
WHERE Company ILIKE '%armour%';

SELECT Company, Company_copy
FROM meat_poultry_inspect 
WHERE Company ILIKE '%armour%';

-- 13: Select Connecticut plants, zip codes

SELECT Company, City, State, ZIP
FROM meat_poultry_inspect
WHERE State = 'CT'
ORDER BY State, City, Company ASC;


-- 14: Prepare table for modifying zip field

ALTER TABLE meat_poultry_inspect ADD COLUMN Zip_copy varchar(10);

UPDATE meat_poultry_inspect
SET Zip_copy = Zip;


-- 15: UPDATE zip codes missing a leading zero

UPDATE meat_poultry_inspect
SET Zip = '0' || Zip
WHERE State = 'CT';

SELECT Zip, Zip_copy
FROM meat_poultry_inspect
WHERE State = 'CT';


-- 16: Concatenate several fields

SELECT Company || ', ' || City || ', ' || State AS "Combined_Name"
FROM meat_poultry_inspect
ORDER BY Company;