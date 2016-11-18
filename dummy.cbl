       identification division.
       program-id. dummy.
       author.     uvsoftware.
      * dummy program to replace called programs not available yet
      * - copy/rename this dummy.cbl for the missing subprogram
      * - allows testing main program (if subprogram not critical)
      * - may need to modify linkage section to agree with call
      * no-unixwork1/unixproc1 inserts by cobol converter
      * no-eject (for short programs like this)
       environment division.
       input-output section.
       data division.
       working-storage section.
      *linkage section.
      *01  linkage-area.
      *    10 linkage-field1    pic  x(80).
      *procedure division using linkage-area.
       procedure division.
       mainpara.
           display "dummy subprogram called"
           goback returning 0.
      *
