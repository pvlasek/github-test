       identification division.
      * car300 - test mainframe conversion to micro focus cobol
      *        - see cobolcnv.htm, mvsjcl.htm, vsejcl.htm
      * - this program tests accept from sysin & display upon sysout
      * - see directives indd & outdd in /home/uvadm/ctl/cobopt.cbl
      *   (-c indd(sysin) & -c outdd(sysout)
      * - cause micro focus to treat sysin & sysout as external files
      * use extra conversion jobs if you dont have micro focus cobol
      * - sysin1 replaces 'ACCEPT's with 'READ's from a file
      * - sysout1 replaces 'DISPLAY's with 'WRITE's to a file
       program-id. car300.
       environment division.
       input-output section.
       file-control.
uvM   *eject
       data  division.
       file section.
uvM   *eject
       working-storage section.
uvM    copy "unixwork1.cpy".
       01  sysinrec             pic x(80).
       01  sysoutrec            pic x(132).
uvM   *eject
       procedure division.
uvM        perform unixproc1.
       mainline.
           accept sysinrec from sysin.
           if sysinrec (1:2) = "/*" or sysinrec (1:3) = "EOD"
              stop run returning 0
           else
              move sysinrec to sysoutrec
              display sysoutrec upon sysout
              go to mainline.
uvM    copy "unixproc1.cpy".
