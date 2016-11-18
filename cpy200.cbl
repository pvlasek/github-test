       identification division.
      * cpy200 - test/demo mainframe conversion to micro focus cobol
      *        - this program to demo cobfiles5a & mvsfiles5a
      *        - with packed fields under fd/01
       program-id. cpy100.
       environment division.
       input-output section.
       file-control.
uvM   * select paymas assign paymas
uvM        select paymas assign external PAYMAS
                  organization record sequential access mode sequential.
uvM   * select payedit assign payedit
uvM        select payedit assign external PAYEDIT
uvM               organization line sequential.
uvM   *eject
       data  division.
       file section.
       fd  paymas record contains 80 characters.
           01 cm1.
              10 paymas-empno    pic 9(6).
              10 paymas-delete   pic x(4).
              10 paymas-name     pic x(20).
              10 paymas-gross    pic s9(7)v99 comp-3.
              10 paymas-tax      pic s9(7)v99 comp-3.
              10 paymas-cpp      pic s9(7)v99 comp-4.
              10 paymas-uic      pic s9(5)v99.
              10 filler          pic x(32).
       fd  payedit record contains 120 characters.
           01 editrec.
              10 edit-empno      pic 9(6).
              10 edit-delete     pic x(4).
              10 edit-name       pic x(20).
              10 edit-gross      pic zzzz,zzz.99-.
              10 edit-tax        pic zzzz,zzz.99-.
              10 edit-cpp        pic zzzz,zzz.99-.
              10 edit-uic        pic zz,zzz.99-.
              10 filler          pic x(44).
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
           open input paymas. open output payedit.
           read paymas at end move '1' to cm1-eof.
           perform dtlrtn until cm1-eof = '1'.
           close paymas payedit.
           stop run.
       dtlrtn.
           move spaces to editrec.
           move paymas-empno to edit-empno.
           move paymas-delete to edit-delete.
           move paymas-name to edit-name.
           move paymas-gross to edit-gross.
           move paymas-tax to edit-tax.
           move paymas-cpp to edit-cpp.
           move paymas-uic to edit-uic.
           write editrec before advancing 1 line.
           read paymas at end move '1' to cm1-eof.
uvM    copy "unixproc1.cpy".
