
# CSV files

1. Austria: [at.csv](at.csv), [at-E.csv](at-E.csv) and [at-N.csv](at-N.csv)
1. Bulgaria: [bg.csv](bg.csv), [bg-E.csv](bg-E.csv) and [bg-N.csv](bg-N.csv)
1. Croatia: [hr.csv](hr.csv), [hr-E.csv](hr-E.csv) and [hr-N.csv](hr-N.csv)
1. Cyprus: [cy.csv](cy.csv), [cy-E.csv](cy-E.csv) and [cy-N.csv](cy-N.csv)
1. Czech Republic [cz.csv](cz.csv), [cz-E.csv](cz-E.csv) and [cz-N.csv](cz-N.csv)
1. Denmark: [dk.csv](dk.csv), [dk-E.csv](dk-E.csv) and [dk-N.csv](dk-N.csv)
1. Estonia: [ee.csv](ee.csv), [ee-E.csv](ee-E.csv) and [ee-N.csv](ee-N.csv)
1. Finland: [fi.csv](fi.csv), [fi-E.csv](fi-E.csv) and [fi-N.csv](fi-N.csv)
1. Germany: [de.csv](de.csv), [de-E.csv](de-E.csv) and [de-N.csv](de-N.csv)
   * [de.png](de.png), [de-E.png](de-E.png) and [de-N.png](de-N.png) (Under construction)
1. Netherlands: [nl.csv](nl.csv), [nl-E.csv](nl-E.csv) and [nl-N.csv](nl-N.csv)
1. Lithuania: [lt.csv](lt.csv), [lt-E.csv](lt-E.csv) and [lt-N.csv](lt-N.csv)
1. Poland: [pl.csv](pl.csv), [pl-E.csv](pl-E.csv) and [pl-N.csv](pl-N.csv)
1. Romania: [ro.csv](ro.csv), [ro-E.csv](ro-E.csv) and [ro-N.csv](ro-N.csv)
1. Slovakia: [sk.csv](sk.csv), [sk-E.csv](sk-E.csv) and [sk-N.csv](sk-N.csv)

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
