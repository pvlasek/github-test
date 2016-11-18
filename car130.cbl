       identification division.
      * car130 - test mainframe conversion to micro focus cobol
      * - capture parm-data from jcl // exec program,parm=xxx
      * this car130.cbl illustrates using a c subrtn
      * with --> call "GETPARM" using parm-data parm-lth
      * vs car120.cbl all cobol solution, vu converter inserts code
      * - display "PARM" upon env-var & accept parm-data from env-var
       program-id. car130.
       environment division.
       input-output section.
       file-control.
uvM   * select custmas assign custmas
uvM        select custmas assign external CUSTMAS
                  organization record sequential access mode sequential.
uvM   * select nalist assign nalist
uvM        select nalist assign external NALIST
uvM               organization line sequential.
uvM   *eject
       data  division.
       file section.
       fd  custmas record contains 256 characters.
           01 cm1. copy "custmas.cpy".
       fd  nalist record contains 90 characters.
           01 listrec.
              05 list-cust      pic 9(6).
              05 list-delete    pic x(4).
              05 list-nameadrs  pic x(80).
      *
uvM   *eject
       working-storage section.
uvM    copy "unixwork1.cpy".
       01  page-hdngs.
           05 filler            pic x(40) value
              'CAR130: CUSTOMER NAME & ADDRESS LIST    '.
           05 report-date       pic x(20) value spaces.
           05 filler            pic x(5) value 'PAGE#'.
           05 filler            pic x(55) value spaces.
       01  cm1-eof              pic x value ' '.
      *
      * parameters for: call "GETPARM" using parm-lth parm-data.
      * - getparm.c uses w-s vs l-s & noneed for using on proc div
      * - note parm-lth is numeric, not binary (avoid big/little end)
       01 parm-lth          pic 9(4) value zeros.
       01 parm-data         pic x(100) value spaces.
      *
uvM   *eject
       procedure division.
uvM        perform unixproc1.
       mainline.
           open input custmas. open output nalist.
           call "getparm" using parm-lth parm-data.
           move parm-data to report-date.
           write listrec from page-hdngs before advancing 2 lines.
           read custmas at end move '1' to cm1-eof.
           perform dtlrtn until cm1-eof = '1'.
           close custmas nalist.
           stop run.
       dtlrtn.
           move spaces to listrec.
           move cm-cust to list-cust.
           move cm-delete to list-delete.
           move cm-nameadrs to list-nameadrs.
           write listrec before advancing 1 line.
           read custmas at end move '1' to cm1-eof.
uvM    copy "unixproc1.cpy".
