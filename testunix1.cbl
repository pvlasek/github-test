       identification division.
      * testunix1 - test/demo mainframe conversion to micro focus cobol
      *           - vancouver utilities from www.uvsoftware.ca
      * this program tests unixproc1.cpy & unixwork1.cpy
      *  - code inserted into user programs by cobol converter (cnvmf4/5
      * perform unixproc1.     <-- inserted after 'PROCEDURE DIVISION'
      * copy "unixproc1.cpy".  <-- inserted at end of program
      * - accepts date & env-variables (jobid1,jobid2,parm,rundate)
      * - includes code to display micro focus file status
      * copy "unixwork1.cpy".  <-- inserted after 'WORKING-STORAGE'
      *                          - stores values accepted by unixproc1
       program-id. testunix1.
       environment division.
       input-output section.
       file-control.
uvM   * select custmas assign external custmas
           select custmas assign external custmas
             organization indexed access sequential
             file status custmas-stat
             record key custnum
             alternate key custname with duplicates.
uvM   *eject
       data  division.
       file section.
       fd  custmas record contains 256 characters.
           01 custmasrec.
              05 custnum        pic   x(6).
              05 filler         pic   x(4).
              05 custname       pic   x(25).
              05 custdata       pic   x(221).
uvM   *eject
       working-storage section.
uvM    copy "unixwork1.cpy".
       01  misc.
           05  custmas-stat     pic xx value spaces.
      *
uvM   *eject
       procedure division.
uvM        perform unixproc1.
           display "JOBID1 "         jobid1        upon console.
           display "JOBID2 "         jobid2        upon console.
           display "parm1-lth "      parm1-lth     upon console.
           display "parm1-data "     parm1-data    upon console.
      *    display "parm2-lth "      parm2-lth     upon console.
      *    display "parm2-data "     parm2-data    upon console.
      *
           display "sysdate-ymd8  "  sysdate-ymd8  "  "
                                     sysdate-ymd8e upon console.
           display "sysdate-ymd6  "  sysdate-ymd6  "    "
                                     sysdate-ymd6e upon console.
           display "sysdate-mdy8  "  sysdate-mdy8  "  "
                                     sysdate-mdy8e upon console.
           display "sysdate-mdy6  "  sysdate-mdy6  "    "
                                     sysdate-mdy6e upon console.
      *eject
      *
           display "rundate-ymd8  "  rundate-ymd8  "  "
                                     rundate-ymd8e upon console.
           display "rundate-ymd6  "  rundate-ymd6  "    "
                                     rundate-ymd6e upon console.
           display "rundate-mdy8  "  rundate-mdy8  "  "
                                     rundate-mdy8e upon console.
           display "rundate-mdy6  "  rundate-mdy6  "    "
                                     rundate-mdy6e upon console.
      *    display "current-date  "  current-date  upon console.
      * above (current-date) applies only to vse (not mvs)
      *
           open input custmas.
           if custmas-stat not = '00'
              move custmas-stat to mf-filestat
              move "CUSTMAS"    to mf-filenamei
              move "CUSTMAS"    to mf-filenamex
              perform mf-display-filestat-eoj
           else display "CUSTMAS opened OK" upon console.
           close custmas.
           stop run.
uvM    copy "unixproc1.cpy".
