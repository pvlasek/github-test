       identification division.
      * car120 - test mainframe conversion to micro focus cobol
      * - capture parm-data from jcl // exec program,parm=xxx
      * converter looks for linkage section parm... lth comp
      * - saves parm-lth & parm-data fieldnames for moves at proc div
      * at procedure division converter inserts perform unixproc1
      * - displays "PARM" upon env-var, accepts parm-data1 from env-var
      * - unixproc1 stores parm1-lth & parm1-data in working-storage
      * - converter inserts 'MOVE's to linkage section
      *note - may need to modify, since only 1st parm-data field moved
       program-id. car120.
uvM   * converted by cnvAIXcbl3 uvcopy 20140813 on 2014/08/30_13:52:16
       environment division.
       input-output section.
       file-control.
uvM        select custmas assign external CUSTMAS
                  organization sequential access mode sequential.
uvM        select nalist assign external NALIST
uvM               organization line sequential.
uvM   *EJect
       data  division.
       file section.
       fd  custmas record contains 256 characters.
           01 cm1. copy "custmas.cpy".
       fd  nalist record contains 90 characters.
           01 listrec.
              05 list-cust      pic 9(6).
              05 list-delete    pic x(4).
              05 list-nameadrs  pic x(80).
uvM   *EJect
       working-storage section.
uvM    copy "unixwork3.cpy".
       01  page-hdngs.
           05 filler            pic x(40) value
              'CAR120: CUSTOMER NAME & ADDRESS LIST    '.
           05 report-date       pic x(20) value spaces.
           05 filler            pic x(60) value spaces.
       01  cm1-eof              pic x value ' '.
      *
       linkage section.
uvM    01 parmdata            pic  x(200).
       01  parm-data-pkt.
           05 parm-lth          pic 9(4) comp.
           05 parm-data         pic x(100).
      *
       procedure division using parm-data-pkt.
uvM        perform unixproc3.
uvP               move parmdatalth to parm-lth.
uvP               move parmworkdata to parm-data.
      *note - cobol converter inserts 'PERFORM UNIXPROC1' here
      *     - also inserts move parm-data/lth from w/s to l/s
      *     - see parm-data/lth explanations lines 2-10 above
uvM   *eject
       mainline.
           open input custmas. open output nalist.
           move parm-data to report-date.
           if report-date equal spaces
              accept report-date from console.
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
uvM    copy "unixproc3.cpy".
