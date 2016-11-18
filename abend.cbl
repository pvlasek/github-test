       identification division.
       program-id. abend.
       author.     uvsoftware.
      * program to replace called abend program not available
      * - which may have been written in assembler
      * - copy/rename this abend.cbl for the missing subprogram
      * - may need to modify linkage section to agree with call
      * no-unixwork1/unixproc1 inserts by cobol converter
      * no-eject (for short programs like this)
       environment division.
       input-output section.
       data division.
       working-storage section.
       linkage section.
       01  linkage-area.
           10 linkage-field1    pic  x(80).
       procedure division using linkage-area.
       mainpara.
           display "abend subprogram called"
           stop run returning 99.
      *
