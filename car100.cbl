       identification division.
      * car100 - test/demo mainframe conversion to micro focus cobol
      *        - customer n&a list with report hdng & date via accept
       program-id. car100.
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
       fd  nalist record contains 120 characters.
           01 listrec.
              05 list-cust       pic 9(6).
              05 list-delete     pic x(4).
              05 list-nameadrs   pic x(80).
uvM   *eject
       working-storage section.
uvM    copy "unixwork1.cpy".
       01  page-hdngs.
           05 filler            pic x(40) value
              'CAR100: CUSTOMER NAME & ADDRESS LIST    '.
           05 run-date          pic x(20) value spaces.
           05 filler            pic x(60) value spaces.
       01  cm1-eof              pic x value ' '.
      *
uvM   *eject
       procedure division.
uvM        perform unixproc1.
       mainline.
           accept run-date from date.
           open input custmas. open output nalist.
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
