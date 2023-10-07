# CSV Files and Charts

See [CSV Files at ASAPOP Website](https://storage.googleapis.com/asapop-website-20220812/csv.html) for more CSV files from other countries.

| Country                            | CSV Files                                                                               | Charts                                                                                  |
|------------------------------------|-----------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------|
| Albania                            | [al.csv](al.csv) and [al-N.csv](al-N.csv)                                               | [al.png](al.png) and [al-N.png](al-N.png)                                               |
| Belgium: Brussels                  | [be-bru.csv](be-bru.csv), [be-bru-E.csv](be-bru-E.csv) and [be-bru-N.csv](be-bru-N.csv) | [be-bru.png](be-bru.png), [be-bru-E.png](be-bru-E.png) and [be-bru-N.png](be-bru-N.png) |
| Belgium: Flanders                  | [be-vlg.csv](be-vlg.csv), [be-vlg-E.csv](be-vlg-E.csv) and [be-vlg-N.csv](be-vlg-N.csv) | [be-vlg.png](be-vlg.png), [be-vlg-E.png](be-vlg-E.png) and [be-vlg-N.png](be-vlg-N.png) |
| Belgium: Wallonia                  | [be-wal.csv](be-wal.csv), [be-wal-E.csv](be-wal-E.csv) and [be-wal-N.csv](be-wal-N.csv) | [be-wal.png](be-wal.png), [be-wal-E.png](be-wal-E.png) and [be-wal-N.png](be-wal-N.png) |
| Cyprus                             | [cy.csv](cy.csv), [cy-E.csv](cy-E.csv) and [cy-N.csv](cy-N.csv)                         | [cy.png](cy.png), [cy-E.png](cy-E.png) and [cy-N.png](cy-N.png)                         |
| France                             | [fr.csv](fr.csv), [fr-E.csv](fr-E.csv) and [fr-N.csv](fr-N.csv)                         | [fr.png](fr.png), [fr-E.png](fr-E.png) and [fr-N.png](fr-N.png)                         |
| Georgia                            | [ge.csv](ge.csv) and [ge-N.csv](ge-N.csv)                                               | [ge.png](ge.png) and [ge-N.png](ge-N.png)                                               |
| Ireland                            | [ie.csv](ie.csv), [ie-E.csv](ie-E.csv) and [ie-N.csv](ie-N.csv)                         | [ie.png](ie.png), [ie-E.png](ie-E.png) and [ie-N.png](ie-N.png)                         |
| Russia                             | [ru.csv](ru.csv) and [ru-N.csv](ru-N.csv)                                               | [ru.png](ru.png) and [ru-N.png](ru-N.png)                                               |
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
