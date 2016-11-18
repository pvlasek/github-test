       identification division.
      * car100 - test/demo mainframe conversion to micro focus cobol
      *        - vancouver utilities from www.uvsoftware.ca
       program-id. car101.
       environment division.
       input-output section.
       file-control.
uvM   * select custmas1 assign custmas1
uvM        select custmas1 assign external CUSTMAS1
                  organization record sequential access mode sequential.
uvM   * select nalist assign nalist
uvM        select nalist assign external NALIST
uvM               organization line sequential.
uvM   *eject
       data  division.
       file section.
       fd  custmas1 record contains 256 characters.
           01 cm1rec            pic x(100).
       fd  nalist record contains 90 characters.
           01 listrec           pic x(100).
uvM   *eject
       working-storage section.
uvM    copy "unixwork1.cpy".
       01  wrk-flds.
           05 cm1-eof           pic x value ' '.
      *
uvM   *eject
       procedure division.
uvM        perform unixproc1.
       mainline.
           open input custmas1. open output nalist.
           read custmas1 at end move '1' to cm1-eof.
           perform dtlrtn until cm1-eof = '1'.
           close custmas1 nalist.
           stop run.
       dtlrtn.
           move spaces to listrec.
           move cm1rec to listrec.
           write listrec before advancing 1 line.
           read custmas1 at end move '1' to cm1-eof.
uvM    copy "unixproc1.cpy".
