       identification division.
      * cpy100 - test/demo mainframe conversion to micro focus cobol
      * ------> this program to demo compile failure (missing copybook)
       program-id. cpy100.
       environment division.
       input-output section.
       file-control.
uvM   * select paymas assign paymas
uvM        select paymas assign external PAYMAS
                  organization record sequential access mode sequential.
uvM   * select nalist assign nalist
uvM        select nalist assign external NALIST
uvM               organization line sequential.
uvM   *eject
       data  division.
       file section.
       fd  paymas record contains 256 characters.
           01 cm1. copy "paymas.cpy".
       fd  nalist record contains 120 characters.
           01 listrec.
              05 list-empno      pic 9(6).
              05 list-delete     pic x(4).
              05 list-nameadrs   pic x(80).
uvM   *eject
       working-storage section.
uvM    copy "unixwork1.cpy".
       01  wrk-flds.
           05 cm1-eof           pic x value ' '.
           05 run-date          pic 9(6).
      *
uvM   *eject
       procedure division.
uvM        perform unixproc1.
       mainline.
           accept run-date from date.
           open input paymas. open output nalist.
           read paymas at end move '1' to cm1-eof.
           perform dtlrtn until cm1-eof = '1'.
           close paymas nalist.
           stop run.
       dtlrtn.
           move spaces to listrec.
           move cm-empno to list-empno.
           move cm-delete to list-delete.
           move cm-nameadrs to list-nameadrs.
           write listrec before advancing 1 line.
           read paymas at end move '1' to cm1-eof.
uvM    copy "unixproc1.cpy".
