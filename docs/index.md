
# CSV Files and Charts

| Country                          | CSV Files                                                                               | Charts                                                                                  |
|----------------------------------|-----------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------|
| Austria                          | [at.csv](at.csv), [at-E.csv](at-E.csv) and [at-N.csv](at-N.csv)                         | [at.png](at.png), [at-E.png](at-E.png) and [at-N.png](at-N.png)                         |
| Belgium                          |                                                                                         |                                                                                         |
| Bulgaria                         | [bg.csv](bg.csv), [bg-E.csv](bg-E.csv) and [bg-N.csv](bg-N.csv)                         |                                                                                         |
| Croatia                          | [hr.csv](hr.csv), [hr-E.csv](hr-E.csv) and [hr-N.csv](hr-N.csv)                         |                                                                                         |
| Cyprus                           | [cy.csv](cy.csv), [cy-E.csv](cy-E.csv) and [cy-N.csv](cy-N.csv)                         |                                                                                         |
| Czech Republic                   | [cz.csv](cz.csv), [cz-E.csv](cz-E.csv) and [cz-N.csv](cz-N.csv)                         | [cz.png](cz.png), [cz-E.png](cz-E.png) and [cz-N.png](cz-N.png)                         |
| Denmark                          | [dk.csv](dk.csv), [dk-E.csv](dk-E.csv) and [dk-N.csv](dk-N.csv)                         | [dk.png](dk.png), [dk-E.png](dk-E.png) and [dk-N.png](dk-N.png)                         |
| Estonia                          | [ee.csv](ee.csv), [ee-E.csv](ee-E.csv) and [ee-N.csv](ee-N.csv)                         |                                                                                         |
| Finland                          | [fi.csv](fi.csv), [fi-E.csv](fi-E.csv) and [fi-N.csv](fi-N.csv)                         | [fi.png](fi.png), [fi-E.png](fi-E.png) and [fi-N.png](fi-N.png)                         |
| France                           | [fr.csv](fr.csv), [fr-E.csv](fr-E.csv) and [fr-N.csv](fr-N.csv)                         | [fr.png](fr.png), [fr-E.png](fr-E.png) and [fr-N.png](fr-N.png)                         |
| Germany                          | [de.csv](de.csv), [de-E.csv](de-E.csv) and [de-N.csv](de-N.csv)                         | [de.png](de.png), [de-E.png](de-E.png) and [de-N.png](de-N.png)                         |
| Greece                           |                                                                                         |                                                                                         |
| Hungary                          |                                                                                         |                                                                                         |
| Ireland                          |                                                                                         |                                                                                         |
| Italy                            |                                                                                         |                                                                                         |
| Latvia                           |                                                                                         |                                                                                         |
| Lithuania                        | [lt.csv](lt.csv), [lt-E.csv](lt-E.csv) and [lt-N.csv](lt-N.csv)                         |                                                                                         |
| Luxembourg                       |                                                                                         |                                                                                         |
| Malta                            | [mt.csv](mt.csv), [mt-E.csv](mt-E.csv) and [mt-N.csv](mt-N.csv)                         | [mt.png](mt.png), [mt-E.png](mt-E.png) and [mt-N.png](mt-N.png)                         |
| Netherlands                      | [nl.csv](nl.csv), [nl-E.csv](nl-E.csv) and [nl-N.csv](nl-N.csv)                         | [nl.png](nl.png), [nl-E.png](nl-E.png) and [nl-N.png](nl-N.png)                         |
| Poland                           | [pl.csv](pl.csv), [pl-E.csv](pl-E.csv) and [pl-N.csv](pl-N.csv)                         |                                                                                         |
| Portugal                         |                                                                                         |                                                                                         |
| Romania                          | [ro.csv](ro.csv), [ro-E.csv](ro-E.csv) and [ro-N.csv](ro-N.csv)                         |                                                                                         |
| Slovakia                         | [sk.csv](sk.csv), [sk-E.csv](sk-E.csv) and [sk-N.csv](sk-N.csv)                         |                                                                                         |
| Slovenia                         |                                                                                         |                                                                                         |
| Spain                            | [es.csv](es.csv), [es-E.csv](es-E.csv) and [es-N.csv](es-N.csv)                         | [es.png](es.png), [es-E.png](es-E.png) and [es-N.png](es-N.png)                         |
| Sweden                           |                                                                                         |                                                                                         |
| United Kingdom: Great Britain    |                                                                                         |                                                                                         |
| United Kingdom: Northern Ireland | [gb-nir.csv](gb-nir.csv), [gb-nir-E.csv](gb-nir-E.csv) and [gb-nir-N.csv](gb-nir-N.csv) | [gb-nir.png](gb-nir.png), [gb-nir-E.png](gb-nir-E.png) and [gb-nir-N.png](gb-nir-N.png) |

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
