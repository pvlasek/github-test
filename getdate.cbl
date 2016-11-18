       identification division.
       program-id. getdate.
       author.     uvsoftware.
      *****************************************************************
      * getdate - cobol called program to get current date
      * accepts 6 digit yymmdd from unix os,& prepends century '20'
      * - could easily do in calling cobol program
      * - this used to demo replacing assembler subrtn with cobol
      *****************************************************************
       environment division.
       input-output section.
uvM   *eject
       data division.
      *working-storage section.
      *01 dummy1                   pic x(80).
uvM    working-storage section.
uvM    copy "unixwork1.cpy".
       linkage section.
       01  sysdate.
           05  sysdate-cc          pic 9(02).
           05  sysdate-yymmdd.
               10  sysdate-yy      pic 9(02).
               10  sysdate-mm      pic 9(02).
               10  sysdate-dd      pic 9(02).
      *
uvM   *eject
       procedure division using sysdate.
uvM        perform unixproc1.
       mainpara.
           accept sysdate-yymmdd from date.
           move '20' to sysdate-cc.
           goback returning 00.
      *
uvM    copy "unixproc1.cpy".
