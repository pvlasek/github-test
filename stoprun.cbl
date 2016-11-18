       identification division.
       program-id. stoprun.
       author.     uvsoftware.
      * program to replace called programs not available yet
      * - copy/rename this stoprun.cbl for a missing similar subprogram
      * - allows testing main program (if subprogram not critical)
      * no-unixwork1/unixproc1 inserts by cobol converter
      * no-eject (for short programs like this)
       environment division.
       input-output section.
       data division.
       working-storage section.
       procedure division.
       mainpara.
           display "stoprun subprogram called"
           stop run returning 99.
      *
