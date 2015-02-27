-- STATISTICAL FUNCTIONS
-- When it comes to stats, PostgreSQL ain't no substitute for R, 
-- Pandas or maybe even Excel. But having the ability to check a few 
-- key indicators without pushing your data elsewhere is handy.

-- Correlation with Census data
-- Or, what is the relationship between two variables?
-- Output of -1 to 1.

SELECT 
    ROUND(CORR(MED_HH_INC, PCT_BACH_HIGHER)::numeric,2) AS bach_inc, 
    ROUND(CORR(PCT_TRAVEL_60_MIN, MED_HH_INC)::numeric,2) AS inc_trav,
    ROUND(CORR(PCT_TRAVEL_60_MIN, PCT_BACH_HIGHER)::numeric,2) AS bach_trav
FROM acs_2012_stats;


-- Linear regression with Census data 

-- Data journalists often want to answer more complex questions about the 
-- relationships between variables. For example, given a county where 30% of
-- the population has a bachelor's degree or higher, what would we expect its
-- median household income to be? And for every percentage point increase
-- in that educational attainment measure, how much on average would we expect 
-- median income to increase? 

-- In simple terms, a linear regression aims to establish a linear relationship 
-- between two variables, typically an independent variable (such as education) 
-- and a variable thought to be dependent on it (such as income). 

-- Consider a scatterplot using our Census data. Each dot would represent
-- one U.S. county, with its position on the x-axis showing the percent of 
-- the population ages 25+ having a bachelor's degree or higher. The dot's 
-- position on the y-axis represents the county's median household income. 
-- We could draw a line through the dots -- a regression line -- which is the 
-- calculated “best fit” through all the dots.

-- The formula for the regression line is:

-- Y = bX + A

-- Y is the predicted score (y-axis or dependent variable). 
-- b is the slope of the line. 
-- X is the percent bachelor's degree (x-axis or independent variable). 
-- A is the Y-intercept, or the value at which the line crosses the y-axis when X is zero. 

-- Let's say a county has 10% of its population ages 25+ with bachelor's 
-- degree or higher. What is the predicted median household income? 
-- The values look like this:

-- Predicted Median HH Income = (937.66)(10) + 27,375.47 = 36,752.07

-- In addition to the predicted score for a particular point on the line, journalists 
-- often find it useful to report the slope. The slope tells us how many units of the 
-- y-axis value will increase for each unit of the x-axis value. In this case, for 
-- every percentage point increase in percent with bachelor's degrees, we can predict 
-- that a county's median household income will increase $937.66.

-- Finally, running a regression calculation with stats software (and in Postgres) will 
-- report the coefficient of determination, perhaps better known as the r-squared value. 
-- r itself is the correlation coefficient showing the direction and strength of the 
-- relationship between two variables. The square of that, the coefficient of determination, 
-- tells the percent of the variation in the y (dependent) variable that is explained by 
-- the x (independent) variable. In our example, the r-squared value is .477, meaning 
-- that about 48% of the variation in median household income can be explained by the 
-- percentage of people in a county with a bachelor's degree or higher.

-- Here's how to find all those values with PostgreSQL:

SELECT 
    ROUND(REGR_R2(MED_HH_INC, PCT_BACH_HIGHER)::numeric,3) AS R2,
    ROUND(REGR_SLOPE(MED_HH_INC, PCT_BACH_HIGHER)::numeric,2) AS Slope,
    ROUND(REGR_INTERCEPT(MED_HH_INC, PCT_BACH_HIGHER)::numeric,2) AS Intercept
FROM acs_2012_stats;

-- Additional stats functions:

-- variance
SELECT var_pop(MED_HH_INC) FROM acs_2012_stats;
-- standard deviation of the entire population
SELECT stddev_pop(MED_HH_INC) FROM acs_2012_stats;
-- covariance
SELECT covar_pop(MED_HH_INC, PCT_BACH_HIGHER) FROM acs_2012_stats;
