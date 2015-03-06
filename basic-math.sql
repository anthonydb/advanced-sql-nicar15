-- DOING MATH

-- Quick review of basic math operators: Run each of these statements separately:

SELECT 2 + 2;
SELECT 9 - 1;
SELECT 3 * 4;
SELECT 12 / 3;
SELECT 6 % 4; -- modulo
SELECT 3 ^ 4; -- power


-- Integer vs. decimal division. Notice what happens when you
-- divide two integers? Providing one of the inputs as a decimal
-- forces a decimal result.

SELECT 11 / 6;
SELECT 11.0 / 6;

-- You also can CAST an integer as a decimal
SELECT CAST (11 AS DECIMAL(5,1)) / 6;


-- Order of operations. You learned this 
-- in elementary school, but it's worth reviewing.

SELECT 2 + 3 * 4;   -- answer: 14
SELECT (2 + 3) * 4; -- answer: 20


-- Let's do some math on Census data. Here are the population counts
-- in each column tabulating race in the 2010 Census by county:

SELECT CtyName,
       STUSAB,
       P0010001 AS "Total",
       P0010003 AS "White Alone",
       P0010004 AS "Black Alone",
       P0010005 AS "Am Indian/Alaska Native Alone",
       P0010006 AS "Asian Alone",
       P0010007 AS "Native Hawaiian ... Alone",
       P0010008 AS "Some Other Race Alone",
       P0010009 AS "Two or More Races"
FROM counties;


-- Let's check that our race column totals add up
-- to the total population field:

SELECT 
CtyName, 
STUSAB, 
P0010001 AS "Total",
P0010003 + P0010004 + P0010005 + P0010006 + P0010007 
         + P0010008 + P0010009 AS "All Races",
(P0010003 + P0010004 + P0010005 + P0010006 + P0010007 
          + P0010008 + P0010009) - P0010001 AS "Diff"
FROM Counties;


-- Now, let's calculate for each county the percent of the
-- population that's Asian (percent of the whole). We'll sort the
-- table for good measure.

SELECT CtyName,
       STUSAB,
       (CAST (P0010006 AS DECIMAL(10,1)) / P0010001) * 100 AS "PctAsian"
FROM Counties
ORDER BY (CAST (P0010006 AS DECIMAL(10,1)) / P0010001) DESC;


-- Calculate percent change. You know how to do this, right?
-- Let's create a table, insert some values and then check
-- the percent change.

CREATE TABLE PercentChangeCalc (
    department varchar(20),
    spend_2010 integer,
    spend_2014 integer
);

INSERT INTO PercentChangeCalc 
VALUES 
    ('Building', 250000, 289000),
    ('Assessor', 178556, 179500),
    ('Clerk', 87777, 90001),
    ('Police', 451980, 650000),
    ('Library', 250000, 223000),
    ('Recreation', 199000, 195000);

-- Here's the calculation. Notice we're using the ROUND function.
SELECT Department,
       spend_2010,
       spend_2014,  
       ROUND( (CAST (spend_2014 AS DECIMAL(10,1)) - spend_2010) / spend_2010 * 100, 1 )
FROM PercentChangeCalc;

-- Sums and averages using the SUM() and AVG() functions

SELECT SUM(P0010001),
       AVG(P0010001)
FROM counties;
    

-- Create a MEDIAN() function
-- Via https://wiki.postgresql.org/wiki/Aggregate_Median

CREATE OR REPLACE FUNCTION _final_median(anyarray)
   RETURNS float8 AS
$$ 
  WITH q AS
  (
     SELECT val
     FROM unnest($1) val
     WHERE VAL IS NOT NULL
     ORDER BY 1
  ),
  cnt AS
  (
    SELECT COUNT(*) AS c FROM q
  )
  SELECT AVG(val)::float8
  FROM 
  (
    SELECT val FROM q
    LIMIT  2 - MOD((SELECT c FROM cnt), 2)
    OFFSET GREATEST(CEIL((SELECT c FROM cnt) / 2.0) - 1,0)  
  ) q2;
$$
LANGUAGE sql IMMUTABLE;
 
CREATE AGGREGATE median(anyelement) (
  SFUNC=array_append,
  STYPE=anyarray,
  FINALFUNC=_final_median,
  INITCOND='{}'
);


-- SUM(), AVG() and MEDIAN() in action

SELECT SUM(P0010001),
       AVG(P0010001),
       MEDIAN(P0010001)
FROM counties;