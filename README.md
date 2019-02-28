# European Opinion Polls as Open Data

This GitHub repository provides European opinion polls as open data.

## Instructions for How to Contribute

In general, do a `pull` before you start editing a country poll file, so you get
the most recent copy. Do a `commit` per country poll file, so that it's easier
to merge and resolve conflicts, and consider to `push` or send in a
`pull request` for each commit.

## File Structure and Conventions

Each country poll file contains the following columns with the following
conventions:

* Polling firm: name of the polling firm
** If there are already other polls registered for that polling firm, reuse the
   name
** If there aren't already other polls registered for that polling firm, try to
   find out the polling firm's proper name, i.e. the way they refer to
   themselves, e.g. on their web site or in their report
** If more than one polling firm is involved in a poll, concatenate the names
   using commas (`,`) and `and`
* Commissionners: same as for the polling firms, or `N/A` if there's not
  commissionner for the poll

