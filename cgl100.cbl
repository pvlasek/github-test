       identification division.
      * cgl100 - test mainframe conversion to micro focus cobol
      *        - list general ledger chart of accounts
       program-id. cgl100.
       environment division.
       input-output section.
       file-control.
uvM   * select acctmas assign acctmas
uvM        select acctmas assign external ACCTMAS
                  organization record sequential access mode sequential.
uvM   * select actlist assign actlist
uvM        select actlist assign external ACTLIST
uvM               organization line sequential.
uvM   *eject
       data division.
       file section.
       fd  acctmas record contains 128 characters.
           01 glmrec.
              05 glm-acct       pic x(8).
              05 glm-type       pic x(10).
              05 glm-dscrptn    pic x(30).
              05 glm-balance    pic s9(9)v99 comp-3.
              05 glm-date       pic x(8).
              05 filler         pic x(66).
       fd  actlist record contains 120 characters.
           01 listrec.
              05 list-acct      pic x(8).
              05 filler         pic x(2).
              05 list-dscrptn   pic x(30).
              05 list-balance   pic zzz,zzz,zzz.99-.
              05 filler         pic x(2).
              05 list-date      pic x(8).
              05 filler         pic x(55).
uvM   *eject
       working-storage section.
uvM    copy "unixwork1.cpy".
       01  wrk-flds.
           05 glm-eof           pic x value ' '.
      *
uvM   *eject
       procedure division.
uvM        perform unixproc1.
       mainline.
           open input acctmas. open output actlist.
           read acctmas at end move '1' to glm-eof.
           perform dtlrtn until glm-eof = '1'.
           close acctmas actlist.
           stop run.
       dtlrtn.
           move spaces to listrec.
           move glm-acct to list-acct.
           move glm-dscrptn to list-dscrptn.
           move glm-balance to list-balance
           move glm-date to list-date.
           write listrec before advancing 1 line.
           read acctmas at end move '1' to glm-eof.
uvM    copy "unixproc1.cpy".
