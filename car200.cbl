       identification division.
      * car200 - test mainframe conversion to micro focus cobol
      *        - vancouver utilities from www.uvsoftware.ca
      *        - list sales details with customer name from custmas
       program-id. car200.
       environment division.
       input-output section.
       file-control.
uvM   * select saledtl assign saledtl
uvM        select saledtl assign external SALEDTL
                  organization record sequential
                  access mode sequential.
uvM   * select custmas assign custmas
uvM        select custmas assign external CUSTMAS
                  organization indexed access mode random
uvM               record key cm-cust
uvM               alternate record key cm-name with duplicates.
uvM   * select salelst assign salelst
uvM        select salelst assign external SALELST
uvM               organization line sequential.
uvM   *eject
       data  division.
       file section.
       fd  saledtl record contains 64 characters.
           01 salerec. copy "saledtl.cpy".
       fd  custmas record contains 256 characters.
           01 custrec. copy "custmas.cpy".
       fd  salelst record contains 120 characters.
           01 detail-line. copy "sdline.cpy".
           01 total-line. copy "stline.cpy".
uvM   *eject
       working-storage section.
uvM    copy "unixwork1.cpy".
       01  wrk-flds.
           10 cm1-eof           pic x value ' '.
           10 total-qty         pic s9(7) value 0.
           10 total-amount      pic s9(7)v99 value 0.
uvM   *eject
       procedure division.
uvM        perform unixproc1.
       mainline.
           open input saledtl custmas. open output salelst.
           read saledtl at end move '1' to cm1-eof.
           perform dtlrtn until cm1-eof = '1'.
           perform ttlrtn.
           close saledtl custmas salelst. stop run.
       dtlrtn.
           move spaces to custrec.
           move sd-cust to cm-cust.  read custmas.
           move spaces to detail-line.
           move sd-cust   to dl-cust.  move cm-name  to dl-cusname.
           move sd-slsmn  to dl-slsmn. move sd-date  to dl-date.
           move sd-inv    to dl-inv.   move sd-prod  to dl-prod.
           move sd-qty    to dl-qty.   move sd-price to dl-price.
           move sd-amount to dl-amount.
           write detail-line before advancing 1 line.
           add sd-qty to total-qty. add sd-amount to total-amount.
           read saledtl at end move '1' to cm1-eof.
       ttlrtn.
           move spaces to total-line.
           move total-qty to st-qty.
           move total-amount to st-amount.
           write total-line before advancing 1 line.
      * end of cobol program car300
uvM    copy "unixproc1.cpy".
