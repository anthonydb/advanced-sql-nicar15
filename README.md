# NICAR 2015: Advanced SQL with PostgreSQL
The code and data examples here were created for the 2015 National Institute for Computer Assisted Reporting conference held in Atlanta, Ga., and sponsored by [Investigative Reporters and Editors](www.ire.org).

## Getting started

* This hands-on class will use the [pgAdmin](www.pgadmin.org) client to edit and run queries on PostgreSQL. Depending on your operating system and how you installed PostgreSQL, pgAdmin may need to be installed separately.

* In pgAdmin, load the `create-tables.sql` script and run it. (You may need to change the location of the data files in the three `COPY` statements.) When finished, you'll have three tables loaded with data:
  * **counties**: 2010 Census PL94 data.
  * **meat_poultry_inspect**: USDA data on plants that produce meat and poultry.
  * **acs_2012_stats**: Derived data from the 2012 American Community Survey.

## Basic math

We'll start with math review and then move ahead.

* Load the `basic-math.sql` script and work through each example.