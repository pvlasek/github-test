       identification division.
      * ctx100 - test/demo mainframe conversion to micro focus cobol
      *        - list dat1/citytax1 file with packed/binary/zoned
       program-id. ctx100.
       environment division.
       input-output section.
       file-control.
uvM   * select citytax assign citytax
uvM        select citytax assign external CITYTAX
                  organization record sequential access mode sequential.
uvM   * select taxlist assign taxlist
uvM        select taxlist assign external TAXLIST
uvM               organization line sequential.
uvM   *eject
       data  division.
       file section.
       fd  citytax record contains 128 characters.
           copy "citytax1.cpy".
       fd  taxlist record contains 82 characters.
           01 listrec.
              05 list-folio        pic x(10).
              05 list-name1        pic x(20).
              05 list-post-date    pic zzzzzz9.
              05 list-land-value   pic zzz,zzz,zz9.
              05 list-imp-value    pic zzz,zzz,zz9.
              05 list-face-value   pic zzz,zzz,zz9.
              05 list-maint-tax    pic zzzz,zzz.99.
              05 filler            pic x(1).
uvM   *eject
       working-storage section.
uvM    copy "unixwork1.cpy".
       01  page-hdngs.
           05 filler            pic x(40) value
              'CTX100: CITYTAX LISTING'.
           05 run-date          pic x(20) value spaces.
           05 filler            pic x(22) value spaces.
       01  ctx-eof              pic x value ' '.
uvM   *eject
       procedure division.
uvM        perform unixproc1.
       mainline.
           accept run-date from date.
           open input citytax. open output taxlist.
           write listrec from page-hdngs before advancing 2 lines.
           read citytax at end move '1' to ctx-eof.
           perform dtlrtn until ctx-eof = '1'.
           close citytax taxlist.
           stop run.
       dtlrtn.
           move spaces to listrec.
           move ctx-folio to list-folio.
           move ctx-name to list-name1.
           move ctx-post-date to list-post-date.
           move ctx-imp-value to list-imp-value.
           move ctx-land-value to list-land-value.
           move ctx-face-value to list-face-value.
           move ctx-maint-tax to list-maint-tax.
           write listrec before advancing 1 line.
           read citytax at end move '1' to ctx-eof.
uvM    copy "unixproc1.cpy".
