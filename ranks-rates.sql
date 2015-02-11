-- The RANK() and DENSE_RANK() functions

CREATE TABLE widgets (
    company varchar(30),
    widget_output integer
);

INSERT INTO widgets (company, widget_output) 
VALUES
    ('AAA Widgets', 125000),
    ('Springfield Widget Masters', 143000),
    ('Best Widgets', 196000),
    ('Acme Inc.', 133000),
    ('District Widget Inc.', 201000),
    ('Clarke Industries', 620000),
    ('Stavesacre Industries', 244000),
    ('Bowers Widgets', 201000);

SELECT company, widget_output, 
RANK() OVER (ORDER BY widget_output DESC),
DENSE_RANK() OVER (ORDER BY widget_output DESC) 
FROM widgets;


-- RANK() within groups

CREATE TABLE store_sales (
    store varchar(30),
    category varchar(30),
    sales int
);

INSERT INTO store_sales (store, category, sales) 
VALUES
    ('Broders', 'Cereal', 598),
    ('Broders', 'Ice Cream', 210),
    ('Broders', 'Beer', 344),
    ('Cramers', 'Cereal', 1744),
    ('Cramers', 'Ice Cream', 1015),
    ('Cramers', 'Beer', 781),
    ('Wallace', 'Cereal', 422),
    ('Wallace', 'Ice Cream', 864),
    ('Wallace', 'Beer', 211);

SELECT store, category, sales, 
RANK() OVER (PARTITION BY store ORDER BY sales DESC)
FROM store_sales;


-- Use a self-join to show just the No. 1 ranks

SELECT *
FROM
    (SELECT store, category, sales, 
    RANK() OVER (PARTITION BY store ORDER BY sales DESC) AS Rank
    FROM store_sales) AS a
WHERE a.Rank = 1;


-- Calculating murder rate per 100,000 people

CREATE TABLE murder_rate (
    City varchar(25),
    Population int,
    Murders_2012 int
);

INSERT INTO murder_rate (
VALUES
    ('New York City', 8289415, 419),
    ('Washington, D.C.', 632323, 88),
    ('Detroit', 707096, 386),
    ('Boston', 630648, 57),
    ('Miami', 414327, 69) 
);

SELECT 
    City,
    Population,
    Murders_2012,
    ROUND((Murders_2012::numeric * 100000) 
    / Population, 1) AS Per_100_Thousand
FROM murder_rate

-- Add rankings

SELECT 
    City,
    Population,
    Murders_2012,
    ROUND((Murders_2012::numeric * 100000) 
    / Population, 1) AS Per_100_Thousand,
    RANK() OVER (ORDER BY (Murders_2012::numeric * 100000) / Population DESC)
FROM murder_rate

