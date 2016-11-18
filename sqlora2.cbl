       identification division.
      * sqlora2 - demo cobol-api for oracle
      *         - read cust1 table & write to a sequential file
      *           (vs sqlora1 program to create table & load from file)
      *         - also see sqlora2 to read table rows write seqntl file
      *         - see alt versions sqlmyo1 mysql/odbc, sqldb21 for db2
      *         - see doc at www.uvsoftware.ca/sqldemo.htm#part_4
      * 3 ways to compile: see ctl/cobdirectives at 'SQLdemo.htm#4T1'
      * 1. procobol - called separately, requires no sql directives
      * 2. preprocess(cobsql) microfocus calls procobol better animation
      * 3. "SQL(targetdb==OracleOCI)" openesql
       program-id. sqlora2.
       environment division.
       input-output section.
       file-control.
uvM   * select cust1 assign external cust1out
           select cust1 assign external cust1out
uvM               organization line sequential access mode sequential.
uvM   *eject
       data  division.
       file section.
       fd  cust1 record contains 80 characters.
           01 cust1rec.
              05 c1num          pic 9(6).
              05 filler         pic x(1).
              05 c1name         pic x(22).
              05 filler         pic x(1).
              05 c1adrs         pic x(22).
              05 filler         pic x(1).
              05 c1city         pic x(16).
              05 filler         pic x(1).
              05 c1prov         pic x(2).
              05 filler         pic x(7).
      *
uvM   *eject
       working-storage section.
uvM    copy "unixwork1.cpy".
      * database options, communications area, & declare section
      *    copy "sqlca.cpy".
      * above copy *cmtd out, mystery how following include works ?
uvM        exec sql include "'sqlca.cpy'.cpy" end-exec.
           exec sql begin declare section end-exec.
      *
      * database & user/pswd for connect to mysql, oracle,& db2
           01  dbname           pic x(20).
           01  userpass         pic x(20).
      *
      * customer record fields to be inserted into cust1 table
           01  csrec.
               05 csnum         pic 9(6).
               05 csname        pic x(22).
               05 csadrs        pic x(22).
               05 cscity        pic x(16).
               05 csprov        pic x(2).
           exec sql end declare section end-exec.
      *
      *eject
uvM   *eject
       procedure division.
uvM        perform unixproc1.
       begin-program.
      **connect to database --> uncomment for mysql/odbc,oracle,or db2
      * - modify cobdirectives, see www.uvsoftware.ca/sqldemo.htm#4t1
      * following works for mysql/odbc
      *    move "myodbc351" dbname.
      *    move "mysql2/mysql200" to userpass.
      *    exec sql connect to :dbname user :userpass end-exec.
      * following works for db2
      *    move "ar" to dbname
      *    move "db2demo1" to dbuser
      *    move "db2demo100" to dbpass
      *    exec sql connect
      *         to :dbname user :dbuser using :dbpass end-exec.
      * following works for oracle:
           move "demo1/demo100" to userpass.
           exec sql connect :userpass end-exec.
           if sqlcode not = 0 go to sql-error.
      *
      * declare cursor & select cust1 fields for fetch
           exec sql declare cust1cursor cursor for select
uvM             custno, name1, adrs, city, prov from cust1 end-exec.
           if sqlcode not = 0 go to sql-error.
           exec sql open cust1cursor end-exec.
           if sqlcode not = 0 go to sql-error.
      *
      * open output file & use loop to fetch rows from table & write
           open output cust1.
       mainloop.
           exec sql fetch cust1cursor into
                :csnum, :csname, :csadrs, :cscity, :csprov end-exec.
           if sqlcode not = 0 go to table-end.
      * move host variables to fd record fields & write record
           move csnum to c1num, move csname to c1name,
           move csadrs to c1adrs, move cscity to c1city,
           move csprov to c1prov.
           write cust1rec.
           go to mainloop.
      *
      * end of table
       table-end.
           display "End of table, all rows written to output file"
                    upon console.
           exec sql commit work release end-exec.
           close cust1. stop run.
      *
      * sql error rtn - when any sql error occurs
       sql-error.
           display "oracle error detected: " sqlerrmc upon console.
           exec sql rollback work release end-exec.
           stop run.
      ******************* end program sqlora2.cbl *********************
uvM    copy "unixproc1.cpy".
