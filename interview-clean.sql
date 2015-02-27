-- INTERVIEW AND CLEAN YOUR DATA


-- Backups!
-- First, *never* modify your original data. Work on a copy
-- so you can go back to the original if needed.

-- Backup method one:
CREATE TABLE meat_poultry_inspect_backup AS
SELECT * FROM meat_poultry_inspect;

-- Backup method two:
SELECT * INTO meat_poultry_inspect_backup
FROM meat_poultry_inspect;

-- Check number of records:
SELECT COUNT(*) FROM meat_poultry_inspect;
-- Check number of records:
SELECT COUNT(*) FROM meat_poultry_inspect_backup;


-- INTERVIEW your data

-- Using the MIN() and MAX() functions on a column
-- to see what the biggest/smallest values are in it;
-- useful for finding anomalous data. 

SELECT MIN(company) AS "Min", MAX(company) AS "Max"
FROM meat_poultry_inspect;

SELECT MIN(GrantDate) AS "MinDate", MAX(GrantDate) AS "MaxDate"
FROM meat_poultry_inspect;


-- Take a look at a handful of sorted values with 
-- SELECT with LIMIT

SELECT GrantDate
FROM meat_poultry_inspect
ORDER BY GrantDate ASC
LIMIT 5;


-- SELECT with LIMIT and exclude NULL values

SELECT GrantDate
FROM meat_poultry_inspect
WHERE GrantDate IS NOT NULL
ORDER BY GrantDate DESC
LIMIT 5;


-- How many states do we have in this data?
-- SELECT with GROUP BY to show the unique values

SELECT State
FROM meat_poultry_inspect
GROUP BY State
ORDER BY State;


-- How many of each state do we have in this data?
-- SELECT with COUNT() to count unique states

SELECT State, COUNT(State) AS "ct" -- name the column with an alias
FROM meat_poultry_inspect
GROUP BY State
ORDER BY COUNT(State) DESC;


-- Are company names entered consistently?
-- SELECT with COUNT() to find inconsistencies

SELECT Company, COUNT(Company) AS "ct"
FROM meat_poultry_inspect
GROUP BY Company
ORDER BY Company ASC;


-- Use GROUP BY on multiple columns

SELECT Company, Street, City, COUNT(Company)
FROM meat_poultry_inspect
GROUP BY Company, Street, City
ORDER BY Company, Street, City;


-- Are the zip codes in good shape?
-- Use LENGTH() and COUNT() to test the ZIP field

SELECT LENGTH(ZIP), COUNT(LENGTH(ZIP))
FROM meat_poultry_inspect
GROUP BY LENGTH(ZIP)
ORDER BY LENGTH(ZIP) ASC;


-- Use LENGTH() to find short ZIP fields

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


-- CLEAN your data!

-- Let's copy a column to a new column as a further backup.
-- Add a column with ALTER TABLE

ALTER TABLE meat_poultry_inspect ADD COLUMN Company_copy varchar(50);


-- View the added column, which is empty

SELECT Company, Company_copy 
FROM meat_poultry_inspect 
ORDER BY Company;


-- Copy the original field values into the new field with UPDATE

UPDATE meat_poultry_inspect
SET Company_copy = Company;

-- To view the results:
SELECT Company, Company_copy 
FROM meat_poultry_inspect 
ORDER BY Company;


-- Let's make one company's name consistent and
-- UPDATE field values that match a string

UPDATE meat_poultry_inspect
SET Company = 'Armour-Eckrich Meats'
WHERE Company ILIKE '%armour%';

SELECT Company, Company_copy
FROM meat_poultry_inspect 
WHERE Company ILIKE '%armour%';


-- Let's fix some of the zip codes. 
-- For example, Connecticut's are missing the leading zero

SELECT Company, City, State, ZIP
FROM meat_poultry_inspect
WHERE State = 'CT'
ORDER BY State, City, Company ASC;


-- Let's create another backup new column and fill it

ALTER TABLE meat_poultry_inspect ADD COLUMN Zip_copy varchar(10);

UPDATE meat_poultry_inspect
SET Zip_copy = Zip;


-- 15: UPDATE zip codes missing a leading zero

UPDATE meat_poultry_inspect
SET Zip = '0' || Zip -- concatenate!
WHERE State = 'CT';

SELECT Zip, Zip_copy
FROM meat_poultry_inspect
WHERE State = 'CT';


-- Bonus: concatenating fields can be useful for output

SELECT Company || ', ' || City || ', ' || State AS "Combined_Name"
FROM meat_poultry_inspect
ORDER BY Company;