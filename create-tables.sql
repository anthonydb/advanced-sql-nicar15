-- Create Table for Census 2010 PL94 Import
-- Full data dictionary available at: http://www.census.gov/prod/cen2010/doc/pl94-171.pdf

CREATE TABLE counties (
    CTYNAME varchar(90),-- Name of the county 
    STUSAB varchar(2),  -- State/U.S. abbreviation
    SUMLEV varchar(3),  -- Summary Level
    REGION integer,     -- Region 
    DIVISION integer,   -- Division
    STATE varchar(2),   -- State FIPS code
    COUNTY varchar(3),  -- County code
    AREALAND bigint,    -- Area (Land) in square meters 
    AREAWATR bigint,    -- Area (Water) in square meters
    POP100 integer,     -- Population count (100%)
    HU100 integer,  -- Housing Unit count (100%)
    INTPTLAT decimal(13,10), -- Internal point (latitude)
    INTPTLON decimal(13,10), -- Internal point (longitude)
    -- This section is referred to as P1. Race:
    P0010001 integer,   -- Total population
    P0010002 integer,   -- Population of one race:
    P0010003 integer,       -- White Alone
    P0010004 integer,       -- Black or African American alone
    P0010005 integer,       -- American Indian and Alaska Native alone
    P0010006 integer,       -- Asian alone
    P0010007 integer,       -- Native Hawaiian and Other Pacific Islander alone
    P0010008 integer,       -- Some Other Race alone
    P0010009 integer,   -- Two or more races:
    P0010010 integer,   -- Population of two or more races:
    P0010011 integer,       -- White; Black or African American
    P0010012 integer,       -- White; American Indian and Alaska Native
    P0010013 integer,       -- White; Asian
    P0010014 integer,       -- White; Native Hawaiian and Other Pacific Islander 
    P0010015 integer,       -- White; Some Other Race
    P0010016 integer,       -- Black or African American; American Indian and Alaska Native
    P0010017 integer,       -- Black or African American; Asian
    P0010018 integer,       -- Black or African American; Native Hawaiian and Other Pacific Islander
    P0010019 integer,       -- Black or African American; Some Other Race
    P0010020 integer,       -- American Indian and Alaska Native; Asian
    P0010021 integer,       -- American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander
    P0010022 integer,       -- American Indian and Alaska Native; Some Other Race
    P0010023 integer,       -- Asian; Native Hawaiian and Other Pacific Islander
    P0010024 integer,       -- Asian; Some Other Race
    P0010025 integer,       -- Native Hawaiian and Other Pacific Islander; Some Other Race
    P0010026 integer,   -- Population of three races
    P0010047 integer,   -- Population of four races
    P0010063 integer,   -- Population of five races
    P0010070 integer,   -- Population of six races
    -- This section is referred to as P2. HISPANIC OR LATINO, AND NOT HISPANIC OR LATINO BY RACE
    P0020001 integer,   -- Total
    P0020002 integer,   -- Hispanic or Latino
    P0020003 integer,   -- Not Hispanic or Latino:
    P0020004 integer,   -- Population of one race:
    P0020005 integer,       -- White Alone
    P0020006 integer,       -- Black or African American alone
    P0020007 integer,       -- American Indian and Alaska Native alone
    P0020008 integer,       -- Asian alone
    P0020009 integer,       -- Native Hawaiian and Other Pacific Islander alone
    P0020010 integer,       -- Some Other Race alone
    P0020011 integer,   -- Two or More Races
    P0020012 integer,   -- Population of two races
    P0020028 integer,   -- Population of three races    
    P0020049 integer,   -- Population of four races
    P0020065 integer,   -- Population of five races
    P0020072 integer,   -- Population of six races
    -- This section is referred to as P3. RACE FOR THE POPULATION 18 YEARS AND OVER
    P0030001 integer,   -- Total
    P0030002 integer,   -- Population of one race:
    P0030003 integer,       -- White alone
    P0030004 integer,       -- Black or African American alone
    P0030005 integer,       -- American Indian and Alaska Native alone
    P0030006 integer,       -- Asian alone
    P0030007 integer,       -- Native Hawaiian and Other Pacific Islander alone
    P0030008 integer,       -- Some Other Race alone
    P0030009 integer,   -- Two or More Races
    P0030010 integer,   -- Population of two races
    P0030026 integer,   -- Population of three races
    P0030047 integer,   -- Population of four races
    P0030063 integer,   -- Population of five races
    P0030070 integer,   -- Population of six races
    -- This section is referred to as P4. HISPANIC OR LATINO, AND NOT HISPANIC OR LATINO BY RACE 
    -- FOR THE POPULATION 18 YEARS AND OVER
    P0040001 integer,   -- Total
    P0040002 integer,   -- Hispanic or Latino
    P0040003 integer,   -- Not Hispanic or Latino:
    P0040004 integer,   -- Population of one race:
    P0040005 integer,   -- White alone
    P0040006 integer,   -- Black or African American alone
    P0040007 integer,   -- American Indian and Alaska Native alone
    P0040008 integer,   -- Asian alone
    P0040009 integer,   -- Native Hawaiian and Other Pacific Islander alone
    P0040010 integer,   -- Some Other Race alone
    P0040011 integer,   -- Two or More Races 
    P0040012 integer,   -- Population of two races
    P0040028 integer,   -- Population of three races
    P0040049 integer,   -- Population of four races
    P0040065 integer,   -- Population of five races 
    P0040072 integer,   -- Population of six races
    -- This section is referred to as H1. OCCUPANCY STATUS  
    H0010001 integer,   -- Total housing units
    H0010002 integer,   -- Occupied
    H0010003 integer    -- Vacant
);

COPY counties
FROM 'counties.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

--------------------------------------
-- Import USDA Meat/Poultry Plant List

CREATE TABLE meat_poultry_inspect (
    EstNumber varchar(50), 
    Company varchar(50), 
    Street varchar(60), 
    City varchar(30), 
    State varchar(2), 
    ZIP varchar(10), 
    Phone varchar(14), 
    GrantDate date, 
    Activities varchar(30), 
    DBAs text
);

COPY meat_poultry_inspect
FROM 'meat-poultry-inspect.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

--------------------------------------------------
-- Create Census ACS 2012 stats table, import data

CREATE TABLE acs_2012_stats (
    GEOID varchar(12),
    COUNTY_ST varchar(50),
    PCT_BACH_HIGHER decimal(4,1),
    MED_HH_INC int,
    PCT_TRAVEL_60_MIN decimal(4,1)
);

COPY acs_2012_stats
FROM 'acs_2012_stats.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');
