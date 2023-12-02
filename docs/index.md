# CSV Files and Charts

See [CSV Files at ASAPOP Website](https://storage.googleapis.com/asapop-website-20220812/csv.html) for more CSV files from other countries.

| Country                            | CSV Files                                                                               | Charts                                                                                  |
|------------------------------------|-----------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------|
| United Kingdom: Northern Ireland   | [gb-nir.csv](gb-nir.csv), [gb-nir-E.csv](gb-nir-E.csv) and [gb-nir-N.csv](gb-nir-N.csv) | [gb-nir.png](gb-nir.png), [gb-nir-E.png](gb-nir-E.png) and [gb-nir-N.png](gb-nir-N.png) |

# Documentation

The files named `αα.csv` contain all polls registered in our database, with
`αα` being the country's ISO 3166-1 alpha-2 code. The files named `αα-E.csv`
contain the polls for European elections only, while the files named `αα-N.csv`
contain the national polls only.

The format of the CSV files is as follows:

* Polling firm: The name of the polling firm
* Commissioners: The name of the commissioners, or empty if none
* Fieldwork Start: Start date for the fieldwork
* Fieldwork End: End date for the fieldwork
* Scope: Scope for the poll, either `National` or `European`
* Sample Size: Sample size for the poll, either a number or `Not Available` if not available
* Sample Size Qualification: Either `Provided` if the sample size was provided by the polling firm, or `Estimated/Assumed` if it was not provided by estimated or assumed, or `N/A` if the sample size was not available
* Participation: Either a percentage for the participation, or `Not Available` if not available
* Precision: Either a percentage for the precision of the results, or `Seats` if the results are given in terms of seats
* Party Names: As a percentage, number of seats, or `Not Available` if not available
* Other: As a percentage, number of seats, or `Not Available` if not available

Read the article
[How “Simple Things” Quickly Become Complicated in Software Development](https://medium.com/grensesnittet/how-simple-things-quickly-become-complicated-in-software-development-9cf52233226d)
to get some background information about the challenges to store opinion polls
in tables.
