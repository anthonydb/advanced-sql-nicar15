-- Correlation with Census data

SELECT 
    ROUND(CORR(MED_HH_INC, PCT_BACH_HIGHER)::numeric,2) AS bach_inc, 
    ROUND(CORR(PCT_TRAVEL_60_MIN, MED_HH_INC)::numeric,2) AS inc_trav,
    ROUND(CORR(PCT_TRAVEL_60_MIN, PCT_BACH_HIGHER)::numeric,2) AS bach_trav
FROM acs_2012_stats;


-- Regression with Census data 

SELECT 
    ROUND(REGR_R2(MED_HH_INC, PCT_BACH_HIGHER)::numeric,3) AS R2,
    ROUND(REGR_SLOPE(MED_HH_INC, PCT_BACH_HIGHER)::numeric,2) AS Slope,
    ROUND(REGR_INTERCEPT(MED_HH_INC, PCT_BACH_HIGHER)::numeric,2) AS Intercept
FROM acs_2012_stats;


-- r squared
SELECT regr_r2(MED_HH_INC, PCT_BACH_HIGHER) FROM acs_2012_stats;
-- coefficient
SELECT regr_slope(MED_HH_INC, PCT_BACH_HIGHER) FROM acs_2012_stats;
-- y intercept 
SELECT regr_intercept(MED_HH_INC, PCT_BACH_HIGHER) FROM acs_2012_stats;


-- variance
SELECT var_pop(MED_HH_INC) FROM acs_2012_stats;
-- standard deviation of the entire population
SELECT stddev_pop(MED_HH_INC) FROM acs_2012_stats;
-- covariance
SELECT covar_pop(MED_HH_INC, PCT_BACH_HIGHER) FROM acs_2012_stats;
