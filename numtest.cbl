      * numtest.cbl - from dennis warren, jan 2014
      * - to test err 163 - illegal char in numeric field
      * - occurs with .int, but not .gnt
       identification division.
       program-id. numtest.
       environment division.
       configuration section.
uvM   *eject
       data division.
uvM   *eject
       working-storage section.
uvM    copy "unixwork1.cpy".
       77 testdata                pic 9(05).
       77 numdata                 pic 9(03).
       01 data-writer.
          05 dw-hold              pic zz,zz9.
          05 dw-test              pic z,zz9.
          05 dw-mix               pic x(03)   value "EFR".
      *
uvM   *eject
       procedure division.
uvM        perform unixproc1.
           move 12345   to dw-hold.
           move 1987    to dw-test.
           move dw-test to testdata.
           add 400      to testdata.
           move dw-mix  to numdata.
           display "THE VALUE AT DW-HOLD IS " dw-hold end-display.
           display "THE VALUE AT DW-TEST IS " dw-test end-display.
           display "THE VALUE AT TESTDATA IS " testdata end-display.
           display "THE VALUE AT NUMDATA IS " numdata.
           stop run.
uvM    copy "unixproc1.cpy".
