# European Opinion Polls as Open Data

This GitHub repository provides European opinion polls as open data.

Read the article
[How “Simple Things” Quickly Become Complicated in Software Development](https://medium.com/grensesnittet/how-simple-things-quickly-become-complicated-in-software-development-9cf52233226d)
to get some background information about the challenges to store opinion polls
in tables.

## Instructions for How to Contribute

In general, do a `pull` before you start editing a country poll file, so you get
the most recent copy. Do a `commit` per country poll file, so that it's easier
to merge and resolve conflicts, and consider to `push` or send in a
`pull request` for each commit.

## File Structure and Conventions

Each country poll file contains the following columns with the following
conventions:

* Polling firm: name of the polling firm
  * If there are already other polls registered for that polling firm, reuse the
    name
  * If there aren't already other polls registered for that polling firm, try to
    find out the polling firm's proper name, i.e. the way they refer to
    themselves, e.g. on their web site or in their report
  * If more than one polling firm is involved in a poll, concatenate the names
    using commas (`,`) and `and`
* Commissionners: same as for the polling firms, or `N/A` if there's no
  commissionner for the poll
* Fieldwork Start: the start date of the fieldwork, formatted as `YYYY-MM-DD`
* Fieldwork End: the end date of the fieldwork, formatted as `YYYY-MM-DD`
  * Polls are sorted in descending order on Fieldwork End first, and Fieldwork
    Start after that
* Scope: the scope for the poll; the first letter is the code for the main scope
  of the poll, additional letters are the codes for the other scopes the poll
  can be used for; most polls will fall in the category `NE`, a national poll
  that can be used for European election projections too, some in the category
  `EN`, a European election poll that can be used for national projections too,
  and in case a poll has a separate national and European question, the national
  one should be labeled `N`, and the European one `E`; for Belgium, polls may
  be used for regional projections (`R`) too
* Sample size: the sample size of the poll:
  * An integer is the sample size was published by the polling firm or in the
    media
  * An integer in brackets if the sample size wasn't published, but the polling
    firm has a standard sample size, indicated a minimal sample size, or there
    have been other polls with published sample sizes by this polling firm, in
    which case the lowest number can be used
  * `N/A` if nothing is known about the sample size
* Participation: how many of the respondents were willing to reveal their voting
  intention for this poll, as a percentage, or `N/A` if it isn't known
  * If the sample size is a net sample size, use `N/A`, such that the actual
    sample size isn't further reduced
* Precision: the precision for the results; typically `1`, `0.5` or `0.1`; if
  the results are only expressed in terms of seats (like in the Netherlands),
  use `S`
* Results per party, as percentages, or `N/A` if the party wasn't polled or
  didn't exist at the time of polling
  * If you need a new column for a new party or electoral alliance, don't just
    add it, but request it to be set up. Otherwise the scripts producing the
    CSV files will start to fail.
