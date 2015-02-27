# NICAR 2015: Advanced SQL with PostgreSQL
The code and data examples here were created for the 2015 National Institute for Computer Assisted Reporting conference held in Atlanta, Ga., and sponsored by [Investigative Reporters and Editors](www.ire.org).

## Getting started

* This hands-on class will use the [pgAdmin](www.pgadmin.org) client to edit and run queries on PostgreSQL. Depending on your operating system and how you installed PostgreSQL, pgAdmin may need to be installed separately.

* In pgAdmin, load the `create-tables.sql` script and run it. (You may need to change the location of the data files in the three `COPY` statements.) When finished, you'll have three tables loaded with data:
  * **counties**: 2010 Census PL94 data.
  * **meat_poultry_inspect**: USDA data on plants that produce meat and poultry.
  * **acs_2012_stats**: Derived data from the 2012 American Community Survey.

## Basic math

We'll start with math review before moving on.

* Load the `basic-math.sql` script and work through each example.

## Interview and clean data

This segment covers how to check your data for problems and how to clean it up safely.

* Load the `interview-create.sql` script and work through the examples.

## Creating ranks and rates

Journalists generally like to discover which X is (highest/most/smallest/least/etc.). Here's how to do that with SQL.

* Load the `ranks-rates.sql` script to work the examples.

